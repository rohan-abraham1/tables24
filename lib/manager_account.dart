import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerAccount extends StatefulWidget {
  @override
  _ManagerAccountState createState() => _ManagerAccountState();
}

class _ManagerAccountState extends State<ManagerAccount> {
  getMethod() async {
    String theUrl = 'https://tables-manager.000webhostapp.com/getdata.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Account Details"),
      ),
      body: FutureBuilder(
        future: getMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching Data"),
            );
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (context, index) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Name: ${snap[index]['name']}',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        Text('Login ID: ${snap[index]['id']}'),
                        Text('Restaurant ID: ${snap[index]['id']}'),
                        FlatButton(
                          child: Text('Logout'),
                          onPressed: (null),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
