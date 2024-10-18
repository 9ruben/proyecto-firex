import 'package:firebase_core/firebase_core.dart';
import 'package:firetask/pages/home_page.dart';
import 'package:firetask/pages/login_page.dart';
import 'package:firetask/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  runApp(MyApp());
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firetask",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Colors.blue, // Cambia a tu color deseado
        // Puedes agregar más personalizaciones aquí
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => LoginPage()); // Página predeterminada
      },
    );
  }
}
