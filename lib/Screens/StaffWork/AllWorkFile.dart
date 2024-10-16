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

class AllWorkFile extends StatefulWidget {
  AllWorkFile({
    super.key,
  });

  @override
  _AllWorkFileState createState() => _AllWorkFileState();
}

class _AllWorkFileState extends State<AllWorkFile> {
  int _selectedDestination = 0;

  bool DataLoad = false;

  var uuid = Uuid();

  TextEditingController SearchByStudentIDController = TextEditingController();
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController StudentPhoneNoController = TextEditingController();
  TextEditingController StudentFatherPhoneNoController =
      TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController SchoolOrCollegeNameController = TextEditingController();
  TextEditingController DepartmentController = TextEditingController();
  TextEditingController TotalStudentController = TextEditingController();
  TextEditingController YearController = TextEditingController();
  TextEditingController RecentClassController = TextEditingController();

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
        FirebaseFirestore.instance.collection('PhoneCallStudentList');

    Query StudentInfoquery =
        _collectionStudentInfoRef.where("FileID", isEqualTo: "");

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

  List FileHeaderInfo = [];

  Future<void> getFileHeaderInfo() async {
    CollectionReference _collectionFileInfoRef =
        FirebaseFirestore.instance.collection('AllWorkFileHeader');

    QuerySnapshot FileInfoquerySnapshot = await _collectionFileInfoRef.get();

    FileHeaderInfo =
        FileInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    if (FileHeaderInfo.isEmpty) {
      setState(() {
        DataLoad = false;
      });
    } else {
      setState(() {
        FileHeaderInfo = [];
        FileHeaderInfo =
            FileInfoquerySnapshot.docs.map((doc) => doc.data()).toList();
        CommentController.clear();
        createControllers();

        DataLoad = true;
      });
    }

    // print(AllData);
  }

  @override
  void initState() {
    // FlutterNativeSplash.remove();

    // getAllStudentInfo();

    getFileHeaderInfo();

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
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    // your logic
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
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
                                            child: CircularProgressIndicator(),
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
                                                    decoration: InputDecoration(
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
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color:
                                                                Color.fromARGB(
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
                                                    decoration: InputDecoration(
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
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color:
                                                                Color.fromARGB(
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
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText:
                                                          'Total Student',

                                                      hintText: 'Total Student',

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
                                                            color:
                                                                Color.fromARGB(
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
                                                    decoration: InputDecoration(
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
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    66,
                                                                    125,
                                                                    145)),
                                                      ),
                                                    ),
                                                    controller: YearController,
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
                                                    decoration: InputDecoration(
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
                                                        borderSide: BorderSide(
                                                            width: 3,
                                                            color:
                                                                Color.fromARGB(
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
                                        onPressed: () => Navigator.pop(context),
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
                                            "Year": YearController.text.trim(),
                                            "RecentClass": RecentClassController
                                                .text
                                                .trim(),
                                            "LastWork": DateTime.now()
                                                .toIso8601String(),
                                            "Incomplete": TotalStudentController
                                                .text
                                                .trim(),
                                            "FileID":
                                                ProductUniqueID.toString(),
                                          };

                                          final docUser = FirebaseFirestore
                                              .instance
                                              .collection("StaffWorkHeader")
                                              .doc(ProductUniqueID);

                                          docUser
                                              .set(StaffCallingHeader)
                                              .then((value) => setState(() {
                                                    setState(() {
                                                      loading = false;
                                                    });

                                                    Navigator.pop(context);

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
                                                            'Created successfull',
                                                        message:
                                                            'Created successfull',

                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                        contentType:
                                                            ContentType.success,
                                                      ),
                                                    );

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
                                                            'Something Wrong!!!',
                                                        message:
                                                            'Please Check your connection',

                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                        contentType:
                                                            ContentType.failure,
                                                      ),
                                                    );
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
                )
              ],
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Phone Call Work",
                  ),
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
                                  label: Text('S/C Name'),
                                ),
                                DataColumn(
                                  label: Text('Department'),
                                ),
                                DataColumn(
                                  label: Text('Total Student'),
                                ),
                                DataColumn(
                                  label: Text('Recent Class'),
                                ),
                                DataColumn(
                                  label: Text('Year'),
                                ),
                                DataColumn(
                                  label: Text('Last Work Time'),
                                ),
                                DataColumn(
                                  label: Text('Incomplete'),
                                ),
                                DataColumn(
                                  label: Text('Edit'),
                                ),
                                DataColumn(
                                  label: Text('Delete'),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                  FileHeaderInfo.length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["SchoolOrCollegeName"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["Department"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["TotalStudent"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["RecentClass"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["Year"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["LastWork"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(Text(FileHeaderInfo[index]
                                                ["Incomplete"]
                                            .toString()
                                            .toUpperCase())),
                                        DataCell(ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Edit"))),
                                        DataCell(ElevatedButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String Title =
                                                      "Are You Sure?? You Want to Delete This File!!!!!";

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
                                                            : const SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "Delete করতে নিচে থাকা Yes button এ press করুন।",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Josefin Sans",
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
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

                                                              final collection =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'AllWorkFileHeader');
                                                              collection
                                                                  .doc(FileHeaderInfo[
                                                                          index]
                                                                      [
                                                                      "FileID"]) // <-- Doc ID to be deleted.
                                                                  .delete() // <-- Delete
                                                                  .then((_) {
                                                                setState(() {
                                                                  // delete All student info under this file

                                                                  getFileHeaderInfo();
                                                                  const snackBar =
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
                                                                          'Delete Successfull',
                                                                      message:
                                                                          'Delete Successfull',

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
                                                                });
                                                              }).catchError(
                                                                      (error) {
                                                                setState(() {
                                                                  const snackBar =
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
                                                                });
                                                              });
                                                            },
                                                            child: const Text(
                                                                "Yes"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Delete"))),
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
