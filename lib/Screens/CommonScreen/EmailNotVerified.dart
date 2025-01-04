
import 'package:confidence/Screens/important.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class EmailNotVerified extends StatefulWidget {
  const EmailNotVerified({super.key});

  @override
  State<EmailNotVerified> createState() => _EmailNotVerifiedState();
}

class _EmailNotVerifiedState extends State<EmailNotVerified> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: ColorName().appColor),
        automaticallyImplyLeading: false,
        title: const Text("Email Not Verified",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("আপনার Email টি Verify করেননি। তাই আপনার Registration বাতিল করা হয়েছে। নতুনভাবে Registration করুন।এবং আপনার Email টি Verify করুন।")),
      ));

  }
}