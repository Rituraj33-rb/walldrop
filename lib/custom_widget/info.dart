import 'package:flutter/material.dart';
import 'package:waldrop/custom_widget/constant.dart';
import 'package:waldrop/screens/login.dart';
import 'package:waldrop/screens/home.dart';
import 'package:waldrop/survices/auth.dart';
class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  SignoutMethod(context)async{
    await signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
  }

  @override
  Widget build(BuildContext context) {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: [
         UserAccountsDrawerHeader(accountName: Text(constant.name),
             accountEmail: Text(constant.email),
           currentAccountPicture: CircleAvatar(
             child: ClipOval(
               child: Image.network(constant.image,
               height: 90,
               width: 90,
               fit: BoxFit.cover,
               ),

             ),
           ),
           decoration: BoxDecoration(
             color: Colors.black,
             image: DecorationImage(
               image: NetworkImage(
                 'https://cdn57.androidauthority.net/wp-content/uploads/2015/11/00-best-backgrounds-and-wallpaper-apps-for-android-1000x562.jpg.webp'
               ),
               fit: BoxFit.cover,
             ),
           ),
         ),
         ListTile(
           leading:Icon(Icons.favorite),
           title: Text('Favorite'),
           onTap: ()=>null,
         ),
         ListTile(
           leading:Icon(Icons.help),
           title: Text('about'),
           onTap: ()=>null,
         ),
         ListTile(
           leading:Icon(Icons.exit_to_app),
           title: Text('Logout'),
           onTap: ()=>SignoutMethod(context),
         ),
       ],
     ),
   );
  }
}
