import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/provider/my_provider.dart';
import 'package:foodapp/screen/my_order.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {


  String? first_name = '';
  String? last_name = '';
  String? email = '';
  String? address = '';
  String? userId = '';

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
          address = snapshot.data()!["Address"];
          userId = snapshot.data()!["userid"];
        });
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _getDataFromDatabase();

  }
  Widget cartItem({
    required String image,
    required String name,
    required int price,
    required void Function() onTap,
    required int quantity,
    required int total,

  }) {
    return Row(

      children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Quantity $quantity",
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "Total \$ $total",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),

                ],
              )
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    int Fulltotal = provider.totalprice();

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
                  builder: (context) => CartPage(),
                ),
              );
            }),
        title: Row(children: [const Text("Check Out Page"), const SizedBox(width: 90,), Text("ITEM- ${provider.cartList.length}",style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold))], ),


      ),
      body:
      Column(
          children:[
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(),

              ),
              height: 320,
              width: 400,
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (ctx, index) {
                  provider.getDeleteIndex(index);
                  return cartItem(
                    onTap: (){
                      provider.delete();
                    },
                    image: provider.cartList[index].image,
                    name: provider.cartList[index].name,
                    quantity: provider.cartList[index].quantity,
                    price: provider.cartList[index].price,
                    total: provider.cartList[index].price * provider.cartList[index].quantity,

                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.black87, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(

                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CheckoutPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Total Amount",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "\$ $Fulltotal",
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 157,
                decoration: BoxDecoration(
                    color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                child: Column(
                    children : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Customer Name",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${first_name!} ${last_name!}",
                            style: const TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email Address",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            email!,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
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
                            address!,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          ),
                        ],
                      ),
                    ]
                )
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(

                    onPressed: () {


                        FirebaseFirestore.instance
                          .collection('orders')
                          .add({
                        'name': first_name!+ last_name!,
                        'total': "\$ $Fulltotal".toString(),
                        'food': provider.cartList.map((e) => "${e.name} * ${e.quantity} Items\n").toString(),
                        'email': email!,
                        'address': address!,
                        'date': FieldValue.serverTimestamp(),
                          'userid': userId!,

                      });
                      provider.cartList.clear();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirmation Massage"),
                          content: const Text("You Have Successfully place the Order please settle the Payment after you receive the Food, Thank-you :) Have an Nice Meal"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const MyOrders(),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.deepOrange,
                                padding: const EdgeInsets.all(14),
                                child: const Text("OK",  style: TextStyle(color: Colors.black),),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      "Confirm Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}





