import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screen/home_page.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

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
                  builder: (context) => HomePage(),
                ),
              );
            }),
        title: const Text("My Orders Page"),


      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Timestamp t = document['date'];
              DateTime d = t.toDate();
              return Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                height: 400,
                                decoration: BoxDecoration(
                                    color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    children : [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Ordered Date",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Expanded(child:
                                          Text(
                                            'Date ${d.day} /${d.month} /${d.year}\nTime ${d.hour} : ${d.minute}',
                                            style: const TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Email Address",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child:
                                          Text(
                                            document['email'],
                                            style: const TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Ordered Items",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child:
                                          Text(
                                            document['food'],
                                            style: const TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Total Price",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child:
                                          Text(
                                            document['total'],
                                            style: const TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Shipping Address",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child:
                                          Text(
                                            document['address'],
                                            style: const TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),

                                    ]
                                ))
                          ]),
                    ),
                  ),

                ]
              );
            }).toList(),
          );
        },
      ),
    );
  }
}