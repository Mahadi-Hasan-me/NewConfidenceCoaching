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

  bool DataLoad = false;

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

  Future<void> getAllStudentInfo() async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery = _collectionStudentInfoRef
        .where("TeacherAcademyName", isEqualTo: "Rezuan Math Care");

    QuerySnapshot StudentInfoquerySnapshot = await StudentInfoquery.get();
     AllStudentInfo =
            StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllStudentInfo.isEmpty) {
      DataLoad = false;
    } else {
      setState(() {
        AllStudentInfo = [];
        AllStudentInfo =
            StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

        MarksController.clear();
        createControllers();
      });
      DataLoad = true;
    }

    // print(AllData);
  }

  Future<void> getSearchAllStudentInfo(
      String AcademyName, String HSCBatchYear) async {
    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query StudentInfoquery = _collectionStudentInfoRef
        .where("TeacherAcademyName", isEqualTo: AcademyName)
        .where("BatchName", isEqualTo: HSCBatchYear);

    QuerySnapshot StudentInfoquerySnapshot = await StudentInfoquery.get();

    AllStudentInfo =
        StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllStudentInfo.isEmpty) {
      setState(() {
        DataLoad = false;
      });
    } else {
      setState(() {
        AllStudentInfo = [];
        AllStudentInfo =
            StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
        MarksController.clear();
        createControllers();

        DataLoad = true;
      });
    }

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
                  Text(
                      "Add Student Exam Marks ${selectedTeachersAcademyValue} ${selectedBatchNameValue}"),
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
                                  selectedTeachersAcademyValue = value;
                                  BatchName.clear();

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

                                // setState(() {
                                //   selectedTeachersAcademyValue = value;
                                // });
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
                            // getSearchProductInfo(SearchByStudentIDController
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
            body:!DataLoad?SingleChildScrollView(child: Center(child: Text("No Data Available"),),):GridView.count(
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
                            label: Text('Academy Name'),
                          ),
                          DataColumn(
                            label: Text('Batch Name'),
                          ),
                          DataColumn(
                            label: Text('Batch Day'),
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
                                  DataCell(Text(AllStudentInfo[index]["SIDNo"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentPhoneNumber"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["TeacherAcademyName"].toString().toUpperCase()}")),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["BatchName"].toString().toUpperCase()}")),
                                  DataCell(Text(
                                      "${AllStudentInfo[index]["PrivateDay"].toString().toUpperCase()}")),
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
                                                "SIDNo": AllStudentInfo[i]
                                                    ["SIDNo"],
                                                "TeacherAcademyName":
                                                    AllStudentInfo[i]
                                                        ["TeacherAcademyName"],
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
                                                            "SID:${StudentMarksWithInfo[i]["SIDNo"]},TN:${StudentMarksWithInfo[i]["TopicName"].toString()}, M:${StudentMarksWithInfo[i]["TotalMarks"].toString()} HM:${StudentMarksWithInfo[i]["HighestMarks"].toString()}, P:${StudentMarksWithInfo[i]["Position"].toString()}, ${StudentMarksWithInfo[i]["TeacherAcademyName"].toString()}";

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
