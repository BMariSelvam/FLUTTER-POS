import 'package:beauity_saloon/Helper/colors.dart';
import 'package:beauity_saloon/helper/textformfield.dart';
import 'package:beauity_saloon/model/GetCustomerListModel.dart';
import 'package:beauity_saloon/model/GetSupplierListModel.dart';
import 'package:beauity_saloon/view/CashInOutAddController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../helper/constant.dart';

class CashInOutAdd extends StatefulWidget {
  const CashInOutAdd({Key? key}) : super(key: key);

  @override
  State<CashInOutAdd> createState() => _CashInOutAddState();
}

class _CashInOutAddState extends State<CashInOutAdd> {
  late CashInOutAddController controller;

  FocusNode cashFocus = FocusNode();
  FocusNode tranTypeFocus = FocusNode();
  FocusNode customerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Get.put(CashInOutAddController());
    controller.getCashRegister();
    controller.getCustomer();
    controller.getSupplier();

    controller.tranDateController.text =
        '${controller.selectedDate.day}-${controller.selectedDate.month}-${controller.selectedDate.year}';

    print('controller.tranTypeController.text------------------------------------------');
    print(controller.tranTypeController.text);
    print('controller.tranTypeController.text------------------------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashInOutAddController>(builder: (logic) {
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
              title: const Text('POS CASH IN OUT',
                  style: TextStyle(fontSize: 20, color: MyColors.w)),
              backgroundColor: MyColors.mainTheme),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Tran No', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: CustomTextFormField(
                                readOnly: true,
                                controller: controller.tranNoController,
                                filled: true,
                                filledColor: MyColors.greyForTextFormField,
                                textStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [],
                                maxLength: 50,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Tran Date', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: CustomTextFormField(
                                readOnly: true,
                                // onTap: () async {
                                //   DateTime? pickedDate = await showDatePicker(
                                //       context: context,
                                //       initialDate: DateTime.now(),
                                //       firstDate: DateTime.now(),
                                //       //DateTime.now() - not to allow to choose before today.
                                //       lastDate: DateTime.now());
                                //   controller.date = DateFormat('dd-MM-yyyy')
                                //       .format(pickedDate!);
                                //   setState(() {
                                //     controller.tranDateController.text =
                                //         controller.date!;
                                //   });
                                // },
                                controller: controller.tranDateController,
                                suffixIcon:
                                    const Icon(Icons.calendar_today_rounded),
                                filledColor: MyColors.greyForTextFormField,
                                textStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [],
                                maxLength: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Cash Register', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: SearchField(
                                offset: const Offset(0, 50),
                                controller: controller.cashRegisterController,
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
                                //   thumbVisibility: true,
                                //   thumbColor: Colors.red,
                                //   fadeDuration: const Duration(milliseconds: 3000),
                                //   trackColor: Colors.blue,
                                //   trackRadius: const Radius.circular(10),
                                // ),
                                searchInputDecoration: InputDecoration(
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
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
                                    .map((e) => SearchFieldListItem(
                                        e.terminalName.toString(),
                                        item: e.terminalName,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            e.terminalName.toString(),
                                            style: const TextStyle(
                                                color: MyColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )))
                                    .toList(),

                                focusNode: cashFocus,
                                suggestionState: Suggestion.expand,
                                suggestionStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                onSuggestionTap: (SearchFieldListItem x) {
                                  cashFocus.unfocus();
                                  print(
                                      'controller.cashRegisterController.text>>>>>>>>>>>>>>>');
                                  print(controller.cashRegisterController.text);
                                  print(
                                      'controller.cashRegisterController.text>>>>>>>>>>>>>>>');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Reference No', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: CustomTextFormField(
                                controller: controller.refNoController,
                                filledColor: MyColors.greyForTextFormField,
                                textStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [],
                                maxLength: 50,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Tran Type', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: SearchField(
                                offset: const Offset(0, 50),
                                controller: controller.tranTypeController,
                                readOnly: true,
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
                                emptyWidget: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('No Results found',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                maxSuggestionsInViewPort: 2,
                                hint: 'Select Tran Type',
                                scrollbarDecoration: ScrollbarDecoration(),
                                searchInputDecoration: InputDecoration(
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
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
                                suggestions: controller.type
                                    .map((e) => SearchFieldListItem(e,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: MyColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )))
                                    .toList(),

                                focusNode: tranTypeFocus,
                                suggestionState: Suggestion.expand,
                                suggestionStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                onSuggestionTap: (SearchFieldListItem x) {
                                  tranTypeFocus.unfocus();
                                  setState(() {
                                    if(controller.tranTypeController.text == 'IN'){
                                      controller.tranType = true;
                                      controller.cusOrSupController.clear();
                                    } else{
                                      controller.tranType = false;
                                      controller.cusOrSupController.clear();
                                    }
                                  });
                                  print('controller.tranType');
                                  print(controller.tranType);
                                  print('controller.tranType');
                                  print(
                                      'controller.tranTypeController.text>>>>>>>>>>>>>>>');
                                  print(controller.tranTypeController.text);
                                  print(
                                      'controller.tranTypeController.text>>>>>>>>>>>>>>>');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Amount', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: CustomTextFormField(
                                controller: controller.amountController,
                                filledColor: MyColors.greyForTextFormField,
                                textStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [NumericInputFormatter()],
                                maxLength: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading( controller.tranType ? 'Select Customer' : 'Select Supplier', 15),
                            controller.tranType ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: SearchField<GetCustomerListModel>(
                                offset: const Offset(0, 50),
                                controller: controller.cusOrSupController,
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
                                emptyWidget: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('No Results found',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                maxSuggestionsInViewPort: 6,
                                hint: 'Select Customer',
                                scrollbarDecoration: ScrollbarDecoration(),
                                //   thumbVisibility: true,
                                //   thumbColor: Colors.red,
                                //   fadeDuration: const Duration(milliseconds: 3000),
                                //   trackColor: Colors.blue,
                                //   trackRadius: const Radius.circular(10),
                                // ),
                                searchInputDecoration: InputDecoration(
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
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
                                suggestions: controller.getCustomerList
                                    .map((e) => SearchFieldListItem<GetCustomerListModel>(e.name.toString(),
                                        item: e,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            e.name.toString(),
                                            style: const TextStyle(
                                                color: MyColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )))
                                    .toList(),

                                focusNode: customerFocusNode,
                                suggestionState: Suggestion.expand,
                                suggestionStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                onSuggestionTap: (SearchFieldListItem<GetCustomerListModel> x) {
                                  customerFocusNode.unfocus();
                                  print('________________________${controller.cusOrSupController.text}______________________________');
                                },
                              ),
                            ) :
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: SearchField<GetSupplierListModel>(
                                offset: const Offset(0, 50),
                                controller: controller.cusOrSupController,
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
                                emptyWidget: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('No Results found',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                maxSuggestionsInViewPort: 6,
                                hint: 'Select Supplier',
                                scrollbarDecoration: ScrollbarDecoration(),
                                //   thumbVisibility: true,
                                //   thumbColor: Colors.red,
                                //   fadeDuration: const Duration(milliseconds: 3000),
                                //   trackColor: Colors.blue,
                                //   trackRadius: const Radius.circular(10),
                                // ),
                                searchInputDecoration: InputDecoration(
                                    suffixIcon:
                                    const Icon(Icons.arrow_drop_down),
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
                                suggestions: controller.getSupplierList
                                    .map((e) => SearchFieldListItem<GetSupplierListModel>(e.name.toString(),
                                    item: e,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        e.name.toString(),
                                        style: const TextStyle(
                                            color: MyColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )))
                                    .toList(),

                                focusNode: customerFocusNode,
                                suggestionState: Suggestion.expand,
                                suggestionStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                onSuggestionTap: (SearchFieldListItem<GetSupplierListModel> x) {
                                  customerFocusNode.unfocus();
                                  print('________________________${controller.cusOrSupController.text}______________________________');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading('Remarks', 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: CustomTextFormField(
                                hintText: 'Enter Text here...',
                                hintTextStyle: TextStyle(fontSize: 15),
                                maxLine: 3,
                                controller: controller.remarksController,
                                filledColor: MyColors.greyForTextFormField,
                                textStyle: const TextStyle(
                                    color: MyColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [],
                                maxLength: 200,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          bottomNavigationBar: buttons(),
        ),
      );
    });
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
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          //     child:
          //         buttonText('Save & Print', 15, FontWeight.bold, MyColors.w)),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () {},
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

  Text buttonText(
      String text, double size, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
