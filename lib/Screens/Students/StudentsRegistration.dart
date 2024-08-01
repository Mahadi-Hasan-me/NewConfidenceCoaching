import 'dart:convert';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/Students/ImageUpload.dart';
// import 'package:confidence/Screens/Students/OTPPage.dart';
import 'package:confidence/Screens/important.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();
  TextEditingController myAddressController = TextEditingController();
  TextEditingController myPhoneNumberController = TextEditingController();
  TextEditingController myAdminNameController = TextEditingController();
  TextEditingController MotherNameController = TextEditingController();
  TextEditingController FatherNameController = TextEditingController();
  TextEditingController DateOfBirthController = TextEditingController();
  TextEditingController BirthCertificateNoController = TextEditingController();
  TextEditingController NIDController = TextEditingController();
  TextEditingController FatherPhoneNoController = TextEditingController();
  TextEditingController CourseFeeController = TextEditingController();
  TextEditingController IDNoController = TextEditingController();
  TextEditingController RegCodeController = TextEditingController();
  TextEditingController PresentAddressController = TextEditingController();
  TextEditingController SSCRollNoController = TextEditingController();
  TextEditingController HSCRollNoController = TextEditingController();
  TextEditingController RegistrationNoController = TextEditingController();
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController SSCGPAController = TextEditingController();
  TextEditingController HSCGPAController = TextEditingController();
  TextEditingController SSCInstitutionNameController = TextEditingController();
  TextEditingController HSCInstitutionNameController = TextEditingController();
  TextEditingController FutureAimController = TextEditingController();
  TextEditingController SSCBatchYearController = TextEditingController();
  TextEditingController HSCBatchYearController = TextEditingController();

  String errorTxt = "";

  String RegCode = "confidence123";

  var RegCodeTextField = "";

  String SelectedValue = "";

  String SelectedSemisterValue = "";

  String SelectedCategory = "";

  var createUserErrorCode = "";

  bool loading = false;

  var rng = new Random();
  var code = Random().nextInt(90000000) + 10000000;

  // All Error Message Show

  bool NameError = false;
  bool phoneNumberError = false;
  bool EmailError = false;
  bool addressError = false;
  bool passwordError = false;
  bool FatherPhoneError = false;
  bool CourseFeeError = false;
  bool IDError = false;

  void checkEmailTextField() {
    if (myEmailController.text.isEmpty) {
      setState(() {
        EmailError = true;
      });
    } else {
      setState(() {
        EmailError = false;
      });
    }
  }

  void checkPhoneNumberTextField() {
    if (myPhoneNumberController.text.isEmpty) {
      setState(() {
        phoneNumberError = true;
      });
    } else {
      setState(() {
        phoneNumberError = false;
      });
    }
  }

  void checkNameTextField() {
    if (StudentNameController.text.isEmpty) {
      setState(() {
        NameError = true;
      });
    } else {
      setState(() {
        NameError = false;
      });
    }
  }

  void checkAddressTextField() {
    if (myAddressController.text.isEmpty) {
      setState(() {
        addressError = true;
      });
    } else {
      setState(() {
        addressError = false;
      });
    }
  }

  void checkPasswordTextField() {
    if (myPassController.text.isEmpty) {
      setState(() {
        passwordError = true;
      });
    } else {
      setState(() {
        passwordError = false;
      });
    }
  }

  void checkFatherPhoneNoTextField() {
    if (FatherPhoneNoController.text.isEmpty) {
      setState(() {
        FatherPhoneError = true;
      });
    } else {
      setState(() {
        FatherPhoneError = false;
      });
    }
  }

  void checkCourseFeeTextField() {
    if (CourseFeeController.text.isEmpty) {
      setState(() {
        CourseFeeError = true;
      });
    } else {
      setState(() {
        CourseFeeError = false;
      });
    }
  }

  void checkIDTextField() {
    if (IDNoController.text.isEmpty) {
      setState(() {
        IDError = true;
      });
    } else {
      setState(() {
        IDError = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // FlutterNativeSplash.remove();

    print(code);
  }

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: const Text(
          "Student Registration Form",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: loading
            ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: const Color(0xFF1A1A3F),
                    secondRingColor: Theme.of(context).primaryColor,
                    thirdRingColor: Colors.white,
                    size: 100,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    errorTxt.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                color: Colors.red.shade400,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${errorTxt}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          )
                        : Text(""),

                    const SizedBox(
                      height: 15,
                    ),

                    // Center(
                    //   child: Lottie.asset(
                    //   'lib/images/animation_lk8g4ixk.json',
                    //     fit: BoxFit.cover,
                    //     width: 300,
                    //     height: 200
                    //   ),
                    // ),

                    // SizedBox(
                    //           height: 20,
                    //         ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Student Name',
                              helperText: NameError ? 'Required Enter Student Name' : "",
                              helperStyle: TextStyle(color: Colors.red.shade400),
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Student Name',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: StudentNameController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Father Name',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Father Name',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: FatherNameController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mother Name',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Mother Name',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: MotherNameController,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date of Birth (01/01/2000)',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Date of Birth (01/01/2000)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: DateOfBirthController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Student Phone No(017******)',
                              helperText: phoneNumberError ? 'Required Enter Student Phone No' : "",
                              helperStyle: TextStyle(color: Colors.red.shade400),
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Student Phone No(017******)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: myPhoneNumberController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Father Phone No(017****)',
                              helperText: FatherPhoneError ? 'Required Enter Father Phone No' : "",
                              helperStyle: TextStyle(color: Colors.red.shade400),
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Father Phone No(017****)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: FatherPhoneNoController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'SSC Roll No',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'SSC Roll No',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: SSCRollNoController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'HSC Roll No',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'HSC Roll No ',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: HSCRollNoController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Registration No',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Registration No',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: RegistrationNoController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 5,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'SSC GPA',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'SSC GPA',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: SSCGPAController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 5,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'HSC GPA',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'HSC GPA',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: HSCGPAController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'SSC Institution Name',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'SSC Institution Name',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: SSCInstitutionNameController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'HSC Institution Name',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'HSC Institution Name',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: HSCInstitutionNameController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                        onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Present Address',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Present Address',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: PresentAddressController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 3,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              helperText: addressError ? 'Required Enter Permanent Address' : "",
                              helperStyle: TextStyle(color: Colors.red.shade400),
                              labelText: 'Permanent Address',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'Permanent Address',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: myAddressController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 4,
                          child: TextField(
                        
                        onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText:
                                  'Future Aim (BUET, Medical, University, Nursing)',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText:
                                  'Future Aim (BUET, Medical, University, Nursing)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: FutureAimController,
                          ),
                        ),
                      ],
                    ),



                   const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: TextField(
                        onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'SSC Batch Year(2024)',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'SSC Batch Year(2024)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: SSCBatchYearController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: width / 2,
                          child: TextField(
                            onChanged: (value) {
                        checkAddressTextField();
                        checkNameTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();

                      },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              
                              labelText: 'HSC Batch Year(2026)',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : Colors.black),
                              hintText: 'HSC Batch Year(2026)',
                              //  enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                              //   ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                            ),
                            controller: HSCBatchYearController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                     
                      ],
                    ),

       

                    SizedBox(
                      height: 11,
                    ),

                    Container(
                      height: 70,
                      child: DropdownButton(
                        hint: SelectedValue == ""
                            ? Text('Department')
                            : Text(
                                SelectedValue,
                                style: TextStyle(
                                    color: ColorName().appColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: ColorName().appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        items: [
                          'Science',
                          'Arts',
                          'Commerce',
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              SelectedValue = val!;
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 11,
                    ),

                    TextField(
                      onChanged: (value) {
                        setState(() {
                          RegCodeTextField = value.trim().toLowerCase();
                        });

                        // For Android

                        // setState(() {
                        //   RegCodeController.text = value;
                        // });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Reg Code',
                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Theme.of(context).primaryColor
                                : Colors.black),
                        hintText: 'Enter Reg Code',
                        //  enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                        //   ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                      ),
                      controller: RegCodeController,
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    SizedBox(
                      height: 15,
                    ),

// যদি Android হয় তখন নিচে RegCodeTextField change করে RegCodeController.text.trim().tolowerCase() ব্যবহার করতে হবে।

                    RegCode == RegCodeTextField &&
                            
                            myAddressController.text.isNotEmpty &&
                            StudentNameController.text.isNotEmpty &&
                            myPhoneNumberController.text.isNotEmpty &&
                            FatherPhoneNoController.text.isNotEmpty &&
                            SelectedValue.isNotEmpty 
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    try {
                                      // final credential = await FirebaseAuth
                                      //     .instance
                                      //     .createUserWithEmailAndPassword(
                                      //   email: myEmailController.text.trim(),
                                      //   password: myPassController.text.trim(),
                                      // );

                                      // await credential.user?.updateDisplayName(
                                      //     myAdminNameController.text
                                      //         .trim()
                                      //         .toLowerCase());

                                      // await credential.user?.updatePhoneNumber(myPhoneNumberController.text.trim() as PhoneAuthCredential);

                                      // await credential.user?.sendEmailVerification();

                                      // var AdminMsg = "Dear Admin, ${myEmailController.text.trim()}  ${myPhoneNumberController.text} Admin হতে চায়। Please Check App";

                                      // final response = await http
                                      //     .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01713773514&message=${AdminMsg}'));

                                      // if (response.statusCode == 200) {
                                      // If the server did return a 200 OK response,
                                      // then parse the JSON.
                                      final docUser = FirebaseFirestore.instance
                                          .collection("StudentInfo");

                                      final jsonData = {
                                        "StudentName": StudentNameController
                                            .text
                                            .trim()
                                            .toLowerCase(),

                                        "StudentPhoneNumber":
                                            myPhoneNumberController.text.trim(),
                                        "StudentPresentAddress":
                                            PresentAddressController.text
                                                .trim(),

                                        "StudentPermanentAddress":
                                            myAddressController.text
                                                .trim(),

                                        "StudentDateOfBirth":
                                            DateOfBirthController.text.trim(),

                                        "FatherName": FatherNameController.text
                                            .trim()
                                            .toLowerCase(),
                                        "MotherName": MotherNameController.text
                                            .trim()
                                            .toLowerCase(),
                                        "SSCRollNo":SSCRollNoController.text.trim(),
                                        "HSCRollNo":HSCRollNoController.text.trim(),
                                        "RegistrationNo":RegistrationNoController.text.trim(),
                                        "SSCInstitutionName":SSCInstitutionNameController.text.trim(),
                                        "HSCInstitutionName":HSCInstitutionNameController.text.trim(),
                                        "SSCGPA":SSCGPAController.text.trim(),
                                        "HSCGPA":HSCGPAController.text.trim(),
                                        "FutureAim":FutureAimController.text.trim(),
                                        "FatherPhoneNo":
                                            FatherPhoneNoController.text.trim(),
                                        "SSCBatchYear":SSCBatchYearController.text.trim(),
                                        "HSCBatchYear":HSCBatchYearController.text.trim(),
                                        "Department": SelectedValue.toString()
                                            .toLowerCase(),

                                        "SIDNo": code.toString(),
                                        "AdmissionDateTime":
                                            "${DateTime.now().toIso8601String()}",
                                        "AdmissionDate":
                                            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                        "AdmissionMonth":
                                            "${DateTime.now().month}/${DateTime.now().year}",
                                        "AdmissionYear":
                                            "${DateTime.now().year}",
                                        "StudentStatus": "new",
                                        "AccountStatus": "open",
                                        "TeacherList":[],
                                        "FatherPhoneOtpCode": code.toString(),
                                        "StudentPhoneOtpCode": code.toString(),
                                        "StudentPhoneVerify": "false",
                                        "FatherPhoneVerify": "false",
                                        "StudentImageUrl":
                                            "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg"
                                      };

                                      await docUser
                                          .doc(code.toString())
                                          .set(jsonData)
                                          .then((value) => setState(() async {
                                                var OtpMsg =
                                                    "Your OTP ${code} MediCrack. InanSoft";

                                                // final response = await http.get(
                                                //     Uri.parse(
                                                //         'https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=${myPhoneNumberController.text.trim()}&message=${OtpMsg}'));

                                                // if (response.statusCode ==
                                                //     200) {
                                                //   // If the server did return a 200 OK response,
                                                //   // then parse the JSON.

                                                //   print("");
                                                // } else {
                                                //   // If the server did not return a 200 OK response,
                                                //   // then throw an exception.
                                                //   throw Exception(
                                                //       'Failed to load album');
                                                // }

                                                final snackBar = SnackBar(
                                                  /// need to set following properties for best effect of awesome_snackbar_content
                                                  elevation: 0,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content:
                                                      AwesomeSnackbarContent(
                                                    title:
                                                        'Registration Successfull',
                                                    message:
                                                        'Registration Successfull',

                                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                    contentType:
                                                        ContentType.success,
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackBar);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ImageUpload(SID: code.toString())),
                                                );

                                                //  myAdminNameController.clear();
                                                //     myEmailController.clear();
                                                //     myPassController.clear();
                                                //     myPhoneNumberController.clear();

                                                setState(() {
                                                  loading = false;
                                                });
                                              }))
                                          .onError((error, stackTrace) =>
                                              setState(() {
                                                setState(() {
                                                  loading = false;
                                                });

                                                final snackBar = SnackBar(
                                                  /// need to set following properties for best effect of awesome_snackbar_content
                                                  elevation: 0,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content:
                                                      AwesomeSnackbarContent(
                                                    title:
                                                        'Registration Successfull',
                                                    message:
                                                        'Registration Successfull',

                                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                    contentType:
                                                        ContentType.success,
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackBar);
                                              }));

                                      setState(() {
                                        loading = false;
                                      });

                                      // print(credential.user!.email.toString());
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        loading = false;
                                      });

                                      setState(() {
                                        errorTxt = e.code.toString();
                                      });

                                      // if (e.code == 'weak-password') {

                                      //   setState(() {
                                      //     loading = false;
                                      //     createUserErrorCode = "weak-password";
                                      //   });
                                      //   print('The password provided is too weak.');
                                      // } else if (e.code == 'email-already-in-use') {

                                      //   setState(() {
                                      //     loading = false;
                                      //     createUserErrorCode = "email-already-in-use";
                                      //   });
                                      //   print('The account already exists for that email.');
                                      // }
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      print(e);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Theme.of(context).primaryColor),
                                  ),
                                  child: const Text(
                                    "Create Account",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text("")
                  ],
                ),
              ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
