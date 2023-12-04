import 'dart:async';
import 'dart:convert';

import 'package:beauity_saloon/Helper/preferenceHelper.dart';
import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/view/LoginScreen.dart';
import 'package:beauity_saloon/view/printPreview.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper/appRoute.dart';
import 'DeviceActivation/DeviceValidationScreen.dart';


class SplashCOntroller extends GetxController with StateMixin {
  String? osName;
  String? deviceName;
  String? deviceId;
  final users = [].obs;
  Rx<bool> isLoading = false.obs;


  @override
  onInit() async {
    super.onInit();
    CheckActivatOrDeactivate();
  }

  CheckActivatOrDeactivate() async {
    String? Activationcode = await PreferenceHelper.getActivationCode(key: 'my_key');
    if (Activationcode != null) {
      print("Activationcode in");
      print(Activationcode);
      getDeviceInformation();
      // Get.to(const LoginPage());
    } else {
      print("Activationcode out");
      // Get.to(const DeviceVAlidationScreen());
      Get.to(const SplashScreen());
      // Get.to(const PosInvoicePrintPreview());
    }
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
  SpleshApis();
}

SpleshApis() async {
  String url = "${HttpUrl.mobileCheckUrl}/CompanyDeviceInfoDetail/GetbyDeviceId?";
  var uri = Uri.parse(url);
  Map<String, dynamic> parameters = {
    "UENNo" : await PreferenceHelper.getActivationCode(key: 'my_key'),
    "DeviceId": "${deviceId}",
    "Project": "SALOONAPP"
  };
  if (parameters != null) {
    uri = Uri.http(uri.authority, uri.path, parameters);
    print(uri);
    print(parameters);
  }
  var response = await http.get(uri);
  print("response");
  print(response.body);
  var data = json.decode(response.body);
  print(data['Status']);
  if(data['Code'] == 200 && data['Status']) {
    Timer(const Duration(seconds: 1),
            () =>   Get.offAllNamed(AppRoutes.splashScreen));
  } else {
    Timer(const Duration(seconds: 1),
            () => Get.offAndToNamed(DeviceVAlidationScreen.routeName));
  }
  return data;
}



}
