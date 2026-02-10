# Release Notes

## [1.0.0] - 2026-02-09 (Sanjay's Submission)

### Overview
This release delivers a fully functional, containerized QA environment. All build blockers related to the Flutter SDK and dependency resolution have been resolved, ensuring a stable "one-command" setup for testing.

### Technical Fixes & Improvements
- **Docker Infrastructure:** Fixed the critical "Exit Code 69" build error by manually injecting the Flutter SDK into the Dart base image.
- **Dependency Management:** Implemented a dynamic `pubspec` cleanup strategy to ensure compatibility in Linux-based container builds.
- **QA Documentation:** Delivered a structured Test Plan and a comprehensive Bug Report log (4 critical issues found).

### Deployment Instructions
1. Run `docker compose up --build` from the root directory.
2. Access the Frontend at `http://localhost:8080`.
3. Access the Backend at `http://localhost:8081`.

---

## [0.0.12] - Legacy Starter Template
- Provides a working QA starter with a minimal web UI, a protected API route, Docker/Compose, and CI stub.
- Candidates can focus on QA, light automation, and release artifacts.