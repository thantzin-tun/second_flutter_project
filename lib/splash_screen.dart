import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:get/get.dart";
import 'package:second_flutter_project/screen/product/product_home_screen.dart';
import 'package:second_flutter_project/screen/contact/contact_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ContactScreen())
        // );
      // Get.to(const ContactScreen());
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          ColorFiltered(
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 237, 203, 203), BlendMode.darken),
              child: Image.asset("assets/images/splash.jpg",
                  height: double.infinity, fit: BoxFit.fitHeight)),
         Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "Beautiful Girls",
                style: GoogleFonts.dynaPuff(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 45),
              ),
              const SizedBox(height: 30,),
              const CircularProgressIndicator(color: Colors.white,)
              ]
            ),
        ]),
      )),
    );
  }
}
