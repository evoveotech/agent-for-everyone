#!/bin/bash
echo "Hook triggered at $(date)" >> /tmp/ai-hook-debug.log
echo "Args: $@" >> /tmp/ai-hook-debug.log
echo "Stdin:" >> /tmp/ai-hook-debug.log
cat >> /tmp/ai-hook-debug.log

# Add detailed debugging
echo "=== DEBUG SECTION ===" >> /tmp/ai-hook-debug.log
echo "AI_PROJECT_DIR: $AI_PROJECT_DIR" >> /tmp/ai-hook-debug.log
echo "Current working directory: $(pwd)" >> /tmp/ai-hook-debug.log

# Define the service directories to check
services_dirs=("email" "exports" "form" "frontend" "projects" "uploads" "users" "utilities" "events" "database")
services_with_changes=()

# Check each service directory for git changes
for service in "${services_dirs[@]}"; do
    service_path="$AI_PROJECT_DIR/$service"
    echo "Checking service: $service at $service_path" >> /tmp/ai-hook-debug.log
    
    # Check if directory exists and is a git repo
    if [ -d "$service_path" ] && [ -d "$service_path/.git" ]; then
        echo "  -> Is a git repository" >> /tmp/ai-hook-debug.log
        
        # Check for changes in this specific repo
        cd "$service_path"
        git_status=$(git status --porcelain 2>/dev/null)
        
        if [ -n "$git_status" ]; then
            echo "  -> Has changes:" >> /tmp/ai-hook-debug.log
            echo "$git_status" | sed 's/^/    /' >> /tmp/ai-hook-debug.log
            services_with_changes+=("$service")
        else
            echo "  -> No changes" >> /tmp/ai-hook-debug.log
        fi
    else
        echo "  -> Not a git repository or doesn't exist" >> /tmp/ai-hook-debug.log
    fi
done

# Return to original directory
cd "$AI_PROJECT_DIR"

echo "Services with changes: ${services_with_changes[@]}" >> /tmp/ai-hook-debug.log

if [[ ${#services_with_changes[@]} -gt 0 ]]; then
    services_list=$(IFS=', '; echo "${services_with_changes[*]}")
    echo "Changes detected in: $services_list — triggering build-error-resolver..." >> /tmp/ai-hook-debug.log
    echo "Changes detected in: $services_list — triggering build-error-resolver..." >&2

    # NOTE: This hook uses CLI-specific commands. Adapt for your AI assistant tool.
    # Example below uses Claude CLI syntax — replace with your tool's equivalent.
    echo "Attempting to run AI assistant with sub-agent..." >> /tmp/ai-hook-debug.log
    
    # Try different possible syntaxes for sub-agents
    if command -v claude >/dev/null 2>&1; then
        # Option 1: Try direct agent invocation (Claude CLI)
        claude --agent build-error-resolver <<EOF 2>> /tmp/ai-hook-debug.log
Build and fix errors in these specific services only: ${services_list}

Focus on these services in the monorepo structure. Each service has its own build process.
EOF
        
        # If that fails, try alternative syntax
        if [ $? -ne 0 ]; then
            echo "First attempt failed, trying alternative syntax..." >> /tmp/ai-hook-debug.log
            claude chat "Use the build-error-resolver agent to build and fix errors in: ${services_list}" 2>> /tmp/ai-hook-debug.log
        fi
    else
        echo "AI assistant CLI not found in PATH — adapt for your tool" >> /tmp/ai-hook-debug.log
    fi
    
    echo "AI assistant command completed with exit code: $?" >> /tmp/ai-hook-debug.log
else
    echo "No services with changes detected — skipping build-error-resolver." >> /tmp/ai-hook-debug.log
    echo "No services with changes detected — skipping build-error-resolver." >&2
fi

echo "=== END DEBUG SECTION ===" >> /tmp/ai-hook-debug.log
exit 0