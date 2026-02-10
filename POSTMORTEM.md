# Technical Post-Mortem: Docker Build Resolution

### The Issue
During the initial `docker compose up`, the Frontend build failed consistently with **Exit Code 69**. The root cause was that the base Dart image did not include the Flutter SDK, preventing the execution of `flutter build web`.

### The Investigation
- Verified that `dart pub get` was failing because the project had Flutter dependencies.
- Identified that the `shelf` package and other web-related dependencies required a specific Flutter environment not present in the standard Dart container.

### The Resolution
I implemented a custom multi-stage Dockerfile strategy:
1. **SDK Injection:** Manually cloned the Flutter stable branch into the container.
2. **Path Configuration:** Updated the container's PATH to recognize Flutter binaries.
3. **Environment Patching:** Used `sed` commands to dynamically clean up the `pubspec.yaml` and `pubspec.lock` files to ensure dependency compatibility within the Linux-based container environment.

### Lesson Learned
Infrastructure-as-Code requires ensuring that the build environment perfectly mirrors the development SDK requirements.