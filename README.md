# Aortem QA Integration - Sanjay Mahanta

This repository contains the completed QA assignment. The environment has been fully containerized, build issues resolved, and exploratory testing completed with documented bug reports.

## Quick Start (Docker Compose)
Run the following command to build and start both services:
```bash
docker compose up --build

Frontend: http://localhost:8080

Backend Health: http://localhost:8081/healthz

Key Fixes & Deliverables
Infrastructure: Fixed the Flutter SDK missing issue in the Docker build process (Exit Code 69).

QA Documentation: Detailed TEST_PLAN.md and BUG_REPORTS.md included in the root.

Root Cause Analysis: POSTMORTEM.md explains the technical challenges faced during containerization.

Service Integration: Verified communication between the Flutter Web frontend and the Dart backend.

API Endpoints Verified
GET /healthz: System health check.

GET /v1/secret: Protected route (Tested with mock authentication tokens).


Notes for Reviewer
The build logs are captured in build_output.log. Please refer to BUG_REPORTS.md for critical vulnerabilities found during the exploratory testing phase



ScreenShots

![alt text](<Screenshot (46).png>) ![alt text](<Screenshot (44).png>) ![alt text](<Screenshot (45).png>)