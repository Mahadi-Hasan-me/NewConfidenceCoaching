import 'dart:math';
import 'package:confidence/Screens/Students/AllStudent.dart';
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

class AllStudentMSG extends StatefulWidget {
  final List AllStudentInfo;

  const AllStudentMSG({super.key, required this.AllStudentInfo});

  @override
  State<AllStudentMSG> createState() => _AllStudentMSGState();
}

class _AllStudentMSGState extends State<AllStudentMSG> {
  TextEditingController SMSController = TextEditingController();

  bool loading = false;

  int SMSCount = 0;

  Future sendSMS(String MSG) async {
    setState(() {
      loading = true;
    });

    for (var i = 0; i < widget.AllStudentInfo.length; i++) {
      try {
        final response = await http.get(Uri.parse(
            'https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${widget.AllStudentInfo[i]["StudentPhoneNumber"]}&message=${MSG}'));

        if (response.statusCode == 200) {
          setState(() {
            SMSCount = SMSCount + 1;
          });
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      } catch (e) {}
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getData(widget.CustomerNID);
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
          "স্টুডেন্টদের প্রতি মেসেজ পাঠানো",
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
              child: Text(
                "SMS Send Successfully: ${SMSCount.toString()}/${widget.AllStudentInfo.length.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.green),
              ),
            )
          : Container(
              child: loading
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                color: Color.fromARGB(255, 245, 201, 42),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "আপনার সকল স্টুডেন্টের প্রতি SMS পাঠান",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              minLines: 2,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter SMS',

                                hintText: 'Enter SMS',

                                //  enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                              ),
                              controller: SMSController,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });

                                      sendSMS(SMSController.text.trim());
                                    },
                                    child: Text(
                                      "Send",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
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
