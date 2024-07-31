import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:confidence/Screens/important.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUpload extends StatefulWidget {
  final String SID;
  const ImageUpload({super.key, required this.SID});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  bool loading = false;

  String LastUpdatedCustomerImageUrl =
      "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png";

  File? _photo;

  String image64 = "";

  String UploadImageURl = "";

  bool ImageLoading = false;

//  bool loading = false;

  List AllUploadImageUrl = [];

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(BuildContext context) async {
    //old
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    var pickedFile = await FilePicker.platform.pickFiles();

    if (pickedFile != null) {
      print(pickedFile.files.first.name);
    }

    //old
    setState(() {
      if (pickedFile != null) {
        final bytes =
            Uint8List.fromList(pickedFile.files.first.bytes as List<int>);

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        setState(() {
          loading = true;
        });
        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    setState(() {
      loading = true;
    });

    try {
      var request = await http
          .post(
              Uri.parse(
                  "https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),
              body: {
                'image': '$image64',
              })
          .then((value) => setState(() {
                print(jsonDecode(value.body));

                var serverData = jsonDecode(value.body);

                var serverImageUrl = serverData["data"]["url"];

                setState(() {
                  UploadImageURl = serverImageUrl;
                  AllUploadImageUrl.insert(
                      AllUploadImageUrl.length, serverImageUrl);
                });

                print(serverImageUrl);

                // updateData(serverImageUrl,context);

                upadteImageURl(String StudentImageUrl) {
                  final docUser = FirebaseFirestore.instance
                      .collection("StudentInfo")
                      .doc(widget.SID);
                  final updateImage = {"StudentImageUrl": StudentImageUrl};
                  // user Data Update and show snackbar

                  docUser
                      .update(updateImage)
                      .then((value) => setState(() {
                            // Navigator.pop(context);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => CustomerProfile(
                            //           CustomerID: widget.CustomerID)),
                            // );
                          }))
                      .onError((error, stackTrace) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: const Text('Something Wrong'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          )));
                }

                upadteImageURl(serverImageUrl);

                setState(() {
                  loading = false;
                });

                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Your Image Upload Successfull',
                    message: 'Your Image Upload Successfull',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }))
          .onError((error, stackTrace) => setState(() {
                setState(() {
                  loading = false;
                });

                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Something Wrong!!!',
                    message: 'Try again later',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: ColorName().appColor),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: const Text(
          "Upload Image",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            loading
                ? Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF1A1A3F),
                      rightDotColor: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 155,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: _photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  _photo!,
                                  width: 400,
                                  height: 400,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                width: 400,
                                height: 400,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
