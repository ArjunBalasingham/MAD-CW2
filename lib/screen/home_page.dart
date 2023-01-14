import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/modles/categories_modle.dart';
import 'package:foodapp/modles/food_categories_modle.dart';
import 'package:foodapp/modles/food_modle.dart';
import 'package:foodapp/provider/my_provider.dart';
import 'package:foodapp/screen/categories.dart';
import 'package:foodapp/screen/detail_page.dart';
import 'package:foodapp/screen/my_order.dart';
import 'package:foodapp/screen/user_profile.dart';
import 'package:foodapp/screen/welcome_page.dart';
import 'package:foodapp/screen/widget/bottom_Contianer.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1st
  List<CategoriesModle> burgerList = [];

  ///2nd
  List<CategoriesModle> recipeList = [];
  ///3rd
  List<CategoriesModle> pizzaList = [];
  ///4th
  List<CategoriesModle> drinkList = [];

  List<FoodModle> singleFoodList = [];

  List<FoodCategoriesModle> burgerCategoriesList = [];
  List<FoodCategoriesModle> recipeCategoriesList = [];
  List<FoodCategoriesModle> pizzaCategoriesList = [];
  List<FoodCategoriesModle> drinkCategoriesList = [];

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
              color: Color(0x98000000),
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
  Widget burger() {
    return Row(
      children: burgerList
          .map((e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: burgerCategoriesList,
                    ),
                  ),
                );
              }))
          .toList(),
    );
  }

////2nd
  Widget recipe() {
    return Row(
      children: recipeList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          Categories(list: recipeCategoriesList),
                    ),
                  );
                },
              ))
          .toList(),
    );
  }

  //3rd
  Widget pizza() {
    return Row(
      children: pizzaList
          .map(
            (e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(list: pizzaCategoriesList),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }

  /////4th
  Widget drink() {
    return Row(
      children: drinkList
          .map(
            (e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(list: drinkCategoriesList),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
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
    MyProvider provider = Provider.of<MyProvider>(context);
    // 1st
    provider.getBurgerCategory();
    burgerList = provider.throwBurgerList;
    //2nd
    provider.getRecipeCategory();
    recipeList = provider.throwRecipeList;
    //3rd
    provider.getDrinkCategory();
    drinkList = provider.throwDrinkList;
    // 4th
    provider.getPizzaCategory();
    pizzaList = provider.throwPizzaList;
    //////////////single food list/////////
    provider.getFoodList();
    singleFoodList = provider.throwFoodModleList;
    provider.getBurgerCategoriesList();
    burgerCategoriesList = provider.throwBurgerCategoriesList;
    provider.getrecipeCategoriesList();
    recipeCategoriesList = provider.throwRecipeCategoriesList;
    provider.getPizzaCategoriesList();
    pizzaCategoriesList = provider.throwPizzaCategoriesList;
    provider.getDrinkCategoriesList();
    drinkCategoriesList = provider.throwDrinkCategoriesList;

    //user data display in drawer

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
                        builder: (context) => const UserProfile(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_shopping_cart, color: Colors.white,),
                  title: const Text('Cart', style: TextStyle(fontSize: 20, color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shop, color: Colors.white,),
                  title: const Text('Order', style: TextStyle(fontSize: 20, color: Colors.white),),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MyOrders(),
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
      ),
      body:
      SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search Food",
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                burger(),
                recipe(),
                pizza(),
                drink(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 500,
            child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: singleFoodList
                    .map(
                      (e) => BottomContainer(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                image: e.image,
                                name: e.name,
                                price: e.price,
                              ),
                            ),
                          );
                        },
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    )
                    .toList()
                ),
          )
        ],
      ),
    ),
    );
  }
}
