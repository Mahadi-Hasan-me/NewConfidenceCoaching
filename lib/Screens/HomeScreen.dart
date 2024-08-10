import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/AllBatchInfo.dart';
import 'package:confidence/Screens/Attendance/ShowStudentAttendance.dart';
import 'package:confidence/Screens/Dashboard/StudentAllPayment.dart';
import 'package:confidence/Screens/ExamMarks/ExamMarks.dart';
import 'package:confidence/Screens/Students/StudentProfile.dart';
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

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController DayController = TextEditingController();
  TextEditingController PaymentAmountController = TextEditingController();
  TextEditingController StudentPhoneNoController = TextEditingController();
  TextEditingController SetDueController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// var ProductID = "";

  List AllStudentInfo = [];

  Future<void> getAllStudentInfo() async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery = _collectionStudentInfoRef
        .where("TeacherAcademyName", isEqualTo: "Rezuan Math Care");

    QuerySnapshot StudentInfoquerySnapshot =
        await _collectionStudentInfoRef.get();

    setState(() {
      AllStudentInfo = [];
      AllStudentInfo =
          StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
    });

    // print(AllData);
  }

  Future<void> getSearchAllStudentInfo(
      String AcademyName, String HSCBatchYear) async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery = _collectionStudentInfoRef
        .where("TeacherAcademyName", isEqualTo: AcademyName)
        .where("HSCBatchYear", isEqualTo: HSCBatchYear);

    QuerySnapshot StudentInfoquerySnapshot =
        await _collectionStudentInfoRef.get();

    setState(() {
      AllStudentInfo = [];
      AllStudentInfo =
          StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
    });

    // print(AllData);
  }

  Future<void> getSearchByID(String SID) async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery =
        _collectionStudentInfoRef.where("SIDNo", isEqualTo: SID);

    QuerySnapshot StudentInfoquerySnapshot = await StudentInfoquery.get();

    // Get data from docs and convert map to List
    // AllStudentInfo =
    //     StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentInfo = [];
      AllStudentInfo =
          StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
      SearchByStudentIDController.clear();
    });

    // print(AllData);
  }

  Future<void> getSearchByStudentPhoneNo(String StudentPhoneNumber) async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery = _collectionStudentInfoRef
        .where("StudentPhoneNumber", isEqualTo: StudentPhoneNumber);

    QuerySnapshot StudentInfoquerySnapshot = await StudentInfoquery.get();

    // Get data from docs and convert map to List
    // AllStudentInfo =
    //     StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentInfo = [];
      AllStudentInfo =
          StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
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

  List<String> BatchName = [
    'HSC261',
    'HSC262',
    'HSC263',
    'HSC263',
  ];
  String? selectedBatchNameValue;

  @override
  void initState() {
    // FlutterNativeSplash.remove();

    getAllStudentInfo();

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
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Exam'),
                selected: _selectedDestination == 0,
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Batch Info'),
                selected: _selectedDestination == 0,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllBatchInfo()));
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
                  getAllStudentInfo();
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
                          value: '/about',
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String Title = "নিচে নতুন ব্যাচের নাম লিখুন";

                                bool loading = false;
                                String ClassStartHour = "";
                                String ClassStartMinute = "";
                                String ClassEndHour = "";
                                String ClassEndMinute = "";

                                final List<String> TeachersAcademy = [
                                  'Rezuan Math Care',
                                  'Sazzad ICT',
                                  'MediCrack',
                                  'Protick Physics',
                                ];
                                String? selectedTeachersAcademyValue;

                                final List<String> HSCBatchYear = [
                                  '2024',
                                  '2025',
                                  '2026',
                                  '2027',
                                  '2028',
                                  '2029',
                                  '2030',
                                  '2031',
                                  '2032',
                                  '2033',
                                ];
                                String? HSCBatchYearValue;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "${Title}",
                                              style: const TextStyle(
                                                  fontFamily: "Josefin Sans",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: loading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const SizedBox(
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
                                                            'New Batch Name(HSC241)',

                                                        hintText:
                                                            'New Batch Name(HSC241)',

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
                                                          BatchNameController,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Card(
                                                    elevation: 20,
                                                    child: Container(
                                                      width: 200,
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            'Select Academy Name',
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
                                                  ),
                                                  Card(
                                                    elevation: 20,
                                                    child: Container(
                                                      width: 200,
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            'Select HSC Batch Year',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                            ),
                                                          ),
                                                          items: HSCBatchYear
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
                                                              HSCBatchYearValue,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              HSCBatchYearValue =
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
                                                            'Batch Running Topics',

                                                        hintText:
                                                            'Batch Running Topics',

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
                                                          PerStudentFeeController,
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
                                                            'Day(শনি, সোম, বুধ)',

                                                        hintText:
                                                            'Day(শনি, সোম, বুধ)',

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
                                                      controller: DayController,
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
                                                                            .hovered)) {
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.04);
                                                                    }
                                                                    if (states.contains(WidgetState
                                                                            .focused) ||
                                                                        states.contains(
                                                                            WidgetState.pressed)) {
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.12);
                                                                    }
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
                                                                      const TimeOfDay(
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
                                                              child: const Text(
                                                                  'Start Time'))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              "Class End: "),
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
                                                                            .hovered)) {
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.04);
                                                                    }
                                                                    if (states.contains(WidgetState
                                                                            .focused) ||
                                                                        states.contains(
                                                                            WidgetState.pressed)) {
                                                                      return Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.12);
                                                                    }
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
                                                                      const TimeOfDay(
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
                                                              child: const Text(
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

                                            var id = getRandomString(9);

                                            var updateData = {
                                              "BatchID": id,
                                              "BatchName": BatchNameController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                              "TotalStudent": "0",
                                              "BatchRunningTopics":
                                                  BatchDescriptionController
                                                      .text
                                                      .trim()
                                                      .toString(),
                                              "PrivateDay":
                                                  DayController.text.trim(),
                                              "HSCBatchYear": HSCBatchYearValue,
                                              "PerStudentFee":
                                                  PerStudentFeeController.text
                                                      .trim()
                                                      .toString(),
                                              "TeacherAcademyName":
                                                  selectedTeachersAcademyValue,
                                              "BatchOldTopics": [],
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
                                                    .doc(id);

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
                          child: const Text(
                            "Create Batch Name",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String Title =
                                      "নিচে Class বন্ধের বার্তা লিখুন";

                                  bool loading = false;

                                  int SuccessfulMSG = 0;
                                  int unSuccessfullMSG = 0;
                                  int TotalMSG = AllStudentInfo.length;

                                  // String LabelText ="আয়ের খাত লিখবেন";

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                Title,
                                                style: const TextStyle(
                                                    fontFamily: "Josefin Sans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: loading
                                            ? Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "Successfully Send: ${SuccessfulMSG.toString()}"),
                                                    Text(
                                                        "Failed: ${unSuccessfullMSG.toString()}"),
                                                    Text(
                                                        "Total SMS: ${TotalMSG.toString()}"),
                                                    CircularProgressIndicator(),
                                                  ],
                                                ),
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      width: 300,
                                                      child: TextField(
                                                        maxLines: 10,
                                                        onChanged: (value) {},
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Message BOX',

                                                          hintText:
                                                              'Message BOX',

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
                                                            borderSide: BorderSide(
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
                                                            ClassOfMsgController,
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

                                              var MsgData = {
                                                "MSGID": ProductUniqueID,
                                                "year":
                                                    "${DateTime.now().year}",
                                                "month":
                                                    "${DateTime.now().month}/${DateTime.now().year}",
                                                "Date":
                                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                "DateTime": DateTime.now()
                                                    .toIso8601String(),
                                                "msg": ClassOfMsgController.text
                                                    .trim()
                                              };

                                              final CentralBoardSMS =
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'CentralBoardSMS')
                                                      .doc(ProductUniqueID);

                                              CentralBoardSMS.set(MsgData)
                                                  .then((value) =>
                                                      setState(() async {
                                                        var AdminMsg =
                                                            ClassOfMsgController
                                                                .text
                                                                .trim();

                                                        for (var i = 0;
                                                            i <
                                                                AllStudentInfo
                                                                    .length;
                                                            i++) {
                                                          try {
                                                            final response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        'https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllStudentInfo[i]["StudentPhoneNumber"].trim()}&message=$AdminMsg'));

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              setState(() {
                                                                SuccessfulMSG++;
                                                              });
                                                              // If the server did return a 200 OK response,
                                                              // then parse the JSON.
                                                              print(jsonDecode(
                                                                  response
                                                                      .body));
                                                            } else {
                                                              setState(() {
                                                                unSuccessfullMSG++;
                                                              });
                                                              // If the server did not return a 200 OK response,
                                                              // then throw an exception.
                                                              throw Exception(
                                                                  'Failed to load album');
                                                            }
                                                          } catch (e) {}
                                                        }

                                                        // Navigator.pop(context);

                                                        // getProductInfo();
                                                        Navigator.pop(context);

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
                                            },
                                            child: const Text("Send"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Send SMS to All Student",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String Title = "নিচে ID দিয়ে Search করুন";
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
                                                style: const TextStyle(
                                                    fontFamily: "Josefin Sans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: 300,
                                                      child: TextField(
                                                        onChanged: (value) {},
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
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
                                                            borderSide: BorderSide(
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

                                              getSearchByID(StudentIDController
                                                  .text
                                                  .trim()
                                                  .toString());
                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Search"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Search By ID",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String Title =
                                      "নিচে Phone No দিয়ে Search করুন";

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
                                                style: const TextStyle(
                                                    fontFamily: "Josefin Sans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: 300,
                                                      child: TextField(
                                                        onChanged: (value) {},
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Enter Student Phone No',

                                                          hintText:
                                                              'Enter Student Phone No',

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
                                                            borderSide: BorderSide(
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
                                                            StudentPhoneNoController,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
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

                                              getSearchByStudentPhoneNo(
                                                  StudentPhoneNoController.text
                                                      .trim()
                                                      .toString());

                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Search"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Search By Phone No",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String Title =
                                      "নিচে Class বন্ধের বার্তা লিখুন";

                                  bool loading = false;

                                  int SuccessfulMSG = 0;
                                  int unSuccessfullMSG = 0;
                                  int TotalMSG = AllStudentInfo.length;

                                  // String LabelText ="আয়ের খাত লিখবেন";

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                Title,
                                                style: const TextStyle(
                                                    fontFamily: "Josefin Sans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: loading
                                            ? Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "Successfully Send: ${SuccessfulMSG.toString()}"),
                                                    Text(
                                                        "Failed: ${unSuccessfullMSG.toString()}"),
                                                    Text(
                                                        "Total SMS: ${TotalMSG.toString()}"),
                                                    CircularProgressIndicator(),
                                                  ],
                                                ),
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      width: 300,
                                                      child: TextField(
                                                        maxLines: 10,
                                                        onChanged: (value) {},
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Message BOX',

                                                          hintText:
                                                              'Message BOX',

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
                                                            borderSide: BorderSide(
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
                                                            SetDueController,
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

                                              for (var i = 0;
                                                  i < AllStudentInfo.length;
                                                  i++) {
                                                var MsgData = {
                                                  "Due": (int.parse(
                                                              AllStudentInfo[i]
                                                                      ["Due"]
                                                                  .toString()) +
                                                          int.parse(AllStudentInfo[
                                                                      i][
                                                                  "PerStudentFee"]
                                                              .toString()))
                                                      .toString(),
                                                };

                                                final PerTeacherStudentInfo =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'PerTeacherStudentInfo')
                                                        .doc(AllStudentInfo[i]
                                                            ["id"]);

                                                PerTeacherStudentInfo.update(
                                                        MsgData)
                                                    .then((value) =>
                                                        setState(() async {
                                                          var AdminMsg =
                                                              "SID:${AllStudentInfo[i]["SIDNo"]} DUE:${(int.parse(AllStudentInfo[i]["Due"].toString()) + int.parse(AllStudentInfo[i]["PerStudentFee"].toString())).toString()}tk Please pay by 10/${DateTime.now().month}/${DateTime.now().year}";

                                                          try {
                                                            final response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        'https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllStudentInfo[i]["StudentPhoneNumber"].trim()}&message=$AdminMsg'));

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              setState(() {
                                                                SuccessfulMSG++;
                                                              });
                                                              // If the server did return a 200 OK response,
                                                              // then parse the JSON.
                                                              print(jsonDecode(
                                                                  response
                                                                      .body));
                                                            } else {
                                                              setState(() {
                                                                unSuccessfullMSG++;
                                                              });
                                                              // If the server did not return a 200 OK response,
                                                              // then throw an exception.
                                                              throw Exception(
                                                                  'Failed to load album');
                                                            }
                                                          } catch (e) {}

                                                          // Navigator.pop(context);

                                                          // getProductInfo();
                                                          Navigator.pop(
                                                              context);

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
                                                              titleFontSize: 12,
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

                                                getAllStudentInfo();
                                              }
                                            },
                                            child: const Text("Set Due"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Set Due for All Student",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String SelectedStudentStatus = "";
                                String Title = "কাজের জন্য নির্বাচন করুন";

                                bool loading = false;

                                // String LabelText ="আয়ের খাত লিখবেন";

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              Title,
                                              style: const TextStyle(
                                                  fontFamily: "Josefin Sans",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: loading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
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
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            List AllWorkStudent = [];

                                            for (var i = 0;
                                                i < AllStudentInfo.length;
                                                i++) {
                                              var perWorkStudent = {
                                                "StudentName": AllStudentInfo[i]
                                                    ["StudentName"],
                                                "StudentPhoneNumber":
                                                    AllStudentInfo[i]
                                                        ["StudentPhoneNumber"],
                                                "FatherPhoneNo":
                                                    AllStudentInfo[i]
                                                        ["FatherPhoneNo"],
                                                "FutureAim": AllStudentInfo[i]
                                                    ["FutureAim"],
                                                "SIDNo": AllStudentInfo[i]
                                                    ["SIDNo"],
                                                "StudentImageUrl":
                                                    AllStudentInfo[i]
                                                        ["StudentImageUrl"],
                                                "Comment": "",
                                                "CallDone": "false",
                                                "FileUrl": "",
                                                "HSCBatchYear":
                                                    AllStudentInfo[i]
                                                        ["HSCBatchYear"],
                                                "SSCBatchYear":
                                                    AllStudentInfo[i]
                                                        ["SSCBatchYear"],
                                                "Department": AllStudentInfo[i]
                                                    ["Department"],
                                              };

                                              AllWorkStudent.add(
                                                  perWorkStudent);
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
                          value: '/hello',
                          child: const Text(
                            "Make Work",
                            style: TextStyle(
                                fontFamily: "Josefin Sans",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ];
                    },
                  ),
                  const Text(" Confidence Dashboard"),
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
                              onChanged: (String? value) async {
                                CollectionReference _collectionBatchInfoRef =
                                    FirebaseFirestore.instance
                                        .collection('AllBatchInfo');

                                Query BatchInfoRefquery =
                                    _collectionBatchInfoRef.where(
                                        "TeacherAcademyName",
                                        isEqualTo:
                                            selectedTeachersAcademyValue);

                                QuerySnapshot BatchInfoRefquerySnapshot =
                                    await BatchInfoRefquery.get();

                                // Get data from docs and convert map to List
                                // AllStudentInfo =
                                //     StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

                                setState(() {
                                  BatchName = [];

                                  List AllBatchInfo = [];

                                  AllBatchInfo = BatchInfoRefquerySnapshot.docs
                                      .map((doc) => doc.data())
                                      .toList();

                                  for (var i = 0;
                                      i < AllBatchInfo.length;
                                      i++) {
                                    BatchName.add(AllBatchInfo[i]["BatchName"]);
                                  }
                                  ;
                                });

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
                                  selectedBatchNameValue = value;
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
                            // getSearchByID(SearchByStudentIDController
                            //     .text
                            //     .trim()
                            //     .toLowerCase());

                            getSearchAllStudentInfo(
                                selectedTeachersAcademyValue!,
                                selectedBatchNameValue!);
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
                        headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        columnSpacing: 12,
                        headingRowColor:
                            const WidgetStatePropertyAll(Colors.pink),
                        horizontalMargin: 12,
                        minWidth: 2600,
                        dividerThickness: 3,
                        isHorizontalScrollBarVisible: true,
                        columns: const [
                          DataColumn2(
                            label: Text('SL'),
                          ),
                          DataColumn2(
                            label: Text('Student ID'),
                          ),
                          DataColumn2(
                            label: Text('Payment Status'),
                          ),
                          DataColumn2(
                            label: Text('Due Amount'),
                          ),
                          DataColumn(
                            label: Text('Student Name'),
                          ),
                          DataColumn(
                            label: Text('Phone No'),
                          ),
                          // DataColumn2(
                          //   label: Text('Institution Name'),
                          //   size: ColumnSize.L,
                          // ),
                          DataColumn2(
                              label: Text('Father Phone No'), fixedWidth: 170),
                          DataColumn(
                            label: Text('Pay'),
                            // numeric: true,
                          ),
                          DataColumn(
                            label: Text('Send SMS'),
                            // numeric: true,
                          ),
                          DataColumn(
                            label: Text('Academy Name'),
                            // numeric: true,
                          ),
                          DataColumn(
                            label: Text('Status'),
                            // numeric: true,
                          ),
                          DataColumn(
                            label: Text('Edit'),
                            // numeric: true,
                          ),

                          DataColumn(
                            label: Text('Details'),
                            // numeric: true,
                          ),

                          DataColumn(
                            label: Text('Attendance'),
                            // numeric: true,
                          ),

                          DataColumn(
                            label: Text('All Fee'),
                            // numeric: true,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            AllStudentInfo.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text('${index + 1}')),

                                  DataCell(Text(AllStudentInfo[index]["SIDNo"]
                                      .toString()
                                      .toUpperCase())),

                                  DataCell((int.parse(AllStudentInfo[index]
                                                  ["Due"]
                                              .toString())) >
                                          0
                                      ? Text(
                                          "DUE".toString().toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "PAID".toString().toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )),

                                  DataCell((int.parse(AllStudentInfo[index]
                                                  ["Due"]
                                              .toString())) >
                                          0
                                      ? Text(
                                          "${AllStudentInfo[index]["Due"].toString().toUpperCase()}৳",
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )
                                      : Text(
                                          "${AllStudentInfo[index]["Due"].toString().toUpperCase()}৳",
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )),

                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentPhoneNumber"]
                                      .toString()
                                      .toUpperCase())),

                                  // DataCell(Text(
                                  //     "${AllStudentInfo[index]["InstitutionName"].toString().toUpperCase()}")),

                                  DataCell(Text(AllStudentInfo[index]
                                          ["FatherPhoneNo"]
                                      .toString()
                                      .toUpperCase())),

                                  DataCell(
                                      AllStudentInfo[index]["Status"] == "Close"
                                          ? Text("")
                                          : ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    String Title =
                                                        "Payment যুক্ত করুন";

                                                    bool loading = false;
                                                    bool DiscountAvailable =
                                                        false;

                                                    // String LabelText ="আয়ের খাত লিখবেন";

                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return AlertDialog(
                                                          title: Column(
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  Title,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          "Josefin Sans",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          content: loading
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                )
                                                              : SingleChildScrollView(
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      SizedBox(
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          onChanged:
                                                                              (value) {},
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            labelText:
                                                                                'SID: ${AllStudentInfo[index]["SIDNo"].toString().toUpperCase()}',

                                                                            hintText:
                                                                                'SID: ${AllStudentInfo[index]["SIDNo"].toString().toUpperCase()}',

                                                                            //  enabledBorder: OutlineInputBorder(
                                                                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                            //     ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                            ),
                                                                            errorBorder:
                                                                                const OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                            ),
                                                                          ),
                                                                          controller:
                                                                              StudentIDController,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          onChanged:
                                                                              (value) {},
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            labelText:
                                                                                'Name: ${AllStudentInfo[index]["StudentName"].toString().toUpperCase()}',

                                                                            hintText:
                                                                                'Name: ${AllStudentInfo[index]["StudentName"].toString().toUpperCase()}',

                                                                            //  enabledBorder: OutlineInputBorder(
                                                                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                            //     ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                            ),
                                                                            errorBorder:
                                                                                const OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                            ),
                                                                          ),
                                                                          controller:
                                                                              StudentNameController,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            TextField(
                                                                          readOnly:
                                                                              true,
                                                                          onChanged:
                                                                              (value) {},
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            labelText:
                                                                                'Due: ${AllStudentInfo[index]["Due"].toString().toUpperCase()}৳',

                                                                            hintText:
                                                                                'Due: ${AllStudentInfo[index]["Due"].toString().toUpperCase()}৳',

                                                                            //  enabledBorder: OutlineInputBorder(
                                                                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                            //     ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                            ),
                                                                            errorBorder:
                                                                                const OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                            ),
                                                                          ),
                                                                          controller:
                                                                              StudentNameController,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            TextField(
                                                                          onChanged:
                                                                              (value) {},
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            labelText:
                                                                                'Payment Amount',

                                                                            hintText:
                                                                                'Payment Amount',

                                                                            //  enabledBorder: OutlineInputBorder(
                                                                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                            //     ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                            ),
                                                                            errorBorder:
                                                                                const OutlineInputBorder(
                                                                              borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                            ),
                                                                          ),
                                                                          controller:
                                                                              PaymentAmountController,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      CheckboxListTile(
                                                                        title: const Text(
                                                                            "Discount Available?",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "Josefin Sans")),
                                                                        value:
                                                                            DiscountAvailable,
                                                                        onChanged:
                                                                            (newValue) {
                                                                          setState(
                                                                              () {
                                                                            DiscountAvailable =
                                                                                newValue!;
                                                                          });
                                                                        },
                                                                        controlAffinity:
                                                                            ListTileControlAffinity.leading, //  <-- leading Checkbox
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      DiscountAvailable
                                                                          ? SizedBox(
                                                                              width: 300,
                                                                              child: TextField(
                                                                                onChanged: (value) {},
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(),
                                                                                  labelText: 'Discount Amount',

                                                                                  hintText: 'Discount Amount',

                                                                                  //  enabledBorder: OutlineInputBorder(
                                                                                  //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                                  //     ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                                  ),
                                                                                  errorBorder: const OutlineInputBorder(
                                                                                    borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                                  ),
                                                                                ),
                                                                                controller: DiscountAmountController,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              ""),
                                                                    ],
                                                                  ),
                                                                ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: const Text(
                                                                  "Cancel"),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                });

                                                                var PaymentData =
                                                                    {
                                                                  "PaymentAmount":
                                                                      PaymentAmountController
                                                                          .text
                                                                          .trim(),
                                                                  "SIDNo": AllStudentInfo[
                                                                          index]
                                                                      ["SIDNo"],
                                                                  "DiscountAmount": DiscountAvailable
                                                                      ? DiscountAmountController
                                                                          .text
                                                                          .trim()
                                                                      : "",
                                                                  "TeacherAcademyName":
                                                                      AllStudentInfo[
                                                                              index]
                                                                          [
                                                                          "TeacherAcademyName"],
                                                                  "BatchName":
                                                                      AllStudentInfo[
                                                                              index]
                                                                          [
                                                                          "BatchName"],
                                                                  "year":
                                                                      "${DateTime.now().year}",
                                                                  "month":
                                                                      "${DateTime.now().month}/${DateTime.now().year}",
                                                                  "Date":
                                                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                                  "DateTime": DateTime
                                                                          .now()
                                                                      .toIso8601String(),
                                                                };

                                                                final PerTeacherStudentPayment = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'PerTeacherStudentPayment')
                                                                    .doc(
                                                                        ProductUniqueID);

                                                                PerTeacherStudentPayment
                                                                        .set(
                                                                            PaymentData)
                                                                    .then((value) =>
                                                                        setState(
                                                                            () async {
                                                                          var PaymentDataUpdate =
                                                                              {
                                                                            "Due": DiscountAvailable
                                                                                ? ((int.parse(AllStudentInfo[index]["Due"])) - (int.parse((PaymentAmountController.text.trim().toString()))) + (int.parse(DiscountAmountController.text.trim().toString()))).toString()
                                                                                : ((int.parse(AllStudentInfo[index]["Due"])) - (int.parse((PaymentAmountController.text.trim().toString())))).toString(),
                                                                            "Totalpay":
                                                                                (int.parse(AllStudentInfo[index]["Totalpay"]) + int.parse(PaymentAmountController.text.trim().toString())).toString(),
                                                                          };

                                                                          print(
                                                                              PaymentDataUpdate);

                                                                          print(
                                                                              PaymentData);

                                                                          final PerTeacherStudentPayment = FirebaseFirestore
                                                                              .instance
                                                                              .collection('PerTeacherStudentInfo')
                                                                              .doc(AllStudentInfo[index]["id"]);

                                                                          PerTeacherStudentPayment.update(PaymentDataUpdate)
                                                                              .then((value) => setState(() async {
                                                                                    Navigator.pop(context);

                                                                                    // try {
                                                                                    //   var AdminMsg = "Hello ${AllStudentInfo[index]["StudentName"]} you pay ${PaymentAmountController.text.trim()}৳/${AllStudentInfo[index]["Due"]} ${AllStudentInfo[index]["TeacherAcademyName"]}";

                                                                                    //   final response =
                                                                                    //       await http
                                                                                    //           .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllStudentInfo[index]["FatherPhoneNo"]}&message=$AdminMsg'));

                                                                                    //   if (response
                                                                                    //           .statusCode ==
                                                                                    //       200) {
                                                                                    //     // If the server did return a 200 OK response,
                                                                                    //     // then parse the JSON.
                                                                                    //     print(jsonDecode(
                                                                                    //         response
                                                                                    //             .body));
                                                                                    //   } else {
                                                                                    //     // If the server did not return a 200 OK response,
                                                                                    //     // then throw an exception.
                                                                                    //     throw Exception(
                                                                                    //         'Failed to load album');
                                                                                    //   }
                                                                                    // } catch (e) {}

                                                                                    // Navigator.pop(context);

                                                                                    getAllStudentInfo();

                                                                                    final snackBar = SnackBar(
                                                                                      elevation: 0,
                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      content: AwesomeSnackbarContent(
                                                                                        titleFontSize: 12,
                                                                                        title: 'successfull',
                                                                                        message: 'Hey Thank You. Good Job',

                                                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                                        contentType: ContentType.success,
                                                                                      ),
                                                                                    );

                                                                                    ScaffoldMessenger.of(context)
                                                                                      ..hideCurrentSnackBar()
                                                                                      ..showSnackBar(snackBar);

                                                                                    setState(() {
                                                                                      loading = false;
                                                                                    });
                                                                                  }))
                                                                              .onError((error, stackTrace) => setState(() {
                                                                                    final snackBar = SnackBar(
                                                                                      /// need to set following properties for best effect of awesome_snackbar_content
                                                                                      elevation: 0,

                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      content: AwesomeSnackbarContent(
                                                                                        titleFontSize: 12,
                                                                                        title: 'Something Wrong!!!!',
                                                                                        message: 'Try again later...',

                                                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                                        contentType: ContentType.failure,
                                                                                      ),
                                                                                    );

                                                                                    ScaffoldMessenger.of(context)
                                                                                      ..hideCurrentSnackBar()
                                                                                      ..showSnackBar(snackBar);

                                                                                    setState(() {
                                                                                      loading = false;
                                                                                    });
                                                                                  }));

                                                                          // Navigator.pop(
                                                                          //     context);

                                                                          try {
                                                                            var AdminMsg =
                                                                                "Hello ${AllStudentInfo[index]["StudentName"]} you pay ${PaymentAmountController.text.trim()}৳/${AllStudentInfo[index]["Due"]} ${AllStudentInfo[index]["TeacherAcademyName"]}";

                                                                            final response =
                                                                                await http.get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllStudentInfo[index]["FatherPhoneNo"]}&message=$AdminMsg'));

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              // If the server did return a 200 OK response,
                                                                              // then parse the JSON.
                                                                              print(jsonDecode(response.body));
                                                                            } else {
                                                                              // If the server did not return a 200 OK response,
                                                                              // then throw an exception.
                                                                              throw Exception('Failed to load album');
                                                                            }
                                                                          } catch (e) {}

                                                                          // Navigator.pop(context);

                                                                          // getProductInfo();

                                                                          final snackBar =
                                                                              SnackBar(
                                                                            elevation:
                                                                                0,
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            content:
                                                                                AwesomeSnackbarContent(
                                                                              titleFontSize: 12,
                                                                              title: 'successfull',
                                                                              message: 'Hey Thank You. Good Job',

                                                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                              contentType: ContentType.success,
                                                                            ),
                                                                          );

                                                                          ScaffoldMessenger.of(
                                                                              context)
                                                                            ..hideCurrentSnackBar()
                                                                            ..showSnackBar(snackBar);

                                                                          setState(
                                                                              () {
                                                                            loading =
                                                                                false;
                                                                          });
                                                                        }))
                                                                    .onError((error,
                                                                            stackTrace) =>
                                                                        setState(
                                                                            () {
                                                                          final snackBar =
                                                                              SnackBar(
                                                                            /// need to set following properties for best effect of awesome_snackbar_content
                                                                            elevation:
                                                                                0,

                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            content:
                                                                                AwesomeSnackbarContent(
                                                                              titleFontSize: 12,
                                                                              title: 'Something Wrong!!!!',
                                                                              message: 'Try again later...',

                                                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                              contentType: ContentType.failure,
                                                                            ),
                                                                          );

                                                                          ScaffoldMessenger.of(
                                                                              context)
                                                                            ..hideCurrentSnackBar()
                                                                            ..showSnackBar(snackBar);

                                                                          setState(
                                                                              () {
                                                                            loading =
                                                                                false;
                                                                          });
                                                                        }));
                                                              },
                                                              child: const Text(
                                                                  "Pay Now"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text("Pay"))),

                                  DataCell(ElevatedButton(
                                      onPressed: () {
                                        //start

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String Title =
                                                "নিচে Class বন্ধের বার্তা লিখুন";

                                            bool loading = false;

                                            // String LabelText ="আয়ের খাত লিখবেন";

                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  title: Column(
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          Title,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "Josefin Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  content: loading
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 10),
                                                              Container(
                                                                width: 300,
                                                                child:
                                                                    TextField(
                                                                  maxLines: 10,
                                                                  onChanged:
                                                                      (value) {},
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Class Off Msg',

                                                                    hintText:
                                                                        'Class Off Msg',

                                                                    //  enabledBorder: OutlineInputBorder(
                                                                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                    //     ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Theme.of(context).primaryColor),
                                                                    ),
                                                                    errorBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              66,
                                                                              125,
                                                                              145)),
                                                                    ),
                                                                  ),
                                                                  controller:
                                                                      ClassOfMsgController,
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
                                                          Navigator.pop(
                                                              context),
                                                      child: Text("Cancel"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          loading = true;
                                                        });

                                                        var MsgData = {
                                                          "year":
                                                              "${DateTime.now().year}",
                                                          "month":
                                                              "${DateTime.now().month}/${DateTime.now().year}",
                                                          "Date":
                                                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                          "DateTime": DateTime
                                                                  .now()
                                                              .toIso8601String(),
                                                          "msg":
                                                              ClassOfMsgController
                                                                  .text
                                                                  .trim()
                                                        };

                                                        final ClassOffSMS =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'ClassOffSMS')
                                                                .doc(
                                                                    ProductUniqueID);

                                                        ClassOffSMS.set(MsgData)
                                                            .then((value) =>
                                                                setState(
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);

                                                                  try {
                                                                    var AdminMsg =
                                                                        ClassOfMsgController
                                                                            .text
                                                                            .trim();

                                                                    final response =
                                                                        await http
                                                                            .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllStudentInfo[index]["PhoneNo"].trim()}&message=$AdminMsg'));

                                                                    if (response
                                                                            .statusCode ==
                                                                        200) {
                                                                      // If the server did return a 200 OK response,
                                                                      // then parse the JSON.
                                                                      print(jsonDecode(
                                                                          response
                                                                              .body));
                                                                    } else {
                                                                      // If the server did not return a 200 OK response,
                                                                      // then throw an exception.
                                                                      throw Exception(
                                                                          'Failed to load album');
                                                                    }
                                                                  } catch (e) {}

                                                                  // Navigator.pop(context);

                                                                  // getProductInfo();

                                                                  final snackBar =
                                                                      SnackBar(
                                                                    elevation:
                                                                        0,
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    content:
                                                                        AwesomeSnackbarContent(
                                                                      titleFontSize:
                                                                          12,
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

                                                                  ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                    ..hideCurrentSnackBar()
                                                                    ..showSnackBar(
                                                                        snackBar);

                                                                  setState(() {
                                                                    loading =
                                                                        false;
                                                                  });
                                                                }))
                                                            .onError((error,
                                                                    stackTrace) =>
                                                                setState(() {
                                                                  final snackBar =
                                                                      SnackBar(
                                                                    /// need to set following properties for best effect of awesome_snackbar_content
                                                                    elevation:
                                                                        0,

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

                                                                  ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                    ..hideCurrentSnackBar()
                                                                    ..showSnackBar(
                                                                        snackBar);

                                                                  setState(() {
                                                                    loading =
                                                                        false;
                                                                  });
                                                                }));
                                                      },
                                                      child: const Text("Send"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );

                                        // End
                                      },
                                      child: Text("Send"))),

                                  // DataCell(ElevatedButton(onPressed: (){

                                  // }, child: Text("Send Exam Marks"))),

                                  DataCell(Text(
                                      "${AllStudentInfo[index]["TeacherAcademyName"]}")),

                                  DataCell(AllStudentInfo[index]["Status"] ==
                                          "Open"
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            var MsgData = {"Status": "Close"};

                                            final ClassOffSMS =
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'PerTeacherStudentInfo')
                                                    .doc(AllStudentInfo[index]
                                                        ["id"]);

                                            ClassOffSMS.update(MsgData)
                                                .then((value) =>
                                                    setState(() async {
                                                      // Navigator.pop(
                                                      //     context);

                                                      getAllStudentInfo();

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

                                                      // setState(() {
                                                      //   loading =
                                                      //       false;
                                                      // });
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
                                                          titleFontSize: 12,
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

                                                      // setState(() {
                                                      //   loading =
                                                      //       false;
                                                      // });
                                                    }));
                                          },
                                          child: const Text(
                                            "Close",
                                            style: TextStyle(color: Colors.red),
                                          ))
                                      : ElevatedButton(
                                          onPressed: () async {
                                            var MsgData = {"Status": "Open"};

                                            final ClassOffSMS =
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'PerTeacherStudentInfo')
                                                    .doc(AllStudentInfo[index]
                                                        ["id"]);

                                            ClassOffSMS.update(MsgData)
                                                .then((value) =>
                                                    setState(() async {
                                                      // Navigator.pop(
                                                      //     context);

                                                      getAllStudentInfo();

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

                                                      // setState(() {
                                                      //   loading =
                                                      //       false;
                                                      // });
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
                                                          titleFontSize: 12,
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

                                                      // setState(() {
                                                      //   loading =
                                                      //       false;
                                                      // });
                                                    }));
                                          },
                                          child: Text(
                                            "Open",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))),

                                  DataCell(ElevatedButton(
                                      onPressed: () {}, child: Text("Edit"))),

                                  DataCell(ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentProfile(
                                                        SIDNo: AllStudentInfo[
                                                            index]["SIDNo"])));
                                      },
                                      child: Text("Detail"))),

                                  DataCell(ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowStudentAttendance(
                                                        SIDNo: AllStudentInfo[
                                                            index]["SIDNo"],
                                                        TeacherAcademyName:
                                                            AllStudentInfo[
                                                                    index][
                                                                "TeacherAcademyName"])));
                                      },
                                      child: Text("Attendance"))),

                                  DataCell(ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentProfile(
                                                        SIDNo: AllStudentInfo[
                                                            index]["SIDNo"])));

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                final List<String>
                                                    TeachersAcademy = [
                                                  'Rezuan Math Care',
                                                  'Sazzad ICT',
                                                  'MediCrack',
                                                  'Protick Physics',
                                                ];
                                                String?
                                                    selectedTeachersAcademyValue;
                                                return AlertDialog(
                                                  title: Text(
                                                      'Payment Info ${AllStudentInfo[index]["SIDNo"].toString().toUpperCase()}'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Card(
                                                          elevation: 20,
                                                          child: Container(
                                                            width: 200,
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton2<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Select Academy Name',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor,
                                                                  ),
                                                                ),
                                                                items: TeachersAcademy.map((String
                                                                        item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
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
                                                                    (String?
                                                                        value) {
                                                                  setState(() {
                                                                    selectedTeachersAcademyValue =
                                                                        value;

                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => StudentAllPayment(
                                                                              TeacherAcademyName: value,
                                                                              SIDNo: AllStudentInfo[index]["SIDNo"])),
                                                                    );
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('CANCEL'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('ACCEPT'),
                                                    ),
                                                  ],
                                                );
                                              });
                                            });
                                      },
                                      child: Text("All Fee")))
                                ]))),
                  ),
                ),
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
