import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:izam_task/app/utils/app_router.dart';
import 'package:izam_task/app/widgets/index.dart';
import 'package:izam_task/shared/widgets/index.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc storage
  final storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path));

  HydratedBloc.storage = storage;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: KeyboardDismissWrapper(
        child: MaterialApp.router(
          title: AppConstants.appTitle,
          routerConfig: AppRouter.router,
          theme: AppConstants.appTheme,
          builder: (context, child) => CartListenerWrapper(child: child!),
        ),
      ),
    );
  }
}
