import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/AllBatchInfo.dart';
import 'package:confidence/Screens/Attendance/ShowStudentAttendance.dart';
import 'package:confidence/Screens/Dashboard/StudentAllPayment.dart';
import 'package:confidence/Screens/ExamMarks/ExamMarks.dart';
import 'package:confidence/Screens/ExamMarks/ShowEveryAcademyResult.dart';
import 'package:confidence/Screens/ExamMarks/ShowPerStudentExamResult.dart';
import 'package:confidence/Screens/PDF/MoneyReceipt.dart';
import 'package:confidence/Screens/Students/StudentProfile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  TextEditingController SchoolOrCollegeNameController = TextEditingController();
  TextEditingController DepartmentController = TextEditingController();
  TextEditingController TotalStudentController = TextEditingController();
  TextEditingController YearController = TextEditingController();
  TextEditingController RecentClassController = TextEditingController();

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
  String? selectedForNextPageTeachersAcademyValue;

  List<String> BatchName = [
    'HSC261',
    'HSC262',
    'HSC263',
    'HSC263',
  ];
  String? selectedBatchNameValue;
  String? selectedForNextPageBatchNameValue;

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
    var UniqueID = uuid.v4();

    ClassOfMsgController.text =
        "আগামীকাল ..... কারণে আমাদের ..... প্রতিষ্ঠান ক্লাস বন্ধ থাকবে।আমরা বিষয়টির জন্য আন্তরিকভাবে দুঃখিত।";

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[

              Center(child: Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

              const Divider(
                height: 1,
                thickness: 1,
              ),
              
              ListTile(
                leading: Icon(Icons.fingerprint),
                title: Text(
                  'Give Attendance',
                  
                ),
                onTap: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('নিচে ব্যাচের নাম এবং একাডেমিক নাম দেন।'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('This is a demo alert dialog.'),
                              Text(
                                  'Would you like to approve of this message?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Approve'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Exam Result'),
                selected: _selectedDestination == 0,
                onTap: () {
                  var VisiblePaymentDate =
                      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

                  void _onSelectionChanged(
                      DateRangePickerSelectionChangedArgs args) {
                    // TODO: implement your code here

                    if (args.value is PickerDateRange) {
                      try {
                        final DateTime rangeStartDate = args.value.startDate;
                        var adminSetDay = rangeStartDate.day;
                        var adminSetMonth = rangeStartDate.month;
                        var adminSetYear = rangeStartDate.year;

                        var paymentDate =
                            "${adminSetDay}/${adminSetMonth}/${adminSetYear}";

                        VisiblePaymentDate = paymentDate;

                        print(
                            "${adminSetDay}/${adminSetMonth}/${adminSetYear}");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowEveryAcademyResult(
                                  TeacherAcademyName:
                                      selectedForNextPageTeachersAcademyValue,
                                  BatchName: selectedForNextPageBatchNameValue,
                                  ExamDate: paymentDate,
                                )));

                        final DateTime rangeEndDate = args.value.endDate;
                      } catch (e) {}
                    } else if (args.value is DateTime) {
                      final DateTime selectedDate = args.value;
                      print(selectedDate);
                    } else if (args.value is List<DateTime>) {
                      final List<DateTime> selectedDates = args.value;
                      print(selectedDates);
                    } else {
                      final List<PickerDateRange> selectedRanges = args.value;
                      print(selectedRanges);
                    }
                  }

                  var PaymentDate =
                      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final List<String> TeachersAcademyName = [
                          'Rezuan Math Care',
                          'Sazzad ICT',
                          'MediCrack',
                          'Protick Physics',
                        ];
                        String? selectedTeachersAcademyNameValue;

                        List<String> TeacherBatchName = [
                          'HSC261',
                          'HSC262',
                          'HSC263',
                          'HSC263',
                        ];
                        String? selectedTeacherBatchNameValue;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              color: Theme.of(context).primaryColor,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "নিচে থেকে Date Select করুন।",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        items: TeachersAcademyName.map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                )).toList(),
                                        value: selectedTeachersAcademyNameValue,
                                        onChanged: (String? value) async {
                                          CollectionReference
                                              _collectionBatchInfoRef =
                                              FirebaseFirestore.instance
                                                  .collection('AllBatchInfo');

                                          Query BatchInfoRefquery =
                                              _collectionBatchInfoRef.where(
                                                  "TeacherAcademyName",
                                                  isEqualTo:
                                                      selectedTeachersAcademyValue);

                                          QuerySnapshot
                                              BatchInfoRefquerySnapshot =
                                              await BatchInfoRefquery.get();

                                          // Get data from docs and convert map to List
                                          // AllStudentInfo =
                                          //     StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

                                          setState(() {
                                            selectedTeachersAcademyNameValue =
                                                value;
                                            selectedForNextPageTeachersAcademyValue =
                                                value;
                                            TeacherBatchName.clear();

                                            List AllBatchInfo = [];

                                            AllBatchInfo =
                                                BatchInfoRefquerySnapshot.docs
                                                    .map((doc) => doc.data())
                                                    .toList();

                                            for (var i = 0;
                                                i < AllBatchInfo.length;
                                                i++) {
                                              TeacherBatchName.add(
                                                  AllBatchInfo[i]["BatchName"]);
                                            }
                                            ;
                                          });

                                          // setState(() {
                                          //   selectedTeachersAcademyValue = value;
                                          // });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
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
                                        items: TeacherBatchName.map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                )).toList(),
                                        value: selectedTeacherBatchNameValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedTeacherBatchNameValue =
                                                value;
                                            selectedForNextPageBatchNameValue =
                                                value;
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
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

                                // ElevatedButton(
                                //     onPressed: () async {
                                //       // getSearchProductInfo(SearchByStudentIDController
                                //       //     .text
                                //       //     .trim()
                                //       //     .toLowerCase());

                                //       // getSearchAllStudentInfo(
                                //       //     selectedTeachersAcademyValue!,
                                //       //     selectedBatchNameValue!);
                                //     },
                                //     child: Text("Search")),
                              ],
                            ),
                            Container(
                              child: SfDateRangePicker(
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                todayHighlightColor:
                                    Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        );
                      });

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
                                                "MSGID": UniqueID,
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
                                                      .doc(UniqueID);

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

                                                        const snackBar =
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
                                                        const snackBar =
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
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      onChanged: (value) {},
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'School/ College Name',

                                                        hintText:
                                                            'School/ College Name',

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
                                                          SchoolOrCollegeNameController,
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
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Department(Science)',

                                                        hintText:
                                                            'Department(Science)',

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
                                                          DepartmentController,
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
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Total Student',

                                                        hintText:
                                                            'Total Student',

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
                                                          TotalStudentController,
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
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Year',

                                                        hintText: 'Year',

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
                                                          YearController,
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
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Recent Class(Nine/Ten/SSC/HSC)',

                                                        hintText:
                                                            'Recent Class(Nine/Ten/SSC/HSC)',

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
                                                          RecentClassController,
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
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            var StaffCallingHeader = {
                                              "SchoolOrCollegeName":
                                                  SchoolOrCollegeNameController
                                                      .text
                                                      .trim(),
                                              "Department": DepartmentController
                                                  .text
                                                  .trim(),
                                              "TotalStudent":
                                                  TotalStudentController.text
                                                      .trim(),
                                              "Year":
                                                  YearController.text.trim(),
                                              "RecentClass":
                                                  RecentClassController.text
                                                      .trim(),
                                              "LastWork": DateTime.now()
                                                  .toIso8601String(),
                                              "Incomplete":
                                                  TotalStudentController.text
                                                      .trim(),
                                              "FileID": UniqueID.toString(),
                                            };

                                            final docUser = FirebaseFirestore
                                                .instance
                                                .collection("StaffWorkHeader")
                                                .doc(UniqueID);

                                            docUser
                                                .set(StaffCallingHeader)
                                                .then((value) => setState(() {
                                                      setState(() {
                                                        loading = false;
                                                      });

                                                      Navigator.pop(context);

                                                      const snackBar = SnackBar(
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
                                                              'Created Successfull',
                                                          message:
                                                              'Created Successfull',

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

                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //       builder: (context) => CustomerProfile(
                                                      //           CustomerID: widget.CustomerID)),
                                                      // );
                                                    }))
                                                .onError((error, stackTrace) =>
                                                    setState(() {
                                                      setState(() {
                                                        loading = false;
                                                      });

                                                      const snackBar = SnackBar(
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
                                                              'Something Wrong!!!',
                                                          message:
                                                              'Something Wrong!!!',

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
                            label: Text('Exam Result'),
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
                                                                  "StudentName": AllStudentInfo[
                                                                              index]
                                                                          [
                                                                          "StudentName"]
                                                                      .toString()
                                                                      .toUpperCase(),
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
                                                                  "Due": DiscountAvailable
                                                                      ? ((int.parse(AllStudentInfo[index]["Due"])) - (int.parse((PaymentAmountController.text.trim().toString()))) + (int.parse(DiscountAmountController.text.trim().toString())))
                                                                          .toString()
                                                                      : ((int.parse(AllStudentInfo[index]["Due"])) -
                                                                              (int.parse((PaymentAmountController.text.trim().toString()))))
                                                                          .toString(),
                                                                };

                                                                final PerTeacherStudentPayment = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'PerTeacherStudentPayment')
                                                                    .doc(
                                                                        UniqueID);

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
                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoneyReceiptPDF(SalesData: [PaymentData])));

                                                                                    final snackBar = SnackBar(
                                                                                      elevation: 0,
                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      content: AwesomeSnackbarContent(
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
                                                                .doc(UniqueID);

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
                                                      'Exam Info ${AllStudentInfo[index]["SIDNo"].toString().toUpperCase()}'),
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
                                                                          builder: (context) => Showperstudentexamresult(
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
                                      child: Text("Exam Marks"))),

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
