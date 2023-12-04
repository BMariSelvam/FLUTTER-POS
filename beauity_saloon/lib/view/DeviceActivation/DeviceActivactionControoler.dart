import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Helper/preferenceHelper.dart';
import '../../helper/api.dart';
import '../LoginScreen.dart';


class DeviceActivationController extends GetxController with StateMixin {
  TextEditingController uenNumberCOntroller = TextEditingController();
  TextEditingController activationController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? osName;
  String? deviceName;
  String? deviceId;

  @override
  onInit() async {
    super.onInit();
    getDeviceInformation();
  }

  getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      // For iOS devices
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      osName = 'ios';
      deviceName = iosDeviceInfo.name;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else {
      // For Android devices
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      osName = 'android';
      deviceName = androidDeviceInfo.model;
      deviceId = androidDeviceInfo.androidId;
    }
    print("deviceID : $deviceId");
  }

  postData() async {
    String url = "${HttpUrl.mobileCheckUrl}/CompanyDeviceInfoDetail/ActivateDevice";
    final apiUrl = Uri.parse(url);
    final requestBody = {
      // "OrgId": "5",
      "UENNo": uenNumberCOntroller.text,
      "Project": "SALOONAPP",
      "ActivationCode": activationController.text,
      "DeviceID": "${deviceId}",
      "DeviceShortCode": nameController.text,
      "Status": true,
      "CreatedBy": "admin"
    };
    print(requestBody);
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the body as JSON
    );
    if (response.statusCode == 200) {
      print(response);
      var data = json.decode(response.body);
      if (data['Code'] == 200 && data['Status']){
        Get.snackbar("Your Activation", "Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.black26);
        await PreferenceHelper.saveActvationCode(key: 'my_key', value: uenNumberCOntroller.text);
        Get.to(const SplashScreen());
      } else {
        Get.snackbar("Failed!", "${data['Message']}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.black26);
      }
      print('POST request successful!');
      print('Response data: ${response.body}');
    } else {
      Get.snackbar("", "Invalid Data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.black26);
      print('POST request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }


  }
}
