import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task_03/pages/register_page.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Image(image: Image.asset('assets/welcome.png').image),
            const SizedBox(height: 20),
            Text("Discover Your Dream Job Here",
            style: GoogleFonts.poppins(
              color: const Color(0xff1F41BB),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
              child: Text("Explore all the existing job roles based on your interest and study major",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 72),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()));
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
                  child: Text("Login", style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterPage()));
                    },
                    child: Text("Register", style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
