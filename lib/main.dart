import 'package:flutter/material.dart';
import 'package:waldrop/custom_widget/local.dart';
import 'package:waldrop/screens/fullscreen.dart';
import 'package:waldrop/screens/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:waldrop/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin=false;

  getLogInStatus()async{
    await LocalData.getLogData().then((value){
      setState((){
        isLogin=value!;
      });
    });
  }

  @override
 void initstate(){
    super.initState();
    getLogInStatus();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wall drop',
      theme: ThemeData(

        // primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
       home:
      AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
            'images/spl.png'),

        nextScreen:isLogin?Home():Login(),
        splashIconSize: 300,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0x1F142C),

      ),
    );
  }
}

