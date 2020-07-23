import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override 
Widget build (BuildContext context){
  return new MaterialApp(
    home: HomePage(),
  );
}
}

class HomePage extends StatefulWidget{
  @override 
_HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{

final String url = "https://swapi.dev/api/people";
List data;


  Future<String> getJsonData() async{
    var response = await http.get(
      //encode the url
      Uri.encodeFull(url),
      //only accept json response
      headers: {"Accept" : "application/json"}
    );

 setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
    });
    return "success";
  }

 @override 
  void initState(){
    super.initState();
    this.getJsonData();
  }
  @override 
  Widget build (BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("retrive json via HTTP Get"),
      ),
body: new ListView.builder(
  itemCount:  data == null ? 0 : data.length,
  itemBuilder: (BuildContext context, int index){
    return new Container(
      child: Center(
          child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Card(
              child: new Container(
                child: new Text(data[index]['name']),
                padding: const EdgeInsets.all(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  },
),
   );
 } 
}