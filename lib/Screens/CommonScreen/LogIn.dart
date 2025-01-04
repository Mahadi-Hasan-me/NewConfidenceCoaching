
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/CommonScreen/EmailNotVerified.dart';
import 'package:confidence/Screens/CommonScreen/InternetChecker.dart';
import 'package:confidence/Screens/CommonScreen/Registration.dart';
import 'package:confidence/Screens/HomeScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart' show kIsWeb;





class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();

bool _passVisibility = true;

    String errorTxt = "";

   var createUserErrorCode = "";

   bool loading = false;




   
// internet Connection Checker


// Future getConnection() async{

//   final connectivityResult = await (Connectivity().checkConnectivity());
// if (connectivityResult == ConnectivityResult.mobile) {
//   print("mobile");
//   setState(() {
//     online = true;
//   });
// } else if (connectivityResult == ConnectivityResult.wifi) {
//    print("wifi");
//      setState(() {
//     online = true;
//   });
//   // I am connected to a wifi network.
// } else if (connectivityResult == ConnectivityResult.ethernet) {
//    print("Ethernet");
//      setState(() {
//     online = true;
//   });
//   // I am connected to a ethernet network.
// } else if (connectivityResult == ConnectivityResult.vpn) {
//    print("vpn");

//   setState(() {
//     online = true;
//   });
//   // I am connected to a vpn network.
//   // Note for iOS and macOS:
//   // There is no separate network interface type for [vpn].
//   // It returns [other] on any device (also simulator)
// } else if (connectivityResult == ConnectivityResult.bluetooth) {
//    print("bluetooth");
//   setState(() {
//     online = true;
//   });
//   // I am connected to a bluetooth.
// } else if (connectivityResult == ConnectivityResult.other) {
//    print("other");
//   setState(() {
//     online = true;
//   });
//   // I am connected to a network which is not in the above mentioned networks.
// } else if (connectivityResult == ConnectivityResult.none) {
//    print("none");

//     setState(() {
//     online = false;
//   });
   
//   // I am not connected to any network.
// }
// }


// internet Connection Checker

// bool online = true;
// Future getInternetValue() async{

// bool onlineData =await getInternetConnectionChecker().getInternetConnection() ;

// setState(() {
//   online = onlineData;
  
// });


// }




// late var timer;

//    @override
//   void initState() {


//  if (mounted) {
//    var period = const Duration(seconds:1);
//    timer = Timer.periodic(period,(arg) {
//                   getInternetValue();
//     });
   
//  }


//     // TODO: implement initState
//     FlutterNativeSplash.remove();
//     super.initState();
//   }




//     @override
// void dispose() {
//   timer.cancel();
//   super.dispose();
// }



  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        
     systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: const Text("Log In",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: CircularProgressIndicator(),
                    ),
              ):SingleChildScrollView(

        child: AutofillGroup(
                child: Padding(
                       padding: EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5,),
                        child: Column(
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

              
              
              
              
              
                //  createUserErrorCode=="wrong-password"? Center(
                //   child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Container(
                
                
                //                   child: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Icon(Icons.close, color: Colors.red,),
                //       Text("Wrong password provided for that user."),
                //     ],
                //   ),
                //                   ),
                   
                //                decoration: BoxDecoration(
                //                 color: Colors.red[100],
                
                //                 border: Border.all(
                //         width: 2,
                //         color: Colors.white
              
                        
                //       ),
                //                 borderRadius: BorderRadius.circular(10)      
                //                ),)),
                // ):Text(""),
              
              
              
              
              
              
              
                // createUserErrorCode=="user-not-found"? Center(
                //   child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Container(
                
                
                //                   child: Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 8),
                //   child: Row(
                //     children: [
                //       Icon(Icons.close, color: Colors.red,),
                //       Text("No user found for that email.", overflow: TextOverflow.clip,),
                //     ],
                //   ),
                //                   ),
                   
                //                decoration: BoxDecoration(
                //                 color: Colors.red[100],
                
                //                 border: Border.all(
                //         width: 2,
                //         color: Colors.white
              
                        
                //       ),
                //                 borderRadius: BorderRadius.circular(10)      
                //                ),)),
                // ):Text(""),
              
              
              
              
              
              
              
              
                
              
              
              
              
                          
                
                Center(
                  child: Lottie.asset(
                  'lib/images/Animation - 1705200671397.json',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200
                  ),
                ),
                          
                          SizedBox(
                                    height: 20,
                                  ),
                          
                          
                          
                TextField(
                  autofillHints: [AutofillHints.email],
                  
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                       labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                          ),
                      hintText: 'Enter Your Email',
                          
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
                  controller: myEmailController,
                ),
                          
                          
                          
                          
                SizedBox(
                  height: 20,
                ),
                          
                          
                          
                          
                          
                TextField(
                   autofillHints: [AutofillHints.password],

                    keyboardType: TextInputType.visiblePassword,
                  obscureText: _passVisibility,
                  obscuringCharacter:"*",


                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor,),

                        suffixIcon: IconButton(
                      icon: _passVisibility
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        _passVisibility = !_passVisibility;

                        setState(() {});
                      },
                    ),
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
                  height: 10,
                ),
                          
                          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 150, child:TextButton(onPressed: () async{
              
              
                      setState(() {
                        loading = true;
                      });
              
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: myEmailController.text.trim(),
                          password: myPassController.text.trim()
                        );
              
                        var userName = credential.user!.displayName;
                        var userEmail = credential.user!.email;
                        var userVerified = credential.user!.emailVerified;
              
              
                        if (userVerified) {
              
              
                          List  AllData = [];
              
              
                      CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('Teachers');
              
                        Query query = _collectionRef.where("userEmail", isEqualTo: myEmailController.text);
                      QuerySnapshot querySnapshot = await query.get();
              
                  
                        // Get docs from collection reference
                       
              
                        // Get data from docs and convert map to List
                        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        setState(() {
                          
                          AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
              
              
              
              
              
                        print(AllData);
                          
              
              
                 
              
              
              
                    if (AllData[0]["AdminApprove"] == "true") {
              
                      
              
              
                             Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(UserName: userName, UserEmail: userEmail, )),);
              
                             setState(() {
                            loading=false;
                          });
              
                      
                    }
              
                    else{
              
                      setState(() {
                            loading=false;
                          });
              
              
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => StaffScreen()),);
              
              
                    }

                        }
                        else{
              
              
                      try {

                                await credential.user?.sendEmailVerification().then((value) => setState((){

                                setState(() {
                                 loading = false;
                                
                               });



                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmailNotVerified()));

                                  print("Done");
                               
                                })).onError((error, stackTrace) => setState((){


                                setState(() {
                                 loading = false;
                             
                               });




                                  



                          

                                  print("________________________$error");
                                }));
                                
                              } catch (e) {
                                print(e);
                                
                              }
              
                              setState(() {
                            loading=false;
                                 });
                          
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()),);
              
              
                        }
              
              
              
              
                  
              
              
              
                        
                    
              
              
              
              
              
              
                      } on FirebaseAuthException catch (e) {

                        setState(() {
                          errorTxt = e.code.toString();

                          loading = false;
                        });




                        // if (e.code == 'user-not-found') {
              
                        //   setState(() {
                        //     loading=false;
                        //     createUserErrorCode = "user-not-found";
                            
                        //   });
                        //   print('No user found for that email.');
                        // } else if (e.code == 'wrong-password') {
              
              
                        //   setState(() {
                        //     loading=false;
                        //     createUserErrorCode = "wrong-password";
                            
                        //   });
                        //   print('Wrong password provided for that user.');
                        // }
                      }
              
              
              
              
              
              
              
                    }, child: Text("Log in", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      ),),),
              
              
              
                Container(width: 150, child:TextButton(onPressed: (){
              
                       Navigator.push(
                    context,
              
                           MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                  );
              
              
              
              
                }, child: Text("Create Account", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
                      ),),),
              
              
              
              
              
                  ],
                )
                          
                          
                          
                          ],
                        ),
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
    paint.color = Color(0xff8f00ff);
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