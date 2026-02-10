# TEST_PLAN - Results & Findings

## Scope
- Login flow (mock verification)
- Protected API `/v1/secret` integration

## Cases & Results
1. **Sign-in success -> token present**
   - **Result:** [PASS] Token state updates to "set" upon clicking sign-in.
2. **Sign-in failure -> no token**
   - **Result:** [FAIL] **Critical Bug Found.** The app allows sign-in even with empty fields or invalid formats.
3. **`/healthz` returns 200/ok**
   - **Result:** [PASS] Verified via direct backend access and logs.
4. **`/v1/secret` without token -> 401**
   - **Result:** [PASS] Backend correctly rejects unauthorized requests (Verified in Docker logs).
5. **`/v1/secret` with token -> 200 + uid**
   - **Result:** [FAIL] **UI Bug Found.** Backend sends 200 OK with data (verified in Network tab), but the Frontend UI fails to render the message.

## Summary of Exploratory Bugs
- **BUG-001:** Frontend UI rendering failure for protected data.
- **BUG-002:** Missing input validation on Login (Critical Security Flaw).
- **BUG-003:** Unresponsive buttons post sign-out.