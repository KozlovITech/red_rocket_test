# RedRocket Test Task

![1](https://github.com/user-attachments/assets/6fed5f59-b758-4a2d-9197-a214e35b762e)

![2](https://github.com/user-attachments/assets/36bff484-57b3-45d6-947a-fede0846cadc)


https://github.com/user-attachments/assets/9a12d761-f618-476d-a39d-5c6e45475fa9


A Flutter mini app with two screens: **Login** and **Home**, built using Clean Architecture.

## Features
- **Login Screen**:
    - Email and password fields with validation.
    - Login button is active only when both fields are valid.
    - Shows error messages for invalid input.
    - On successful login, the token is stored in `flutter_secure_storage` and the user is redirected to the Home screen.

- **Home Screen**:
    - Displays a welcome message with the username.
    - Logout button that clears the token and navigates back to the Login screen.

## Technologies
- **State Management**: `bloc` / `cubit`
- **Navigation**: `go_router`
- **Networking**: `dio` + `retrofit`
- **Dependency Injection**: `get_it` + `injectable`
- **Token Storage**: `flutter_secure_storage`
- **Parsing**: `freezed` + `json_serializable`
- **Responsive UI**: `flutter_screenutil`

## Project Structure
- `data` — API handling, DTO/Model
- `domain` — use cases, Entity
- `presentation` — UI + BLoC/Cubit
- `di` — dependency injection configuration
