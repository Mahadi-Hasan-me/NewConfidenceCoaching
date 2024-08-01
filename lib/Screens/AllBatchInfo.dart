import 'dart:math';
import 'package:confidence/Screens/Students/AllStudent.dart';
import 'package:confidence/Screens/important.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  TextEditingController StudentOTPController = TextEditingController();

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
          : 
             SingleChildScrollView(
                      child: Text(""),
                    ),
          
    );
  }
}
