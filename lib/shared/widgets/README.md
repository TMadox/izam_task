# App Module

This module contains the core application setup and shared components.

## Structure

```
app/
├── constants/               # App-wide constants
│   └── app_constants.dart
├── extensions/              # Utility extensions
│   └── num_extension.dart
├── utils/                   # Utility functions
│   ├── app_router.dart
│   ├── helpers.dart
│   └── screen_size_helpers.dart
├── widgets/                 # App-specific setup widgets
│   ├── app_providers.dart
│   ├── cart_listener_wrapper.dart
│   └── index.dart
└── README.md
```

## Widget Organization

### `app/widgets/` - App-specific setup widgets

- **`AppProviders`** - BLoC providers setup and initialization
- **`CartListenerWrapper`** - App-level cart state listening and undo snackbar management

### `shared/widgets/` - Reusable UI components

- **`UndoSnackBar`** - Reusable snackbar component with countdown timer
- **`KeyboardDismissWrapper`** - Reusable keyboard dismissal functionality
- **`CartBottomBar`** - Reusable bottom bar component for cart display.
- **`BlocIntegratedCart`** - Reusable cart component with BLoC integration.
- **`ShoppingCartWidget`** - Reusable shopping cart widget component.

## Improvements Made

### 1. **Widget Separation**

- **Before**: All app logic was in one massive main.dart file (114 lines)
- **After**: Separated into focused, reusable widgets:
  - App-specific widgets in `app/widgets/`
  - Reusable UI components in `shared/widgets/`

### 2. **Constants Management**

- Created `AppConstants` class to centralize:
  - App information (title, theme)
  - Colors (primary, snackbar colors)
  - Dimensions (sizes, padding, spacing)
  - Durations (snackbar, progress timing)
  - Text styles

### 3. **Clean Architecture**

- **Single Responsibility**: Each widget has one clear purpose
- **Reusability**: Widgets can be easily reused across the app
- **Maintainability**: Changes to styling or behavior are centralized
- **Testability**: Each widget can be tested independently

### 4. **Modern Flutter Patterns**

- Proper widget composition
- Clean imports with index files
- Consistent naming conventions
- Separation of concerns

### 5. **Performance Benefits**

- Reduced widget rebuilds through proper separation
- Better memory management
- Cleaner widget tree
- Optimized state handling

## Usage

```dart
// Import app-specific widgets
import 'package:izam_task/app/widgets/index.dart';

// Import shared widgets
import 'package:izam_task/shared/widgets/index.dart';

// Or import specific widgets
import 'package:izam_task/app/widgets/app_providers.dart';
import 'package:izam_task/shared/widgets/undo_snackbar.dart';
```

## Key Components

### App-Specific Widgets (`app/widgets/`)

#### AppProviders

Handles the setup of all BLoC providers for the application.

#### CartListenerWrapper

Listens to cart state changes and shows the undo snackbar when appropriate.

### Shared Widgets (`shared/widgets/`)

#### UndoSnackBar

A reusable snackbar component with countdown timer for cart undo functionality.

#### KeyboardDismissWrapper

Automatically dismisses the keyboard when tapping outside of text fields.

#### CartBottomBar

Reusable bottom bar component for cart display.

#### BlocIntegratedCart

Reusable cart component with BLoC integration.

#### ShoppingCartWidget

Reusable shopping cart widget component.

## Constants

The `AppConstants` class provides centralized access to:

- App title and theme
- Snackbar styling and behavior
- Progress indicator settings
- Color scheme
- Timing configurations

## Future Enhancements

- Add app-wide error handling
- Implement app state management
- Add theme switching functionality
- Implement app analytics
- Add app-wide loading states
- Implement app configuration management
- Add app-wide navigation helpers
- Implement app-wide validation utilities
