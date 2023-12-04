import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Helper/colors.dart';
import '../Helper/preferenceHelper.dart';
import '../helper/CartService.dart';
import '../helper/NetworkManger.dart';
import '../helper/api.dart';
import '../helper/appRoute.dart';
import '../helper/locator.dart';
import '../model/CategoryModel.dart';
import '../model/CreatePosInvoiceModel.dart';
import '../model/CustomerCreateModel.dart';
import '../model/GetCustomerListModel.dart';
import '../model/PayModeModel.dart';
import '../model/ProductModel1.dart';
import '../model/SubCategoryModel.dart';
import '../model/TaxModel.dart';
import 'package:http/http.dart' as http;

import '../model/postal_code_model.dart';

class DashBoardController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  TextEditingController CustomerName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController MobileNumber = TextEditingController();
  TextEditingController postalcode = TextEditingController();
  TextEditingController Address3 = TextEditingController();
  TextEditingController Address1 = TextEditingController();
  TextEditingController Address2 = TextEditingController();
  TextEditingController Country = TextEditingController();
  TextEditingController billDiscountController = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();

  TextEditingController cashcontroller = TextEditingController();
  TextEditingController netscontroller = TextEditingController();
  TextEditingController paynowcontroller = TextEditingController();
  TextEditingController onlinecontroller = TextEditingController();

  RxList<GetCustomerListModel> getCustomerList = <GetCustomerListModel>[].obs;
  GetCustomerListModel? selectedGetCustomerList;
  RxInt category = 0.obs;
  RxInt subcategory = 0.obs;
  RxInt product = 0.obs;
  Rx<List<CategoryModel>?> categoryList = (null as List<CategoryModel>?).obs;
  Rx<List<SubCategoryModel>?> subCategoryList = (null as List<SubCategoryModel>?).obs;

  final CartService cartService = getIt<CartService>();
  RxList<Product> cartAddedProduct = <Product>[].obs;
  RxList<Product> selectedProducts = <Product>[].obs;
  CustomerCreateModel? customerCreateModel;
  int totalPages = 1;
  int currentPage = 1;
  RxList<Product> productList = <Product>[].obs;
  RxList<TaxModel> taxModel = <TaxModel>[].obs;
  RxList<TaxModel> TruetaxModel = <TaxModel>[].obs;
  RxList<PayModeModel> payModeModel = <PayModeModel>[].obs;
  RxList<PayModeModel> truepayModeModel = <PayModeModel>[].obs;
  List<PayModeModel> selectedpayModeModel = [];
  TaxModel? selectedtaxModel;
  String taxType = "";
  RxList<TaxModel> CalculationTax = <TaxModel>[].obs;
  RxBool fetchIsLoading = false.obs;
  List<PostalModel> postalModel = [];
  String? taxTypes;
  String? taxTypeId;
  double? taxPerc;
  String? DateTimes;
  String? Date;
  double unittotal = 0;
  double subtotal = 0;
  double taxValue = 0;
  double grandTotal = 0;


 late CreatePosInvoiceModel createPosInvoiceModel;

  timeInital() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);
    String Dates = DateFormat("yyyy-MM-dd").format(now);
    print(formattedTime);
    Date = Dates;
    DateTimes = formattedTime;
  }

  getCustomer() async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    selectedGetCustomerList = null;
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.getCustomerList, parameters: {
        "OrganizationId": HttpUrl.org,
        //todo: this line is hardcodes
      });
      // isLoading.value = false;
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

  getAllCategoryList() {
    isLoading.value = true;
    NetworkManager.get(
        url: HttpUrl.getAllCategory,
        parameters: {"OrganizationId": HttpUrl.org}).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<CategoryModel> list = resJson.map<CategoryModel>((value) {
              return CategoryModel.fromJson(value);
            }).toList();
            list.insert(0, CategoryModel(name: "All"));
            categoryList.value = list;
            change(null, status: RxStatus.success());
            return;
          }
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
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: response.apiResponseModel!.message ?? '',
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: error.toString(),
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  getSubCategoryList({required String categoryId}) async {
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getAllSubCategory, parameters: {
      "OrganizationId": HttpUrl.org,
      "CategoryCode": categoryId,
    }).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SubCategoryModel> list =
                resJson.map<SubCategoryModel>((value) {
              return SubCategoryModel.fromJson(value);
            }).toList();
            list.insert(0, SubCategoryModel(name: "All"));
            subCategoryList.value = list;
            change(subCategoryList.value);
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          subCategoryList.value = null;
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
        subCategoryList.value = null;
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      subCategoryList.value = null;
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

  Future<void> getProductByCategoryId(
      {required String categoryId,
      required String subCategoryId,
      required bool isPagination}) async {
    change(null, status: RxStatus.loadingMore());
    await NetworkManager.get(
      url: HttpUrl.getAllProduct,
      parameters: {
        "OrganizationId": "1",
        "Category": categoryId ?? "",
        "SubCategory": subCategoryId ?? "",
        "pageNo": "$currentPage",
        "pageSize": "16"
      },
    ).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<Product> list = resJson.map<Product>((value) {
              return Product.fromJson(value);
            }).toList();
            if (!isPagination) {
              productList.clear();
            }
            productList.addAll(list);
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            updateProductCount();
            change(productList);
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value = [];
          currentPage = 1;
          change(null, status: RxStatus.error());
          // Get.showSnackbar(
          //   GetSnackBar(
          //     title: "Error",
          //     message: response.apiResponseModel!.message ?? '',
          //     icon: const Icon(Icons.error),
          //     duration: const Duration(seconds: 3),
          //   ),
          // );
        }
      } else {
        productList.value = [];
        currentPage = 1;
        change(null, status: RxStatus.error());
        String? message = response.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
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
  }

  Future<void> getTaxDetails() async {
    print("taxValu==========");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.taxApi,
      parameters: {
        "OrganizationId": HttpUrl.org,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            taxModel.value = resJson.map<TaxModel>((value) {
              return TaxModel.fromJson(value);
            }).toList();
            TruetaxModel.value = taxModel.value
                .where((element) => element.isActive = true)
                .toList();
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }


  Future<void> CalcualtiongetTaxDetails(String? taxCode) async {
    print("taxValu==========");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.taxApiGetby,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "TaxCode" : taxCode
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            CalculationTax.value = resJson.map<TaxModel>((value) {
              return TaxModel.fromJson(value);
            }).toList();
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  onCreateCustomer() async {
    isLoading.value = true;
    NetworkManager.post(
            URl: HttpUrl.createCustomer, params: customerCreateModel?.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          print(apiResponse.apiResponseModel!.status);
          Navigator.of(Get.context!).pop();
          showSuccessPopup();
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
    CustomerName.clear();
    MobileNumber.clear();
    emailController.clear();
    postalcode.clear();
    Address1.clear();
    Address2.clear();
    Address3.clear();
    Country.clear();
    selectedtaxModel = null;
    getCustomer();
  }

  showSuccessPopup() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Customer Created \n on successful!'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void updateProductCount() {
    for (var product in productList) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.unitcountController.text =
              element.unitcount.toInt().toString();
          product.unitcount = element.unitcount;
          product.isSelected = true;
          return true;
        } else {
          product.isSelected = false;
          return false;
        }
      });
    }
  }


  Future<void> GetPayMode() async {
    print("taxValu==========");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getPayMode,
      parameters: {
        "OrganizationId": HttpUrl.org,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            payModeModel.value = resJson.map<PayModeModel>((value) {
              return PayModeModel.fromJson(value);
            }).toList();
            truepayModeModel.value = payModeModel.value.where((element) => element.isActive == true && element.isPOS == true).toList();
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  getCustomerbycode() async {
    // isLoading.value = true;
    change(null, status: RxStatus.loading());
    selectedGetCustomerList = null;
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.getCustomerListGetBy, parameters: {
        "OrganizationId": HttpUrl.org,
        "CustomerCode" : "POS"
        //todo: this line is hardcodes
      });
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            getCustomerList.value = resJson.map<GetCustomerListModel>((value) {
              return GetCustomerListModel.fromJson(value);
            }).toList();
            print("getCustomerList.value.first.taxTypeId");
            print(getCustomerList.value.first.taxTypeId);
            // String? taxcode = resJson['TaxTypeId'];
            // CalcualtiongetTaxDetails(getCustomerList.value.first.taxTypeId);
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

  createPosInvoice() async {
    isLoading.value = true;
    int index = 1;
    int selectedIndex = 1;
    createPosInvoiceModel.pOSInvoiceDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });
    createPosInvoiceModel.posPaymentDetail?.forEach((element) {
      element.slNo = selectedIndex;
      selectedIndex += 1;
    });
      NetworkManager.post(URl: HttpUrl.createPosInvoiceApi, params:createPosInvoiceModel.toJson())
          .then((apiResponse) async {
        isLoading.value = false;
        if (apiResponse.apiResponseModel != null) {
          if (apiResponse.apiResponseModel!.status) {
            print(apiResponse.apiResponseModel!.data);
            String orderNo = apiResponse.apiResponseModel!.data;
            selectedGetCustomerList = null;
            cartAddedProduct.clear();
            selectedProducts.clear();
            cartService.clearCart();
            updateProductCount();
            Get.offAllNamed(AppRoutes.posInvoicePrintPreview,arguments: orderNo);
          } else {
            String? message = apiResponse.apiResponseModel?.message;
            PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          }
        } else {
          PreferenceHelper.showSnackBar(context: Get.context!, msg: apiResponse.error);
        }
      });
  }


  getPostal(String postalNo) async {
    fetchIsLoading.value = true;
    final Uri url = Uri.parse(
        "https://developers.onemap.sg/commonapi/search?searchVal=%22$postalNo%22&returnGeom=N&getAddrDetails=Y");
    fetchIsLoading.value = false;
    print(url);
    print(postalNo);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = json.decode(response.body);
      postalModel = (jsonData['results'] as List)
          .map((e) => PostalModel.fromJson(e))
          .toList();
      Address1.text = "${postalModel.first.BLKNO}, ${postalModel.first.ROADNAME}";
      Address3.text = (postalModel.first.BUILDING! == "NIL") ? "" : postalModel.first.BUILDING!;
    Country.text = "Singapore";
      // addressLine3Controller.text = postalModel.first.BUILDING!;
      change(postalModel);
      change(null, status: RxStatus.success());
      print(postalModel.first.ADDRESS);
    } else {
      change(null, status: RxStatus.error());
      Get.snackbar(
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.red,
        "Attention",
        "Please enter postal code",
        icon: const Icon(Icons.emergency),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

}
