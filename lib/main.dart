import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/Models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Users"),)),
      body: Center(
        child: FutureBuilder(
          future: _GetData(),
          builder: (context,snapshot)
          {
            if(!snapshot.hasData)
              {
                return Center(
                  child: Text("Loading......"),
                );
              }
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (context,index)
                {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          width: 2,
                          color: Colors.grey
                        ))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                snapshot.data[index].picture+snapshot.data[index].index.toString()+".jpg"
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(snapshot.data[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(snapshot.data[index].company,style: TextStyle(fontSize: 18)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(snapshot.data[index].email,style: TextStyle(fontSize: 18),),
                                )
                              ],
                            ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          },
        )
      ),
    );
  }

  Future<List<User>> _GetData() async{
    var response = await http.get("http://www.json-generator.com/api/json/get/bYKKPeXRcO?indent=2");
    List<User> users = [];
    if(response.statusCode == 200) {
      var jsData = convert.jsonDecode(response.body);

      for (var d in jsData) {
        User user=User(d["index"],d["about"],d["name"],d["picture"],d["company"],d["email"]);
        users.add(user);
      }
    }
    return users;
  }
}


