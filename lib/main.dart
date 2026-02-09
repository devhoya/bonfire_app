import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'presentation/bloc/session_bloc.dart';
import 'presentation/screens/app_splash_screen.dart';
import 'presentation/screens/main_fireplace_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup dependency injection
  setupDependencies();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const BonfireApp());
}

class BonfireApp extends StatefulWidget {
  const BonfireApp({super.key});

  @override
  State<BonfireApp> createState() => _BonfireAppState();
}

class _BonfireAppState extends State<BonfireApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonfire Focus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _showSplash
          ? AppSplashScreen(
              onFinished: () => setState(() => _showSplash = false),
            )
          : BlocProvider(
              create: (context) => getIt<SessionBloc>(),
              child: const MainFireplaceScreen(),
            ),
    );
  }
}
