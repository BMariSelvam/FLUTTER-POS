import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'DeviceActivactionControoler.dart';

class DeviceVAlidationScreen extends StatefulWidget {
  const DeviceVAlidationScreen({Key? key}) : super(key: key);

  static const String routeName = "/DeviceVAlidationScreen";

  @override
  State<DeviceVAlidationScreen> createState() => _DeviceVAlidationScreenState();
}

class _DeviceVAlidationScreenState extends State<DeviceVAlidationScreen> {
  late DeviceActivationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(DeviceActivationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 32.0,
                      ),
                      child: Image.asset(
                        "assets/images/bro.png",
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.uenNumberCOntroller,
                  decoration: InputDecoration(
                    labelText: 'Uen Number',
                    prefixIcon: Icon(Icons.confirmation_num),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter Uen Number";
                    } else if (value.length < 6) {
                      return 'please Enter Uen Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  controller: controller.activationController,
                  decoration: InputDecoration(
                    labelText: 'ActivationCode Code',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter ActivationCode Code";
                    } else if (value.length < 6) {
                      return 'please Enter ActivationCode Code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter Name";
                    } else if (value.length < 6) {
                      return 'please Enter Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff159594)
                  ),
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller. postData();
                    }
                  },
                  child: Text('Add Device'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
