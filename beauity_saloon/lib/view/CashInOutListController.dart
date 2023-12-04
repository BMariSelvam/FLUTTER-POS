import 'package:beauity_saloon/Helper/preferenceHelper.dart';
import 'package:beauity_saloon/helper/NetworkManger.dart';
import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/model/CashRegisterGetAllModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashInOutListController extends GetxController with StateMixin{
  bool isFilter = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController cashRegController = TextEditingController();
  TextEditingController tranNoController = TextEditingController();

  String? fromDate;
  String? toDate;
  late DateTime toFromDate;

  RxBool isLoading = false.obs;

  RxList<CashRegisterGetAllModel> getCashRegisterList = <CashRegisterGetAllModel>[].obs;

  getCashRegister() async {
    // isLoading.value = true;
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.getCashRegister, parameters: {
        "OrganizationId": HttpUrl.org,
      });
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getCashRegisterList.value = resJson.map<CashRegisterGetAllModel>((value) {
              return CashRegisterGetAllModel.fromJson(value);
            }).toList();
            print("getCashRegister.length from list");
            print(getCashRegisterList.length);
            print("getCashRegister.length from list");
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
      }
      change(null, status: RxStatus.success());
    } catch (error) {
      print(error.toString());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}