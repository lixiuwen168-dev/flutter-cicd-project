import 'package:app_foods/service/wiget_support.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'both_register_login_page.dart';

class Onbaording extends StatefulWidget {
  const Onbaording({super.key});

  @override
  State<Onbaording> createState() => _OnbaordingState();
}

class _OnbaordingState extends State<Onbaording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: Container(
        margin: EdgeInsets.only(top: 45.0),
        child: Column(
          children: [
            Image.asset("images/pic1.png"),
            SizedBox(height: 20),
            Text(
              "The Fastest\nFood Delivery",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),  
            Text(
              "Craving Something delicious?"
              "\nOrder now and get your favorite"
              "\ndelivery fast!",
              style: GoogleFonts.poppins(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BothRegisterLoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    "Get Start",
                    style: GoogleFonts.poppins(
                      color: Colors.blueGrey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
