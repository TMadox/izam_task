# Cart Feature

This feature handles the shopping cart functionality and checkout process.

## Structure

```
cart/
├── bloc/                    # State management
│   ├── cart_bloc.dart
│   ├── cart_event.dart
│   └── cart_state.dart
├── constants/               # Constants and styling
│   └── cart_constants.dart
├── entities/                # Data models
│   ├── cart.dart
│   ├── cart_item.dart
│   ├── cart_totals.dart
│   └── receipt.dart
├── pages/                   # Main pages
│   └── cart_page.dart
├── widgets/                 # Reusable UI components
│   ├── cart_app_bar.dart
│   ├── cart_content.dart
│   ├── cart_discount_section.dart
│   ├── cart_empty_widget.dart
│   ├── cart_error_widget.dart
│   ├── cart_item_card.dart
│   ├── cart_items_list.dart
│   ├── cart_loading_widget.dart
│   ├── cart_summary_section.dart
│   └── index.dart
└── README.md
```

## Improvements Made

### 1. **Widget Separation**

- **Before**: All UI logic was in one massive widget tree (255 lines)
- **After**: Separated into focused, reusable widgets:
  - `CartAppBar` - App bar with navigation and clear cart
  - `CartLoadingWidget` - Loading state
  - `CartErrorWidget` - Error state
  - `CartEmptyWidget` - Empty cart state
  - `CartItemCard` - Individual cart item display
  - `CartItemsList` - List of cart items
  - `CartDiscountSection` - Discount input and management
  - `CartSummarySection` - Price summary and checkout
  - `CartContent` - Main content composition

### 2. **Constants Management**

- Created `CartConstants` class to centralize:
  - Colors (primary, error, success, discount colors)
  - Dimensions (padding, spacing, icon sizes, border radius)
  - Text styles (title, subtitle, item name, price, total styles)
  - Animation settings (duration, curves)

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
- Proper state management with BlocConsumer

### 5. **Performance Benefits**

- Reduced widget rebuilds through proper separation
- Better memory management
- Cleaner widget tree
- Optimized state handling

## Usage

```dart
// Import all widgets
import 'package:izam_task/src/cart/widgets/index.dart';

// Or import specific widgets
import 'package:izam_task/src/cart/widgets/cart_item_card.dart';
```

## Key Features

- **Cart Management**: Add, remove, and update item quantities
- **Discount System**: Apply cart-wide discounts with validation
- **Price Calculation**: Automatic subtotal, VAT, and total calculation
- **Checkout Process**: Complete checkout with receipt generation
- **Error Handling**: Graceful error states
- **Loading States**: Proper loading indicators
- **Empty States**: User-friendly empty cart display
- **Responsive Design**: Adapts to different screen sizes

## State Management

The cart uses BLoC pattern with the following states:

- `CartInitial` - Initial loading state
- `CartLoaded` - Cart with items loaded
- `CartError` - Error state with message
- `CartCheckoutSuccess` - Successful checkout with receipt

## Future Enhancements

- Add item wishlist functionality
- Implement saved carts
- Add multiple payment methods
- Implement order history
- Add cart sharing functionality
- Implement cart expiration
- Add bulk operations (select multiple items)
- Implement cart templates
