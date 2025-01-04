import 'dart:async';
import 'dart:convert';
import 'package:confidence/Screens/HomeScreen.dart';
import 'package:confidence/Screens/Students/AllFile.dart';
import 'package:confidence/Screens/Students/UploadStudentFile.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:uuid/uuid.dart';




class StudentProfile extends StatefulWidget {


  final String SIDNo;
  





  const StudentProfile({super.key, required this.SIDNo});

  @override
  State<StudentProfile> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<StudentProfile> {

   var uuid = Uuid();


TextEditingController DueAmountController = TextEditingController();






bool loading = true;







   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("SIDNo", isEqualTo: widget.SIDNo);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       loading = false;
    
     });

    print(AllData);
}























bool online = true;
Future getInternetValue() async{

// bool onlineData =await getInternetConnectionChecker().getInternetConnection() ;

// setState(() {
//   online = onlineData;
  
// });


}


late var timer;







@override
  void initState() {

 if (mounted) {
   var period = const Duration(seconds:1);
   timer = Timer.periodic(period,(arg) {
                  getInternetValue();
    });
   
 }
    // TODO: implement initState
    
    getData();

    // getSaleData();
    super.initState();
  }



  @override
void dispose() {
  timer.cancel();
  super.dispose();
}



  Future refresh() async{


    setState(() {
            loading = true;
            
           getData();
          //  getSaleData();

    });

  }
















  @override
  Widget build(BuildContext context) {



    var ServiceID = uuid.v4();
    


 

    return  Scaffold(
      backgroundColor: Colors.white,


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async{



                FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(UserName: user.displayName, UserEmail: user.email,)));
                    }
                  });





                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllFile(SIDNo: widget.SIDNo)));


                },
                icon: const Icon(
                  Icons.file_copy,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),),
      ),
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Student Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child:loading?LinearProgressIndicator()
        : online==false?Center(child: Text("No Internet Connection", style: TextStyle(fontSize: 24, color: Colors.red),)):SingleChildScrollView(
      
                child: Padding(
                  padding:  EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5, bottom: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      
                      Center(
                        child:  ClipOval(
                          child: Image.network(
                            AllData[0]["StudentImageUrl"]==""?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoocHKiIUok-RD7VaxEivcDEwGLdbsMO5JL66hM1Z12x9t6kEvwqKoUNvDeRBc6H9dh4g&usqp=CAU":"${AllData[0]["StudentImageUrl"]}",
                            width: 200,
                            height: 150,
                          ),
                        ),
                      ),
              
               SizedBox(
                        height: 20,
                      ),
      
      
                  Table(
                       border: TableBorder(
                       horizontalInside:
                  BorderSide(color: Colors.white, width: 10.0)),
                      textBaseline: TextBaseline.ideographic,
                        children: [
      
                  
                  
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["StudentName"].toString()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),
      
      
      
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Father Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["FatherName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
      
      
                        TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mother Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["MotherName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
                        TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("SID No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["SIDNo"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
                         TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Present Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["StudentPresentAddress"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),

                          

                           TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Permanent Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["StudentPermanentAddress"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
      
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("S Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["StudentPhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
      
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("F Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["FatherPhoneNo"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("SSC Roll No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["SSCRollNo"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("SSC Institution Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["SSCInstitutionName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("HSC Roll No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["HSCRollNo"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("HSC Institution Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["HSCInstitutionName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Registration No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["RegistrationNo"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("SSC GPA", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["SSCGPA"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("HSC GPA", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["HSCGPA"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                                
      
                           TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Student Date Of Birth", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["StudentDateOfBirth"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                         
                          
      
      
                   
      
                      
      
                         
                    
                       
                        ],
                      ),


                    SizedBox(height: 15,),





















      
      
      
      
      
                     
      
      
      
              
              
              
              
              
                    ],
                  ),
                ),
              ),
      ),
        
        floatingActionButton: FloatingActionButton(
      onPressed: (){

Navigator.of(context).push(MaterialPageRoute(builder: (context) => Uploadstudentfile(SID: widget.SIDNo)));

      },
        tooltip: 'Upload File',
        child: const Icon(Icons.upload_file),
      ), 
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
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