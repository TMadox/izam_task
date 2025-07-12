import 'package:go_router/go_router.dart';
import 'package:izam_task/src/catalog/pages/catalog_page.dart';
import 'package:izam_task/src/intro/pages/splash_page.dart';

class AppRouter {
  static GoRouter get router => _router;
  static const String splash = '/splash';
  static const String catalog = '/catalog';
  static const String cart = '/cart';
  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, name: 'splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: catalog, name: 'catalog', builder: (context, state) => const CatalogPage()),
    ],
    // Handle unknown routes
    errorBuilder: (context, state) => const CatalogPage(),
  );
}
