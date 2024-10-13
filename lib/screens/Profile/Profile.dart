import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String loading = "Loading.....";
  String baseImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
  List<QueryDocumentSnapshot> user = [];
  getUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    user.addAll(querySnapshot.docs);
    setState(() {});
  }

  File? imageFile;
  String? uploadedFileURL;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image!.path);
    }
    setState(() {});
  }

Future<void> updateProfileImage() async {
    if (imageFile == null) return;

    try {
      // Create a reference to Firebase Storage
        String uid = FirebaseAuth.instance.currentUser!.uid;
        // Create a reference to Firebase Storage
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageReference = storage.ref().child(
            'profile_images/$uid.jpg');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(imageFile!);
      await uploadTask;

      // Get the download URL of the uploaded file
      String downloadURL = await storageReference.getDownloadURL();
      setState(() {
        uploadedFileURL = downloadURL;
      });

      // Store the download URL in Firestore under the user document
      await FirebaseFirestore.instance.collection('users').add({
            'profileImageURL': downloadURL,
            'email': FirebaseAuth.instance.currentUser!.email
          });

      print('File uploaded and URL saved: $downloadURL');
    } catch (e) {
      print('Error occurred while uploading: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      user.length > 1 ? user[user.length-1]['profileImageURL'] : baseImage),
                ),
                Positioned(
                  child: IconButton(
                      onPressed: () async {
                        await getImage();
                        updateProfileImage();
                      },
                      icon: CircleAvatar(
                          backgroundColor: kprimaryColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ))),
                  bottom: -5,
                  right: -5,
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.account_circle_outlined,
                size: 35,
                color: kprimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "User Name : ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "${user.length > 0 ? user[0]['user_name'] : loading}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.email_outlined,
                size: 35,
                color: kprimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Email : ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "${user.length > 0 ? user[0]['email'] : loading}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.phone,
                size: 35,
                color: kprimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Phone : ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "${user.length > 0 ? user[0]['phone'] : loading}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
