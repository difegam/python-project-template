# ADR 0001: Adopt uv dependency cooldowns with exclude-newer

## Status

**Date:** 2026-04-10

- [ ] Proposed
- [x] Accepted
- [ ] Deprecated
- [ ] Rejected
- [ ] In Testing
- [ ] Superseded by ADR-XXX

## Decision (What/How)

We will configure `uv` with `exclude-newer = "P7D"` in
`[tool.uv]` so this template does not install distributions published within
the last seven days by default.

This decision applies to dependency resolution performed through the template's
standard `uv` workflow and complements the committed lockfile and vulnerability
scanning already used by the project.

## Context (Why)

This repository is a template, so its defaults become downstream project
defaults. Installing directly from PyPI without a time-based guard can pull in a
malicious release published only minutes or hours earlier, before package index
operators, maintainers, or security researchers have time to detect and
quarantine it.

The April 2026 PyPI incident involving compromised `litellm` and `telnyx`
releases showed that popular packages can be used to distribute credential
stealing malware during a short but high-impact exposure window. PyPI's
[incident report](https://blog.pypi.org/posts/2026-04-02-incident-report-litellm-telnyx-supply-chain-attack/)
recommends dependency cooldowns as a practical mitigation for tools such as
`uv` and `pip`.

The template already uses multiple dependency safety controls:

- `uv.lock` for reproducible application environments.
- `uv-secure` in pre-commit to scan locked dependencies for known
  vulnerabilities.
- `exclude-newer = "P7D"` in `pyproject.toml` to avoid consuming very recent
  uploads by default.

Those controls solve different problems. Lockfiles improve reproducibility,
scanners identify known issues, and a dependency cooldown reduces exposure to
newly published malicious releases before the ecosystem has had time to react.

## Options Considered

### Option 1: Do not use a dependency cooldown

**Pros:**

- Always allows the newest release to be installed immediately.
- Avoids any extra explanation when maintainers expect the latest package.

**Cons:**

- Maximizes exposure to fresh supply-chain compromises.
- Makes template consumers depend entirely on upstream detection speed.

### Option 2: Use a shorter cooldown such as `P3D`

**Pros:**

- Reduces exposure to the most recent releases.
- Delays package adoption less than a seven-day cooldown.

**Cons:**

- Leaves a narrower but still meaningful exposure window.
- Provides less margin for weekends, holidays, and slower disclosure cycles.

### Option 3: Rely only on lockfiles and vulnerability scanning

**Pros:**

- Keeps reproducibility and known-vulnerability checks in place.
- Avoids blocking recent releases during installation.

**Cons:**

- Does not protect the initial install or update event from a malicious release.
- Known-vulnerability tooling cannot reliably detect zero-day malicious uploads
  in time.

### Option 4: Use a seven-day cooldown with `exclude-newer = "P7D"`

**Pros:**

- Provides a conservative default for a reusable template.
- Adds a passive safeguard to normal `uv` operations without extra steps.
- Works as defense in depth alongside lockfiles and security scanning.

**Cons:**

- Delays access to newly published packages by default.
- Requires a conscious override when an urgent new release is needed.

We chose Option 4 because this repository is intended to be copied into new
projects, and a conservative default is justified when the setting is simple to
override for teams with different risk tolerance.

## Consequences

**Positive:**

- Reduces the chance that template users install a malicious release during the
  first hours or days after publication.
- Makes supply-chain risk reduction part of the default developer workflow.
- Complements `uv.lock` and `uv-secure` rather than replacing them.
- Encourages intentional dependency updates instead of automatically drinking
  from the latest-release firehose.

**Negative:**

- Developers may not receive the newest package release immediately.
- Urgent dependency updates may require an explicit cooldown bypass.
- Teams using this template need to understand why dependency resolution may
  skip very recent releases.
- This control is not sufficient on its own and must still be paired with
  vulnerability management and normal dependency review.
