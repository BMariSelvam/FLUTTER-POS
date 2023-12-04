import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import 'LoginControoler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LoginController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LoginController());
    loadUserEmailPassword();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
          key: controller.formKey1,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        scale: 3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        color: MyColors.w,
                        height: height(context) / 1.5,
                        width: width(context) / 1.5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: controller.emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLength: 30,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                    // Deny whitespace
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"[^\w\s]")),
                                    // Deny special characters
                                  ],
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: 'User Name',
                                    fillColor: Colors.white,
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide.none,
                                    //     borderRadius: BorderRadius.circular(10.0)),
                                    border: OutlineInputBorder(),
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the User Name';
                                    } else if (value!.startsWith(' ')) {
                                      return 'Cannot start with a space';
                                    } else if (value!.endsWith(' ')) {
                                      return 'Cannot end with a space';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.passwordController,
                                  obscureText: controller.passwordVisibility,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLength: 16,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Password',
                                    counterText: "",
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          controller.passwordVisibility =
                                              !controller.passwordVisibility;
                                        });
                                      },
                                      icon: controller.passwordVisibility
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                    ),
                                    border: const OutlineInputBorder(),
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide.none,
                                    //     borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the Password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: height(context) / 25),
                                remberMeCheckBox(),
                                SizedBox(height: height(context) / 25),
                                const Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: MyColors.mainTheme),
                                ),
                                SizedBox(height: height(context) / 25),
                                (controller.isLoading.value == true)
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0))),
                                        onPressed: () {
                                          // Get.offAllNamed(AppRoutes.dashboardScreen);

                                          FocusScope.of(context).unfocus();
                                          if (controller.formKey1.currentState!
                                              .validate()) {
                                            controller.onLoginTapped();
                                          }
                                        },
                                        child: const Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    // Center(
                    //   child: Container(
                    //     width: width(context)/1,
                    //     decoration: const BoxDecoration(
                    //       // border: Border.all(color: Colors.black),
                    //         borderRadius: BorderRadius.all(Radius.circular(30))
                    //     ),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(25.0), // Set the desired radius here
                    //       child: Card(
                    //           elevation: 0,
                    //           color: Colors.white.withOpacity(0.3),
                    //           child: Padding(
                    //             padding:
                    //             const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    //             child: Column(
                    //               children: [
                    //                 const SizedBox(height: 10),
                    //                 TextFormField(
                    //                   controller: controller.userIdController,
                    //                   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //                   maxLength: 30,
                    //                   inputFormatters: [
                    //                     FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
                    //                     FilteringTextInputFormatter.deny(RegExp(r"[^\w\s]")), // Deny special characters
                    //                   ],
                    //                   decoration: InputDecoration(
                    //                     filled: true,
                    //                     hintText: 'User Name',
                    //                     fillColor: Colors.white,
                    //                     border: OutlineInputBorder(
                    //                         borderSide: BorderSide.none,
                    //                         borderRadius: BorderRadius.circular(10.0)
                    //                     ),
                    //                     counterText: "",
                    //                     contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),),
                    //                   validator: (value) {
                    //                     if (value == null || value.isEmpty) {
                    //                       return 'Please enter the User Name';
                    //                     } else if (value!.startsWith(' ')) {
                    //                       return 'Cannot start with a space';
                    //                     } else if (value!.endsWith(' ')) {
                    //                       return 'Cannot end with a space';
                    //                     } else {
                    //                       return null;
                    //                     }
                    //                   },
                    //                 ),
                    //                 const SizedBox(height: 20),
                    //                 TextFormField(
                    //                   controller: controller.passwordController,
                    //                   obscureText: controller.passwordVisibility,
                    //                   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //                   maxLength: 16,
                    //                   decoration: InputDecoration(
                    //                     filled: true,
                    //                     hintText: 'Password',
                    //                     counterText: "",
                    //                     fillColor: Colors.white,
                    //                     suffixIcon: IconButton(
                    //                       onPressed: () {
                    //                         setState(() {
                    //                           controller.passwordVisibility =
                    //                           !controller.passwordVisibility;
                    //                         });
                    //                       },
                    //                       icon: controller.passwordVisibility
                    //                           ? const Icon(
                    //                         Icons.visibility_off,
                    //                         color: Colors.grey,
                    //                       )
                    //                           : const Icon(
                    //                         Icons.visibility,
                    //                         color: Colors.grey,
                    //                       ),
                    //                     ),
                    //                     border: OutlineInputBorder(
                    //                         borderSide: BorderSide.none,
                    //                         borderRadius: BorderRadius.circular(10.0)
                    //                     ),
                    //                     contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),),
                    //                   validator: (value) {
                    //                     if (value == null || value.isEmpty) {
                    //                       return 'Please enter the Password';
                    //                     } else {
                    //                       return null;
                    //                     }
                    //                   },
                    //                 ),
                    //                 const SizedBox(height: 35),
                    //                 (controller.isLoading1.value == true)
                    //                     ? Center(child: const CircularProgressIndicator())
                    //                     : ElevatedButton(
                    //
                    //                     style: ElevatedButton.styleFrom(
                    //
                    //                         shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                             BorderRadius.circular(
                    //                                 10.0))),
                    //                     onPressed: () {
                    //                       FocusScope.of(context).unfocus();
                    //                       if (controller.formKey1.currentState!
                    //                           .validate()) {
                    //
                    //                         // controller.loginModel =
                    //                         //     LoginModel(
                    //                         //   msgSourceChannelID: '120',
                    //                         //   accessToken: controller.access_token,
                    //                         //   reqRefNo:
                    //                         //       controller.referenceNumber,
                    //                         //   gcifID: vGcifNo,
                    //                         //   corpId: vGcifNo,
                    //                         //   loginId: vLoginId,
                    //                         //   password: controller
                    //                         //       .passwordController.text,
                    //                         //   mpin: '',
                    //                         //   languageCode: "EN",
                    //                         //   location: controller
                    //                         //       .currentCity.value,
                    //                         //   ipAddr: '120.10.0.1',
                    //                         //   os: controller.osName,
                    //                         //   deviceId: controller.deviceId,
                    //                         //   deviceType: 'mobileNo',
                    //                         //   appName: 'Customer Portal',
                    //                         //   appVersionCode: "1.0.0",
                    //                         //   requestFlag: "N",
                    //                         // );
                    //                       }
                    //                       // Get.toNamed(AppRoute.homeScreen);
                    //                     },
                    //                     child: const Text(
                    //                       'LOGIN',
                    //                       style: TextStyle(
                    //                         fontWeight: FontWeight.w700,
                    //                       ),
                    //                     )),
                    //               ],
                    //             ),
                    //           )),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  remberMeCheckBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 24.0,
        width: 24.0,
        child: Theme(
            data: ThemeData(
                unselectedWidgetColor: MyColors.mainTheme // Your color
                ),
            child: Checkbox(
              activeColor: MyColors.mainTheme,
              value: controller.isChecked,
              onChanged: (value) {
                setState(() {
                  handleRemeberme(value!);
                });
              },
            )),
      ),
      const SizedBox(width: 10.0),
      const Text("Remember Me",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.black,
          ))
    ]);
  }

  //handle remember me function
  handleRemeberme(bool value) {
    controller.isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('User Name', controller.emailController.text);
        prefs.setString('password', controller.passwordController.text);
      },
    );
    setState(() {
      controller.isChecked = value;
    });
  }

  //load email and password
  loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("User Name") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          controller.isChecked = true;
        });
        controller.emailController.text = _email ?? "";
        controller.passwordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}
