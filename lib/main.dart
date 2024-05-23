import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/features/user/screens/user_listing_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const UserListingScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
    );
  }
}
