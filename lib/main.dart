import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/provider/my_provider.dart';
import 'package:foodapp/screen/welcome_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Food App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xDBDC8C10),
          appBarTheme: const AppBarTheme(
            color: Color(0xFFFF8737),
          ),
        ),
    home:const WelcomePage()
      ),
    );
  }
}
