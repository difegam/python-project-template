---
description: Generate a comprehensive technical compliance analysis report by comparing source code against defined best practices documentation, identifying violations, and providing actionable remediation steps.
mode: agent
tools:
- "edit/editFiles",
- "search",
- "runCommands",
- "changes",
- "openSimpleBrowser",
- "fetch",
- "githubRepo",
- "todos",
---

# Technical Compliance Analysis Report Generator

## Input Requirements

- Source code location (repository URL or local directory path)

## Analysis Parameters

- Full recursive codebase scan
- Documentation-driven compliance validation
- Best practices documentation based on industry standards (e.g., OWASP, Clean Code, etc.)
- Use Context7 for getting the latest dependencies documentation.
- Output: Structured Markdown report with inline code examples

## Execution Process

1. Initialize Analysis

   - Validate source code access permissions
   - Parse and index best practices documentation
   - Create compliance rule mappings
   - Configure violation detection patterns

2. Violation Entry Format

   ````yaml
   location:
     file: { relative_path }
     line: { line_number }
   details:
     severity: [CRITICAL|HIGH|MEDIUM|LOW]
     rule_reference: { best_practices_section_id }
   code:
     current: |
       ```{language}
       {non_compliant_code}
       ```
     recommended: |
       ```{language}
       {compliant_code}
       ```
   verification:
     test_steps: { validation_procedure }
     acceptance_criteria: { expected_outcome }
   ````

3. Report Sections

   - Executive Overview

     - Compliance percentage score
     - Violation severity distribution
     - High-risk findings summary

   - Technical Assessment

     - Architectural compliance
     - Coding standards adherence
     - Security compliance status
     - Performance evaluation
     - Test coverage analysis

   - Action Items
     - Automated correction scripts
     - Manual remediation steps
     - Testing requirements

## Requirements

- Documentation sections must have unique identifiers
- Code examples must be valid and complete
- All paths must use forward slashes and be repository-relative
- Severity assignments must follow documentation guidelines
- Remediation steps must be practical and verifiable

## Execution Steps

1. Run: `compliance-scan --source {path} --rules {doc_path}`
2. Review generated report at `./compliance-report.md`
3. Execute recommended fixes
4. Validate changes with provided test steps

Success Criteria: All CRITICAL and HIGH severity violations must be resolved with documented verification.
