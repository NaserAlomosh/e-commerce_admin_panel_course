import 'package:ecommerce_admin/core/services/upload_image_service.dart';
import 'package:ecommerce_admin/feachers/home/view/home_view.dart';
import 'package:ecommerce_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UploadImageService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appLevelKey,
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
