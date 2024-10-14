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

class StaffWork extends StatefulWidget {
  StaffWork({
    super.key,
  });

  @override
  _StaffWorkState createState() => _StaffWorkState();
}

class _StaffWorkState extends State<StaffWork> {
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
  TextEditingController StaffWorkController = TextEditingController();
  TextEditingController TopicNameController = TextEditingController();
  TextEditingController ExamDateController = TextEditingController();

  final List<TextEditingController> CommentController = [];

  createControllers() {
    for (var i = 0; i < AllStudentInfo.length; i++) {
      CommentController.add(TextEditingController());
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

        CommentController.clear();
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
        CommentController.clear();
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

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var ProductUniqueID = uuid.v4();

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Calling Work"),
                ],
              ),
            ),
            body: !DataLoad
                ? const SingleChildScrollView(
                    child: Center(
                      child: Text("No Data Available"),
                    ),
                  )
                : GridView.count(
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              columnSpacing: 12,
                              headingRowColor:
                                  const WidgetStatePropertyAll(Colors.pink),
                              horizontalMargin: 12,
                              minWidth: 2600,
                              dividerThickness: 3,
                              columns: const [
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
                                  label: Text('Father Phone No'),
                                ),

                                DataColumn(
                                  label: Text('Dream'),
                                ),

                                DataColumn(
                                  label: Text('Add Comment'),
                                ),

                                // DataColumn(
                                //   label: Text('Save'),
                                //   numeric: true,
                                // ),
                              ],
                              rows: List<DataRow>.generate(
                                  AllStudentInfo.length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(AllStudentInfo[index]
                                                ["SIDNo"]
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
                                        DataCell(Text(AllStudentInfo[index]
                                                ["StudentPhoneNumber"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(AllStudentInfo[index]
                                                ["StudentPhoneNumber"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(ElevatedButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title =
                                                      "Comment যুক্ত করুন";

                                                  bool loading = false;

                                                  // String LabelText ="আয়ের খাত লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title: Column(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "${Title}",
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
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      child:
                                                                          TextField(
                                                                        maxLines:
                                                                            10,
                                                                        onChanged:
                                                                            (value) {},
                                                                        keyboardType:
                                                                            TextInputType.multiline,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'Comment',

                                                                          hintText:
                                                                              'Comment',

                                                                          //  enabledBorder: OutlineInputBorder(
                                                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                          //     ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                                                          ),
                                                                          errorBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                                          ),
                                                                        ),
                                                                        controller:
                                                                            CommentController[index],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
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
                                                                loading = true;
                                                              });

                                                              var perStudentInfoWithComment =
                                                                  {
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

                                                              print(
                                                                  perStudentInfoWithComment);

                                                              // var id = getRandomString(7);

                                                              final ResultInfo = FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'StaffWork')
                                                                  .doc(AllStudentInfo[
                                                                          index]
                                                                      [
                                                                      "SIDNo"]);

                                                              ResultInfo.update(
                                                                      perStudentInfoWithComment)
                                                                  .then((value) =>
                                                                      setState(
                                                                          () async {
                                                                        // Navigator.pop(context);

                                                                        AwesomeDialog(
                                                                          width:
                                                                              500,
                                                                          context:
                                                                              context,
                                                                          animType:
                                                                              AnimType.scale,
                                                                          dialogType:
                                                                              DialogType.success,
                                                                          body: const Center(
                                                                              child: Text(
                                                                            "Comment যুক্ত হয়েছে",
                                                                            style:
                                                                                TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),
                                                                          )),
                                                                          title:
                                                                              'Comment  যুক্ত হয়েছে',
                                                                          desc:
                                                                              'Comment যুক্ত হয়েছে',
                                                                          btnOkOnPress:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ).show();

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
                                                                            title:
                                                                                'successfull',
                                                                            message:
                                                                                'Hey Thank You. Good Job',

                                                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                            contentType:
                                                                                ContentType.success,
                                                                          ),
                                                                        );

                                                                        ScaffoldMessenger.of(
                                                                            context)
                                                                          ..hideCurrentSnackBar()
                                                                          ..showSnackBar(
                                                                              snackBar);

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
                                                                            title:
                                                                                'Something Wrong!!!!',
                                                                            message:
                                                                                'Try again later...',

                                                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                            contentType:
                                                                                ContentType.failure,
                                                                          ),
                                                                        );

                                                                        ScaffoldMessenger.of(
                                                                            context)
                                                                          ..hideCurrentSnackBar()
                                                                          ..showSnackBar(
                                                                              snackBar);

                                                                        setState(
                                                                            () {
                                                                          loading =
                                                                              false;
                                                                        });
                                                                      }));
                                                            },
                                                            child: const Text(
                                                                "Save"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Add Comment"))),
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
