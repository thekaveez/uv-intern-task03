import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task_03/components/my_text_form_field.dart';
import 'package:uv_intern_task_03/pages/login_page.dart';
import 'package:uv_intern_task_03/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> addUserDetails() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
      });
    } catch (e) {
      print("Error adding user details: $e");
    }
  }

  void signUserUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      if(passwordController.text.trim() == confirmPasswordController.text.trim()){

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

          await addUserDetails();



        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );

      }

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print("Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Login failed'),
        ),
      );
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
                const SizedBox(height: 60),
                Text("Create Account",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff1F41BB),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text("Create an account so you can explore all the existing jobs",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40,),
                MyTextFormField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false
                ),
                const SizedBox(height: 20,),
                MyTextFormField(
                  controller: emailController,
                    hintText: "Email",
                    obscureText: false
                ),
                const SizedBox(height: 20,),
                MyTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true
                ),
                const SizedBox(height: 20,),
                MyTextFormField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true
                ),
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          signUserUp();
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
                        child: Text("Sign up", style: GoogleFonts.poppins(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()));
                  },
                  child: Text("Already have an account?",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                ),
                const SizedBox(height: 20,),
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
                                  onPressed: () {
                                    AuthService().signInWithGoogle(context);
                                  },
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
