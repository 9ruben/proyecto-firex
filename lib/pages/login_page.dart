import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetask/models/user_model.dart';
import 'package:firetask/pages/home_page.dart';
import 'package:firetask/pages/register_page.dart';
import 'package:firetask/services/my_service_firestore.dart';
import 'package:firetask/ui/general/colors.dart';
import 'package:firetask/ui/widgets/button_custom_widget.dart';
import 'package:firetask/ui/widgets/general_widgets.dart';
import 'package:firetask/ui/widgets/textfield_normal_widget.dart';
import 'package:firetask/ui/widgets/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  // Function to log in with email and password
  Future<void> _login() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      // Handle different error cases
      if (error.code == "invalid-email") {
        showSnackBarError(context, "El correo electrónico es inválido");
      } else if (error.code == "user-not-found") {
        showSnackBarError(context, "El usuario no está registrado");
      } else if (error.code == "wrong-password") {
        showSnackBarError(context, "La contraseña es incorrecta");
      }
    }
  }

  // Function to log in with Google
  Future<void> _loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) return; // User cancelled the login

    GoogleSignInAuthentication googleSignInAuth = await googleSignInAccount.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuth.idToken,
      accessToken: googleSignInAuth.accessToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );

      userService.existUser(userCredential.user!.email!).then((exists) {
        if (!exists) {
          userService.addUser(userModel).then((result) {
            if (result.isNotEmpty) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            }
          });
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
        }
      });
    }
  }

  // Function to log in with Facebook
  Future<void> _loginWithFacebook() async {
    LoginResult loginResult = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
      permissions: ['email', 'public_profile'],
    );

    if (loginResult.status == LoginStatus.success) {
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();
      AccessToken accessToken = loginResult.accessToken!;

      OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          fullName: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );

        userService.existUser(userCredential.user!.email!).then((exists) {
          if (!exists) {
            userService.addUser(userModel).then((result) {
              if (result.isNotEmpty) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
              }
            });
          } else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
          }
        });
      }
    } else {
      print("Login fallido con Facebook: ${loginResult.status}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                caja30(),
                SvgPicture.asset(
                  'assets/images/login.svg',
                  height: 180.0,
                ),
                caja30(),
                Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                caja10(),
                TextfieldNormalWidget(
                  hintText: "Correo electrónico",
                  icon: Icons.email,
                  controller: _emailController,
                ),
                caja10(),
                caja6(),
                TextFieldPasswordWidget(
                  controller: _passwordController,
                ),
                caja20(),
                ButtonCustomWidget(
                  text: "Iniciar Sesión",
                  icon: "check",
                  color: primary,
                  onPressed: _login,
                ),
                caja20(),
                Text("O ingresa con tus redes sociales"),
                caja20(),
                ButtonCustomWidget(
                  text: "Iniciar sesión con Google",
                  icon: "google",
                  color: Color(0xfff84b2a),
                  onPressed: _loginWithGoogle,
                ),
                caja20(),
                ButtonCustomWidget(
                  text: "Iniciar sesión con Facebook",
                  icon: "facebook",
                  color: Color(0xff507CC0),
                  onPressed: _loginWithFacebook,
                ),
                caja20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aún no estás registrado? "),
                    cajaWith10(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        "Regístrate",
                        style: TextStyle(fontWeight: FontWeight.w600, color: primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
