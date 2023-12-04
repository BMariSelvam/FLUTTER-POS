import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/NetworkManger.dart';
import '../helper/api.dart';
import '../helper/appRoute.dart';
import '../helper/colors.dart';

class LoginController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  final formKey1 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;
  bool isChecked = false;

  onLoginTapped() async {
    print("1111111111111111");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.loginApi, params: {
      "OrgId": HttpUrl.org,
      "Username": emailController.text.trim(),
      "Password": passwordController.text.trim(),
      "BranchCode": "HO"
    }).then((apiResponse) async {
      print("1111111111111111");
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          // Get.offAllNamed(AppRoutes.bottomNavBar);
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;

          if (customerJson != null) {
            Get.offAllNamed(AppRoutes.dashboardScreen);
            // await PreferenceHelper.saveUserData(customerJson)
            //     .then((value) async {
            //   Get.offAllNamed(AppRoutes.bottomNavBar);
            // });
            // await PreferenceHelper.saveEmail(key: "my_key", value: emailController.text);
          } else {
            change(null, status: RxStatus.error());
            Get.snackbar(
              "Error",
              "Customer data is empty!",
              margin: EdgeInsets.all(20),
              backgroundColor: MyColors.red,
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = message;
        print("API Response Message (Error): $message");

        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "Attention",
          message ?? "Your Username or Password are Incorrect",
          icon: const Icon(Icons.emergency),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

}
