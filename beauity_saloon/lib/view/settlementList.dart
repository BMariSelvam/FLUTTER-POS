import 'package:beauity_saloon/Helper/colors.dart';
import 'package:beauity_saloon/helper/appRoute.dart';
import 'package:beauity_saloon/helper/preferencehelper.dart';
import 'package:beauity_saloon/helper/size.dart';
import 'package:beauity_saloon/model/CashRegisterGetAllModel.dart';
import 'package:beauity_saloon/model/PosSettlement.dart';
import 'package:beauity_saloon/view/settlementListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

import '../helper/searchTextField.dart';
import '../helper/textformfield.dart';

class SettlementList extends StatefulWidget {
  const SettlementList({Key? key}) : super(key: key);

  @override
  State<SettlementList> createState() => _SettlementListState();
}

class _SettlementListState extends State<SettlementList> {
  late SettlementListController controller;

  FocusNode searchFocusNode = FocusNode();

  String? code;

  String search = "";

  @override
  void initState() {
    super.initState();
    controller = Get.put(SettlementListController());
    controller.getPosSettlement(
        cusCode: '', fromDate: '', toDate: '', tranNo: '');
    controller.getCashRegister();
  }

  List<PosSettlement> filterList(String query) {
    return controller.getPosSettlementList.where((item) {
      return item.settlementNo
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettlementListController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
                title: const Text('POS SETTLEMENT',
                    style: TextStyle(fontSize: 20, color: MyColors.w)),
                leading: IconButton(
                  color: MyColors.w,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                actions: [
                  IconButton(
                      icon: Icon(controller.isFilter
                          ? Icons.filter_alt_off_rounded
                          : Icons.filter_alt_rounded),
                      color: MyColors.w,
                      onPressed: () {
                        setState(() {
                          controller.isFilter = !controller.isFilter;
                        });
                      },
                      iconSize: 30),
                  IconButton(
                      icon: const Icon(Icons.add_circle_outline_sharp),
                      color: MyColors.w,
                      onPressed: () {
                        Get.toNamed(AppRoutes.addSettlement);
                      },
                      iconSize: 30),
                  const SizedBox(width: 15)
                ],
                backgroundColor: MyColors.mainTheme),
            body: SingleChildScrollView(
                child: Column(
              children: [
                controller.isFilter
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6.9.toInt(),
                                  child: searchTextField(
                                    inputBorder: InputBorder.none,
                                    controller: controller.searchController,
                                    keyboardType: TextInputType.text,
                                    hintText: "Search Tran No",
                                    suffixIcon: const Icon(Icons.search),
                                    onChanged: (String? value) {
                                      setState(() {
                                        search = value.toString();
                                      });
                                      return Text('data');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.tranNoController.clear();
                                      controller.fromDateController.clear();
                                      controller.toDateController.clear();
                                      controller.cashRegController.clear();
                                      controller.searchController.clear();
                                      search = '';
                                      controller.getPosSettlement(
                                          cusCode: "",
                                          fromDate: "",
                                          toDate: "",
                                          tranNo: "");
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: MyColors.mainTheme,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          'Show All',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.w),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6, left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SearchField<CashRegisterGetAllModel>(
                                      offset: const Offset(0, 50),
                                      controller: controller.cashRegController,
                                      // onSearchTextChanged: (query) {
                                      //   final filter = controller.getCustomerList
                                      //       // .where((element) =>
                                      //       // element.toLowerCase().contains(query.toLowerCase()))
                                      //       .toList();
                                      //   return filter
                                      //       .map((e) => SearchFieldListItem(e.name.toString(),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      //         child: Text(e.name.toString(),
                                      //             style: TextStyle(fontSize: 24, color: Colors.red)),
                                      //       )))
                                      //       .toList();
                                      // },
                                      readOnly: true,
                                      emptyWidget: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('No Results found',
                                            style: TextStyle(
                                                color: MyColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      maxSuggestionsInViewPort: 6,
                                      hint: 'Select Cash Register',
                                      scrollbarDecoration:
                                          ScrollbarDecoration(),
                                      //   thumbVisibility: true,
                                      //   thumbColor: Colors.red,
                                      //   fadeDuration: const Duration(milliseconds: 3000),
                                      //   trackColor: Colors.blue,
                                      //   trackRadius: const Radius.circular(10),
                                      // ),
                                      searchInputDecoration: InputDecoration(
                                          suffixIcon:
                                              const Icon(Icons.arrow_drop_down),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintStyle: const TextStyle(
                                              color: MyColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      suggestionsDecoration:
                                          SuggestionDecoration(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MyColors.mainTheme),
                                        // borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      suggestions: controller
                                          .getCashRegisterList
                                          .map((e) => SearchFieldListItem<
                                                  CashRegisterGetAllModel>(
                                              e.terminalName.toString(),
                                              item: e,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                child: Text(
                                                  e.terminalName.toString(),
                                                  style: const TextStyle(
                                                      color: MyColors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )))
                                          .toList(),
                                      focusNode: searchFocusNode,
                                      suggestionState: Suggestion.expand,
                                      suggestionStyle: const TextStyle(
                                          color: MyColors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      onSuggestionTap: (SearchFieldListItem<
                                              CashRegisterGetAllModel>
                                          selectedItem) {
                                        searchFocusNode.unfocus();
                                        CashRegisterGetAllModel? cashRegister =
                                            selectedItem.item;
                                        code = cashRegister?.cashRegisterCode;

                                        print(
                                            '>>>>>>>>>>>>>>>>>>$code<<<<<<<<<<<<<<<<<<<<<<<<<<<');
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CustomTextFormField(
                                      controller: controller.tranNoController,
                                      labelText: 'Tran No',
                                      textStyle: const TextStyle(
                                          color: MyColors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      inputFormatters: [],
                                      maxLength: 50,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CustomTextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedFromDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime.now());
                                        controller.fromDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedFromDate!);
                                        controller.toFromDate = pickedFromDate;
                                        setState(() {
                                          controller.fromDateController.text =
                                              controller.fromDate ?? '';
                                          print(
                                              'fffffffffffffffffffffff${controller.fromDate}');
                                        });
                                      },
                                      controller: controller.fromDateController,
                                      labelText: 'From Date',
                                      textStyle: const TextStyle(
                                          color: MyColors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      inputFormatters: [],
                                      maxLength: 50,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CustomTextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    controller.toFromDate,
                                                firstDate:
                                                    controller.toFromDate,
                                                lastDate: DateTime.now());
                                        controller.toDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate!);
                                        setState(() {
                                          controller.toDateController.text =
                                              controller.toDate ?? '';
                                          print(
                                              'tttttttttttttttttttttttttttt${controller.toDate}');
                                        });
                                      },
                                      controller: controller.toDateController,
                                      labelText: 'To Date',
                                      textStyle: const TextStyle(
                                          color: MyColors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      inputFormatters: [],
                                      maxLength: 50,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      search = '';
                                      controller.searchController.clear();

                                      controller.getPosSettlement(
                                          cusCode: code ?? "",
                                          fromDate: controller.fromDate ?? "",
                                          toDate: controller.toDate ?? "",
                                          tranNo: controller
                                                  .tranNoController.text ??
                                              "");
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: MyColors.mainTheme,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          'Search',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.w),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            thickness: 2,
                          )
                        ],
                      )
                    : const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5), blurRadius: 2),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 18,
                    right: 18,
                    bottom: 0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FlexColumnWidth(1.2),
                            1: FlexColumnWidth(0.5),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(1),
                            5: FixedColumnWidth(105)
                          },
                          children: const [
                            TableRow(children: [
                              Text(
                                'Tran No',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Tran Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text(
                                    'Opening Amount',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text(
                                    'Total Cash',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 35, left: 6),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Action',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                list(),
                const SizedBox(
                  height: 20,
                )
              ],
            ))),
      );
    });
  }

  list() {
    if (controller.getPosSettlementList.value.isNotEmpty &&
        controller.getPosSettlementList.value != null) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: search.isEmpty
              ? controller.getPosSettlementList.value.length
              : filterList(search).length,
          itemBuilder: (context, index) {
            final items = search.isEmpty
                ? controller.getPosSettlementList.value[index]
                : filterList(search)[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2),
                ],
              ),
              margin: const EdgeInsets.only(
                top: 15,
                left: 18,
                right: 18,
                bottom: 0,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1.2),
                        1: FlexColumnWidth(0.5),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                        5: FixedColumnWidth(105)
                      },
                      children: [
                        TableRow(children: [
                          Text(
                            items.settlementNo ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatDate(controller
                                .getPosSettlementList.value[index].settlementDate) ??
                                '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              items.openingAmount?.toStringAsFixed(2) ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              items.totalCashAmount?.toStringAsFixed(2) ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 25, left: 6),
                              child: Text(
                                '0.00',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 1,
                              right: 10,
                            ),
                            padding: const EdgeInsets.only(
                              left: 1,
                              right: 3,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.mainTheme,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 10, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                    color: MyColors.w,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.edit_document,
                                        size: 15,
                                        color: MyColors.mainTheme,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "Select",
                                        style: TextStyle(
                                          color: MyColors.mainTheme,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                settlementEdit(),
                              ],
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'No Data found',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  settlementEdit() {
    return SizedBox(
      height: 25,
      width: 28,
      child: PopupMenuButton(
        color: MyColors.w,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: Colors.black54)),
        iconSize: 25,
        padding: const EdgeInsets.all(1),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: MyColors.w,
        ),
        offset: const Offset(0, 30),
        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    // Image.asset(IconAssets.editIcon),
                    SizedBox(
                      width: width(context) / 50,
                    ),

                    const Text(
                      'Edit ',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: MyColors.mainTheme),
                    ),
                  ]),
                ],
              )),
          const PopupMenuDivider(),
          PopupMenuItem(
            height: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset(
                      // IconAssets.delete,
                      // scale: 1.2,
                      // ),
                      SizedBox(
                        width: width(context) / 50,
                      ),

                      const Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: MyColors.mainTheme),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
