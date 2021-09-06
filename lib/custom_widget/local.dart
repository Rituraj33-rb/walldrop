import 'package:shared_preferences/shared_preferences.dart';
class LocalData{
  static String namekey="NAMEKEY";
  static String emailkey="EMAILKEY";
  static String imagekey="IMAGEKEY";
  static String logkey="LOGKEY";

  
  static Future<bool> saveName(String username)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.setString(namekey,username);
  }

  static Future<bool> saveEmail(String useremail)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.setString(emailkey,useremail);
  }
  static Future<bool> saveImg(String userImg)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.setString(imagekey,userImg);
  }
  static Future<String?> getName()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.getString(namekey);
  }
  static Future<String?> geEmail()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.getString(emailkey);
  }
  static Future<String?> geImg()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.getString(imagekey);
  }
  static Future<bool> savelog(bool isUserLogin) async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.setBool(logkey, isUserLogin);
  }

  static Future<bool?>getLogData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.getBool(logkey);
  }
}

