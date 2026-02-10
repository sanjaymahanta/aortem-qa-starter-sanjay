# Changelog

## [1.0.1] - 2026-02-09 (Sanjay's Updates)
### Added
- Integrated Docker Compose to orchestrate Frontend (8080) and Backend (8081).
- Added comprehensive `BUG_REPORTS.md` and `POSTMORTEM.md` for QA transparency.
- Automated Build Logs (`build_output.log`) for infrastructure verification.

### Fixed
- **Critical:** Resolved Docker Build 'Exit Code 69' by implementing manual Flutter SDK installation within the container.
- **Dependency Patch:** Used dynamic shell scripting to clean `pubspec.yaml` and resolve version conflicts during containerization.
- **Connectivity:** Fixed cross-port communication issues between services.