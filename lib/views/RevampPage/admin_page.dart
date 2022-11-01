import 'package:fcsc_admin/views/RevampPage/home.dart';
import 'package:fcsc_admin/views/RevampPage/userPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String logOut = 'images/log_out.svg';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController _examNumber = TextEditingController();
  final Widget logOutIcon = SvgPicture.asset(
    logOut,
    semanticsLabel: 'call Icon ',
    height: 10.83.h,
    width: 10.87.h,
  );
  String? controlNumber = "";
  String newValue = "";
  Future<void> scanQRCode() async {
    // String controlNumber;
    try {
      controlNumber = await FlutterBarcodeScanner.scanBarcode(
        '#ff38AA5F',
        'Cancel',
        true,
        ScanMode.QR,
      ).then((value) {
        setState(() {
          newValue = value;
          // if (newValue != "-1") {
          //   // scanCard();
          //   Get.to(UserCard());
          // }
          Get.to(UserPage());
        });
      });
    } on PlatformException {
      controlNumber = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: Color(0xffF0F3F5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Icon(
                          Icons.person,
                          color: Color(0xff79807C),
                          size: 50,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Admin",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text("Welcome Back",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Color(0xff024126),
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(
                  //           Icons.logout_rounded,
                  //           color: Colors.red,
                  //         )),
                  //   ],
                  // )
                ],
              ),
              SizedBox(height: 42.h),
              GestureDetector(
                onTap: () => scanQRCode(),
                child: Container(
                  height: 160.h,
                  width: 358.w,
                  decoration: BoxDecoration(
                      color: Color(0xffE6F2EC),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        width: 355.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    AssetImage("images/container_image.png"))),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                          ),
                          Icon(Icons.qr_code),
                          SizedBox(
                            width: 18.25.w,
                          ),
                          Text(
                            "Scan Exam Card",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 139.w,
                          ),
                          Container(
                            width: 25.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 211, 223, 218),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Container(
                    width: 140.w,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 211, 223, 218),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("or"))),
                  Container(
                    width: 145.w,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                "Enter candidate’s exam number to validate",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff79807C)),
              ),
              SizedBox(height: 30.h),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          width: 300.w,
                          height: 40.h,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                                autocorrect: false,
                                enableSuggestions: false,
                                validator: (String? number) => number!.isEmpty
                                    ? 'Please enter candidate Exam Number'
                                    : null,
                                controller: _examNumber,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "1234566677",
                                  hintStyle: GoogleFonts.lato(
                                    fontSize: 14,
                                  ),
                                )),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              color: Color.fromARGB(003, 017, 011, 007))),
                      SizedBox(height: 30.h),
                      Container(
                        width: 300.w,
                        height: 40.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff219653)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            onPressed: () async {
                              // if (_formKey.currentState!.validate()) {
                              //   Login customerDetails = Login(
                              //       _email_address.text, _password.text);

                              //   model.login(customerDetails);
                              // }
                              Get.to(() => UserPage());
                            },
                            child: Text('Validate',
                                style: TextStyle(color: Colors.white))),
                      ),
                      SizedBox(height: 80.h),
                      GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove('pass');
                          Get.to(() => HomeScreen());
                        },
                        child: Container(
                          width: 300.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: Color(0xffFFE5E5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                logOutIcon,
                                SizedBox(
                                  width: 12.08.w,
                                ),
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                      color: Color(0xffD90A0A),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 300.w,
                      //   height: 40.h,
                      //   child: ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               Color(0xffFFE5E5)),
                      //           shape: MaterialStateProperty.all<
                      //                   RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //           ))),
                      //       onPressed: () async {
                      //         final SharedPreferences prefs =
                      //             await SharedPreferences.getInstance();
                      //         await prefs.remove('pass');
                      //         Get.to(() => HomeScreen());
                      //       },
                      //       child: Text('Log Out',
                      //           style: TextStyle(color: Color(0xffD90A0A)))),
                      // ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
