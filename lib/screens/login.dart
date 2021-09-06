import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:waldrop/custom_widget/local.dart';
import 'package:waldrop/screens/home.dart';
import 'package:waldrop/survices/auth.dart';
import 'package:waldrop/custom_widget/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);



  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void checkLoginStatus()async{
    final FirebaseAuth auth= FirebaseAuth.instance;
    final user= await auth.currentUser;
    if(user!=null){
      constant.name= (await LocalData.getName())!;
      constant.email= (await LocalData.geEmail())!;
      constant.image= (await LocalData.geImg())!;
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
    }
  }
  void initstate(){
    checkLoginStatus();
  }
  signInMethod(context) async{
    await signInWithGoogle();
    constant.name= (await LocalData.getName())!;
    constant.email= (await LocalData.geEmail())!;
    constant.image= (await LocalData.geImg())!;
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 60),
                height: 150,
                child: Text('Wall Drop',style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
              Expanded(child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('images/w.png',),

                  SignInButton(Buttons.GoogleDark, onPressed:(){
                    signInMethod(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  }),

            ],
          ),
        ),
      ),
    ),
      ],
    ),
    ),
      ),
    );
  }
}
