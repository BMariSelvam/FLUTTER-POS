import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helper/NetworkManger.dart';
import '../helper/api.dart';
import '../model/GetPrintModel/GetPrintPreviewModel.dart';
import '../model/OrgDetailsModel.dart';
import 'package:http/http.dart' as http;


class PrintController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxList<GetPrintPreviewModel> payModeModel = <GetPrintPreviewModel>[].obs;
  RxList<OrgDetailsModel> orgdetailsModel = <OrgDetailsModel>[].obs;
  RxList<OrgDetailsModel> totalorgdetailsModel = <OrgDetailsModel>[].obs;
  String orderDate = "";

  getOrgDetails() async {
    change(null, status: RxStatus.loading());
    isLoading.value = true;
    await NetworkManager.get(url: HttpUrl.getOrgDetalis, parameters: {}).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          print(resJson);
          if (resJson != null) {
            print(resJson);
            orgdetailsModel.value = resJson.map<OrgDetailsModel>((value) {
              return OrgDetailsModel.fromJson(value);
            }).toList();

            change(null, status: RxStatus.success());
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        change(null, status: RxStatus.error());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  fetchData() async {
    final response = await http.get(Uri.parse(HttpUrl.getOrgDetalis));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List? resJson = data['Data'];

      print(resJson);
      if (resJson != null) {
        print(resJson);
        orgdetailsModel.value = resJson.map<OrgDetailsModel>((value) {
          return OrgDetailsModel.fromJson(value);
        }).toList();
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    }
  }
    getSubCategoryList(String? orderNumber) async {
      change(null, status: RxStatus.loading());
      isLoading.value = true;
      await NetworkManager.get(url: HttpUrl.getPosInvoiceDetails, parameters: {
        "OrganizationId": HttpUrl.org,
        "OrderNo": orderNumber,
      }).then((response) {
        isLoading.value = false;
        if (response.apiResponseModel != null &&
            response.apiResponseModel!.status) {
          change(null, status: RxStatus.success());
          if (response.apiResponseModel!.data != null) {
            List? resJson = response.apiResponseModel!.data!;
            print(resJson);
            if (resJson != null) {
              print(resJson);
              payModeModel.value = resJson.map<GetPrintPreviewModel>((value) {
                return GetPrintPreviewModel.fromJson(value);
              }).toList();
              final inputDate = DateTime.parse(
                  "${payModeModel.first.orderDate}");
              orderDate = DateFormat("dd-MM-yyyy").format(inputDate);
              print(payModeModel.value);
              change(null, status: RxStatus.success());
              return;
            }
            change(null, status: RxStatus.success());
          } else {
            change(null, status: RxStatus.error());
            Get.showSnackbar(
              GetSnackBar(
                title: "Error",
                message: response.apiResponseModel!.message ?? '',
                icon: const Icon(Icons.error),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } else {
          change(null, status: RxStatus.error());
        }
      }).catchError((error) {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: error.toString(),
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      });
      // Similar usage for POST, PUT, and DELETE requests
    }
  }