import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screen/admin_page.dart';
import 'package:foodapp/screen/home_page.dart';
import 'package:foodapp/screen/sign_up.dart';
import 'package:foodapp/screen/welcome_page.dart';
import 'package:foodapp/screen/widget/my_text_field.dart';

import 'admin_view_order.dart';


class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadding = false;
  RegExp regExp = RegExp(LoginPage.pattern as String);
  late UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  AdminPage(),
            ),
          );
        }else if(documentSnapshot.get('role') == "customer"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomePage(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }



  Future loginAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;
      if(user != null){
        route();
      }

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No user found for that email.'),
              ),
            );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
        setState(() {
          loadding = false;
        });
      }
      setState(() {
        loadding = false;

      });

    }
    finally{

    }
  }

  void validation() {
    if (email.text.trim().isEmpty ||
        email.text.trim().isEmpty && password.text.trim().isEmpty ||
        password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All Field is Empty'),
        ),
      );
    }
    if (email.text.trim().isEmpty || email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is Empty'),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid Email'),
        ),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password is Empty'),
        ),
      );
      return;
    } else {
      setState(() {
        loadding = true;

      });
      loginAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            }),
        title: Text("Login Page"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 120),
              child: Text(
                "Login In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                MyTextField(
                  controller: email,
                  obscureText: false,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: password,
                  obscureText: true,
                  hintText: 'Password',
                ),
              ],
            ),
            loadding
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: 60,
                    width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2b2b2b),
                  // side: BorderSide(color: Colors.yellow, width: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {

                  validation();

                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),

              ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Text(
                  "New user?",
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(

                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                  child: const Text('Register now.',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
