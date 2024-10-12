import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String loading="Loading.....";
  List<QueryDocumentSnapshot> user = [];
  getUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    user.addAll(querySnapshot.docs);
    setState(() {});
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
          SizedBox(height: 40,),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                ),
                Positioned(
                  child: IconButton(
                      onPressed: () {},
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
          Container(
          //   padding:  EdgeInsets.all(8.0),
          //   decoration: BoxDecoration(
          //   color: Colors.grey[300],  // Grey background color,   // Makes the container circular
          //   border: Border.,
          // ),
            child: Row(
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
                  "${user.length>0? user[0]['user_name'] :loading }",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
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
                "${user.length>0? user[0]['email'] :loading }",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold

                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
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
                "${user.length>0? user[0]['phone'] :loading }",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
