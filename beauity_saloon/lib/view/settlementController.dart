import 'package:beauity_saloon/Helper/colors.dart';
import 'package:beauity_saloon/helper/NetworkManger.dart';
import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/helper/appRoute.dart';
import 'package:beauity_saloon/model/CashInOutDetailModel.dart';
import 'package:beauity_saloon/model/CashRegisterGetAllModel.dart';
import 'package:beauity_saloon/model/PosSettlement.dart';
import 'package:beauity_saloon/model/PosSettlementDetailModel.dart';
import 'package:beauity_saloon/model/LoginUserModel.dart';
import 'package:beauity_saloon/model/PosCurrencyDenamination.dart';
import 'package:beauity_saloon/model/PosPaymode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helper/preferencehelper.dart';

class SettlementController extends GetxController with StateMixin {
  TextEditingController settlementNo = TextEditingController();
  TextEditingController settlementDate = TextEditingController();
  TextEditingController cashRegister = TextEditingController();
  TextEditingController openingAmount = TextEditingController();
  TextEditingController totalCash = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController cashIn = TextEditingController();
  TextEditingController cashOut = TextEditingController();

  String selectedDate =
      DateFormat('dd-MM-yyyy').format(DateTime.now().toLocal());

  String? date;

  RxBool isLoading = false.obs;

  RxList<PosSettlementDetailModel> getSettlementList =
      <PosSettlementDetailModel>[].obs;
  RxList<PosCurrencyDenamination> getCurrencyDenominationList =
      <PosCurrencyDenamination>[].obs;
  RxList<PosPaymode> getPosPaymodeList = <PosPaymode>[].obs;

  PosSettlement createPosSettlement = PosSettlement();

  double currencyTotal = 0;
  double tot = 0;
  double posTot = 0;
  double val = 0.00;
  double excess = 0.00;
  double shortage = 0.00;

  LoginUserModel? userDetail;

  // late List<double> rowTotalList;

  RxList<CashRegisterGetAllModel> getCashRegisterList =
      <CashRegisterGetAllModel>[].obs;
  RxList<CashRegisterGetAllModel> getTerminalNameList =
      <CashRegisterGetAllModel>[].obs;
  RxList<CashInOutDetailModel> getCashInOutList = <CashInOutDetailModel>[].obs;

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
            getCashRegisterList.value =
                resJson.map<CashRegisterGetAllModel>((value) {
              return CashRegisterGetAllModel.fromJson(value);
            }).toList();
            print("getCashRegisterList.length from list");
            print(getCashRegisterList.length);
            print("getCashRegisterList.length from list");
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

  getTerminal(String terName, String code) async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
          url: HttpUrl.getTerminalName,
          parameters: {"OrganizationId": HttpUrl.org, "TerminalName": terName});
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getTerminalNameList.value =
                resJson.map<CashRegisterGetAllModel>((value) {
              return CashRegisterGetAllModel.fromJson(value);
            }).toList();
            openingAmount.text =
                getTerminalNameList.first.depositAmount?.toStringAsFixed(2) ??
                    "0.00";
            getSettlementDetail(code);
            totalCalc();

            print("getTerminalNameList.length from list");
            print(getTerminalNameList.length);
            print("getTerminalNameList.length from list");
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

  getSettlementDetail(String code) async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    userDetail = await PreferenceHelper.getUserData();
    try {
      final apiResponse = await NetworkManager.get(
          url: HttpUrl.getSettlementDetail,
          parameters: {
            "OrganizationId": HttpUrl.org,
            "CashRegisterCode": code,
            "TranDate": selectedDate,
            "User": userDetail?.username ?? ""
          });
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            /// change list getter name...
            getSettlementList.value =
                resJson.map<PosSettlementDetailModel>((value) {
              return PosSettlementDetailModel.fromJson(value);
            }).toList();
            getCurrencyDenominationList.value =
                getSettlementList.first.posCurrencyDenamination!;

            getCurrencyDenominationList.value.first.countControllers.clear();
            currencyTotal = 0.00;
            // rowTotalList = List.filled(getCurrencyDenominationList.length, 0.0);
            getPosPaymodeList.value = getSettlementList.first.posPaymode!;

            // for (int i = 0; i < getCurrencyDenominationList.length; i++) {
            //   countControllers.add(TextEditingController());
            // }

            // getTerminal(terName);
          }
          posTot = 0.00;
          for (var item in getPosPaymodeList.value) {
            posTot += item.paidAmount ?? 0.00;
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

  getCashInOut(String code) async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
          url: HttpUrl.getCashInOutDetail,
          parameters: {
            "OrganizationId": HttpUrl.org,
            "CashRegisterCode": code,
            "TranDate": selectedDate
            //todo: this line is hardcodes
          });
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getCashInOutList.value = resJson.map<CashInOutDetailModel>((value) {
              return CashInOutDetailModel.fromJson(value);
            }).toList();
            cashIn.text =
                getCashInOutList.first.cashInAmount?.toStringAsFixed(2) ??
                    "0.00";
            cashOut.text =
                getCashInOutList.first.cashOutAmount?.toStringAsFixed(2) ??
                    "0.00";

            print("getCashInOutList.length from list");
            print(getCashInOutList.first.cashInAmount);
            print(getCashInOutList.first.cashOutAmount);
            print("getCashInOutList.length from list");
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

  createSettlement() async {
    isLoading.value = true;
    int slNo = 1;
    for (var element in createPosSettlement.pOSSettlementDetails!) {
      element.slNo = slNo++;
    }
    NetworkManager.post(
            URl: HttpUrl.createPosSettlement,
            params: createPosSettlement?.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          print(apiResponse.apiResponseModel!.status);
          Get.showSnackbar(
            const GetSnackBar(
              messageText: Text(
                'Settlement done Successfully',
                style: TextStyle(
                  fontSize: 15,
                  color: MyColors.w,
                ),
              ),
              icon: Icon(Icons.done, color: MyColors.w,),
              duration: Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              margin: EdgeInsets.all(10),
              borderRadius: 15,
            ),
          );
          Get.toNamed(AppRoutes.settlementList);
         } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: apiResponse.error,
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

  }

  totalCalc() {
    if (getPosPaymodeList.value.isEmpty) {
      totalCash.text = '0.00';

      tot = (openingAmount.text.isNotEmpty
              ? double.parse(openingAmount.text)
              : 0.00) +
          (cashIn.text.isNotEmpty ? double.parse(cashIn.text) : 0.00) -
          (cashOut.text.isNotEmpty ? double.parse(cashOut.text) : 0.00);
      total.text = tot.toStringAsFixed(2);
    }
    if (getPosPaymodeList.value.isNotEmpty) {
      if (getPosPaymodeList.first.paymentType == "CASH") {
        totalCash.text =
            getPosPaymodeList.first.paidAmount?.toStringAsFixed(2) ?? '0.00';
        tot = (openingAmount.text.isNotEmpty
                ? double.parse(openingAmount.text)
                : 0.00) +
            (cashIn.text.isNotEmpty ? double.parse(cashIn.text) : 0.00) +
            (totalCash.text.isNotEmpty ? double.parse(totalCash.text) : 0.00) -
            (cashOut.text.isNotEmpty ? double.parse(cashOut.text) : 0.00);
        total.text = tot.toStringAsFixed(2);
      } else {
        totalCash.text = '0.00';
        tot = (openingAmount.text.isNotEmpty
                ? double.parse(openingAmount.text)
                : 0.00) +
            (cashIn.text.isNotEmpty ? double.parse(cashIn.text) : 0.00) -
            (cashOut.text.isNotEmpty ? double.parse(cashOut.text) : 0.00);
        total.text = tot.toStringAsFixed(2);
      }
    }
  }

  shortExcessCalc() {
    val = double.parse(totalCash.text) - currencyTotal;

    if (val.isNegative) {
      shortage = 0.00;
      excess = val.abs();
    } else {
      excess = 0.00;
      shortage = val;
    }
  }
}
