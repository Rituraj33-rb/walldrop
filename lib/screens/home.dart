import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waldrop/custom_widget/coustom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:waldrop/custom_widget/info.dart';
import 'package:waldrop/screens/fullscreen.dart';
import 'package:waldrop/screens/login.dart';
import 'package:waldrop/screens/search.dart';
import 'package:waldrop/survices/auth.dart';


class Home extends StatefulWidget {




  @override
  _State createState() => _State();
}

class _State extends State<Home> {


  List images = [];
  int page = 1;

  // get index => null;
  // get imageurl=>null;


  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization': '563492ad6f91700001000001c53c6d1988a541319731bb2c7138e3dd'
        }).then((value) {
      print(value.body);
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }

  lode() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' +
        page.toString();
    await http.get(Uri.parse(url),
        headers: {
          'Authorization': '563492ad6f91700001000001c53c6d1988a541319731bb2c7138e3dd'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  Future<bool> _onBackPress() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Do you want to exit '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: _onBackPress,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: appName(),
          ),
          drawer: Info(),
          body:
          Column(
            children: [

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: GridView.builder(
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreen(
                                            imageurl: images[index]['src']['large2x'],
                                          )));
                            },
                            child: Container(color: Colors.black,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                      images[index]['src']['tiny'],
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  lode();
                },
                child: Container(
                  color: Colors.black,
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Show More',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

}