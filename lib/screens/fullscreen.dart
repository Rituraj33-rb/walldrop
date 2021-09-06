import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';


class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({ Key? key,  required this.imageurl}) : super(key: key);
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey();
  Future<void> _showSnackBar(String text) async {
    scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          backgroundColor:  Theme.of(context).brightness==Brightness.dark?Colors.black54:Colors.white.withOpacity(0.8),
          margin: EdgeInsets.all(30.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          elevation: 0.5,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          content: Center(
            heightFactor: 0.9,
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).brightness!=Brightness.dark?Colors.red:Colors.white,
                  fontSize: 16
              ),
            ),
          ),
        )
    );
  }
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    final bool result =
    await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
    Navigator.of(context).pop();
    var showSnackBar = _showSnackBar('Wallpaper set Successfully');
  }
  _save() async {
    var status= await Permission.storage.request();
    if(status.isGranted) {
      var response = await Dio().get(
          widget.imageurl,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          // quality: 60,
          // name: "hello"
          );
      print(result);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Image.network(widget.imageurl),
                ),
              ),

              // Center(
              //   child: ElevatedButton(onPressed: (){
              //          setwallpaper();
              //   }, child:Text('set wallpaper')),
              // ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(onPressed: (){
                     _save();
                   }
                   , child: Icon(Icons.file_download)
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(onPressed: (){
                     setwallpaper();
                   }
                       , child: Text('Set Wallpaper')
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(onPressed: (){
                       Share.share(widget.imageurl);
                   }
                       , child: Icon(Icons.share),
                   ),
                 ),
               ],
             )
            ],
          )),
    );
  }
}