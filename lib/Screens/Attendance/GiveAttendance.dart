import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/PDF/MoneyReceipt.dart';
import 'package:confidence/Screens/important.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

class GiveAttendance extends StatefulWidget {
  final TeacherAcademyName;
  final BatchName;

  const GiveAttendance(
      {super.key, required this.TeacherAcademyName, required this.BatchName});

  @override
  State<GiveAttendance> createState() => _GiveAttendanceState();
}

class _GiveAttendanceState extends State<GiveAttendance> {
  var uuid = Uuid();
  // এখানে Date দিয়ে Data fetch করতে হবে।

  var DataLoad = "";
  // Firebase All Customer Data Load

  bool loading = false;

  List AllData = [];

  List positionedAllData = [];

  List positionData = [];

  int moneyAdd = 0;

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

  var PaymentDate =
      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

  Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    setState(() {
      loading = true;
    });

    Query query = _collectionRef
        .where("BatchName", isEqualTo: widget.BatchName)
        .where("TeacherAcademyName", isEqualTo: widget.TeacherAcademyName);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    moneyAdd = 0;

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        DataLoad = "";
      });

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        // loading = false;
      });

      // positionData.sort();

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        // AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

  List todayAttendanceData = [];

  Future<void> getTodayAttendanceData(
      String SIDNo, BuildContext context) async {
    // Get docs from collection reference
    CollectionReference _CustomerOrderHistoryCollectionRef =
        FirebaseFirestore.instance.collection('StudentAttendance');

    // all Due Query Count
    Query _CustomerOrderHistoryCollectionRefDueQueryCount =
        _CustomerOrderHistoryCollectionRef.where("SIDNo", isEqualTo: SIDNo).where(
            "Date",
            isEqualTo:
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");

    QuerySnapshot queryDueSnapshot =
        await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();

    if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        todayAttendanceData =
            queryDueSnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;

        //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeAttendance(StudentEmail: StudentEmail, AttendanceType: todayAttendanceData[0]["type"] , AttendanceID: todayAttendanceData[0]["AttendanceID"])));
      });
    }

    print(AllData);
  }

// Get Search Information

  Future<void> getSearchData(BatchName, TeacherAcademyName) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('PerTeacherStudentInfo');

    Query query = _collectionRef
        .where("BatchName", isEqualTo: BatchName)
        .where("TeacherAcademyName", isEqualTo: TeacherAcademyName);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = [];
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        DataLoad = "";
      });

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        AllData = [];
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        // loading = false;
      });

      // positionData.sort();

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        // AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

  @override
  void initState() {
    // TODO: implement initState
    // getData(widget.ExamDate);
    super.initState();
  }

  //  Future refresh() async{

  //   setState(() {

  //        getData(PaymentDate);

  //   });

  // }

  @override
  Widget build(BuildContext context) {
    var AttendanceID = uuid.v4();

    selectedBatchNameValue = widget.BatchName;
    selectedTeachersAcademyValue = widget.TeacherAcademyName;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //                 context,MaterialPageRoute(builder: (context) => PerDayBikeSalePDFPreview(BikesData: todaySalesData)),
          //               );
        },
        child: Text("Print"),
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: Theme.of(context).primaryColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date;${PaymentDate},Batch: ${selectedBatchNameValue}, Academy: ${selectedTeachersAcademyValue.toString().toUpperCase()} Give Attendance",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
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

                          Query BatchInfoRefquery = _collectionBatchInfoRef
                              .where("TeacherAcademyName",
                                  isEqualTo: selectedTeachersAcademyValue);

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

                            for (var i = 0; i < AllBatchInfo.length; i++) {
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
                            getSearchData(selectedBatchNameValue,
                                selectedTeachersAcademyValue);
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
          ],
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DataLoad == "0"
              ? const Center(child: Text("No Data Available"))
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AllData[index]["LastAttendance"] ==
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                ? Colors.green.shade100
                                : ColorName().AppBoxBackgroundColor,
                            border: Border.all(
                                width: 2,
                                color: AllData[index]["LastAttendance"] ==
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                    ? Colors.green.shade100
                                    : ColorName().AppBoxBackgroundColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "SID No:- ${AllData[index]["SIDNo"]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Column(
                                children: [
                                  AllData[index]["LastAttendance"] ==
                                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                      ? TextButton(
                                          onPressed: () async {
                                            getTodayAttendanceData(
                                                AllData[index]["SIDNo"],
                                                context);
                                          },
                                          child: Text(
                                            "Change",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    ColorName().appColor),
                                          ),
                                        )
                                      : Text(""),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Name:${AllData[index]["StudentName"].toString().toUpperCase()}"),
                                  Text(
                                      "Phone Number:${AllData[index]["StudentPhoneNumber"]}"),
                                  Text(
                                      "Father Phone No: ${AllData[index]["FatherPhoneNo"]}"),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AllData[index]["LastAttendance"] ==
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                    ? Text("")
                                    : TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });

                                          var updateData = {
                                            "LastAttendance":
                                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                          };

                                          final StudentInfo = FirebaseFirestore
                                              .instance
                                              .collection(
                                                  'PerTeacherStudentInfo')
                                              .doc(AllData[index]["id"]);

                                          StudentInfo.update(updateData)
                                              .then((value) =>
                                                  setState(() async {
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "StudentAttendance");

                                                    final jsonData = {
                                                      "AttendanceID":
                                                          AttendanceID,
                                                      "StudentName":
                                                          AllData[index]
                                                              ["StudentName"],
                                                      "SIDNo": AllData[index]
                                                          ["SIDNo"],
                                                      "StudentPhoneNumber":
                                                          AllData[index][
                                                              "StudentPhoneNumber"],
                                                      "Date":
                                                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                      "month":
                                                          "${DateTime.now().month}/${DateTime.now().year}",
                                                      "year":
                                                          "${DateTime.now().year}",
                                                      "DateTime":
                                                          "${DateTime.now().toIso8601String()}",
                                                      "type": "absence"
                                                    };

                                                    await docUser
                                                        .doc(AttendanceID)
                                                        .set(jsonData)
                                                        .then((value) =>
                                                            setState(() async {
                                                              getSearchData(
                                                                  widget
                                                                      .BatchName,
                                                                  widget
                                                                      .TeacherAcademyName);

                                                              setState(() {
                                                                loading = false;
                                                              });
                                                            }))
                                                        .onError((error,
                                                                stackTrace) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content:
                                                                  const Text(
                                                                      'Success'),
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'Undo',
                                                                onPressed: () {
                                                                  // Some code to undo the change.
                                                                },
                                                              ),
                                                            )));

                                                    final snackBar = SnackBar(
                                                      elevation: 0,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content:
                                                          AwesomeSnackbarContent(
                                                        title: 'Successfull',
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
                                                      behavior: SnackBarBehavior
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
                                                            ContentType.failure,
                                                      ),
                                                    );

                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(snackBar);

                                                    setState(() {
                                                      loading = false;
                                                    });
                                                  }));
                                        },
                                        child: Text(
                                          "Absence",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.red.shade400),
                                        ),
                                      ),
                                SizedBox(
                                  height: 2,
                                ),
                                AllData[index]["LastAttendance"] ==
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });

                                          var updateData = {
                                            "LastAttendance":
                                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                          };

                                          final StudentInfo = FirebaseFirestore
                                              .instance
                                              .collection(
                                                  'PerTeacherStudentInfo')
                                              .doc(AllData[index]["id"]);

                                          StudentInfo.update(updateData)
                                              .then((value) =>
                                                  setState(() async {
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "StudentAttendance");

                                                    final jsonData = {
                                                      "AttendanceID":
                                                          AttendanceID,
                                                      "StudentName":
                                                          AllData[index]
                                                              ["StudentName"],
                                                      "SIDNo": AllData[index]
                                                          ["SIDNo"],
                                                      "StudentPhoneNumber":
                                                          AllData[index][
                                                              "StudentPhoneNumber"],
                                                      "Date":
                                                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                      "month":
                                                          "${DateTime.now().month}/${DateTime.now().year}",
                                                      "year":
                                                          "${DateTime.now().year}",
                                                      "DateTime":
                                                          "${DateTime.now().toIso8601String()}",
                                                      "type": "presence"
                                                    };

                                                    await docUser
                                                        .doc(AttendanceID)
                                                        .set(jsonData)
                                                        .then((value) =>
                                                            setState(() async {
                                                              getSearchData(
                                                                  widget
                                                                      .BatchName,
                                                                  widget
                                                                      .TeacherAcademyName);

                                                              setState(() {
                                                                loading = false;
                                                              });
                                                            }))
                                                        .onError((error,
                                                                stackTrace) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content:
                                                                  const Text(
                                                                      'Success'),
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'Undo',
                                                                onPressed: () {
                                                                  // Some code to undo the change.
                                                                },
                                                              ),
                                                            )));

                                                    final snackBar = SnackBar(
                                                      elevation: 0,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content:
                                                          AwesomeSnackbarContent(
                                                        title: 'Successfull',
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
                                                      behavior: SnackBarBehavior
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
                                                            ContentType.failure,
                                                      ),
                                                    );

                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(snackBar);

                                                    setState(() {
                                                      loading = false;
                                                    });
                                                  }));
                                        },
                                        child: Text(
                                          "Presence",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.green.shade400),
                                        ),
                                      ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 9,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: AllData.length,
                ),
    );
  }
}
