# POS System - Flutter Application

A modern Point of Sale (POS) system built with Flutter, featuring a product catalog, shopping cart management, and checkout functionality. This application demonstrates clean architecture principles, state management with BLoC pattern, and responsive design.

## 🚀 Features

### Core Functionality

- **Product Catalog**: Browse and search through available products
- **Shopping Cart**: Add, remove, and manage cart items with quantity controls
- **Discount System**: Apply line-item and cart-wide discounts
- **Price Calculation**: Automatic VAT (15%) and total calculations
- **Checkout Process**: Complete transactions with receipt generation
- **Persistent Storage**: Cart state persists across app sessions

### Technical Features

- **Clean Architecture**: Modular feature-based structure
- **State Management**: BLoC pattern with HydratedBloc for persistence
- **Responsive Design**: Adapts to different screen sizes
- **Error Handling**: Graceful error states with retry functionality
- **Loading States**: Proper loading indicators throughout the app
- **Testing**: Comprehensive unit tests with bloc_test

## 📱 Screenshots

_[Screenshots would be added here]_

## 🏗️ Architecture

The project follows a clean, modular architecture with feature-based organization:

```
lib/
├── app/                     # App-level configuration
│   ├── constants/          # App-wide constants
│   ├── extensions/         # Utility extensions
│   ├── utils/             # App utilities
│   └── widgets/           # App-level widgets
├── shared/                # Shared components
│   └── widgets/          # Reusable UI components
└── src/                  # Feature modules
    ├── catalog/          # Product catalog feature
    ├── cart/            # Shopping cart feature
    └── intro/           # Introduction/splash feature
```

### Feature Structure

Each feature follows a consistent structure:

- **bloc/**: State management (events, states, bloc)
- **entities/**: Data models and business logic
- **pages/**: Main page widgets
- **widgets/**: Reusable UI components
- **constants/**: Feature-specific constants
- **services/**: Business logic and API calls

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: BLoC (flutter_bloc 9.1.1)
- **Persistence**: HydratedBloc 10.0.0
- **Routing**: GoRouter 14.6.1
- **Testing**: bloc_test 10.0.0
- **UI Components**: Material Design 3
- **Printing**: flutter_esc_pos_utils 1.0.1

## 📦 Dependencies

### Core Dependencies

```yaml
bloc: ^9.0.0 # State management
flutter_bloc: ^9.1.1 # Flutter BLoC integration
hydrated_bloc: ^10.0.0 # Persistent state storage
go_router: ^14.6.1 # Navigation
equatable: ^2.0.7 # Value equality
path_provider: ^2.1.4 # File system access
flutter_esc_pos_utils: ^1.0.1 # Receipt printing
bottom_sheet_bar: ^2.3.11 # Bottom sheet UI
```

### Development Dependencies

```yaml
bloc_test: ^10.0.0 # BLoC testing
flutter_lints: ^5.0.0 # Code linting
flutter_test: # Flutter testing framework
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.2 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd izam_task
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

## 🧪 Testing

The project includes comprehensive tests for the cart functionality:

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/cart_bloc_test.dart

# Run tests with coverage
flutter test --coverage
```

### Test Coverage

The test suite covers:

- **Cart Operations**: Add, remove, update quantities
- **Discount Calculations**: Line-item and cart-wide discounts
- **Price Calculations**: Subtotal, VAT, and total calculations
- **State Management**: BLoC state transitions
- **Edge Cases**: Empty cart, error states

### Test Structure

```dart
// Example test structure
group('CartBloc', () {
  test('adds two different items and calculates correct totals', () {
    // Test implementation
  });

  test('changes quantity and applies discount, updates totals correctly', () {
    // Test implementation
  });
});
```

## 📊 Data Models

### Product Catalog

Products are loaded from `assets/catalog.json`:

```json
{
  "id": "p01",
  "name": "Coffee",
  "price": 2.5
}
```

### Cart Item

```dart
class CartItem {
  final Item item;
  final int quantity;
  final double discountPercentage;
  // ... other properties
}
```

### Cart Totals

```dart
class CartTotals {
  final double subtotal;
  final double vat;
  final double discount;
  final double grandTotal;
}
```

## 🎨 UI/UX Features

### Design System

- **Primary Color**: Indigo (#6366F1)
- **Theme**: Material Design 3
- **Typography**: Consistent text styles
- **Spacing**: 8px base unit system

### Responsive Design

- **Grid Layout**: Adapts to screen size
- **Flexible Components**: Scale appropriately
- **Touch Targets**: Minimum 44px for accessibility

### User Experience

- **Loading States**: Clear feedback during operations
- **Error Handling**: User-friendly error messages
- **Empty States**: Helpful guidance when no data
- **Animations**: Smooth transitions and feedback

## 🔧 Configuration

### App Constants

Key configuration in `lib/app/constants/app_constants.dart`:

- App title and branding
- Color scheme
- Dimensions and spacing
- Animation durations
- Theme configuration

### Feature Constants

Each feature has its own constants file:

- `catalog_constants.dart`: Catalog-specific styling
- `cart_constants.dart`: Cart-specific styling

## 📱 Platform Support

- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Chrome, Firefox, Safari, Edge
- **Desktop**: Windows, macOS, Linux

## 🚀 Performance Optimizations

- **Widget Separation**: Reduced rebuilds through proper widget composition
- **State Management**: Efficient BLoC pattern implementation
- **Memory Management**: Proper disposal of resources
- **Asset Optimization**: Compressed images and efficient loading

## 🔒 Security Considerations

- **Data Validation**: Input validation for all user inputs
- **Error Handling**: Secure error messages without exposing internals
- **State Persistence**: Secure local storage implementation

## 📈 Future Enhancements

### Planned Features

- [ ] Product search and filtering
- [ ] User authentication and roles
- [ ] Order history and management
- [ ] Multiple payment methods
- [ ] Inventory management
- [ ] Receipt customization
- [ ] Offline mode support
- [ ] Multi-language support

### Technical Improvements

- [ ] Integration tests
- [ ] Performance monitoring
- [ ] Analytics integration
- [ ] Push notifications
- [ ] Cloud synchronization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter best practices
- Write tests for new features
- Maintain code documentation
- Use consistent naming conventions
- Follow the existing architecture patterns

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library contributors
- Material Design team for design guidelines
- Flutter community for best practices and examples

## 📞 Support

For support and questions:

- Create an issue in the repository
- Check the documentation in each feature's README
- Review the test files for usage examples

---

**Built with ❤️ using Flutter**
