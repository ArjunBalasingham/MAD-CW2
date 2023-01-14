import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screen/admin_view_order.dart';
import 'package:foodapp/screen/user_profile.dart';
import 'package:foodapp/screen/welcome_page.dart';

import 'Admin_profile.dart';

class AdminPage extends StatefulWidget {

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  Widget categoriesContainer(
      {required void Function() onTap,
        required String image,
        required String name}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image)),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget drawerItem({required String name, required IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,

      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 20, color: Colors.white),

      ),

    );
  }

  ////1st

  String? first_name = '';
  String? email = '';
  String image = '';
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
          email = snapshot.data()?["email"];
          image = snapshot.data()?["image"];

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
      drawer: Drawer(
        child: Container(
          color: const Color(0xa38a3c06),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/background.jpg'),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                  accountName: Text(first_name!),
                  accountEmail: Text(email!),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.white,),
                  title: const Text('Profile', style: TextStyle(fontSize: 20, color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AdminProfile(),
                      ),
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                const ListTile(
                  leading: Text(
                    "Communicate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                  title: const Text('Log Out', style: TextStyle(fontSize: 20, color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions:[
          GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(image!),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
          ),


        ],
        title: const Text("Admin Page"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xa38a3c06),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,fixedSize: Size.fromWidth(365)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AdminViewOrder(),
                  ),
                );
              },
              child: const Text(
                'Customer Orders',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,fixedSize: Size.fromWidth(365)),
              onPressed: () {},
              child: const Text(
                'View Customers',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,),
              onPressed: () {},
              child: const Text(
                'Register Customer',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,fixedSize: Size.fromWidth(365)),
              onPressed: () {},
              child: const Text(
                'Add New Foods',
                style: TextStyle(fontSize: 40),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
