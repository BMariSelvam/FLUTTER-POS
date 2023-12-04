import 'package:beauity_saloon/Helper/colors.dart';
import 'package:beauity_saloon/helper/api.dart';
import 'package:beauity_saloon/helper/appRoute.dart';
import 'package:beauity_saloon/helper/constant.dart';
import 'package:beauity_saloon/helper/size.dart';
import 'package:beauity_saloon/helper/textformfield.dart';
import 'package:beauity_saloon/model/CashRegisterGetAllModel.dart';
import 'package:beauity_saloon/model/PosPaymentDetail.dart';
import 'package:beauity_saloon/model/PosPaymode.dart';
import 'package:beauity_saloon/model/PosSettlement.dart';
import 'package:beauity_saloon/model/PosSettlementDetailModel.dart';
import 'package:beauity_saloon/view/settlementController.dart';
import 'package:beauity_saloon/view/settlementList.dart';
import 'package:beauity_saloon/view/settlementListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class SettlementScreen extends StatefulWidget {
  const SettlementScreen({Key? key}) : super(key: key);

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  late SettlementController controller;
  late SettlementListController _controller;

  FocusNode searchFocusNode = FocusNode();

  String? code;
  String? terName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SettlementController());
    _controller = Get.put(SettlementListController());
    controller.getCashRegister();

    controller.settlementDate.text = controller.selectedDate;
    print("[]][][][]][]][]]][[][]");
    print(controller.selectedDate);
    print("[]][][][]][]][]]][[][]");

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettlementController>(builder: (logic) {
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
              leading: IconButton(
                color: MyColors.w,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text('POS SETTLEMENT',
                  style: TextStyle(fontSize: 20, color: MyColors.w)),
              backgroundColor: MyColors.mainTheme),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First Column
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading('Settlement No', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.settlementNo,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    heading('Settlement Date', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          // onTap: () async {
                          //   DateTime? pickedDate = await showDatePicker(
                          //       context: context,
                          //       initialDate: DateTime.now(),
                          //       firstDate: DateTime.now(),
                          //       //DateTime.now() - not to allow to choose before today.
                          //       lastDate: DateTime.now());
                          //   controller.date =
                          //       DateFormat('dd-MM-yyyy').format(pickedDate!);
                          //   setState(() {
                          //     controller.settlementDate.text = controller.date!;
                          //   });
                          // },
                          controller: controller.settlementDate,
                          suffixIcon: const Icon(Icons.calendar_today_rounded),
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                        ),
                      ),
                    ),
                    heading('Cash Register', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: Obx(() {
                          return SearchField<CashRegisterGetAllModel>(
                            validator: (val) {
                              if (val!.isEmpty || val == null) {
                                return 'Select Cash Register';
                              }
                              return null;
                            },
                            offset: const Offset(0, 50),
                            controller: controller.cashRegister,
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
                            // readOnly: true,
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
                            scrollbarDecoration: ScrollbarDecoration(),
                            searchInputDecoration: InputDecoration(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                contentPadding: const EdgeInsets.all(10),
                                hintStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            suggestionsDecoration: SuggestionDecoration(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColors.mainTheme),
                              // borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            suggestions: controller.getCashRegisterList
                                .map((e) => SearchFieldListItem<
                                        CashRegisterGetAllModel>(
                                    e.terminalName.toString(),
                                    item: e,
                                    child: Text(
                                      e.terminalName.toString(),
                                      style: const TextStyle(
                                          color: MyColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )))
                                .toList(),
                            focusNode: searchFocusNode,
                            suggestionState: Suggestion.expand,
                            suggestionStyle: const TextStyle(
                                color: MyColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            onSuggestionTap:
                                (SearchFieldListItem<CashRegisterGetAllModel>
                                    selectedItem) {
                              searchFocusNode.unfocus();
                              CashRegisterGetAllModel? cashRegister =
                                  selectedItem.item;
                              code = cashRegister?.cashRegisterCode;
                              terName = cashRegister?.terminalName;
                              print(
                                  '>>>>>>>>>>>>>>>>>>>>>$code<<<<<<<<<<<<<<<<<<<<<<<');
                              print(
                                  '>>>>>>>>>>>>>>>>>>>>>$terName<<<<<<<<<<<<<<<<<<<<<<<');
                              setState(() {
                                /// Api calls by passing data.
                                controller.getTerminal(
                                    terName ?? '', code ?? "");
                                controller.getCashInOut(code ?? "");

                                /// To clear the fields in currency info.
                                controller.currencyTotal = 0.00;
                                controller.shortage = 0.00;
                                controller.excess = 0.00;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    heading('Opening Amount', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.openingAmount,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    heading('Total Cash', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.totalCash,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    heading('Cash In', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.cashIn,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    heading('Cash Out', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.cashOut,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    heading('Total', 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: CustomTextFormField(
                          readOnly: true,
                          controller: controller.total,
                          filled: true,
                          filledColor: MyColors.greyForTextFormField,
                          textStyle: const TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: const [],
                          maxLength: 50,
                          onChanged: (value) {
                            setState(() {
                              // controller.total.text = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),

              /// Second Column
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: width(context) / 2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading('Currency Denomination Info', 17),
                      const SizedBox(
                        height: 5,
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(0.5),
                          1: FlexColumnWidth(0.8),
                          2: FlexColumnWidth(0.5),
                        },
                        border: TableBorder.all(color: Colors.black12),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  tableHeading('Currency', 15, FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: tableHeading('Count', 15, FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: tableHeading(
                                      'Amount', 15, FontWeight.bold)),
                            ),
                          ]),
                        ],
                      ),
                      currencyInfo(),
                      Table(
                        columnWidths: const {0: FlexColumnWidth(2.6)},
                        border: const TableBorder(
                            verticalInside: BorderSide(color: Colors.black12),
                            bottom: BorderSide(color: Colors.black12),
                            left: BorderSide(color: Colors.black12),
                            right: BorderSide(color: Colors.black12)),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: tableHeading('Total', 13, FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: tableHeading(
                                      controller.currencyTotal
                                          .toStringAsFixed(2),
                                      13,
                                      FontWeight.bold)),
                            ),
                          ])
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),

              /// Third Column
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading('Paymode Info', 17),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: width(context) / 4,
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(0.8),
                          1: FlexColumnWidth(0.5),
                        },
                        border: const TableBorder(
                          left: BorderSide(color: Colors.black12),
                          right: BorderSide(color: Colors.black12),
                          top: BorderSide(color: Colors.black12),
                          bottom: BorderSide(color: Colors.black12),
                          verticalInside: BorderSide(color: Colors.black12),
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  tableHeading('Paymode', 15, FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: tableHeading(
                                      'Amount', 15, FontWeight.bold)),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    paymodeInfo(),
                    SizedBox(
                      width: width(context) / 4,
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(0.8),
                          1: FlexColumnWidth(0.5),
                        },
                        border: const TableBorder(
                          left: BorderSide(color: Colors.black12),
                          right: BorderSide(color: Colors.black12),
                          bottom: BorderSide(color: Colors.black12),
                          verticalInside: BorderSide(color: Colors.black12),
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: tableHeading('Total', 13, FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: tableHeading(
                                      controller.posTot.toStringAsFixed(2),
                                      13,
                                      FontWeight.bold)),
                            ),
                          ])
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    shortExcess(),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: buttons(),
        ),
      );
    });
  }

  paymodeInfo() {
    return SizedBox(
      width: width(context) / 4,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.getPosPaymodeList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.8),
                    1: FlexColumnWidth(0.5),
                  },
                  border: const TableBorder(
                    left: BorderSide(color: Colors.black12),
                    right: BorderSide(color: Colors.black12),
                    bottom: BorderSide(color: Colors.black12),
                    verticalInside: BorderSide(color: Colors.black12),
                  ),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            controller.getPosPaymodeList[index].paymentType ??
                                ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(controller
                                    .getPosPaymodeList[index].paidAmount
                                    ?.toStringAsFixed(2) ??
                                "0.00")),
                      ),
                    ])
                  ],
                ),
              ],
            );
          }),
    );
  }

  double s = 0;

  currencyInfo() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.getCurrencyDenominationList.length,
        itemBuilder: (context, index) {
          double? rowTot = 0;
          return SizedBox(
            width: width(context) / 2.5,
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(0.8),
                2: FlexColumnWidth(0.5),
              },
              border: TableBorder.all(color: Colors.black12),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controller
                        .getCurrencyDenominationList[index].denaminationValue
                        !.toStringAsFixed(0)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(context) / 25, vertical: 8),
                    child: SizedBox(
                      height: 25,
                      child: CustomTextFormField(
                        controller: controller.getCurrencyDenominationList
                            .value[index].countControllers,
                        // controller.countControllers[index],
                        // filled: true,
                        filledColor: MyColors.greyForTextFormField,
                        keyboardType: TextInputType.number,

                        textStyle: const TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        inputFormatters: [NumericInputFormatter()],
                        maxLength: 50,
                        onChanged: (value) {
                          setState(() {
                            /// Converting controller value into double
                            int count = (controller
                                    .getCurrencyDenominationList
                                    .value[index]
                                    .countControllers
                                    .text
                                    .isNotEmpty)
                                ? int.parse(controller
                                    .getCurrencyDenominationList
                                    .value[index]
                                    .countControllers
                                    .text)
                                : 0;

                            /// To calculate each row's Amount (currency * count = Amount) in currency Denomination info
                            controller.getCurrencyDenominationList[index]
                                .rowTotal = (controller
                                        .getCurrencyDenominationList[index]
                                        .denaminationValue! *
                                    count)
                                .toDouble();

                            /// This For loop is to get Total Amount of currency Denomination info
                            controller.currencyTotal = 0.00;
                            for (var item in controller
                                .getCurrencyDenominationList.value) {
                              controller.currencyTotal += item.rowTotal ?? 0;
                            }
                            controller.shortExcessCalc();
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text((controller
                                    .getCurrencyDenominationList[index]
                                    .rowTotal ??
                                0)
                            .toStringAsFixed(2))),
                    //                   controller.rowTotalList[index].toStringAsFixed(2))),
                  ),
                ]),
                /* TableRow(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.fifty.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .fiftyController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .fiftyController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .fiftyController.text)
                              : 0;
                          controller.fiftyTotal = controller.fifty*qty;
                          controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.fiftyTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.fiftyTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.ten.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .tenController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .tenController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .tenController.text)
                              : 0;
                          controller.tenTotal = controller.ten*qty;
                          controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.tenTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.tenTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.five.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .fiveController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .fiveController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .fiveController.text)
                              : 0;
                          controller.fiveTotal = controller.five*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.fiveTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.fiveTotal.toStringAsFixed(2))),
                  ),
              ]),
          TableRow(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                   child: Text(controller.two.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .twoController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .twoController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .twoController.text)
                              : 0;
                          controller.twoTotal = controller.two*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.twoTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.twoTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.one.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .oneController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .oneController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .oneController.text)
                              : 0;
                          controller.oneTotal = controller.one*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.oneTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.oneTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.fiftyPaise.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .fiftyPaiseController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .fiftyPaiseController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .fiftyPaiseController.text)
                              : 0;
                          controller.fiftyPaiseTotal = controller.fiftyPaise*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.fiftyPaiseTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.fiftyPaiseTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.twentyPaise.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .twentyPaiseController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .twentyPaiseController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .twentyPaiseController.text)
                              : 0;
                          controller.twentyPaiseTotal = controller.twentyPaise*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.oneTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.twentyPaiseTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.tenPaise.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .tenPaiseController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .tenPaiseController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .tenPaiseController.text)
                              : 0;
                          controller.tenPaiseTotal = controller.tenPaise*qty;  controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.oneTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.tenPaiseTotal.toStringAsFixed(2))),
                ),
              ]),
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.fivePaise.toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)/25, vertical: 8),
                  child: SizedBox(height: 25,
                    child: CustomTextFormField(
                      controller: controller
                          .fivePaiseController,
                      // filled: true,
                      filledColor: MyColors
                          .greyForTextFormField,
                      keyboardType: TextInputType.number,

                      textStyle: const TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold),
                      inputFormatters: [NumericInputFormatter()],
                      maxLength: 50,
                      onChanged: (value) {
                        setState(() {
                          int qty = (controller
                              .fivePaiseController.text.isNotEmpty)
                              ? int.parse(
                              controller
                                  .fivePaiseController.text)
                              : 0;
                          controller.fivePaiseTotal = controller.fivePaise*qty;
                          controller.currencyTotal();
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                          print(controller.oneTotal);
                          print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight,
                      child: Text( controller.fivePaiseTotal.toStringAsFixed(2))),
                ),
              ]),*/
              ],
            ),
          );
        });
  }

  shortExcess() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading('Shortage', 15),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 10,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: MyColors.greyForTextFormField,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 5),
                        child: tableHeading(
                            controller.shortage.toStringAsFixed(2),
                            14,
                            FontWeight.w500),
                      )),
                ))
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading('Excess', 15),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 10,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: MyColors.greyForTextFormField,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 5),
                        child: tableHeading(
                            controller.excess.toStringAsFixed(2),
                            14,
                            FontWeight.w500),
                      )),
                ))
          ],
        ),
      ],
    );
  }

  buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: MyColors.red),
              child: buttonText('Cancel', 15, FontWeight.bold, MyColors.w)),
          // const SizedBox(
          //   width: 10,
          // ),
          // ElevatedButton(
          //     onPressed: () {
          //       print("<<<<<<<<<<<<<<<$terName>>>>>>>>>>>>>>>");
          //     },
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          //     child:
          //         buttonText('Save & Print', 15, FontWeight.bold, MyColors.w)),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                // print(controller.selectedDate);
                if (controller.cashRegister.text.isNotEmpty &&
                    controller.cashRegister.text != null) {
                  controller.createPosSettlement = PosSettlement(
                    orgId: HttpUrl.org,
                    branchCode: 'HO',
                    cashRegisterCode: code,
                    terminalName: terName,
                    settlementNo: '',
                    settlementDate: controller.selectedDate,
                    settlementDateString: '',
                    totalCashAmount: double.parse(controller.totalCash.text),
                    cashInAmount: double.parse(controller.cashIn.text),
                    cashOutAmount: double.parse(controller.cashOut.text),
                    settlementBy: 'ad',
                    createdBy: 'ad',
                    createdOn: controller.selectedDate,
                    changedBy: 'ad',
                    changedOn: controller.selectedDate,
                    isActive: true,
                    pOSSettlementDetails: controller.getCurrencyDenominationList
                        .map((e) => PosSettlementDetailModel(
                              orgId: HttpUrl.org,
                              settlementNo: "",
                              slNo: e.sNo,
                              denomination: e.denaminationValue,
                              denominationCount: (e.countControllers.text.isNotEmpty ?
                                  int.parse(e.countControllers.text) : 0),
                              total: e.rowTotal,
                              createdBy: "ad",
                              createdOn: controller.selectedDate,
                              changedBy: "ad",
                              changedOn: controller.selectedDate,
                              isActive: true,
                              posPaymode: [],
                              posCurrencyDenamination: [],
                            ))
                        .toList(),
                    pOSPaymode: controller.getPosPaymodeList
                        .map((element) => PosPaymode(
                              paymentType: element.paymentType,
                              paidAmount: element.paidAmount,
                            ))
                        .toList(),
                    shortageAmount: controller.shortage,
                    excessAmount: controller.excess,
                    openingAmount: (controller.openingAmount.text.isNotEmpty ?
                    double.parse(controller.openingAmount.text) : 0.00),
                  );
                  await controller.createSettlement();
                  // Get.toNamed(AppRoutes.settlementList);
                } else {
                  Get.showSnackbar(
                    const GetSnackBar(
                      messageText: Text(
                        'Select a Cash Register',
                        style: TextStyle(fontSize: 15, color: MyColors.w),
                      ),
                      icon: Icon(
                        Icons.error,
                        color: MyColors.w,
                      ),
                      margin: EdgeInsets.all(10),
                      borderRadius: 15,
                      duration: Duration(seconds: 3),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: MyColors.red,
                    ),
                  );
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: buttonText('Save', 15, FontWeight.bold, MyColors.w)),
        ],
      ),
    );
  }

  Text heading(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        color: MyColors.primaryCustom,
        fontSize: size,
      ),
    );
  }

  Text tableHeading(String text, double size, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: size, fontWeight: fontWeight),
    );
  }

  Text buttonText(
      String text, double size, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
