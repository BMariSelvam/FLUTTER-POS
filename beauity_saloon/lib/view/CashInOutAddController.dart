import 'package:beauity_saloon/Helper/preferenceHelper.dart';
import 'package:beauity_saloon/helper/NetworkManger.dart';
import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/model/CashRegisterGetAllModel.dart';
import 'package:beauity_saloon/model/GetCustomerListModel.dart';
import 'package:beauity_saloon/model/GetSupplierListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashInOutAddController extends GetxController with StateMixin{
  TextEditingController tranNoController = TextEditingController();
  TextEditingController tranDateController = TextEditingController();
  TextEditingController cashRegisterController = TextEditingController();
  TextEditingController refNoController = TextEditingController();
  TextEditingController tranTypeController = TextEditingController(text: 'IN');
  TextEditingController amountController = TextEditingController();
  TextEditingController cusOrSupController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  List<String> type = ['IN', 'OUT'];

  bool tranType = true;

  String? date;
  DateTime selectedDate = DateTime.now();

  RxBool isLoading = false.obs;

  RxList<CashRegisterGetAllModel> getCashRegisterList = <CashRegisterGetAllModel>[].obs;

  RxList<GetCustomerListModel> getCustomerList = <GetCustomerListModel>[].obs;

  RxList<GetSupplierListModel> getSupplierList = <GetSupplierListModel>[].obs;

  getCashRegister() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.getCashRegister, parameters: {
        "OrganizationId": HttpUrl.org,
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
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
          // change(null, status: RxStatus.success());
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

  getCustomer() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.getCustomerList, parameters: {
        "OrganizationId": HttpUrl.org,
        //todo: this line is hardcodes
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getCustomerList.value = resJson.map<GetCustomerListModel>((value) {
              return GetCustomerListModel.fromJson(value);
            }).toList();
            return;
          }
          // change(null, status: RxStatus.success());
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

  getSupplier() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.getSupplierList, parameters: {
        "OrganizationId": HttpUrl.org,
        //todo: this line is hardcodes
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getSupplierList.value = resJson.map<GetSupplierListModel>((value) {
              return GetSupplierListModel.fromJson(value);
            }).toList();
            return;
          }
          // change(null, status: RxStatus.success());
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