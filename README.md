# movie_task_app
A Flutter application to manage a list of movies, allowing users to add, delete, and mark movies as favorite.

## Flutter Version

This project uses Flutter version 3.24.0. Ensure you have this version installed to avoid compatibility issues.

## Installation
1. **Clone the repository**:
    ```sh
    git clone https://github.com/RjPatel007/movieAppTask.git
    cd movie_app_task
    ```
2. **Install dependencies**:
    ```sh
    flutter pub get
    ```
3. **Set up the database**:
   Ensure that the `sqflite` and `sqflite_common_ffi` packages are properly configured in your `pubspec.yaml`.
## Usage
1. **Run the application**:
    ```sh
    flutter run
    ```
2. **Run tests**:
    ```sh
    flutter test
    ```
## Features
- Add new movies with title, description, and image.
- Delete movies from the list.
- Mark movies as favorite/unfavorite.
- View a list of all movies.
- View a list of favorite movies by clicking the drawer.
## Running Tests
To run the tests for this application, follow these steps:
1. **Ensure the database is set up**:
   Make sure the database is properly initialized and configured.
2. **Run all tests**:
    ```sh
    flutter test
    ```
3. **Run a specific test file**:
    ```sh
    flutter test test/widget_test.dart
    ```
4. **Run tests with detailed output**:
    ```sh
    flutter test --verbose
    ```
## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
