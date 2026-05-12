---
name: ship
description: Prepares production launches. Use when preparing to deploy to production. Use when you need a pre-launch checklist, when setting up monitoring, when planning a staged rollout, or when you need a rollback strategy.
---

# Shipping and Launch

Ship to production frequently and safely. Faster releases reduce risk and improve feedback loops.

## Overview

Ship to production faster is safer. Frequent small releases reduce the blast radius of any single change and improve feedback loops. A good shipping process includes automated deployment, feature flags, staged rollouts, monitoring, and a rollback strategy.

## When to Use

- Preparing to deploy to production
- Need a pre-launch checklist
- Setting up monitoring for a new feature
- Planning a staged rollout
- Need a rollback strategy
- After completing a feature implementation

## The Pre-Launch Checklist

### Code Quality

- [ ] All tests pass
- [ ] Build succeeds without warnings
- [ ] Code review approved
- [ ] Linting passes
- [ ] No TODOs or FIXMEs in production code
- [ ] No debug or console.log statements
- [ ] Environment variables documented

### Security

- [ ] No hardcoded secrets or credentials
- [ ] Dependencies are up-to-date with no known vulnerabilities
- [ ] Input validation on all user inputs
- [ ] Output encoding to prevent XSS
- [ ] SQL queries parameterized
- [ ] Authentication/authorization verified
- [ ] Rate limiting configured where needed

### Performance

- [ ] No N+1 query patterns
- [ ] Database queries optimized
- [ ] Caching strategy in place
- [ ] Pagination on list endpoints
- [ ] Asset optimization (minification, compression)
- [ ] Lazy loading for heavy resources
- [ ] Performance benchmarks meet targets

### Accessibility

- [ ] Keyboard navigation works
- [ ] Screen reader compatibility verified
- [ ] Color contrast meets WCAG standards
- [ ] Alt text on images
- [ ] ARIA labels on interactive elements
- [ ] Focus management correct

### Infrastructure

- [ ] Database migrations prepared and tested
- [ ] Rollback migrations tested
- [ ] Configuration for production environment
- [ ] CDN configured if needed
- [ ] SSL/TLS certificates valid
- [ ] Load balancer configured
- [ ] Auto-scaling rules configured

### Documentation

- [ ] Release notes written
- [ ] API documentation updated
- [ ] User documentation updated
- [ ] Internal documentation updated
- [ ] Runbook for operations team
- [ ] Known issues documented

## Feature Flag Strategy

Feature flags allow you to deploy code without exposing it to users, enabling instant rollback without code changes.

### Implementation

```typescript
// Environment-based flag
const ENABLE_NEW_FEATURE = process.env.ENABLE_NEW_FEATURE === 'true';

if (ENABLE_NEW_FEATURE) {
  // New implementation
} else {
  // Old implementation
}
```

### Percentage-Based Rollout

```typescript
// Roll out to percentage of users
function shouldShowFeature(userId: string): boolean {
  const hash = hash(userId);
  const percentage = hash % 100;
  return percentage < ROLLOUT_PERCENTAGE;
}
```

### Best Practices

- Default flags to off (safe defaults)
- Log flag checks for debugging
- Use flags for both features and infrastructure changes
- Remove flags after full rollout
- Document flag lifecycle

## Staged Rollout

Deploy gradually to minimize risk:

### The Rollout Sequence

1. **Canary (1-5% of traffic)**
   - Deploy to production
   - Route 1-5% of traffic to new version
   - Monitor for 1-2 hours
   - Check error rates, latency, business metrics

2. **Partial Rollout (10-50% of traffic)**
   - Increase traffic gradually
   - Monitor at each increment
   - Pause if issues detected
   - Continue if metrics healthy

3. **Full Rollout (100% of traffic)**
   - Route all traffic to new version
   - Monitor for 24 hours
   - Be ready to rollback

### Rollout Decision Thresholds

| Metric | Threshold | Action |
|--------|-----------|--------|
| Error rate | >1% | Pause rollout, investigate |
| Error rate | >5% | Rollback immediately |
| Latency (p95) | >2x baseline | Pause rollout, investigate |
| Latency (p95) | >5x baseline | Rollback immediately |
| Business metric | >10% regression | Pause rollout, investigate |

### When to Roll Back

- Error rate exceeds threshold
- Latency significantly degraded
- Business metrics show regression
- Critical functionality broken
- Security issue detected

## Monitoring and Observability

### What to Monitor

**Application Metrics:**
- Request rate and error rate
- Response time (p50, p95, p99)
- CPU, memory, disk usage
- Database connection pool usage
- Cache hit rate

**Business Metrics:**
- Conversion rate
- User engagement
- Revenue impact
- Feature usage rate

**Custom Metrics:**
- Feature-specific success rates
- Business process completion rates
- User journey funnels

### Error Reporting

- Integrate with error tracking (Sentry, Rollbar)
- Configure alert thresholds
- Set up on-call rotation
- Document runbook for common errors

### Post-Launch Verification

After full rollout:

- [ ] Error rates are stable
- [ ] Latency is within baseline
- [ ] Business metrics are healthy
- [ ] No new error patterns
- [ ] User feedback is positive
- [ ] Monitoring confirms stability

## Rollback Strategy

Always have a rollback plan before deploying.

### Rollback Types

**Code Rollback:**
- Revert to previous commit
- Fastest rollback method
- Works for most issues

**Database Rollback:**
- Run rollback migration
- Restore from backup if needed
- Test rollback procedure

**Configuration Rollback:**
- Revert configuration changes
- Feature flags off
- Environment variable changes

### Rollback Preparation

- [ ] Previous version tagged
- [ ] Rollback procedure documented
- [ ] Database backup taken before migration
- [ ] Rollback tested in staging
- [ ] Rollback time estimated
- [ ] Communication plan ready

### Rollback Execution

1. Execute rollback procedure
2. Verify rollback successful
3. Monitor for stability
4. Communicate with stakeholders
5. Document incident
6. Schedule post-mortem

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It's a small change, no need for rollout" | Small changes can have big impact. Always use staged rollout. |
| "We tested it in staging, it'll be fine" | Staging is not production. Production has different data, load, and edge cases. |
| "Rollback is easy, we can just do it" | Rollback is not always simple. Database changes may not be reversible. |
| "We don't need monitoring for this" | You always need monitoring. How will you know if something breaks? |
| "Feature flags add complexity" | Feature flags reduce risk. The complexity is worth the safety. |

## Red Flags

- No pre-launch checklist completed
- No monitoring configured
- No rollback plan
- Database changes without rollback strategy
- Deploying to 100% of traffic immediately
- No feature flags for significant changes
- Skipping staging environment
- No error tracking configured
- No performance benchmarks

## Verification

Before completing a production launch:

- [ ] All pre-launch checklist items completed
- [ ] Staged rollout completed successfully
- [ ] Monitoring confirms stability
- [ ] No rollbacks required
- [ ] Documentation updated
- [ ] Post-launch verification completed
- [ ] Stakeholders notified of successful launch
