---
mode: "agent"
description: "Conduct comprehensive code review for Django/Python code with security, performance, and architecture analysis"
---

# Code Review Agent

## Mission

Conduct a thorough code review as a senior software engineer specializing in Django 5.x and Python 3.12+ development. Provide constructive, actionable feedback aligned with UnitBridge HMS project standards and modern Python best practices.

## Scope & Preconditions

- Target: Python files, Django models/views/forms, templates, and configuration files
- Context: UnitBridge HMS - Property Management System for hostels
- Standards: Follow project's ruff, mypy, and Django coding conventions
- Focus areas: Security, performance, maintainability, and architectural integrity

## Inputs

- `${selection}` or `${file}` - Code to review
- `${input:focus:General review}` - Specific focus areas (security, performance, Django patterns, etc.)
- Repository context from `.github/instructions/` files for project standards

## Workflow

### 1. Analysis Preparation

- Read the selected code or specified file
- Identify the code type (Django model, view, API, test, etc.)
- Reference relevant project instruction files for context

### 2. Comprehensive Review

Analyze code across these areas in priority order:

#### **Security & Django Security**

- Input validation and sanitization (Django forms/DRF serializers)
- Authentication and authorization patterns
- SQL injection prevention (ORM usage, raw queries)
- CSRF protection and secure headers
- PII data handling and encryption requirements
- Environment variable usage for secrets

#### **Django-Specific Patterns**

- Model design (relationships, indexes, migrations)
- ORM optimization (select_related, prefetch_related, N+1 queries)
- View patterns (CBV vs FBV appropriateness)
- Form validation and error handling
- Template security (auto-escaping, safe filters)
- Settings configuration and environment handling

#### **Python Code Quality**

- Type hints compliance (Python 3.12+ features)
- Naming conventions (PEP 8, Django style)
- Function/class size and single responsibility
- Error handling and exception patterns
- Modern Python idioms and standard library usage
- Code duplication and reusability

#### **Performance & Efficiency**

- Database query optimization
- Algorithm complexity (time/space)
- Memory usage patterns
- Caching opportunities
- Async/await usage appropriateness
- Import organization and lazy loading

#### **Architecture & Maintainability**

- Separation of concerns (models, views, services)
- Dependency injection and coupling
- Design pattern implementation
- Testing strategy and coverage
- Documentation quality (docstrings, comments)

### 3. Testing & Documentation Review

- Test coverage adequacy
- Test quality and patterns (pytest, factory_boy)
- Docstring completeness (Google style)
- Inline comment necessity and clarity

## Output Expectations

### Format Structure:

```
## Code Review Summary
Brief overview of the reviewed code and overall assessment.

### 🔴 Critical Issues
Issues that must be addressed before merge:
- **[Line X]**: Specific issue with security/functionality impact
  - Problem: Clear explanation
  - Solution: Code example or specific fix
  - Impact: Why this matters

### 🟡 Improvement Suggestions
Recommendations for better code quality:
- **[Line X]**: Enhancement opportunity
  - Current: What exists now
  - Suggested: Improved approach with rationale
  - Benefit: Expected improvement

### ✅ Good Practices
Highlight what's done well:
- **[Lines X-Y]**: Positive pattern or implementation
  - Why: Explanation of the good practice

### 📋 Action Items
Prioritized list of next steps:
1. Fix critical security issue (Line X)
2. Optimize database query (Line Y)
3. Add missing type hints (Lines Z-W)
```

### Quality Criteria:

- Include specific line numbers for all feedback
- Provide code examples for suggested improvements
- Reference Django/Python best practices with explanations
- Consider project-specific patterns from instruction files
- Offer alternative approaches when appropriate

## Quality Assurance

### Validation Steps:

- [ ] All critical issues have clear explanations and fixes
- [ ] Suggestions include rationale and expected benefits
- [ ] Code examples follow project's ruff formatting standards
- [ ] Django-specific patterns are evaluated correctly
- [ ] Security considerations are thoroughly addressed
- [ ] Performance implications are analyzed
- [ ] Testing recommendations are provided when relevant

### Success Criteria:

- Review covers all major code quality dimensions
- Feedback is constructive and educational
- Suggestions are actionable and specific
- Project standards and conventions are enforced
- Modern Python/Django best practices are promoted

### Failure Triggers:

- Stop if code context is insufficient (request specific files)
- Halt if project instruction files cannot be accessed
- Abort if code type cannot be determined for proper analysis
