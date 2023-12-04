import 'dart:async';
import 'package:beauity_saloon/view/printPreviewController.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bluePrintController.dart';
import 'helper/appRoute.dart';


class BLUEPRINTVIEW extends StatefulWidget {
  const BLUEPRINTVIEW({Key? key}) : super(key: key);

  @override
  State<BLUEPRINTVIEW> createState() => _BLUEPRINTVIEWState();
}

class _BLUEPRINTVIEWState extends State<BLUEPRINTVIEW> {
  late BluePrintController controller;
  String? orderNmber;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();
    controller = Get.put(BluePrintController());
    orderNmber =  Get.arguments as String;
    print("orderNmber");
    print(orderNmber);
    controller.fetchData();
    controller.getSubCategoryList(orderNmber);
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     bluetoothPrint.disconnect();
  }

  bool isButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrintController>(builder: (logic)
    {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Select Printer'),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.dashboardScreen);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Text(
                    "Close",
                    style: TextStyle(fontSize: 20),
                  ),
                ))

            // Text("Logout")
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) =>
                      Column(
                        children: snapshot.data!
                            .map((d) =>
                            ListTile(
                              title: Text(d.name ?? ''),
                              subtitle: Text(d.address ?? ''),
                              onTap: () async {
                                setState(() {
                                  _device = d;
                                });
                              },
                              trailing: _device != null &&
                                  _device!.address == d.address
                                  ? Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                                  : null,
                            ))
                            .toList(),
                      ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            child: Text('connect'),
                            onPressed: _connected
                                ? null
                                : () async {
                              if (_device != null &&
                                  _device!.address != null) {
                                setState(() {
                                  tips = 'connecting...';
                                });
                                await bluetoothPrint.connect(_device!);
                              } else {
                                setState(() {
                                  tips = 'please select device';
                                });
                                print('please select device');
                              }
                            },
                          ),
                          SizedBox(width: 10.0),
                          OutlinedButton(
                            child: Text('disconnect'),
                            onPressed: _connected
                                ? () async {
                              setState(() {
                                tips = 'disconnecting...';
                              });
                              await bluetoothPrint.disconnect();
                            }
                                : null,
                          ),
                        ],
                      ),
                      Divider(),

                      Visibility(
                        visible: isButtonVisible,
                        child: OutlinedButton(
                          child: Text('Print'),
                          onPressed: _connected
                              ? () async {
                            Map<String, dynamic> config = Map();
                            setState(() {
                              isButtonVisible = false;
                            });

                            List<LineText> commonList = [];
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.orgdetailsModel.first.name}',
                              weight: 1,
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.orgdetailsModel.first.addressLine1}, \n${controller.orgdetailsModel.first.addressLine2}, \n${controller.orgdetailsModel.first.addressLine3}, \n${controller.orgdetailsModel.first.countryName}',
                              weight: 0.5.toInt(),
                              align: LineText.ALIGN_LEFT,
                              fontZoom: 2,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------------------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.orderDate},${controller.formattedTime}',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'BusinessRegNo: ${controller.orgdetailsModel.first.businessRegNo}',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content:  'TaxRegNo: ${controller.orgdetailsModel.first.taxRegNo}',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------------------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'S.No',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 0,
                                relativePos: 0,
                                linefeed: 0));
                            commonList.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'ProductName',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 100,
                                relativePos: 0,
                                fontZoom: 1,
                                linefeed: 0));
                            commonList.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Qty',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 320,
                                relativePos: 0,
                                linefeed: 0));
                            commonList.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'price',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 400,
                                relativePos: 0,
                                linefeed: 0));
                            commonList.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Total',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 500,
                                relativePos: 0,
                                linefeed: 1));
                            commonList.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------------------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            commonList.add(LineText(linefeed: 1));
                            // Loop through the data and create receipts for each item
                            List<LineText> list = List.from(
                                commonList); // Clone the common list

                            for (var item in controller.payModeModel.first
                                .pOSInvoiceDetail!) {
                              String title = item
                                  .productName!; // Get the original text
                              // int maxTitleLength = 15; // Set the maximum length you want
                              //
                              // if (title.length > maxTitleLength) {
                              //   title = title.substring(0, maxTitleLength); // Trim the text
                              // }

                              // Add item-specific details to the receipt
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${item.slNo}',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 0,
                                relativePos: 0,
                                linefeed: 0,
                              ));
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: "${title}",
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 100,
                                relativePos: 0,
                                linefeed: 1,
                                // fontZoom: (fontSize / 12.0).toInt(),
                              ));
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${item.qty}',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 320,
                                relativePos: 0,
                                linefeed: 0,
                              ));
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${item.price}',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 400,
                                relativePos: 0,
                                linefeed: 0,
                              ));
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${item.total}',
                                align: LineText.ALIGN_LEFT,
                                absolutePos: 500,
                                relativePos: 0,
                                linefeed: 1,
                              ));
                            }
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '-----------------------------------------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));

                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'SubTotal   : ',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 320,
                              relativePos: 0,
                              linefeed: 0,
                            ));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.payModeModel.first.subTotal}',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 480,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            list.add(LineText(
                              content: "                       ",
                              linefeed: 1,
                              weight: 1,));

                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'TaxValue   : ',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 320,
                              relativePos: 0,
                              linefeed: 0,
                            ));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.payModeModel.first.tax}',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 480,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            list.add(LineText(
                              content: "                       ",
                              linefeed: 1,
                              weight: 1,));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'GrandTotal : ',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 320,
                              relativePos: 0,
                              linefeed: 0,
                            ));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '${controller.payModeModel.first.netTotal}',
                              align: LineText.ALIGN_LEFT,
                              absolutePos: 480,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '----------------Thank You!----------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '----------------Visit Again!----------------',
                              align: LineText.ALIGN_CENTER,
                              absolutePos: 0,
                              relativePos: 0,
                              linefeed: 1,
                            ));
                            list.add(LineText(
                              content: "                       ",
                              linefeed: 1,
                              weight: 1,));
                            list.add(LineText(
                              content: "                       ",
                              linefeed: 1,
                              weight: 1,));


                            await bluetoothPrint.printReceipt(config, list);
                            setState(() {
                              isButtonVisible = true;
                            });
                          }
                              : null,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                      bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      );
    });
  }
}






