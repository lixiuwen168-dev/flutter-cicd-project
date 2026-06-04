import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: 30, color: Colors.black87),
              ),
            ),
            Center(
              child: Image.asset(
                "images/register.png",
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                "Welcome Register Page",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Register now and start enjoying your favorite meals with just a few taps!",
                    style: GoogleFonts.poppins(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Handle registration logic here
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: Colors.blueGrey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              " Already have an account? Login",
              style: GoogleFonts.poppins(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
