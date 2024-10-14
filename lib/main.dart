import 'package:cyber_hulk/services/notification_services.dart';
import 'package:cyber_hulk/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationServices notificationServices = NotificationServices();
  await notificationServices.initNotification();
  await Hive.initFlutter();
  Box box = await Hive.openBox('logindata');
  bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(
        isLoggedIn: isLoggedIn,
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
