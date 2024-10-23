import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task_03/pages/auth_page.dart';
import 'package:uv_intern_task_03/pages/home_page.dart';
import 'package:uv_intern_task_03/pages/register_page.dart';

import '../components/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomePage()),
        // );
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Login failed'),
        ),
      );

    } finally {
      Navigator.pop(context);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text("Login Here",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff1F41BB),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text("Welcome back you’ve been missed!",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 80,),
                MyTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false
                ),
                const SizedBox(height: 30,),
                MyTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot your password?",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff1F41BB),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          signUserIn();

                        },
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 48, vertical: 16)),
                            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xff1F41BB)),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            )
                        ),
                        child: Text("Sign in", style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterPage()));
                  },
                  child: Text("Create new account?",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                ),
                const SizedBox(height: 30,),
                Text("Or continue with",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff1F41BB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff1f4fb),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image(image: Image.asset('assets/google_icon.png', width: 24, height: 24, color: Colors.black).image)
                              )
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff1f4fb),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.facebook, size: 24, color: Colors.black)
                              )
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff1f4fb),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.apple, size: 24, color: Colors.black)
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
