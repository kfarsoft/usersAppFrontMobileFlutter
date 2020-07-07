import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;

  getUsers() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/users');
    data = json.decode(response.body);
    setState(() {
      userData = data['users'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Card(
          child: Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(12), child: Text("$index")),
              CircleAvatar(
                backgroundImage: NetworkImage(userData[index]['avatar']),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    '${userData[index]['firstName']} ${userData[index]['lastName']}'),
              )
            ],
          ),
        ),
        itemCount: userData != null ? userData.length : 0,
      ),
    );
  }
}
