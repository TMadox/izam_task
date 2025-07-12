import 'dart:math' as math;

class StringUtils {
  /// Capitalizes the first letter of a string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Converts a string to title case
  static String toTitleCase(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncates a string to a maximum length
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - suffix.length) + suffix;
  }

  /// Generates a random alphanumeric string
  static String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = math.Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}

class PriceUtils {
  /// Formats a price with currency symbol
  static String formatPrice(double price, {String currency = '\$'}) {
    return '$currency${price.toStringAsFixed(2)}';
  }

  /// Calculates discount amount
  static double calculateDiscount(double originalPrice, double discountRate) {
    return originalPrice * discountRate;
  }

  /// Calculates tax amount
  static double calculateTax(double amount, double taxRate) {
    return amount * taxRate;
  }

  /// Calculates percentage
  static double calculatePercentage(double value, double total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }
}

class DateTimeUtils {
  /// Formats a DateTime to a readable string
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Formats a DateTime to a readable time string
  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  /// Formats a DateTime to a readable date and time string
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${formatTime(date)}';
  }

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Gets the difference in days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

class ValidationUtils {
  /// Validates an email address
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
  }

  /// Validates a phone number (basic validation)
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone);
  }

  /// Validates a credit card number (basic Luhn algorithm)
  static bool isValidCreditCard(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) digit = (digit % 10) + 1;
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}

class ListUtils {
  /// Safely gets an item from a list by index
  static T? safeGet<T>(List<T> list, int index) {
    if (index < 0 || index >= list.length) return null;
    return list[index];
  }

  /// Chunks a list into smaller lists of specified size
  static List<List<T>> chunk<T>(List<T> list, int size) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += size) {
      chunks.add(list.sublist(i, math.min(i + size, list.length)));
    }
    return chunks;
  }

  /// Removes duplicates from a list
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
