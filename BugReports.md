BUG REPORTS - Aortem QA Assignment
Tester: Sanjay Mahanta

Date: 2026-02-10

# BUG-001: Backend Data Not Rendering in Frontend UI
Title: Protected Secret Data fails to display on UI after successful 200 OK response.

Severity: High

Status: Open

Description: After performing a mock login and clicking the "Call /v1/secret" button, the backend returns a successful response with the UID data, but the Frontend UI does not update to display this information.

Steps to Reproduce: Login -> Click 'Call /v1/secret' -> Check UI vs Network Tab.

Expected Result: UI should display the 'secret' UID data.

Actual Result: UI remains static despite a 200 OK response.

# BUG-002: Authentication Bypass with Empty Fields
Title: Login possible with empty Email and Password fields.

Severity: Critical

Status: Open

Description: The login form lacks mandatory field validation. A user can click 'Sign In' without entering any data.

Steps to Reproduce: Leave fields empty -> Click 'Sign In'.

Expected Result: System should show "Fields cannot be empty" error.

Actual Result: System accepts empty inputs and simulates a successful login.

# BUG-003: Missing Email Format Validation
Title: Form accepts invalid email formats (missing '@' or '.com').

Severity: Medium

Status: Open

Description: The email input field does not validate the format, allowing any string to be treated as a valid credential.

Steps to Reproduce: Enter 'sanjay123' -> Click 'Sign In'.

Expected Result: Error message: "Please enter a valid email address."

Actual Result: Login is successful.

# BUG-004: Unresponsive State Post Sign-Out
Title: Service buttons remain clickable but unresponsive after Sign-Out.

Severity: Low

Status: Open

Description: After clicking 'Sign Out', the app does not reset the UI state. 'Call Secret' buttons are still active but do nothing.

Steps to Reproduce: Login -> Click Sign Out -> Click 'Call /v1/secret'.

Expected Result: Buttons should be disabled or user redirected to Login.

Actual Result: Buttons remain clickable but provide no feedback.

# BUG-005: Hardcoded Credentials on Initial Load
Title: Application pre-fills sensitive credentials on launch/refresh.

Severity: Critical

Status: Open

Description: The app loads with "test@example.com" and "password" already filled in. This is a major security violation.

Steps to Reproduce: Open or Refresh the application.

Expected Result: Input fields should be empty by default.

Actual Result: Fields are pre-populated with test credentials.

# BUG-006: Sensitive Data Persistence After Sign-Out
Title: Login credentials are not cleared from UI after user signs out.

Severity: Medium

Status: Open

Description: Even after clicking "Sign Out," the email and password remain visible in the input fields, posing a privacy risk.

Steps to Reproduce: Sign In -> Click Sign Out -> Observe Login Form.

Expected Result: All fields should be cleared upon logout.

Actual Result: Email and password stay visible in the text boxes.