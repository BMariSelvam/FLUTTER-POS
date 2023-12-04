import 'package:beauity_saloon/view/splashScreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  // @override
  // void initState() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     Get.to(
  //         const LoginPage()
  //     );
  //   });
  //
  //   super.initState();
  // }



  late SplashCOntroller controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SplashCOntroller());
    // Timer(const Duration(seconds: 1),
    //         () => Get.offAndToNamed(AppRoute.loginScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: MediaQuery.of(context).size.height/3,
          child:Image.asset("assets/images/appxperts.png")
        ),
      ),
    );
  }
  }