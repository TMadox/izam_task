# Catalog Feature

This feature handles the product catalog display and management.

## Structure

```
catalog/
├── bloc/                    # State management
│   ├── catalog_bloc.dart
│   ├── catalog_event.dart
│   └── catalog_state.dart
├── constants/               # Constants and styling
│   └── catalog_constants.dart
├── entities/                # Data models
│   └── item.dart
├── pages/                   # Main pages
│   └── catalog_page.dart
├── widgets/                 # Reusable UI components
│   ├── catalog_content.dart
│   ├── catalog_empty_widget.dart
│   ├── catalog_error_widget.dart
│   ├── catalog_grid.dart
│   ├── catalog_loading_widget.dart
│   ├── product_card.dart
│   └── index.dart
└── README.md
```

## Improvements Made

### 1. **Widget Separation**

- **Before**: All UI logic was in one massive widget tree (155 lines)
- **After**: Separated into focused, reusable widgets:
  - `CatalogLoadingWidget` - Loading state
  - `CatalogErrorWidget` - Error state with retry functionality
  - `CatalogEmptyWidget` - Empty state
  - `ProductCard` - Individual product display
  - `CatalogGrid` - Grid layout for products
  - `CatalogContent` - Main content with cart integration

### 2. **Constants Management**

- Created `CatalogConstants` class to centralize:
  - Colors (primary, error, text colors)
  - Dimensions (padding, spacing, icon sizes)
  - Grid settings (cross axis count, aspect ratios)
  - Animation settings (duration, curves)
  - Text styles (title, subtitle, product name, price)

### 3. **Clean Architecture**

- **Single Responsibility**: Each widget has one clear purpose
- **Reusability**: Widgets can be easily reused across the app
- **Maintainability**: Changes to styling or behavior are centralized
- **Testability**: Each widget can be tested independently

### 4. **Modern Flutter Patterns**

- Used `switch` expressions for state handling
- Proper widget composition
- Clean imports with index file
- Consistent naming conventions

### 5. **Performance Benefits**

- Reduced widget rebuilds through proper separation
- Better memory management
- Cleaner widget tree

## Usage

```dart
// Import all widgets
import 'package:izam_task/src/catalog/widgets/index.dart';

// Or import specific widgets
import 'package:izam_task/src/catalog/widgets/product_card.dart';
```

## Key Features

- **Responsive Grid Layout**: Adapts to different screen sizes
- **Cart Integration**: Seamless integration with shopping cart
- **Error Handling**: Graceful error states with retry functionality
- **Loading States**: Proper loading indicators
- **Consistent Styling**: Centralized design system
- **Accessibility**: Proper semantic structure

## Future Enhancements

- Add product search functionality
- Implement product filtering by category
- Add product details page
- Implement product images
- Add wishlist functionality
- Implement product reviews and ratings
