import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/Services/provider.dart';
import 'package:r_creative/Controller/provider/Forgot_Password.dart';
import 'package:r_creative/Controller/provider/Login_provider.dart';
import 'package:r_creative/Controller/provider/More_provider.dart';
import 'package:r_creative/Controller/provider/Profile_provider.dart';
import 'package:r_creative/Controller/provider/auth_provider.dart';
import 'package:r_creative/Controller/provider/get_spot_provider.dart';
import 'package:r_creative/view/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Failed to load .env file: $e"); 
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SpotratesProvider()..getSpotrates()),
        ChangeNotifierProvider(create: (_) => MoreProvider()),
        ChangeNotifierProvider(create: (_) => ForgotProvider()),
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'R Creative',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}