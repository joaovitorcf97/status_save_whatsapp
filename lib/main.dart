import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_save_whatsapp/pages/splash_screen.dart';
import 'package:status_save_whatsapp/provider/bottom_nav_provider.dart';
import 'package:status_save_whatsapp/provider/get_statuses_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider<GetStatusesProvider>(
            create: (_) => GetStatusesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
