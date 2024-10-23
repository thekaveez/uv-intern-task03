import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uv_intern_task_03/pages/home_page.dart';
import 'package:uv_intern_task_03/pages/login_page.dart';
import 'package:uv_intern_task_03/pages/welcome_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return const HomePage();
            } else {
              return const WelcomePage();
            }

          }),
    );
  }
}
