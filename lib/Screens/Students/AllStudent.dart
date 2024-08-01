import 'dart:math';
import 'package:confidence/Screens/important.dart';
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
import 'package:data_table_2/data_table_2.dart';

class AllStudentInfo extends StatefulWidget {
  const AllStudentInfo({
    super.key,
  });

  @override
  State<AllStudentInfo> createState() => _AllStudentInfoState();
}

class _AllStudentInfoState extends State<AllStudentInfo> {
  // TextEditingController StudentOTPController = TextEditingController();

  bool loading = false;

// bool resend = false;

  List AllStudentInfo = [];
  var DataLoad = "";

// bool loading = true;

  var rng = new Random();
  var code = Random().nextInt(900000) + 100000;

  // Get Student Information fuction

  Future<void> getStudentInfo() async {
    setState(() {
      loading = true;
    });

    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('StudentInfo');

    // Query DueCustomerquery = _collectionDueCustomerRef.where("ProductVisibleID",
    //     isEqualTo: ProductVisibleID);

    QuerySnapshot StudentInfoquerySnapshot =
        await _collectionStudentInfoRef.get();

    // Get data from docs and convert map to List
    AllStudentInfo =
        StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentInfo =
          StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
      // SearchByStudentIDController.clear();
    });

    setState(() {
      loading = false;
    });

    // print(AllData);
  }

  @override
  void initState() {
    getStudentInfo();

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
          title: const Text(
            "All Student Information",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          backgroundColor: Colors.transparent,
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
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.all(20),
                childAspectRatio: 3 / 2,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DataTable2(
                        headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        columnSpacing: 19,
                        headingRowColor:
                            const WidgetStatePropertyAll(Colors.pink),
                        horizontalMargin: 12,
                        minWidth: 3600,
                        dividerThickness: 3,
                        isHorizontalScrollBarVisible: true,
                        columns: const [
                          DataColumn2(
                            label: Text('SL'),
                            // size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('SID'),
                          ),
                          DataColumn(
                            label: Text('Account Status'),
                          ),
                          DataColumn(
                            label: Text('Department'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Father Name'),
                          ),
                          DataColumn(
                            label: Text('Mother Name'),
                          ),
                          DataColumn(
                            label: Text('Phone No'),
                          ),
                          DataColumn(
                            label: Text('Father Phone No'),
                          ),
                          DataColumn(
                            label: Text('Future Aim'),
                          ),
                          DataColumn(
                            label: Text('Date Of Birth'),
                          ),
                          DataColumn(
                            label: Text('SSC Batch'),
                          ),
                          DataColumn(
                            label: Text('SSC Roll'),
                          ),
                          DataColumn(
                            label: Text('SSC Institution Name'),
                          ),
                          DataColumn(
                            label: Text('SSC GPA'),
                          ),
                          DataColumn(
                            label: Text('HSC Roll'),
                          ),
                          DataColumn(
                            label: Text('HSC Institution Name'),
                          ),
                          DataColumn(
                            label: Text('HSC GPA'),
                          ),
                          DataColumn(
                            label: Text('Present Address'),
                          ),
                          DataColumn(
                            label: Text('Permanent Address'),
                          ),
                          DataColumn(
                            label: Text('Admission Date'),
                          ),
                          DataColumn(
                            label: Text('Verify Student Phone'),
                          ),
                          DataColumn(
                            label: Text('Verify Father Phone'),
                          ),
                          DataColumn(
                            label: Text('Change Status'),
                          ),
                          DataColumn(
                            label: Text('Edit'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            AllStudentInfo.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(AllStudentInfo[index]["SIDNo"]
                                      .toString())),
                                  DataCell(AllStudentInfo[index]
                                                  ["AccountStatus"]
                                              .toString()
                                              .toUpperCase() ==
                                          "OPEN"
                                      ? Text(
                                          AllStudentInfo[index]["AccountStatus"]
                                              .toString()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          AllStudentInfo[index]["AccountStatus"]
                                              .toString()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["Department"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["StudentName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["FatherName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(AllStudentInfo[index]
                                          ["MotherName"]
                                      .toString()
                                      .toUpperCase())),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["StudentPhoneNumber"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["FatherPhoneNo"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["FutureAim"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["StudentDateOfBirth"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["SSCBatchYear"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["SSCRollNo"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["SSCInstitutionName"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["SSCGPA"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["HSCRollNo"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["HSCInstitutionName"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["HSCGPA"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["StudentPresentAddress"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["StudentPermanentAddress"]}')),
                                  DataCell(Text(
                                      '${AllStudentInfo[index]["AdmissionDateTime"]}')),
                                  DataCell(ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Verify"),
                                  )),
                                  DataCell(ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Verify"),
                                  )),
                                  DataCell(ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          String Title =
                                              "Are you sure!! Do You want to change this status?";

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
                                                    : const SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                                height: 10),
                                                            const Center(
                                                              child: Text(
                                                                "আপনি Student Status Change করতে নিচে থাকা Button Click করেন। যদি Cancel করতে চান তবে Cancel Button এ Click করুন ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Josefin Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
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

                                                      var StudentStatus = {
                                                        "AccountStatus": "close"
                                                      };

                                                      final ClassOffSMS =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'StudentInfo')
                                                              .doc(
                                                                  AllStudentInfo[
                                                                          index]
                                                                      [
                                                                      "SIDNo"]);

                                                      ClassOffSMS.update(
                                                              StudentStatus)
                                                          .then((value) =>
                                                              setState(
                                                                  () async {
                                                                

                                                                // Navigator.pop(context);

                                                                // getProductInfo();

                                                                getStudentInfo();

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
                                                                    .of(context)
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
                                    child: Text("Close"),
                                  )),
                                  DataCell(ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Edit"),
                                  )),
                                ]))),
                  ),
                ],
              ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xf08f00ff);
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
