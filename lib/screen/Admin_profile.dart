import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screen/home_page.dart';

import 'admin_page.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  String? first_name = '';
  String? last_name = '';
  String? email = '';
  String? password = '';
  String? image = '';
  String? address = '';

  Future _getDataFromDatabase() async
  {
    await FirebaseFirestore.instance.collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot)async
    {
      if(snapshot.exists!)
      {
        setState(() {
          first_name = snapshot.data()!["firstName"];
          last_name = snapshot.data()!["lastName"];
          email = snapshot.data()!["email"];
          password = snapshot.data()!["password"];
          address = snapshot.data()!["Address"];
          image = snapshot.data()!["image"];
        });
      }
    });
  }
  @override
  void initState(){
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AdminPage(),
                ),
              );
            }),
        title: const Text("Admin Profile"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(10)),

                const Text(
                  "MY PROFILE",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image!),
                    radius: 70,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 43.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.00),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "${first_name!} ${last_name!}",
                              hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 27.0),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.00),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: email!,
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.00),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: password!,
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.00),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: address!,
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),


      ),
    );
  }
}


