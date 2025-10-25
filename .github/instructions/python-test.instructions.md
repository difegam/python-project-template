---
description: "Test generation guidance for Python (pytest, async, coverage, reliability)."
applyTo: "**/tests/**/test_*.py,**/tests/**/*_test.py,**/tests/**/conftest.py,**/test/**/test_*.py,**/test/**/*_test.py,**/test/**/conftest.py,**/*_test.py,**/test_*.py,**/tests.py,**/conftest.py"
---

# Python Test Conventions (pytest)

## Global Copilot Directives
- Use **pytest**; keep tests **deterministic, isolated, and typed**.
- Mirror package structure; name as `test_[unit]_[scenario]_[outcome]`.
- Prefer **fixtures** (in `conftest.py`) and **`@pytest.mark.parametrize`** for scenario coverage.
- Test both **happy paths** and **error conditions**; include edge and boundary cases.
- For async code, use **`pytest-asyncio`**; avoid ad-hoc event loop mgmt.
- No network, filesystem, or time dependencies without fixtures/mocks.

**Copilot prompt tip:** “Generate pytest tests with parametrization, clear names, and fixtures. Include one failing input per test group, and assert exception types/messages with `pytest.raises`.”

---

## Test Stack & Plugins
- Coverage with **pytest-cov**; timeouts with **pytest-timeout** (keep unit tests < 2s).
- Async support with **pytest-asyncio**.
- Property-based testing with **hypothesis** for critical logic.
- Time control with **freezegun**.
- Mocking: use **pytest-mock**; for HTTP use **httpx** test utilities or **responses**/`requests-mock` (match the client you use).

---

## Organization & Patterns
- **Fixtures:** share via `conftest.py`; keep them minimal, composable, and documented.
- **Parametrization:** cover typical, edge, and adversarial inputs in one test body.
- **Isolation:** use tmp paths/dirs (`tmp_path`) for filesystem; **no real network**.
- **Assertions:** use `pytest.raises(...)` for exceptions; `pytest.approx(...)` for floats.
- **Property tests:** focus on invariants (idempotence, monotonicity, associativity, bounds).

---

## Async & Concurrency
- Mark async tests with `@pytest.mark.asyncio`.
- Avoid flakiness: deterministic seeds, fixed time (`freezegun`), and explicit timeouts.
- For concurrent tasks, assert **both** result values and exception propagation.

---

## Integration & E2E
- Keep unit tests fast and local; add separate **integration/E2E** suites when needed.
- Use **containers or ephemeral services** via fixtures if external dependencies are required.

---

## Security & Reliability in Tests
- Do not log or print secrets. Use ephemeral values/random data from `secrets`.
- For subprocess behavior, **never** pass user-controlled strings to `shell=True`.
- Validate input sanitation paths (allowlists/patterns) and error logging.

---

## Tooling Expectations for Tests
- **Ruff** formats and lints tests; keep line length **100**.
- **Mypy** runs in strict mode for test helper utilities and any shared fixtures.

**Copilot negative prompts:** Don’t generate sleeps or timing hacks; don’t rely on global state; don’t make tests depend on order; don’t hit the real network or the user’s home directory.
