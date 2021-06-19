

import 'package:flutter/material.dart';
import 'package:testapp/Models/user.dart';
import 'package:testapp/Services/api_Sevices.dart';

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
        primarySwatch: Colors.blue,
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
  ApiSevices apiSevices=ApiSevices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Users"),)),
      body: Center(
        child: FutureBuilder(
          future: apiSevices.GetData(),
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

//  Future<List<User>> GetData() async{
//    var response = await http.get("http://www.json-generator.com/api/json/get/bYKKPeXRcO?indent=2");
//    List<User> users = [];
//    if(response.statusCode == 200) {
//      var jsData = convert.jsonDecode(response.body);
//      users = (jsData as List).map((e) => User.fromJson(e)).toList();
//    }
//    return users;
//  }
}


