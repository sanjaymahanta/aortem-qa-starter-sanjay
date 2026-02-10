# QA Regression Checklist

- [ ] **Build:** `docker compose up --build` runs without errors.
- [ ] **Network:** Frontend can communicate with Backend (Port 8080 -> 8081).
- [ ] **Auth:** Unauthorized access to `/v1/secret` returns 401.
- [ ] **Auth:** Authorized access with any non-empty token returns 200.
- [ ] **Health:** `/healthz` endpoint returns 200 OK.
- [ ] **UI:** Login screen renders correctly on localhost:8080.
- [ ] **Cleanup:** No large build artifacts or hidden `.dart_tool` folders in the final package.