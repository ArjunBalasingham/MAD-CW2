import 'package:flutter/material.dart';
import 'package:foodapp/screen/sign_up.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Widget button({
    required String name,
    Color? color,
    Color? textColor
  }) {
    return Container(
      height: 45,
      width: 300,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/logo1.jpg', width: 700, height: 700,),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Welcome To Food Mart",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      const Text("Order food form our resturent and"),
                      const Text("Have a Good Meal")
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      // side: BorderSide(color: Colors.yellow, width: 5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.teal,width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(300, 40),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text('Login', style: TextStyle(color: Colors.white),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      // side: BorderSide(color: Colors.yellow, width: 5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.red,width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(300, 40),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: const Text('SignUp', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
