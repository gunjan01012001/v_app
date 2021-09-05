import 'package:flutter/material.dart';
import 'package:v_app/screens/homepage.dart';
import 'package:v_app/screens/introauthscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: NavigationPage(),

       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class NavigationPage extends StatefulWidget{
  @override
  NavigationPageState createState()=> NavigationPageState();
}
class NavigationPageState extends State<NavigationPage>{
  bool isSigned =false;
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null){
        setState(() {
        isSigned=true;
      });
    }else{
      setState((){
      isSigned=false;
    });
    }
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: isSigned==false? IntroAuthScreen():HomePage(),
    );
  }
}