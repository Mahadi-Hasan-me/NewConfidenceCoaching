import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/CommonScreen/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();
  TextEditingController myAddressController = TextEditingController();
  TextEditingController myPhoneNumberController = TextEditingController();
  TextEditingController myAdminNameController = TextEditingController();

 var createUserErrorCode = "";

 bool loading = false;

  bool _passVisibility = true;

    String errorTxt = "";









  
  @override
  void initState() {
  
    super.initState();
    // FlutterNativeSplash.remove();
    
  }


  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();



   







    


 

    return  Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Create Your Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

              child:  loading?LinearProgressIndicator(color: Theme.of(context).primaryColor,):Padding(
                padding: const EdgeInsets.all(8.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                       errorTxt.isNotEmpty?  Center(
                     child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                
                           color: Colors.red.shade400,
                           
                           
                           child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                           )),
                                ),
                   ):Text(""),




                    




            
                    
                    // Center(
                    //   child: Lottie.asset(
                    //   'lib/images/animation_lk8g4ixk.json',
                    //     fit: BoxFit.cover,
                    //     width: 300,
                    //     height: 200
                    //   ),
                    // ),
            
            // SizedBox(
            //           height: 20,
            //         ),
            
            
            
                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Name',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Name',
            
                          //  enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //     ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                          
                          
                          ),
                      controller: myAdminNameController,
                    ),
            
            
            
            
                 
            
            
            
            
                   
                    SizedBox(
                      height: 15,
                    ),



            
            
            
                    TextField(
                      keyboardType: TextInputType.phone,
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Phone Number',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Phone Number',
            
                          //  enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //     ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                          
                          
                          ),
                      controller: myPhoneNumberController,
                    ),
            
            
            
            
                    SizedBox(
                      height: 15,
                    ),
            
            
            
            
            
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Email',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.purple: Colors.black
                  ),
                          hintText: 'Enter Your Email',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: myEmailController,
                    ),
            
                    SizedBox(
                      height: 15,
                    ),

                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Password',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Password',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: myPassController,
                    ),
            

            SizedBox(
                      height: 15,
                    ),











            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{

                   


                          setState(() {
                            loading = true;
                          });





                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: myEmailController.text.trim(),
                          password: myPassController.text.trim(),
                        );

                      



                       
                        await credential.user?.updateDisplayName(myAdminNameController.text.trim());
                        


                     
                      
                  await credential.user?.sendEmailVerification();






                  var AdminMsg = "Dear Admin, ${myEmailController.text.trim()}  ${myPhoneNumberController.text} Admin হতে চায়। Please Check App";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=01919517496&message=${AdminMsg}'));

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.
                     final docUser =  FirebaseFirestore.instance.collection("admin");

                      final jsonData ={

                        "userName":myAdminNameController.text,
                        "userEmail":myEmailController.text,
                        "emailVerified":"",
                        "AdminApprove":"false",
                        "userPhoneNumber":myPhoneNumberController.text,
                        "userPassword":myPassController.text
                     
                      };




                    await docUser.doc(myEmailController.text).set(jsonData).then((value) =>setState((){


                                      AwesomeDialog(
                                            showCloseIcon: true,

                                            btnOkOnPress: () {
                                             
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );
                                            },
                                        
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.rightSlide,
                                            body: SingleChildScrollView(
                                              child: Text("রেজিস্ট্রেশন সম্পন্ন হয়েছে। আপনাকে একটি Email পাঠানো হয়েছে। Email টি Verify করুন।", style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: "Josefin Sans"),))).show();



                    })).onError((error, stackTrace) => setState((){

                                    AwesomeDialog(
                                            showCloseIcon: true,

                                            btnOkOnPress: () {
                                             Navigator.pop(context);
                                            },
                                        
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.rightSlide,
                                            body: SingleChildScrollView(
                                              child: Text("Something Wrong!!! Try again later"))).show();





                      }));




                    
                  
                  } else {
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }

                 


                   

                     

                    

          



                  



                     myAdminNameController.clear();
                      myEmailController.clear();
                      myPassController.clear();

                     setState(() {
                    loading = false;
                  });

              

       


                        

                        // print(credential.user!.email.toString());
                      } on FirebaseAuthException catch (e) {

                        setState(() {
                        errorTxt = e.code.toString();

                          loading = false;
                        });
               
                      } 












                      
                        }, child: Text("Create Account", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              ),),),






               Container(width: 150, child:TextButton(onPressed: (){

                    Navigator.push(
                        context,MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );




                    }, child: Text("Log In", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
              ),),),





               





                      ],
                    ),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                Container(width: 150, child:TextButton(onPressed: (){

                    Navigator.push(
                        context,MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );




                    }, child: Text("Teacher Registration", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
              ),),),


                              Container(width: 150, child:TextButton(onPressed: (){

                    Navigator.push(
                        context,MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );




                    }, child: Text("Staff Registration", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
              ),),),

                    ],)
            
            
            
                  ],
                ),
              ),
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