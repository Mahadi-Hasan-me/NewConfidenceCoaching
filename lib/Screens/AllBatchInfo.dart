import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confidence/Screens/Students/AllStudent.dart';
import 'package:confidence/Screens/important.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class AllBatchInfo extends StatefulWidget {
  const AllBatchInfo({
    super.key,
  });

  @override
  State<AllBatchInfo> createState() => _AllBatchInfoState();
}

class _AllBatchInfoState extends State<AllBatchInfo> {
  TextEditingController StudentIDController = TextEditingController();
  TextEditingController RunningTopicsController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  bool loading = false;

  List AllData = [];
  var DataLoad = "";

// bool loading = true;

  Future<void> GetBatchInfo() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('AllBatchInfo');

    setState(() {
      loading = true;
    });

    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        AllData = [];
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

  Future<void> GetSearchBatchInfo(String AcademyName, String HSCYear) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('AllBatchInfo');

    Query BatchInfoquery = _collectionRef
        .where("TeacherAcademyName", isEqualTo: AcademyName)
        .where("HSCBatchYear", isEqualTo: HSCYear);

    setState(() {
      loading = true;
    });

    QuerySnapshot querySnapshot = await BatchInfoquery.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        AllData = [];
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

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

  @override
  void initState() {
    // TODO: implement initState
    // getData(widget.CustomerNID);

    GetBatchInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: Row(
          children: [
            Text(
              "All Batch Info",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
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
                      'Select HSC Batch Year',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: HSCBatchYear.map(
                        (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )).toList(),
                    value: HSCBatchYearValue,
                    onChanged: (String? value) {
                      setState(() {
                        HSCBatchYearValue = value;
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
                  GetSearchBatchInfo(selectedTeachersAcademyValue.toString(),
                      HSCBatchYearValue.toString());
                },
                child: Text("Search"))
          ],
        ),
        backgroundColor: const Color.fromARGB(0, 23, 21, 21),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: const Color(0xFF1A1A3F),
                secondRingColor: Theme.of(context).primaryColor,
                thirdRingColor: Colors.white,
                size: 100,
              ),
            )
          : GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              childAspectRatio: 3 / 2,
              children: [
                  for (int i = 0; i < AllData.length; i++)
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Text(
                            "${AllData[i]["TeacherAcademyName"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                          ListTile(
                            leading: const Text(""),
                            title: Text(
                                'Batch Name: ${AllData[i]["BatchName"]}   Fee: ${AllData[i]["PerStudentFee"]}৳',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Day: ${AllData[i]["PrivateDay"]}  Time: ${AllData[i]["ClassStartHour"]}:${AllData[i]["ClassStartMinute"]}-${AllData[i]["ClassEndHour"]}:${AllData[i]["ClassEndMinute"]}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Text(""),
                            subtitle: Row(
                              children: [
                                Text(
                                    'Total Student: ${AllData[i]["TotalStudent"]} জন',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black))
                              ],
                            ),
                            title: Text(
                                'Batch Running Topics: ${AllData[i]["BatchRunningTopics"]} ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black)),
                          ),
                          for (int a = 0;
                              a < AllData[i]["BatchOldTopics"].length;
                              a++)
                            Text(
                              'Batch Old Topics: ${AllData[i]["BatchOldTopics"][a]}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () async{

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
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Josefin Sans",
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
                                                              onChanged:
                                                                  (value) {},
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Enter Running Topics',

                                                                hintText:
                                                                    'Enter Running Topics',

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
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          66,
                                                                          125,
                                                                          145)),
                                                                ),
                                                              ),
                                                              controller:
                                                                  RunningTopicsController,
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


                                                      List BatchOldTopic = [];

                                    BatchOldTopic =
                                        AllData[i]["BatchOldTopics"];

                                    BatchOldTopic.add(
                                        AllData[i]["BatchRunningTopics"]);

                                    var UpdateBatchInfo = {
                                      "BatchOldTopics": BatchOldTopic,
                                      "BatchRunningTopics":RunningTopicsController.text.trim()
                                    };

                                    final ChangeBatchInfo = FirebaseFirestore
                                        .instance
                                        .collection('AllBatchInfo')
                                        .doc(AllData[i]["id"]);

                                    ChangeBatchInfo.update(UpdateBatchInfo)
                                        .then((value) => setState(() {
                                              // Navigator.pop(context);

                                              AwesomeDialog(
                                                width: 500,
                                                context: context,
                                                animType: AnimType.scale,
                                                dialogType: DialogType.success,
                                                body: const Center(
                                                    child: Text(
                                                  "ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Josefin Sans",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                title:
                                                    'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                desc:
                                                    'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                btnOkOnPress: () {
                                                  Navigator.pop(context);
                                                },
                                              ).show();

                                              final snackBar = SnackBar(
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  titleFontSize: 12,
                                                  title: 'successfull',
                                                  message:
                                                      'Hey Thank You. Good Job',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.success,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);

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
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title: 'Something Wrong!!!!',
                                                  message: 'Try again later...',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.failure,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);

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
                                  child: Text("Edit Topic")),

                              // Add New Student In Batch
                              ElevatedButton(
                                  onPressed: () async {
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
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Josefin Sans",
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
                                                              onChanged:
                                                                  (value) {},
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
                                                                      color: Color.fromARGB(
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

                                                    List AllStudentInfo = [];

                                                    CollectionReference
                                                        _collectionSingleStudentInfoRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'StudentInfo');

                                                    Query
                                                        SingleStudentInfoquery =
                                                        _collectionSingleStudentInfoRef
                                                            .where("SIDNo",
                                                                isEqualTo:
                                                                    StudentIDController
                                                                        .text
                                                                        .trim());

                                                    QuerySnapshot
                                                        SingleStudentInfoquerySnapshot =
                                                        await SingleStudentInfoquery
                                                            .get();

                                                    // Get data from docs and convert map to List
                                                    setState(() {
                                                      AllStudentInfo = [];
                                                      AllStudentInfo =
                                                          SingleStudentInfoquerySnapshot
                                                              .docs
                                                              .map((doc) =>
                                                                  doc.data())
                                                              .toList();
                                                    });

                                                    if (AllStudentInfo
                                                        .isEmpty) {
                                                      // Navigator.pop(context);

                                                      AwesomeDialog(
                                                        width: 500,
                                                        // ignore: use_build_context_synchronously
                                                        context: context,
                                                        animType:
                                                            AnimType.scale,
                                                        dialogType:
                                                            DialogType.error,
                                                        body: const Center(
                                                            child: Text(
                                                          "দুঃখিত ID টি সঠিক নয়",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Josefin Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        title:
                                                            'দুঃখিত ID টি সঠিক নয়',
                                                        desc:
                                                            'দুঃখিত ID টি সঠিক নয়',
                                                        btnOkOnPress: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ).show();
                                                    } else {
                                                      var id =
                                                          getRandomString(9);

                                                      var updateData = {
                                                        "id": id,
                                                        "StudentName":
                                                            AllStudentInfo[0]
                                                                ["StudentName"],
                                                        "StudentPhoneNumber":
                                                            AllStudentInfo[0][
                                                                "StudentPhoneNumber"],
                                                        "FatherPhoneNo":
                                                            AllStudentInfo[0][
                                                                "FatherPhoneNo"],
                                                        "Department":
                                                            AllStudentInfo[0]
                                                                ["Department"],
                                                        "LastAttendanceDate":
                                                            "",
                                                        "HSCBatchYear":
                                                            AllStudentInfo[0][
                                                                "HSCBatchYear"],
                                                        "TeachersAcademyName":
                                                            "${AllData[i]["TeacherAcademyName"]}",
                                                        "BatchName":
                                                            "${AllData[i]["BatchName"]}",
                                                        "SIDNo":
                                                            StudentIDController
                                                                .text
                                                                .trim(),
                                                        "StudentImageUrl":
                                                            AllStudentInfo[0][
                                                                "StudentImageUrl"],
                                                        "PerStudentFee":
                                                            "${AllData[i]["PerStudentFee"]}",
                                                        "Due":
                                                            "${AllData[i]["PerStudentFee"]}",
                                                        "Totalpay": "",
                                                        "PrivateDay":
                                                            "${AllData[i]["PrivateDay"]}",
                                                        "ClassStartHour":
                                                            "${AllData[i]["ClassStartHour"]}",
                                                        "ClassStartMinute":
                                                            "${AllData[i]["ClassStartMinute"]}",
                                                        "ClassEndHour":
                                                            "${AllData[i]["ClassEndHour"]}",
                                                        "ClassEndMinute":
                                                            "${AllData[i]["ClassEndMinute"]}",
                                                        "Status": "open",
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

                                                      final PerTeacherStudentInfo =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'PerTeacherStudentInfo')
                                                              .doc(id);

                                                      PerTeacherStudentInfo.set(
                                                              updateData)
                                                          .then(
                                                              (value) =>
                                                                  setState(() {
                                                                    // Navigator.pop(context);

                                                                    var UpdateBatchInfo =
                                                                        {
                                                                      "TotalStudent":
                                                                          (int.parse((AllData[i]["TotalStudent"].toString())) + 1)
                                                                              .toString(),
                                                                    };

                                                                    final ChangeBatchInfo = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'AllBatchInfo')
                                                                        .doc(AllData[i]
                                                                            [
                                                                            "id"]);

                                                                    ChangeBatchInfo.update(
                                                                            UpdateBatchInfo)
                                                                        .then((value) =>
                                                                            setState(
                                                                                () {
                                                                              // Navigator.pop(context);

                                                                              AwesomeDialog(
                                                                                width: 500,
                                                                                context: context,
                                                                                animType: AnimType.scale,
                                                                                dialogType: DialogType.success,
                                                                                body: const Center(
                                                                                    child: Text(
                                                                                  "ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে",
                                                                                  style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),
                                                                                )),
                                                                                title: 'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                                                desc: 'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                                                btnOkOnPress: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ).show();

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
                                                                        .onError((error,
                                                                                stackTrace) =>
                                                                            setState(() {
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

                                                                    AwesomeDialog(
                                                                      width:
                                                                          500,
                                                                      context:
                                                                          context,
                                                                      animType:
                                                                          AnimType
                                                                              .scale,
                                                                      dialogType:
                                                                          DialogType
                                                                              .success,
                                                                      body: const Center(
                                                                          child: Text(
                                                                        "ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Josefin Sans",
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )),
                                                                      title:
                                                                          'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                                      desc:
                                                                          'ব্যাচের স্টুডেন্ট সফলভাবে যুক্ত হয়েছে',
                                                                      btnOkOnPress:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ).show();

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

                                                                ScaffoldMessenger
                                                                    .of(context)
                                                                  ..hideCurrentSnackBar()
                                                                  ..showSnackBar(
                                                                      snackBar);

                                                                setState(() {
                                                                  loading =
                                                                      false;
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
                                  child: Text("Add Student")),

                              ElevatedButton(
                                  onPressed: () {}, child: Text("Edit")),
                            ],
                          )
                        ],
                      ),
                    ),
                ]),
    );
  }
}
