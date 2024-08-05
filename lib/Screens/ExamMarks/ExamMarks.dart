import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:input_quantity/input_quantity.dart';
import 'package:uuid/uuid.dart';

class ExamMarks extends StatefulWidget {
  ExamMarks({
    super.key,
  });

  @override
  _ExamMarksState createState() => _ExamMarksState();
}

class _ExamMarksState extends State<ExamMarks> {
  int _selectedDestination = 0;

  var uuid = Uuid();

  TextEditingController SearchByStudentIDController = TextEditingController();

  TextEditingController BatchNameController = TextEditingController();
  TextEditingController BatchDescriptionController = TextEditingController();
  TextEditingController PerStudentFeeController = TextEditingController();
  TextEditingController BuyingPriceController = TextEditingController();
  TextEditingController SalePriceController = TextEditingController();
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController CustomerPhoneNoController = TextEditingController();
  TextEditingController CustomerAddressController = TextEditingController();
  TextEditingController ConditionMonthController = TextEditingController();
  TextEditingController DiscountAmountController = TextEditingController();
  TextEditingController CashInController = TextEditingController();
  TextEditingController InterestController = TextEditingController();
  TextEditingController FileNoController = TextEditingController();
  TextEditingController ClassOfMsgController = TextEditingController();
  TextEditingController TeacherIDController = TextEditingController();
  TextEditingController StudentIDController = TextEditingController();
  TextEditingController ExamMarksController = TextEditingController();
  TextEditingController TopicNameController = TextEditingController();
  TextEditingController ExamDateController = TextEditingController();

  final List<TextEditingController> MarksController = [];

  createControllers() {
    for (var i = 0; i < AllStudentInfo.length; i++) {
      MarksController.add(TextEditingController());
    }
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// var ProductID = "";

  List AllStudentInfo = [];

  Future<void> getProductInfo() async {
    // CollectionReference _collectionDueCustomerRef =
    //   FirebaseFirestore.instance.collection('ProductInfo');

    //   QuerySnapshot DueCustomerquerySnapshot = await _collectionDueCustomerRef.get();

    //   // Get data from docs and convert map to List
    //    AllStudentInfo = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      //  AllStudentInfo = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

      AllStudentInfo = [
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
        {
          "StudentName": "Mahadi",
          "StudentID": "3435",
          "PhoneNo": "43543465",
          "InstitutionName": "Msjdf",
          "FatherPhoneNo": "454546",
          "AcademyName": "Rezuan Math Care",
          "BatchName": "HSC261"
        },
      ];
    });

    // print(AllData);
  }

  Future<void> getSearchProductInfo(String ProductVisibleID) async {
    CollectionReference _collectionDueCustomerRef =
        FirebaseFirestore.instance.collection('ProductInfo');

    Query DueCustomerquery = _collectionDueCustomerRef.where("ProductVisibleID",
        isEqualTo: ProductVisibleID);

    QuerySnapshot DueCustomerquerySnapshot = await DueCustomerquery.get();

    // Get data from docs and convert map to List
    AllStudentInfo =
        DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentInfo =
          DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
      SearchByStudentIDController.clear();
    });

    // print(AllData);
  }

  final List<String> TeachersAcademy = [
    'Rezuan Math Care',
    'Sazzad ICT',
    'MediCrack',
    'Protick Physics',
  ];
  String? selectedTeachersAcademyValue;

  final List<String> BatchName = [
    'HSC261',
    'HSC262',
    'HSC263',
    'HSC263',
  ];
  String? selectedBatchNameValue;

  @override
  void initState() {
    // FlutterNativeSplash.remove();

    getProductInfo();

    createControllers();

    // setState(() {
    //   _selectedDestination = 0;
    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var ProductUniqueID = uuid.v4();

    ClassOfMsgController.text =
        "আগামীকাল ..... কারণে আমাদের ..... প্রতিষ্ঠান ক্লাস বন্ধ থাকবে।আমরা বিষয়টির জন্য আন্তরিকভাবে দুঃখিত।";

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'All Menu',
                  style: textTheme.titleLarge,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Exam'),
                selected: _selectedDestination == 0,
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExamMarks()));
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('All Teachers'),
                selected: _selectedDestination == 1,
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DueCustomers()));
                },
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('All Student'),
                selected: _selectedDestination == 2,
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomers()));
                },
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Add Exam Marks'),
                selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExamMarks()));
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton(
                    onSelected: (value) {
                      // your logic
                    },
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          child: Text(
                            "Add Registered Student",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                          value: '/about',
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String SelectedStudentStatus = "";
                                String Title =
                                    "নিচে নতুন রেজিস্ট্রেশন করা স্টুডেন্ট যুক্ত করুন";

                                bool loading = false;

                                final List<String> TeachersBatch = [
                                  'Rezuan Math Care',
                                  'Sazzad ICT',
                                  'MediCrack',
                                  'Protick Physics',
                                ];
                                String? selectedTeachersBatchValue;

                                // String LabelText ="আয়ের খাত লিখবেন";

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "${Title}",
                                              style: TextStyle(
                                                  fontFamily: "Josefin Sans",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
                                                          String>(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Teacher',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                          ),
                                                        ),
                                                        items: TeachersAcademy
                                                            .map((String
                                                                    item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                )).toList(),
                                                        value:
                                                            selectedTeachersAcademyValue,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            selectedTeachersAcademyValue =
                                                                value;
                                                          });
                                                        },
                                                        buttonStyleData:
                                                            const ButtonStyleData(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          height: 40,
                                                          width: 140,
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
                                                          String>(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Batch',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                          ),
                                                        ),
                                                        items: TeachersBatch
                                                            .map((String
                                                                    item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                )).toList(),
                                                        value:
                                                            selectedTeachersBatchValue,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            selectedTeachersBatchValue =
                                                                value;
                                                          });
                                                        },
                                                        buttonStyleData:
                                                            const ButtonStyleData(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          height: 40,
                                                          width: 140,
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Enter Student ID',

                                                        hintText:
                                                            'Enter Student ID',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          StudentIDController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Enter Teacher ID',

                                                        hintText:
                                                            'Enter Teacher ID',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          TeacherIDController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            var id = getRandomString(7);

                                            var updateData = {
                                              "TeacherAcademyName":
                                                  selectedTeachersAcademyValue
                                                      .toString(),
                                              "TeacherBatchName":
                                                  selectedBatchNameValue
                                                      .toString(),
                                              "TeacherID": TeacherIDController
                                                  .text
                                                  .trim(),
                                              "StudentID": TeacherIDController
                                                  .text
                                                  .trim(),
                                              "Status": "open",
                                              "year": "${DateTime.now().year}",
                                              "month":
                                                  "${DateTime.now().month}/${DateTime.now().year}",
                                              "Date":
                                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                              "DateTime": DateTime.now()
                                                  .toIso8601String(),
                                            };

                                            final StudentInfo =
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'PerTeacherStudentInfo')
                                                    .doc(ProductUniqueID);

                                            StudentInfo.set(updateData)
                                                .then((value) => setState(() {
                                                      // Navigator.pop(context);

                                                      AwesomeDialog(
                                                        width: 500,
                                                        context: context,
                                                        animType:
                                                            AnimType.scale,
                                                        dialogType:
                                                            DialogType.success,
                                                        body: const Center(
                                                            child: Text(
                                                          "ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Josefin Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        title:
                                                            'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                        desc:
                                                            'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                        btnOkOnPress: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ).show();

                                                      final snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          titleFontSize: 12,
                                                          title: 'successfull',
                                                          message:
                                                              'Hey Thank You. Good Job',

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .success,
                                                        ),
                                                      );

                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);

                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }))
                                                .onError((error, stackTrace) =>
                                                    setState(() {
                                                      final snackBar = SnackBar(
                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                        elevation: 0,

                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title:
                                                              'Something Wrong!!!!',
                                                          message:
                                                              'Try again later...',

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .failure,
                                                        ),
                                                      );

                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);

                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }));
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                        PopupMenuItem(
                          child: Text(
                            "Create Batch Name",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                          value: '/about',
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String SelectedStudentStatus = "";
                                String Title = "নিচে নতুন ব্যাচের নাম লিখুন";

                                bool loading = false;
                                String ClassStartHour = "";
                                String ClassStartMinute = "";
                                String ClassEndHour = "";
                                String ClassEndMinute = "";

                                // String LabelText ="আয়ের খাত লিখবেন";

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "${Title}",
                                              style: TextStyle(
                                                  fontFamily: "Josefin Sans",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Teacher ID',

                                                        hintText: 'Teacher ID',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          TeacherIDController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'New Batch Name',

                                                        hintText:
                                                            'New Batch Name',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          BatchNameController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Batch Description',

                                                        hintText:
                                                            'Batch Description',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          BatchDescriptionController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Per Student Fee',

                                                        hintText:
                                                            'Per Student Fee',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          PerStudentFeeController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("Class Start: "),
                                                          TextButton(
                                                              style:
                                                                  ButtonStyle(
                                                                foregroundColor:
                                                                    WidgetStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .blue),
                                                                overlayColor:
                                                                    WidgetStateProperty
                                                                        .resolveWith<
                                                                            Color?>(
                                                                  (Set<WidgetState>
                                                                      states) {
                                                                    if (states.contains(
                                                                        WidgetState
                                                                            .hovered))
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.04);
                                                                    if (states.contains(WidgetState
                                                                            .focused) ||
                                                                        states.contains(
                                                                            WidgetState.pressed))
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.12);
                                                                    return null; // Defer to the widget's default.
                                                                  },
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                final TimeOfDay?
                                                                    newTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay(
                                                                          hour:
                                                                              7,
                                                                          minute:
                                                                              15),
                                                                  initialEntryMode:
                                                                      TimePickerEntryMode
                                                                          .input,
                                                                );

                                                                setState(() {
                                                                  ClassStartHour =
                                                                      newTime!
                                                                          .hour
                                                                          .toString();
                                                                  ClassStartMinute =
                                                                      newTime
                                                                          .minute
                                                                          .toString();
                                                                });
                                                              },
                                                              child: Text(
                                                                  'Start Time'))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Class End: "),
                                                          TextButton(
                                                              style:
                                                                  ButtonStyle(
                                                                foregroundColor:
                                                                    WidgetStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .blue),
                                                                overlayColor:
                                                                    WidgetStateProperty
                                                                        .resolveWith<
                                                                            Color?>(
                                                                  (Set<WidgetState>
                                                                      states) {
                                                                    if (states.contains(
                                                                        WidgetState
                                                                            .hovered))
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.04);
                                                                    if (states.contains(WidgetState
                                                                            .focused) ||
                                                                        states.contains(
                                                                            WidgetState.pressed))
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.12);
                                                                    return null; // Defer to the widget's default.
                                                                  },
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                final TimeOfDay?
                                                                    newTime =
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay(
                                                                          hour:
                                                                              7,
                                                                          minute:
                                                                              15),
                                                                  initialEntryMode:
                                                                      TimePickerEntryMode
                                                                          .input,
                                                                );

                                                                setState(() {
                                                                  ClassEndHour =
                                                                      newTime!
                                                                          .hour
                                                                          .toString();
                                                                  ClassEndMinute =
                                                                      newTime
                                                                          .minute
                                                                          .toString();
                                                                });
                                                              },
                                                              child: Text(
                                                                  'Start End'))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            var id = getRandomString(7);

                                            var updateData = {
                                              "BatchName": BatchNameController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                              "BatchDescription":
                                                  BatchDescriptionController
                                                      .text
                                                      .trim()
                                                      .toString(),
                                              "PerStudentFee":
                                                  PerStudentFeeController.text
                                                      .trim()
                                                      .toString(),
                                              "TeacherID": TeacherIDController
                                                  .text
                                                  .trim(),
                                              "ClassStartHour": ClassStartHour,
                                              "ClassStartMinute":
                                                  ClassStartMinute,
                                              "ClassEndHour": ClassEndHour,
                                              "ClassEndMinute": ClassEndMinute,
                                              "year": "${DateTime.now().year}",
                                              "month":
                                                  "${DateTime.now().month}/${DateTime.now().year}",
                                              "Date":
                                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                              "DateTime": DateTime.now()
                                                  .toIso8601String(),
                                            };

                                            final StudentInfo =
                                                FirebaseFirestore.instance
                                                    .collection('AllBatchInfo')
                                                    .doc(ProductUniqueID);

                                            StudentInfo.set(updateData)
                                                .then((value) => setState(() {
                                                      // Navigator.pop(context);

                                                      AwesomeDialog(
                                                        width: 500,
                                                        context: context,
                                                        animType:
                                                            AnimType.scale,
                                                        dialogType:
                                                            DialogType.success,
                                                        body: const Center(
                                                            child: Text(
                                                          "ব্যাচের নাম সফলভাবে যুক্ত হয়েছে",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Josefin Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        title:
                                                            'ব্যাচের নাম সফলভাবে যুক্ত হয়েছে',
                                                        desc:
                                                            'ব্যাচের নাম সফলভাবে যুক্ত হয়েছে',
                                                        btnOkOnPress: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ).show();

                                                      final snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          titleFontSize: 12,
                                                          title: 'successfull',
                                                          message:
                                                              'Hey Thank You. Good Job',

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .success,
                                                        ),
                                                      );

                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);

                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }))
                                                .onError((error, stackTrace) =>
                                                    setState(() {
                                                      final snackBar = SnackBar(
                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                        elevation: 0,

                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title:
                                                              'Something Wrong!!!!',
                                                          message:
                                                              'Try again later...',

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .failure,
                                                        ),
                                                      );

                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);

                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }));
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                        PopupMenuItem(
                          value: '/hello',
                          child: Text(
                            "Send SMS for Class Off",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: Text(
                            "Send SMS to All Student",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        PopupMenuItem(
                          value: '/hello',
                          child: Text(
                            "Search By ID",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        PopupMenuItem(
                          value: '/hello',
                          child: Text(
                            "Search By Phone No",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        PopupMenuItem(
                          value: '/hello',
                          child: Text(
                            "Set Due for All Student",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        //      PopupMenuItem(
                        //       onTap: () {
                        //            Navigator.push(
                        //   context,MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()),
                        // );
                        //       },
                        //       value: '/hello',
                        //       child: Text("প্রতিদিন বকেয়া উত্তোলনের History", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                        //     ),
                      ];
                    },
                  ),
                  Text("Add Student Exam Marks"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 20,
                        child: Container(
                          width: 200,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Academy Name',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: TeachersAcademy.map(
                                  (String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                              value: selectedTeachersAcademyValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedTeachersAcademyValue = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 20,
                        child: Container(
                          width: 200,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Batch Name',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: BatchName.map(
                                  (String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                              value: selectedBatchNameValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedTeachersAcademyValue = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            getSearchProductInfo(SearchByStudentIDController
                                .text
                                .trim()
                                .toLowerCase());
                          },
                          child: Text("Search")),
                    ],
                  ),
                ],
              ),
            ),
            body: GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              childAspectRatio: 3 / 2,
              children: [
                Card(
                  surfaceTintColor: Colors.white,
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DataTable2(
                        headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        columnSpacing: 12,
                        headingRowColor: WidgetStatePropertyAll(Colors.pink),
                        horizontalMargin: 12,
                        minWidth: 600,
                        dividerThickness: 3,
                        columns: [
                          DataColumn2(
                            label: Text('SL'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Student ID'),
                          ),
                          DataColumn(
                            label: Text('Student Name'),
                          ),
                          DataColumn(
                            label: Text('Phone No'),
                          ),
                          DataColumn(
                            label: Text('Institution Name'),
                          ),
                          DataColumn(
                            label: Text('Father Phone No'),
                          ),
                          DataColumn(
                            label: Text('Academy Name'),
                          ),
                          DataColumn(
                            label: Text('Batch Name'),
                          ),
                          DataColumn(
                            label: Text('Batch Time'),
                          ),
                          DataColumn(
                            label: Text('Add Marks'),
                            numeric: true,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            AllStudentInfo.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentID"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]["PhoneNo"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["InstitutionName"].toString().toUpperCase()}")),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["FatherPhoneNo"].toString().toUpperCase()}")),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["AcademyName"].toString().toUpperCase()}")),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["BatchName"].toString().toUpperCase()}")),
                                  DataCell(Text("")),
                                  DataCell(
                                    Container(
                                      width: 100,
                                      child: TextField(
                                        textInputAction: TextInputAction.go,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Marks',

                                          hintText: 'Marks',

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: MarksController[index],
                                      ),
                                    ),
                                  ),
                                ]))),
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String SelectedStudentStatus = "";
                                String Title = "Marks পাঠিয়ে দিন";

                                bool loading = false;

                                // String LabelText ="আয়ের খাত লিখবেন";

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "${Title}",
                                              style: TextStyle(
                                                  fontFamily: "Josefin Sans",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Exam Marks',

                                                        hintText: 'Exam Marks',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          ExamMarksController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Topic Name',

                                                        hintText: 'Topic Name',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          TopicNameController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Exam Date(23-12-2000)',

                                                        hintText:
                                                            'Exam Date(23-12-2000)',

                                                        //  enabledBorder: OutlineInputBorder(
                                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                        //     ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 3,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                        ),
                                                      ),
                                                      controller:
                                                          ExamDateController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            List AllStudentMarks = [];

                                            List SortStudentMarks = [];

                                            List StudentMarksWithInfo = [];

                                            for (var i = 0;
                                                i < AllStudentInfo.length;
                                                i++) {
                                              AllStudentMarks.add(
                                                  MarksController[i]
                                                      .text
                                                      .trim());

                                              SortStudentMarks.add(
                                                  MarksController[i]
                                                      .text
                                                      .trim());
                                            }

                                            SortStudentMarks.sort();

                                            print(SortStudentMarks);

                                            for (var i = 0;
                                                i < AllStudentMarks.length;
                                                i++) {
                                              var perStudentInfoWithMarks = {
                                                "StudentID": AllStudentInfo[i]
                                                    ["StudentID"],
                                                "AcademyName": AllStudentInfo[i]
                                                    ["AcademyName"],
                                                "BatchName": AllStudentInfo[i]
                                                    ["BatchName"],
                                                "TotalMarks": AllStudentMarks[i]
                                                    .toString(),
                                                "HighestMarks": SortStudentMarks
                                                    .last
                                                    .toString(),
                                                "ExamDate": ExamDateController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "year":
                                                    "${DateTime.now().year}",
                                                "month":
                                                    "${DateTime.now().month}/${DateTime.now().year}",
                                                "Date":
                                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                "DateTime": DateTime.now()
                                                    .toIso8601String(),
                                                "TopicName": TopicNameController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "Position":
                                                    (SortStudentMarks.indexOf(
                                                                    AllStudentMarks[
                                                                        i])
                                                                .toInt() +
                                                            1)
                                                        .toString()
                                              };

                                              StudentMarksWithInfo.insert(
                                                  StudentMarksWithInfo.length,
                                                  perStudentInfoWithMarks);
                                            }
                                            ;

                                            print(StudentMarksWithInfo);

                                            // var id = getRandomString(7);

                                            for (var i = 0;
                                                i < StudentMarksWithInfo.length;
                                                i++) {
                                              final ResultInfo =
                                                  FirebaseFirestore.instance
                                                      .collection('ResultInfo')
                                                      .doc(ProductUniqueID);

                                              ResultInfo.set(
                                                      StudentMarksWithInfo[i])
                                                  .then((value) =>
                                                      setState(() async {
                                                        // Navigator.pop(context);

                                                        var Msg =
                                                            "SID:${StudentMarksWithInfo[i]["StudentID"]},TN:${StudentMarksWithInfo[i]["TopicName"].toString()}, M:${StudentMarksWithInfo[i]["TotalMarks"].toString()} HM:${StudentMarksWithInfo[i]["HighestMarks"].toString()}, P:${StudentMarksWithInfo[i]["Position"].toString()}, ${StudentMarksWithInfo[i]["AcademyName"].toString()}";

                                                        try {
                                                          final response =
                                                              await http.get(
                                                                  Uri.parse(
                                                                      'https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=${AllStudentInfo[i]["FatherPhoneNo"].toString().trim()}&message=${Msg}'));

                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            // If the server did return a 200 OK response,
                                                            // then parse the JSON.

                                                            print("");
                                                          } else {
                                                            // If the server did not return a 200 OK response,
                                                            // then throw an exception.
                                                            throw Exception(
                                                                'Failed to load album');
                                                          }
                                                        } catch (e) {}

                                                        AwesomeDialog(
                                                          width: 500,
                                                          context: context,
                                                          animType:
                                                              AnimType.scale,
                                                          dialogType: DialogType
                                                              .success,
                                                          body: const Center(
                                                              child: Text(
                                                            "Marks যুক্ত হয়েছে",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Josefin Sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          title:
                                                              'Marks  যুক্ত হয়েছে',
                                                          desc:
                                                              'Marks যুক্ত হয়েছে',
                                                          btnOkOnPress: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ).show();

                                                        final snackBar =
                                                            SnackBar(
                                                          elevation: 0,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          content:
                                                              AwesomeSnackbarContent(
                                                            titleFontSize: 12,
                                                            title:
                                                                'successfull',
                                                            message:
                                                                'Hey Thank You. Good Job',

                                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                            contentType:
                                                                ContentType
                                                                    .success,
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                              snackBar);

                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }))
                                                  .onError((error,
                                                          stackTrace) =>
                                                      setState(() {
                                                        final snackBar =
                                                            SnackBar(
                                                          /// need to set following properties for best effect of awesome_snackbar_content
                                                          elevation: 0,

                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          content:
                                                              AwesomeSnackbarContent(
                                                            title:
                                                                'Something Wrong!!!!',
                                                            message:
                                                                'Try again later...',

                                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                            contentType:
                                                                ContentType
                                                                    .failure,
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                              snackBar);

                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }));
                                            }
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text("Send"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // void selectDestination(int index) {
  //   setState(() {
  //     _selectedDestination = index;
  //   });
  // }
}
