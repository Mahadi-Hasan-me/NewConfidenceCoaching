import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/Students/FileView.dart';
import 'package:confidence/Screens/important.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllFile extends StatefulWidget {
  final SIDNo;

  const AllFile({super.key, required this.SIDNo});

  @override
  State<AllFile> createState() => _AllFileState();
}

class _AllFileState extends State<AllFile> {
  bool loading = false;
  List AllStudentFile = [];

  Future<void> getStudentInfo() async {
    setState(() {
      loading = true;
    });

    CollectionReference _collectionStudentInfoRef =
        FirebaseFirestore.instance.collection('StudentFileInfo');

    Query StudentInfoquery =
        _collectionStudentInfoRef.where("SIDNo", isEqualTo: widget.SIDNo);

    QuerySnapshot StudentInfoquerySnapshot = await StudentInfoquery.get();

    // Get data from docs and convert map to List
    AllStudentFile =
        StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentFile =
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          "SID: ${widget.SIDNo}",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [

          for(int i=0; i<AllStudentFile.length; i++)
              ListTile(title: Text("${AllStudentFile[i]["FileName"]}"),subtitle: Text("${AllStudentFile[i]["FileID"]}"),trailing: ElevatedButton(onPressed: (){

                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FileView(FileName: AllStudentFile[i]["FileName"], FileUrl: AllStudentFile[i]["FileUrl"])),
                              );

              }, child: Text("View")),leading: const Icon(Icons.picture_as_pdf),)



        ],
      )),
    );
  }
}
