import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/model/CreatePosInvoiceModel.dart';
import 'package:beauity_saloon/model/PosPaymentDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/appRoute.dart';
import '../helper/colors.dart';
import '../helper/searchdropdowntextfield.dart';
import '../helper/size.dart';
import '../helper/textformfield.dart';
import '../model/CustomerCreateModel.dart';
import '../model/GetCustomerListModel.dart';
import '../model/PayModeModel.dart';
import '../model/PosInvoiceDetail.dart';
import '../model/ProductModel1.dart';
import '../model/TaxModel.dart';
import 'DashboardController.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _HorixzontalscrollController = ScrollController();
  final ScrollController _scrollgridController = ScrollController();

  String textFieldValue = '';
  String dropdownValue = 'Option 1';
  final _scrollThreshold = 200.0;
  String? cateogryId = '';
  String? subCateogryId = '';
  final ScrollController _scrollController = ScrollController();
  List<String> savedProduct = [];
  late DashBoardController controller;
  double unitTotal = 0;
  double totalAmount = 0.0;
  double BalencAmount = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(DashBoardController());
    initialCall();
  }

  initialCall() async {
    controller.getTaxDetails();
    controller.getCustomerbycode();
    controller.getCustomer();
    controller.getAllCategoryList();
    controller.GetPayMode();
    controller.timeInital();
    await controller.getProductByCategoryId(
        categoryId: cateogryId ?? '',
        subCategoryId: subCateogryId ?? '',
        isPagination: false);
    controller.CalcualtiongetTaxDetails("33");
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (controller.currentPage <= controller.totalPages &&
          !controller.status.isLoadingMore) {
        await controller.getProductByCategoryId(
            categoryId: cateogryId ?? '',
            subCategoryId: subCateogryId ?? '',
            isPagination: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: MyColors.mainTheme,
              centerTitle: true,
              title: const Text(
                "IVEPOS",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.settlementList);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8, top: 10, bottom: 5, left: 5),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              right: 8, top: 5, bottom: 5, left: 8),
                          child: Text(
                            "Settlement",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.cashInOutList);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8, top: 10, bottom: 5, left: 5),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              right: 8, top: 5, bottom: 5, left: 8),
                          child: Text(
                            "CashInOut",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.splashScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15, top: 10, bottom: 5, left: 5),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              right: 8, top: 5, bottom: 5, left: 8),
                          child: Text(
                            "Logout",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    ))

                // Text("Logout")
                ],
              ),
          body: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width /
                    2, // Adjust the width here
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CartView(context),
                // Add your content for the left container here
              ),
              Expanded(
                child: Container(
                  color: MyColors.greyForTextFormField,
                  height: MediaQuery.of(context)
                      .size
                      .height, // Use MediaQuery for height
                  child: Column(
                    children: [
                      Container(
                          width: width(context),
                          color: Colors.white,
                          child: buildCategoryListView(context)),
                      Container(
                          width: width(context),
                          color: Colors.white,
                          child: buildSubCategoryListView()),
                       Expanded(
                         child: SingleChildScrollView(
                           controller: _scrollController,
                           scrollDirection: Axis.vertical,
                           child: _productListView(),),
                       )

                      // _productListView()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildCategoryListView(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
          controller: _HorixzontalscrollController,
          shrinkWrap: true,
          itemCount: controller.categoryList.value?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                controller.category.value = index;
                controller.currentPage = 1;
                controller.totalPages = 1;
                controller.productList.clear();
                if (index == 0) {
                  cateogryId = "";
                  subCateogryId = "";
                  controller.subCategoryList.value = null;
                  await controller.getProductByCategoryId(
                      categoryId: '', subCategoryId: '', isPagination: false);
                } else {
                  cateogryId = controller.categoryList.value?[index].code;
                  await controller.getSubCategoryList(
                      categoryId: cateogryId ?? '');
                  await controller.getProductByCategoryId(
                      categoryId: cateogryId ?? '',
                      subCategoryId: '',
                      isPagination: false);
                }
              },
              child: Card(
                elevation: 3,
                color: controller.category.value == index
                    ? MyColors.primaryCustom
                    : MyColors.w,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    controller.categoryList.value?[index].name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 13,
                      color: controller.category.value == index
                          ? MyColors.w
                          : MyColors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildSubCategoryListView() {
    return Obx(() {
      return (controller.subCategoryList.value != null)
          ? Container(
              padding: const EdgeInsets.all(5),
              height: 55,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.subCategoryList.value?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        controller.subcategory.value = index;
                        controller.currentPage = 1;
                        controller.totalPages = 1;
                        controller.productList.clear();
                        if (index == 0) {
                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: "",
                              isPagination: false);
                        } else {
                          subCateogryId =
                              controller.subCategoryList.value?[index].code;

                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: subCateogryId ?? '',
                              isPagination: false);
                        }
                      },
                      child: Card(
                        elevation: 3,
                        color: controller.subcategory.value == index
                            ? MyColors.primaryCustom
                            : MyColors.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            controller.subCategoryList.value?[index].name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              color: controller.subcategory.value == index
                                  ? MyColors.w
                                  : MyColors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
          : Container();
    });
  }

  _productListView() {
    if ((controller.productList.value.isNotEmpty)) {
      return Container(
        child: Column(
          children: [
            GridView.builder(
              // controller: _scrollController,
              controller: _scrollgridController,
              shrinkWrap: true,
              itemCount: controller.productList.value.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = controller.productList.value[index];
                // final isSelected = controller.selectedProducts.value?.contains(product);
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    // if (product.isSelected == true) {
                    // controller.cartService.removeFromCart(product: product);
                    // controller.selectedProducts.value?.remove(product);
                    // product.isSelected = false;
                    // Product? selectedProduct =
                    //     controller.productList.value[index];
                    // if (savedProduct.contains(selectedProduct.productCode)) {
                    //   var selectedIndex = controller.cartAddedProduct
                    //       .indexWhere((element) =>
                    //           element.productCode ==
                    //           selectedProduct.productCode);
                    //
                    //   controller.cartAddedProduct.removeAt(selectedIndex);
                    //   savedProduct.remove(selectedProduct.productCode);
                    // }
                    // setState(() {
                    //   controller.cartService
                    //       .removeFromCart(product: selectedProduct);
                    //   controller.updateProductCount();
                    // });
                    //
                    // if (controller.cartAddedProduct.any((element) =>
                    //     element.productCode == selectedProduct.productCode)) {
                    //   var selectedIndex = controller.cartAddedProduct
                    //       .indexWhere((element) =>
                    //           element.productCode ==
                    //           selectedProduct.productCode);
                    //   controller.cartAddedProduct.removeAt(selectedIndex);
                    //   if (controller.cartAddedProduct.isEmpty) {
                    //     controller.cartAddedProduct.clear();
                    //   }
                    // }
                    // } else {

                    Product? selectedProduct =
                        controller.productList.value[index];
                    if (savedProduct.contains(selectedProduct.productCode)) {
                      var selectedIndex = controller.cartAddedProduct.indexWhere(
                          (element) =>
                              element.productCode == selectedProduct.productCode);

                      controller.cartAddedProduct.removeAt(selectedIndex);
                      savedProduct.remove(selectedProduct.productCode);
                    }
                    setState(() {
                      controller.cartService.addToCart(product: selectedProduct);
                      controller.updateProductCount();
                    });

                    if (selectedProduct?.unitcount != 0) {
                      bool isAlreadyAdded = controller.cartAddedProduct.any(
                          (element) =>
                              element.productCode ==
                              selectedProduct?.productCode);

                      if (!isAlreadyAdded) {
                        controller.cartAddedProduct.add(selectedProduct!);
                      }
                    }
                    // }
                    controller.updateProductCount();

                    print("controller.selectedProduct.length");
                    print(controller.cartAddedProduct.value?.length);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: product.unitcount != 0
                          ? MyColors.primaryCustom
                          : MyColors.w,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Align content at the top
                      children: <Widget>[
                        Container(
                          height: height(context) / 15,
                          width: width(context),
                          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                          child: (controller
                                      .productList[index].productImagePath !=
                                  null)
                              ? ("${controller.productList[index].productImagePath}"
                                      .isNotEmpty)
                                  ? Container(
                                      child: Image.network(
                                        '${controller.productList[index].productImagePath}',
                                        fit: BoxFit.cover,
                                        // You can change the BoxFit as needed

                                        // width: width(context) / 30,
                                        // // Adjust the width and height as needed
                                        // height: height(context) / 30,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/images/noImage1.png",
                                      // fit: BoxFit.cover,
                                      // You can change the BoxFit as needed
                                      // width: width(context) / 30,
                                      // // Adjust the width and height as needed
                                      // height: height(context) / 30,
                                    )
                              : const Icon(Icons.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Text(
                              controller.productList.value?[index].name ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width(context) / 80,
                                  color: MyColors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                              " S\$ ${(controller.productList.value?[index].pOSSellingPrice)?.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: width(context) / 120,
                                  color: MyColors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (controller.status.isLoadingMore)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      );
    } else {
      if (controller.status.isLoadingMore || controller.status.isLoading) {
        return Container();
      }
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: Text("No product Found"),
        ),
      );
    }
  }

  double taxValue = 0;
  double subtotal = 0;
  double discount = 0;
  double total = 0;
  double grandTotal = 0;

  calculateCartTotal() {
    if (controller.billDiscountController.text.isEmpty &&
        controller.billDiscountController.text == null) {
      discount = 0;
    }
    taxValue = 0;
    subtotal = 0;
    total = 0;
    grandTotal = 0;
    for (var element in controller.cartAddedProduct.value) {
      total += (element.unitcount * element.pOSSellingPrice!);
      if (discount != 0 && discount != null) {
        subtotal = total - discount;
        taxValue =
            (subtotal * controller.CalculationTax.value.first.taxPercentage!) /
                100;
        grandTotal = subtotal + taxValue;
      } else {
        subtotal = total;
        taxValue =
            (subtotal * controller.CalculationTax.value.first.taxPercentage!) /
                100;
        grandTotal = subtotal + taxValue;
      }
    }
  }

  CartView(BuildContext context) {
    calculateCartTotal();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: SizedBox(
                width: width(context) / 2.8,
                child: Obx(() {
                  return SearchDropdownTextField<GetCustomerListModel>(
                      hintText: 'POS',
                      hintTextStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: MyColors.w,
                      ),
                      // initialValue: controller.getCustomerList.value.last,
                      inputBorder: BorderSide.none,
                      filled: true,
                      filledColor: MyColors.greyForTextFormField,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      items: controller.getCustomerList.value,
                      color: Colors.black54,
                      selectedItem: controller.selectedGetCustomerList,
                      isValidator: false,
                      // errorMessage: '*',
                      onAddPressed: () {
                        setState(() {
                          controller.selectedGetCustomerList = null;
                        });
                      },
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        controller.selectedGetCustomerList = value;
                        setState(() {
                          String? taxCode = value.taxTypeId;
                          print("taxCode");
                          print(taxCode);
                          if (taxCode != null && taxCode.isNotEmpty) {
                            controller.CalcualtiongetTaxDetails(taxCode);
                          } else {
                            controller.CalcualtiongetTaxDetails("33");
                          }
                        });
                      });
                }),
              ),
            ),
            IconButton(
                onPressed: () {
                  addSplServicePop();
                },
                icon: const Icon(
                  CupertinoIcons.plus_circle,
                  size: 40,
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(40),
              1: FlexColumnWidth(90),
              2: FlexColumnWidth(160),
              3: FlexColumnWidth(60),
              4: FlexColumnWidth(60),
              5: FlexColumnWidth(55),
            },
            children: const [
              TableRow(children: [
                Text(
                  'S.No',
                  style: TextStyle(
                      fontSize: 15,
                      color: MyColors.mainTheme,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Product',
                  style: TextStyle(
                      fontSize: 15,
                      color: MyColors.mainTheme,
                      fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Qty',
                      style: TextStyle(
                          fontSize: 15,
                          color: MyColors.mainTheme,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.mainTheme,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.mainTheme,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Del',
                      // '${MediaQuery.of(context).size.width}',
                      style: TextStyle(
                          fontSize: 15,
                          color: MyColors.mainTheme,
                          fontWeight: FontWeight.bold),
                    )),
              ])
            ],
          ),
        ),
        Expanded(
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: controller.cartAddedProduct.value?.length,
                  itemBuilder: (context, index) {
                    final product = controller.cartAddedProduct.value[index];
                    unitTotal = controller
                            .cartAddedProduct.value[index].pOSSellingPrice! *
                        controller.cartAddedProduct.value[index].unitcount
                            .toDouble();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(40),
                          1: FlexColumnWidth(90),
                          2: FlexColumnWidth(170),
                          3: FlexColumnWidth(60),
                          4: FlexColumnWidth(60),
                          5: FlexColumnWidth(55),
                        },
                        children: [
                          TableRow(children: [
                            // color: Colors.lightBlue,
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text("${index + 1}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                controller.cartAddedProduct.value?[index]
                                        .productName ??
                                    "",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.productList[index]
                                            .unitcountController.text =
                                        controller.productList[index].unitcount
                                            .toInt()
                                            .toString();

                                    Product? selectedProduct = controller
                                        .cartAddedProduct.value?[index];
                                    setState(() {
                                      controller.cartService.removeFromCart(
                                          product: selectedProduct!);
                                      controller.updateProductCount();
                                    });

                                    if (selectedProduct?.unitcount == 0) {
                                      if (controller.cartAddedProduct.any(
                                          (element) =>
                                              element.productCode ==
                                              selectedProduct?.productCode)) {
                                        var selectedIndex = controller
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                                element.productCode ==
                                                selectedProduct?.productCode);
                                        controller.cartAddedProduct
                                            .removeAt(selectedIndex);
                                        if (controller
                                            .cartAddedProduct.isEmpty) {
                                          setState(() {
                                            controller.cartAddedProduct.clear();
                                          });
                                        }
                                      }
                                    }
                                  },
                                  iconSize: 15,
                                  icon: Icon(Icons.remove),
                                ),
                                SizedBox(
                                  width: 65,
                                  height: 30,
                                  child: TextFormField(
                                    controller: controller.cartAddedProduct
                                        .value?[index].unitcountController,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {},
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 2, right: 2),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.productList[index]
                                            .unitcountController.text =
                                        controller.productList[index].unitcount
                                            .toInt()
                                            .toString();
                                    Product? selectedProduct = controller
                                        .cartAddedProduct.value?[index];
                                    if (savedProduct.contains(
                                        selectedProduct?.productCode)) {
                                      var selectedIndex = controller
                                          .cartAddedProduct
                                          .indexWhere((element) =>
                                              element.productCode ==
                                              selectedProduct?.productCode);

                                      controller.cartAddedProduct
                                          .removeAt(selectedIndex);
                                      savedProduct
                                          .remove(selectedProduct?.productCode);
                                    }
                                    // selectedProduct.unitincrement();

                                    setState(() {
                                      controller.cartService
                                          .addToCart(product: selectedProduct!);
                                      controller.updateProductCount();
                                    });

                                    if (selectedProduct?.unitcount != 0) {
                                      bool isAlreadyAdded = controller
                                          .cartAddedProduct
                                          .any((element) =>
                                              element.productCode ==
                                              selectedProduct?.productCode);

                                      if (!isAlreadyAdded) {
                                        controller.cartAddedProduct
                                            .add(selectedProduct!);
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.add),
                                  iconSize: 15,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:0),
                              child: Text(
                                  "S\$ ${controller.cartAddedProduct.value?[index].pOSSellingPrice}0",style: TextStyle(fontSize: 12),),
                            ),
                            Text("S\$ ${unitTotal.toStringAsFixed(2)}",style: TextStyle(fontSize: 12),),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  Product? selectedProduct =
                                      controller.cartAddedProduct.value?[index];
                                  setState(() {
                                    controller.cartService.slectedProductClear(
                                        product: selectedProduct!);
                                    controller.updateProductCount();
                                  });
                                  if (controller.cartAddedProduct.any(
                                      (element) =>
                                          element.productCode ==
                                          selectedProduct?.productCode)) {
                                    var selectedIndex = controller
                                        .cartAddedProduct
                                        .indexWhere((element) =>
                                            element.productCode ==
                                            selectedProduct?.productCode);
                                    controller.cartAddedProduct
                                        .removeAt(selectedIndex);
                                    if (controller.cartAddedProduct.isEmpty) {
                                      setState(() {
                                        selectedProduct?.unitcount = 0;
                                        controller.cartAddedProduct.clear();
                                      });
                                    }
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                  size: 20,
                                ),
                              ),
                            )
                          ]),
                        ],
                      ),
                    );
                  },
                );
              }),
              if (controller.cartAddedProduct.value!.length >= 5)
                Container(
                  height: height(context) / 2.5,
                  color: MyColors.mainTheme,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width(context) / 5,
                                  // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Total :",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                        Text("S\$ ${subtotal.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text("Bill Discount :",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: SizedBox(
                                              width: 100,
                                              height: 40,
                                              child: CustomTextFormField(
                                                controller: controller
                                                    .billDiscountController,
                                                filled: true,
                                                filledColor: MyColors
                                                    .greyForTextFormField,
                                                keyboardType:
                                                    TextInputType.number,
                                                textStyle: const TextStyle(
                                                    color: MyColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                inputFormatters: [],
                                                maxLength: 50,
                                                onChanged: (value) {
                                                  // Update your UI to reflect the changes
                                                  setState(() {
                                                    if (controller
                                                            .billDiscountController
                                                            .text
                                                            .isNotEmpty &&
                                                        controller
                                                                .billDiscountController
                                                                .text !=
                                                            null) {
                                                      discount =
                                                          double.parse(value);
                                                    } else {
                                                      discount = 0;
                                                    }
                                                    calculateCartTotal();
                                                  });
                                                },
                                              )),
                                        )
                                        // Text("₹ 100.0", style: TextStyle(fontSize: 15.0,color: MyColors.w ,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context) / 5,
                                  // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Sub Total :",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                        Text("₹ ${subtotal.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context) / 5,
                                  // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Tax :",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                        Text("S\$ ${taxValue.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context) / 5,
                                  // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Net Total :",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "S\$ ${grandTotal.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: MyColors.w,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width(context) / 4,
                            height: height(context) / 4.2,
                            child: ListView.builder(
                              itemCount:
                                  controller.truepayModeModel.value.length,
                              itemBuilder: (context, index) {
                                var payMentMode =
                                    controller.truepayModeModel.value[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        '${controller.truepayModeModel.value[index].name}',
                                        style: const TextStyle(
                                          color: MyColors.w,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                            width: 100,
                                            height: 45,
                                            child: CustomTextFormField(
                                              controller: controller
                                                  .truepayModeModel
                                                  .value[index]
                                                  .cashcontroller,
                                              keyboardType:
                                                  TextInputType.number,
                                              filled: true,
                                              filledColor:
                                                  MyColors.greyForTextFormField,
                                              textStyle: const TextStyle(
                                                  color: MyColors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              inputFormatters: [],
                                              onChanged: (value) {
                                                setState(() {
                                                  // if (controller.truepayModeModel
                                                  //         .value[index].name !=
                                                  //     "CASH") {
                                                  //   controller
                                                  //           .truepayModeModel
                                                  //           .value[index]
                                                  //           .cashcontroller
                                                  //           .text =
                                                  //       "${grandTotal.toDouble()}";
                                                  // }


                                                  if (controller
                                                      .truepayModeModel
                                                      .value[index]
                                                      .cashcontroller
                                                      .text !=
                                                      null &&
                                                      controller
                                                          .truepayModeModel
                                                          .value[index]
                                                          .cashcontroller
                                                          .text
                                                          .isNotEmpty) {
                                                    bool isAlreadyAdded = controller
                                                        .selectedpayModeModel
                                                        .any((element) =>
                                                    element.code ==
                                                        controller
                                                            .truepayModeModel[
                                                        index]
                                                            .code);
                                                    if (!isAlreadyAdded) {
                                                      controller.selectedpayModeModel
                                                          .add(controller
                                                          .truepayModeModel
                                                          .value[index]);
                                                    }
                                                  }
                                                });

                                                double totalSum = 0.0;
                                                controller.truepayModeModel.value
                                                    .forEach((item) {
                                                  double value = double.tryParse(
                                                      item.cashcontroller.text) ??
                                                      0.0;
                                                  totalSum += value;
                                                  totalAmount = totalSum;

                                                  if (controller.truepayModeModel
                                                      .value[index].name !=
                                                      "CASH") {
                                                    double cashAmount = double.parse(
                                                        controller
                                                            .truepayModeModel
                                                            .value[index]
                                                            .cashcontroller
                                                            .text);
                                                    double grandTotalAmount =
                                                    grandTotal.toDouble();

                                                    if (cashAmount >
                                                        grandTotalAmount) {
                                                      Get.snackbar(
                                                        margin:
                                                        const EdgeInsets.all(20),
                                                        backgroundColor: MyColors.red,
                                                        "Sorry",
                                                        "Payment is greater Than payable amount",
                                                        icon: const Icon(
                                                            Icons.emergency),
                                                        duration: const Duration(
                                                            seconds: 3),
                                                        snackPosition:
                                                        SnackPosition.TOP,
                                                      );
                                                    }
                                                  }

                                                  if (controller.truepayModeModel
                                                      .value[index].name ==
                                                      "CASH") {
                                                    BalencAmount =
                                                        grandTotal.toDouble() -
                                                            totalAmount;
                                                    if (controller
                                                        .truepayModeModel
                                                        .value[index]
                                                        .cashcontroller
                                                        .text !=
                                                        null &&
                                                        controller
                                                            .truepayModeModel
                                                            .value[index]
                                                            .cashcontroller
                                                            .text
                                                            .isEmpty) {
                                                      BalencAmount = 0.0;
                                                    }
                                                  }
                                                });
                                              },
                                              // onTap: () {
                                              //   if (controller.truepayModeModel.value[index].cashcontroller.text.isEmpty) {
                                              //     controller
                                              //         .truepayModeModel
                                              //         .value[index]
                                              //         .cashcontroller
                                              //         .text =
                                              //     "${grandTotal.toDouble()}";
                                              //   }
                                              // },
                                              maxLength: 50,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: width(context) / 6,
                                // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Balence :",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: MyColors.w,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "S\$ ${BalencAmount.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: MyColors.w,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: width(context) / 5,
                                height: height(context) / 15,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (totalAmount >= grandTotal.toDouble()) {
                                      controller.createPosInvoiceModel =
                                          CreatePosInvoiceModel(
                                        orgId: HttpUrl.org,
                                        brachCode: "HO",
                                        cashRegisterCode: "0009",
                                        orderNo: "",
                                        orderDateString: "",
                                        orderDate: controller.Date,
                                        isCredit: false,
                                        customerId: (controller
                                                    .selectedGetCustomerList !=
                                                null)
                                            ? controller
                                                .selectedGetCustomerList?.code
                                            : controller
                                                .getCustomerList.last.code,
                                        customerName: (controller
                                                    .selectedGetCustomerList !=
                                                null)
                                            ? controller
                                                .selectedGetCustomerList?.name
                                            : controller
                                                .getCustomerList.last.name,
                                        taxCode: (controller
                                                    .selectedGetCustomerList !=
                                                null)
                                            ? int.parse(
                                                "${controller.selectedGetCustomerList?.taxTypeId}")
                                            : int.parse(
                                                "${controller.getCustomerList.last.taxTypeId}"),
                                        taxType: (controller
                                                    .selectedGetCustomerList !=
                                                null)
                                            ? controller.selectedGetCustomerList
                                                ?.taxType
                                            : controller.getCustomerList.last
                                                    .taxType ??
                                                "E",
                                        taxPerc: controller.CalculationTax.value
                                            .first.taxPercentage!
                                            .toDouble(),
                                        currencyCode: (controller
                                                    .selectedGetCustomerList !=
                                                null)
                                            ? controller.selectedGetCustomerList
                                                ?.countryId
                                            : controller.getCustomerList.last
                                                    .countryId ??
                                                "SGD",
                                        currencyRate: 1,
                                        total: subtotal.toDouble(),
                                        billDiscount: 0,
                                        billDiscountPerc: 0,
                                        subTotal: subtotal.toDouble(),
                                        tax: taxValue.toDouble(),
                                        netTotal: grandTotal.toDouble(),
                                        remarks: "",
                                        isActive: true,
                                        isUpdate: true,
                                        createdBy: "admin",
                                        createdOn: controller.DateTimes,
                                        changedBy: "admin",
                                        changedOn: controller.DateTimes,
                                        pOSInvoiceDetail: controller
                                            .cartAddedProduct
                                            .map((element) => PosInvoiceDetail(
                                                  orgId: HttpUrl.org,
                                                  orderNo: "",
                                                  slNo: element.slNO,
                                                  productCode:
                                                      element.productCode,
                                                  uOMName: (controller
                                                              .selectedGetCustomerList !=
                                                          null)
                                                      ? controller
                                                          .selectedGetCustomerList
                                                          ?.name
                                                      : controller
                                                          .getCustomerList
                                                          .last
                                                          .name,
                                                  isCredit: false,
                                                  productName:
                                                      element.productName,
                                                  qty: element.unitcount,
                                                  price: element.pOSSellingPrice
                                                      ?.toDouble(),
                                                  foc: 0,
                                                  itemDiscount: 0,
                                                  itemDiscountPerc: 0,
                                                  taxPerc: controller
                                                      .CalculationTax
                                                      .value
                                                      .first
                                                      .taxPercentage!
                                                      .toDouble(),
                                                  taxType: (controller.selectedGetCustomerList !=
                                                          null)
                                                      ? controller
                                                          .selectedGetCustomerList
                                                          ?.taxType
                                                      : controller
                                                              .getCustomerList
                                                              .last
                                                              .taxType ??
                                                          "E",
                                                  total: (element.unitcount
                                                              .toInt() *
                                                          element
                                                              .pOSSellingPrice!
                                                              .toDouble())
                                                      .toDouble(),
                                                  subTotal: (element.unitcount
                                                              .toInt() *
                                                          element
                                                              .pOSSellingPrice!
                                                              .toDouble())
                                                      .toDouble(),
                                                  tax: (((element.unitcount
                                                                          .toDouble() *
                                                                      element
                                                                          .pOSSellingPrice!
                                                                          .toDouble())
                                                                  .toDouble() *
                                                              controller
                                                                  .CalculationTax
                                                                  .value
                                                                  .first
                                                                  .taxPercentage!) /
                                                          100)
                                                      .toDouble(),
                                                  netTotal: (element.unitcount
                                                              .toInt() *
                                                          element
                                                              .pOSSellingPrice!
                                                              .toDouble()) +
                                                      ((((element.unitcount.toDouble() *
                                                                          element
                                                                              .pOSSellingPrice!
                                                                              .toDouble())
                                                                      .toDouble() *
                                                                  controller
                                                                      .CalculationTax
                                                                      .value
                                                                      .first
                                                                      .taxPercentage!) /
                                                              100)
                                                          .toDouble()),
                                                  taxCode: (controller
                                                              .selectedGetCustomerList !=
                                                          null)
                                                      ? int.parse(
                                                          "${controller.selectedGetCustomerList?.taxTypeId}")
                                                      : int.parse(
                                                          "${controller.getCustomerList.last.taxTypeId}"),
                                                  remarks: "",
                                                  createdBy: "admin",
                                                  createdOn:
                                                      controller.DateTimes,
                                                  changedBy: "admin",
                                                  changedOn:
                                                      controller.DateTimes,
                                                  weight: 0,
                                                  isSR: false,
                                                ))
                                            .toList(),
                                        posPaymentDetail: controller
                                            .selectedpayModeModel
                                            .map((e) => PosPaymentDetail(
                                                  orderNo: "",
                                                  branchCode: "HO",
                                                  cashRegisterCode: "0009",
                                                  orgId: HttpUrl.org,
                                                  paymodeName: e.name,
                                                  paymodeCode: e.code,
                                                  amount: double.tryParse(
                                                          "${e.cashcontroller.text}")
                                                      ?.toDouble(),
                                                  settlementNo: "",
                                                  isCredit: false,
                                                  orderDate: controller.Date,
                                                ))
                                            .toList(),
                                        payableAmount: 0,
                                        balanceAmount: 0,
                                        orderNoHold: "",
                                        settlementNo: "",
                                        cashRegisterName: "0009",
                                        roundOff: 0,
                                      );
                                      controller.createPosInvoice();
                                    } else {
                                      Get.snackbar(
                                        margin: const EdgeInsets.all(20),
                                        backgroundColor: MyColors.red,
                                        "Sorry",
                                        "Payment is Less Than payable amount",
                                        icon: const Icon(Icons.emergency),
                                        duration: const Duration(seconds: 3),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.black, // Text color
                                  ),
                                  child: Text(
                                      'Pay S\$ ${grandTotal.toStringAsFixed(2)}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (controller.cartAddedProduct.value!.length <= 4)
          Container(
            height: height(context) /2.3,
            color: MyColors.mainTheme,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width(context) / 5,
                            // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total :",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                  Text("S\$ ${total.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Bill Discount :",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: CustomTextFormField(
                                          controller:
                                              controller.billDiscountController,
                                          filled: true,
                                          filledColor:
                                              MyColors.greyForTextFormField,
                                          keyboardType: TextInputType.number,
                                          textStyle: const TextStyle(
                                              color: MyColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          inputFormatters: [],
                                          maxLength: 50,
                                          onChanged: (value) {
                                            // Update your UI to reflect the changes
                                            setState(() {
                                              if (controller
                                                      .billDiscountController
                                                      .text
                                                      .isNotEmpty &&
                                                  controller
                                                          .billDiscountController
                                                          .text !=
                                                      null) {
                                                discount = double.parse(value);
                                              } else {
                                                discount = 0;
                                              }
                                              calculateCartTotal();
                                            });
                                          },
                                        )),
                                  )
                                  // Text("₹ 100.0", style: TextStyle(fontSize: 15.0,color: MyColors.w ,fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 5,
                            // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Sub Total :",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                  Text("S\$ ${subtotal.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 5,
                            // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Tax :",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                  Text("S\$ ${taxValue.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 5,
                            // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Net Total :",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                  Text("S\$ ${grandTotal.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: MyColors.w,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width(context) / 4,
                      height: height(context) / 4.2,
                      child: ListView.builder(
                        itemCount: controller.truepayModeModel.value.length,
                        itemBuilder: (context, index) {
                          var payMentMode =
                              controller.truepayModeModel.value[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Text(
                                  '${controller.truepayModeModel.value[index].name}',
                                  style: const TextStyle(
                                    color: MyColors.w,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                      width: 100,
                                      height: 45,
                                      child: CustomTextFormField(
                                        controller: controller.truepayModeModel
                                            .value[index].cashcontroller,
                                        keyboardType: TextInputType.number,
                                        filled: true,
                                        filledColor:
                                            MyColors.greyForTextFormField,
                                        textStyle: const TextStyle(
                                            color: MyColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        inputFormatters: [],
                                        onChanged: (value) {
                                          setState(() {
                                            // if (controller.truepayModeModel
                                            //         .value[index].name !=
                                            //     "CASH") {
                                            //   controller
                                            //           .truepayModeModel
                                            //           .value[index]
                                            //           .cashcontroller
                                            //           .text =
                                            //       "${grandTotal.toDouble()}";
                                            // }


                                            if (controller
                                                        .truepayModeModel
                                                        .value[index]
                                                        .cashcontroller
                                                        .text !=
                                                    null &&
                                                controller
                                                    .truepayModeModel
                                                    .value[index]
                                                    .cashcontroller
                                                    .text
                                                    .isNotEmpty) {
                                              bool isAlreadyAdded = controller
                                                  .selectedpayModeModel
                                                  .any((element) =>
                                                      element.code ==
                                                      controller
                                                          .truepayModeModel[
                                                              index]
                                                          .code);
                                              if (!isAlreadyAdded) {
                                                controller.selectedpayModeModel
                                                    .add(controller
                                                        .truepayModeModel
                                                        .value[index]);
                                              }
                                            }
                                          });

                                          double totalSum = 0.0;
                                          controller.truepayModeModel.value
                                              .forEach((item) {
                                            double value = double.tryParse(
                                                    item.cashcontroller.text) ??
                                                0.0;
                                            totalSum += value;
                                            totalAmount = totalSum;

                                            if (controller.truepayModeModel
                                                    .value[index].name !=
                                                "CASH") {
                                              double cashAmount = double.parse(
                                                  controller
                                                      .truepayModeModel
                                                      .value[index]
                                                      .cashcontroller
                                                      .text);
                                              double grandTotalAmount =
                                                  grandTotal.toDouble();

                                              if (cashAmount >
                                                  grandTotalAmount) {
                                                Get.snackbar(
                                                  margin:
                                                      const EdgeInsets.all(20),
                                                  backgroundColor: MyColors.red,
                                                  "Sorry",
                                                  "Payment is greater Than payable amount",
                                                  icon: const Icon(
                                                      Icons.emergency),
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                );
                                              }
                                            }

                                            if (controller.truepayModeModel
                                                    .value[index].name ==
                                                "CASH") {
                                              BalencAmount =
                                                  grandTotal.toDouble() -
                                                      totalAmount;
                                              if (controller
                                                          .truepayModeModel
                                                          .value[index]
                                                          .cashcontroller
                                                          .text !=
                                                      null &&
                                                  controller
                                                      .truepayModeModel
                                                      .value[index]
                                                      .cashcontroller
                                                      .text
                                                      .isEmpty) {
                                                BalencAmount = 0.0;
                                              }
                                            }
                                          });
                                        },
                                        // onTap: () {
                                        //   if (controller.truepayModeModel.value[index].cashcontroller.text.isEmpty) {
                                        //     controller
                                        //         .truepayModeModel
                                        //         .value[index]
                                        //         .cashcontroller
                                        //         .text =
                                        //     "${grandTotal.toDouble()}";
                                        //   }
                                        // },
                                        maxLength: 50,
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width(context) / 6,
                          // decoration: BoxDecoration( border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("Balence :",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: MyColors.w,
                                        fontWeight: FontWeight.bold)),
                                Text("S\$ ${BalencAmount.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: MyColors.w,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width(context) / 5,
                          height: height(context) / 15,
                          child: ElevatedButton(
                            onPressed: () {
                              if (totalAmount >= grandTotal.toDouble()) {
                                controller.createPosInvoiceModel =
                                    CreatePosInvoiceModel(
                                  orgId: HttpUrl.org,
                                  brachCode: "HO",
                                  cashRegisterCode: "0009",
                                  orderNo: "",
                                  orderDateString: "",
                                  orderDate: controller.Date,
                                  isCredit: false,
                                  customerId: (controller
                                              .selectedGetCustomerList !=
                                          null)
                                      ? controller.selectedGetCustomerList?.code
                                      : controller.getCustomerList.last.code,
                                  customerName: (controller
                                              .selectedGetCustomerList !=
                                          null)
                                      ? controller.selectedGetCustomerList?.name
                                      : controller.getCustomerList.last.name,
                                  taxCode: (controller
                                              .selectedGetCustomerList !=
                                          null)
                                      ? int.parse(
                                          "${controller.selectedGetCustomerList?.taxTypeId}")
                                      : int.parse(
                                          "${controller.getCustomerList.last.taxTypeId}"),
                                  taxType:
                                      (controller.selectedGetCustomerList !=
                                              null)
                                          ? controller
                                              .selectedGetCustomerList?.taxType
                                          : controller.getCustomerList.last
                                                  .taxType ??
                                              "E",
                                  taxPerc: controller
                                      .CalculationTax.value.first.taxPercentage!
                                      .toDouble(),
                                  currencyCode:
                                      (controller.selectedGetCustomerList !=
                                              null)
                                          ? controller.selectedGetCustomerList
                                              ?.countryId
                                          : controller.getCustomerList.last
                                                  .countryId ??
                                              "SGD",
                                  currencyRate: 1,
                                  total: subtotal.toDouble(),
                                  billDiscount: 0,
                                  billDiscountPerc: 0,
                                  subTotal: subtotal.toDouble(),
                                  tax: taxValue.toDouble(),
                                  netTotal: grandTotal.toDouble(),
                                  remarks: "",
                                  isActive: true,
                                  isUpdate: true,
                                  createdBy: "admin",
                                  createdOn: controller.DateTimes,
                                  changedBy: "admin",
                                  changedOn: controller.DateTimes,
                                  pOSInvoiceDetail: controller.cartAddedProduct
                                      .map((element) => PosInvoiceDetail(
                                            orgId: HttpUrl.org,
                                            orderNo: "",
                                            slNo: element.slNO,
                                            productCode: element.productCode,
                                            uOMName: (controller
                                                        .selectedGetCustomerList !=
                                                    null)
                                                ? controller
                                                    .selectedGetCustomerList
                                                    ?.name
                                                : controller
                                                    .getCustomerList.last.name,
                                            isCredit: false,
                                            productName: element.productName,
                                            qty: element.unitcount,
                                            price: element.pOSSellingPrice
                                                ?.toDouble(),
                                            foc: 0,
                                            itemDiscount: 0,
                                            itemDiscountPerc: 0,
                                            taxPerc: controller.CalculationTax
                                                .value.first.taxPercentage!
                                                .toDouble(),
                                            taxType:
                                                (controller.selectedGetCustomerList !=
                                                        null)
                                                    ? controller
                                                        .selectedGetCustomerList
                                                        ?.taxType
                                                    : controller.getCustomerList
                                                            .last.taxType ??
                                                        "E",
                                            total: (element.unitcount.toInt() *
                                                    element.pOSSellingPrice!
                                                        .toDouble())
                                                .toDouble(),
                                            subTotal:
                                                (element.unitcount.toInt() *
                                                        element.pOSSellingPrice!
                                                            .toDouble())
                                                    .toDouble(),
                                            tax: (((element.unitcount
                                                                    .toDouble() *
                                                                element
                                                                    .pOSSellingPrice!
                                                                    .toDouble())
                                                            .toDouble() *
                                                        controller
                                                            .CalculationTax
                                                            .value
                                                            .first
                                                            .taxPercentage!) /
                                                    100)
                                                .toDouble(),
                                            netTotal: (element.unitcount
                                                        .toInt() *
                                                    element.pOSSellingPrice!
                                                        .toDouble()) +
                                                ((((element.unitcount.toDouble() *
                                                                    element
                                                                        .pOSSellingPrice!
                                                                        .toDouble())
                                                                .toDouble() *
                                                            controller
                                                                .CalculationTax
                                                                .value
                                                                .first
                                                                .taxPercentage!) /
                                                        100)
                                                    .toDouble()),
                                            taxCode: (controller
                                                        .selectedGetCustomerList !=
                                                    null)
                                                ? int.parse(
                                                    "${controller.selectedGetCustomerList?.taxTypeId}")
                                                : int.parse(
                                                    "${controller.getCustomerList.last.taxTypeId}"),
                                            remarks: "",
                                            createdBy: "admin",
                                            createdOn: controller.DateTimes,
                                            changedBy: "admin",
                                            changedOn: controller.DateTimes,
                                            weight: 0,
                                            isSR: false,
                                          ))
                                      .toList(),
                                  posPaymentDetail:
                                      controller.selectedpayModeModel
                                          .map((e) => PosPaymentDetail(
                                                orderNo: "",
                                                branchCode: "HO",
                                                cashRegisterCode: "0009",
                                                orgId: HttpUrl.org,
                                                paymodeName: e.name,
                                                paymodeCode: e.code,
                                                amount: double.tryParse(
                                                        "${e.cashcontroller.text}")
                                                    ?.toDouble(),
                                                settlementNo: "",
                                                isCredit: false,
                                                orderDate: controller.Date,
                                              ))
                                          .toList(),
                                  payableAmount: 0,
                                  balanceAmount: 0,
                                  orderNoHold: "",
                                  settlementNo: "",
                                  cashRegisterName: "0009",
                                  roundOff: 0,
                                );
                                controller.createPosInvoice();
                              } else {
                                Get.snackbar(
                                  margin: const EdgeInsets.all(20),
                                  backgroundColor: MyColors.red,
                                  "Sorry",
                                  "Payment is Less Than payable amount",
                                  icon: const Icon(Icons.emergency),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black, // Text color
                            ),
                            child: Text('Pay S\$ ${grandTotal.toStringAsFixed(2)}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom))
      ],
    );
  }

  addSplServicePop() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          double alertDialogWidth = 550.0;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Customer',
                  textAlign: TextAlign.center,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                      controller.CustomerName.clear();
                      controller.MobileNumber.clear();
                      controller.emailController.clear();
                      controller.postalcode.clear();
                      controller.Address1.clear();
                      controller.Address2.clear();
                      controller.Address3.clear();
                      controller.Country.clear();
                    },
                    icon: const Icon(
                      CupertinoIcons.clear,
                      size: 30,
                    ))
              ],
            ),
            content: SingleChildScrollView(
              child: Container(
                width: alertDialogWidth,
                height: 580.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      controller: controller.CustomerName,
                      labelText: 'Customer Name',
                      readOnly: false,
                      textStyle: const TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.emailController,
                      labelText: 'Email',
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      textStyle: const TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.MobileNumber,
                      labelText: 'Mobile Number',
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      textStyle: const TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.postalcode,
                      labelText: 'Postal Code',
                      readOnly: false,
                      textStyle: TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                      suffixIcon: controller.fetchIsLoading.value == true
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: InkWell(
                                onTap: () async {
                                  if (controller.postalcode.text.isNotEmpty) {
                                    await controller
                                        .getPostal(controller.postalcode.text);
                                  } else {
                                    Get.snackbar(
                                      margin: const EdgeInsets.all(20),
                                      backgroundColor: MyColors.red,
                                      "Attention",
                                      "Please enter the postal code",
                                      colorText: MyColors.w,
                                      icon: const Icon(
                                        Icons.emergency,
                                        color: MyColors.w,
                                      ),
                                      duration: const Duration(seconds: 3),
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },
                                child: const Card(
                                  elevation: 0,
                                  color: MyColors.mainTheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      "Fetch",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.w,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    // SearchDropdownTextField<TaxModel>(
                    //     hintText: 'Tax Type',
                    //     hintTextStyle: const TextStyle(
                    //         color: MyColors.black,
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold),
                    //     textStyle: const TextStyle(
                    //         color: MyColors.black, fontWeight: FontWeight.bold),
                    //     suffixIcon: const Icon(
                    //       Icons.arrow_drop_down,
                    //       color: MyColors.black,
                    //     ),
                    //     inputBorder: BorderSide.none,
                    //     filled: true,
                    //     // filledColor: MyColors.black,
                    //     border: const OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //     ),
                    //     items: controller.TruetaxModel.value,
                    //     color: MyColors.w,
                    //     selectedItem: controller.selectedtaxModel,
                    //     isValidator: false,
                    //     // errorMessage: '*',
                    //     onAddPressed: () {
                    //       setState(() {
                    //         controller.selectedtaxModel = null;
                    //       });
                    //     },
                    //     onChanged: (value) {
                    //       controller.selectedtaxModel = value;
                    //       setState(() {
                    //         controller.taxTypes = value.taxType;
                    //         controller.taxTypeId = "${value.taxCode}";
                    //         controller.taxPerc = value.taxPercentage;
                    //       });
                    //     }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width(context) / 5,
                          child: CustomTextFormField(
                            controller: controller.Address1,
                            labelText: 'Address1',
                            readOnly: false,
                            textStyle: TextStyle(),
                            inputFormatters: [],
                            obscureText: false,
                            maxLength: 50,
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 5,
                          child: CustomTextFormField(
                            controller: controller.Address2,
                            labelText: 'Address2',
                            readOnly: false,
                            textStyle: TextStyle(),
                            inputFormatters: [],
                            obscureText: false,
                            maxLength: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.Address3,
                      labelText: 'Address',
                      readOnly: false,
                      textStyle: TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.Country,
                      labelText: 'Country',
                      readOnly: true,
                      textStyle: TextStyle(),
                      inputFormatters: [],
                      obscureText: false,
                      maxLength: 50,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.CustomerName.text.isNotEmpty &&
                              controller.MobileNumber.text.isNotEmpty &&
                              controller.Address1.text.isNotEmpty) {
                            controller.customerCreateModel =
                                CustomerCreateModel(
                                    orgId: HttpUrl.org,
                                    name: controller.CustomerName.text,
                                    mail: controller.emailController.text,
                                    addressLine1:
                                        controller.Address1.text ?? "",
                                    addressLine2:
                                        controller.Address2.text ?? "",
                                    addressLine3:
                                        controller.Address3.text ?? "",
                                    mobile: controller.MobileNumber.text,
                                    // taxType: controller.taxTypes,
                                    // taxTypeId: controller.taxTypeId,
                                    // taxPerc: controller.taxPerc,
                                    changedBy: controller.CustomerName.text,
                                    changedOn: controller.DateTimes,
                                    createdBy: controller.CustomerName.text,
                                    createdOn: controller.DateTimes);
                            controller.onCreateCustomer();
                          }
                        },
                        child: Text('Create'))
                  ],
                ),
              ),
            ),
          );
        });
  }

// totalAmountSaveDialog() {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20)),
//             content: SizedBox(
//               width: width(context) / 4.5,
//               height: height(context) / 2.9,
//               child: Column(
//                 children: [
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Expanded(
//                           child: Text(
//                         'CASH',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       )),
//                       SizedBox(
//                           width: 100,
//                           height: 40,
//                           child: CustomTextFormField(
//                             controller: controller.cashcontroller,
//                             textStyle: const TextStyle(
//                                 color: MyColors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                             inputFormatters: [],
//                             maxLength: 50,
//                           ))
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: Text('NETS')),
//                       SizedBox(
//                           width: 100,
//                           height: 40,
//                           child: CustomTextFormField(
//                             controller: controller.cashcontroller,
//                             textStyle: const TextStyle(
//                                 color: MyColors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                             inputFormatters: [],
//                             maxLength: 50,
//                           ))
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: Text('PAYNOW')),
//                       SizedBox(
//                           width: 100,
//                           height: 40,
//                           child: CustomTextFormField(
//                             controller: controller.cashcontroller,
//                             textStyle: const TextStyle(
//                                 color: MyColors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                             inputFormatters: [],
//                             maxLength: 50,
//                           ))
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: Text('ONLINE')),
//                       SizedBox(
//                           width: 100,
//                           height: 40,
//                           child: CustomTextFormField(
//                             controller: controller.cashcontroller,
//                             textStyle: const TextStyle(
//                                 color: MyColors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                             inputFormatters: [],
//                             maxLength: 50,
//                           ))
//                     ],
//                   ),
//                   // SizedBox(height: 10),
//                   // Row(
//                   //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   //     Expanded(child: Text('PAYNOW')),
//                   //     SizedBox(width: 100,height: 40,
//                   //         child: CustomTextFormField(controller: controller.cashcontroller, textStyle: const TextStyle(
//                   //             color: MyColors.black,
//                   //             fontSize: 18,
//                   //             fontWeight: FontWeight.bold
//                   //         ),
//                   //           inputFormatters: [], maxLength: 50,))
//                   //   ],
//                   // ),
//                   SizedBox(height: 35),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('Cancel')),
//                       ElevatedButton(onPressed: () {}, child: Text('Save')),
//                     ],
//                   )
//                 ],
//               ),
//             ));
//       });
// }
}
