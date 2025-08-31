# Blog App

A modern Flutter blog application built with clean architecture principles, featuring user authentication, blog management, and a beautiful dark theme UI.

![Blog App](assets/blog%20app.webp)

## 🚀 Features

- **User Authentication**: Secure login and registration system
- **Blog Management**: Create, read, update, and delete blog posts
- **Modern UI**: Beautiful dark theme with Material Design
- **Real-time Data**: Powered by Supabase backend
- **Offline Support**: Local data persistence with Isar database
- **Image Upload**: Support for blog post images
- **Responsive Design**: Works across multiple platforms

## 🛠️ Tech Stack

- **Framework**: Flutter 3.4.3+
- **State Management**: Flutter Bloc
- **Backend**: Supabase
- **Local Database**: Isar
- **Dependency Injection**: Get It
- **Image Picker**: Image selection and upload
- **Connectivity**: Network status monitoring

## 📱 Screenshots

The app features a modern dark theme with intuitive navigation and smooth user experience.

## 🏗️ Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── app_secrets/              # API keys and secrets
│   ├── comman/                   # Common widgets and utilities
│   ├── error/                    # Error handling
│   ├── network/                  # Network utilities
│   ├── theme/                    # App theming
│   ├── use case/                 # Use cases
│   └── utils/                    # Utility functions
├── features/                     # Feature modules
│   ├── Auth/                     # Authentication feature
│   │   ├── data/                 # Data layer
│   │   ├── domain/               # Domain layer
│   │   └── presentation/         # UI layer
│   └── blogs/                    # Blog management feature
│       ├── data/                 # Data layer
│       ├── domain/               # Domain layer
│       └── presentation/         # UI layer
├── init_dependencies.dart        # Dependency injection setup
└── main.dart                     # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.4.3)
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd new_blog
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a Supabase project
   - Update the API keys in `lib/core/app_secrets/supabase_app_keys.dart`
   - Set up your database schema

4. **Run the app**
   ```bash
   flutter run
   ```

## 📋 Dependencies

### Core Dependencies
- `flutter_bloc: ^8.1.6` - State management
- `supabase_flutter: ^2.7.0` - Backend services
- `get_it: ^8.0.3` - Dependency injection
- `isar_flutter_libs: ^4.0.0-dev.13` - Local database
- `image_picker: ^1.1.2` - Image selection
- `connectivity_plus: ^6.1.2` - Network monitoring

### Utility Dependencies
- `dotted_border: ^2.1.0` - UI components
- `intl` - Internationalization
- `hive: ^4.0.0-dev.2` - Local storage
- `path_provider: ^2.1.0` - File system access
- `fpdart: ^1.1.0` - Functional programming
- `uuid: ^4.5.1` - Unique identifiers

## 🎨 Architecture

This app follows **Clean Architecture** principles with:

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data sources and repositories

### State Management
Uses **BLoC (Business Logic Component)** pattern for predictable state management across the app.

### Dependency Injection
Implements **Get It** for service locator pattern, making dependencies easily manageable and testable.

## 🔧 Configuration

### Environment Setup
1. Create a `.env` file in the root directory
2. Add your Supabase credentials:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

### Platform Support
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 📝 Usage

1. **Authentication**: Users can register or login to access the blog features
2. **Blog Management**: Create, edit, and delete blog posts
3. **Image Upload**: Add images to your blog posts
4. **Offline Mode**: Continue using the app even without internet connection

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Supabase for the backend services
- The open-source community for various packages

---

**Note**: This is a Flutter blog application with modern architecture patterns and a focus on user experience. The app supports multiple platforms and provides a seamless blogging experience.
