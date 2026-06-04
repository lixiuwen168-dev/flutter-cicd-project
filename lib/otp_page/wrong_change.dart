import 'package:app_foods/otp_page/resetpassword_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/onbaording/login_page.dart';

class WrongChange extends StatefulWidget {
  const WrongChange({super.key});

  @override
  State<WrongChange> createState() => _WrongChangeState();
}

class _WrongChangeState extends State<WrongChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: Padding(
        padding: const EdgeInsets.only(top:10, left: 16, right: 16),
        child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("images/wrong_sign.png",
                      width: 300,
                      height: 300,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Text("Password Changing Failed!",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,)
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(textAlign: TextAlign.center,
                      "There's a temporary problem with the service. Please try again later.",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 150       ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetpasswordPage()),
                          );
                        },
                        child: Text(
                          "TRY AGAIN",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "BACK TO LOGIN",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}
