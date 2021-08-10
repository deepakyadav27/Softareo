import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/services/Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> itemList = [];
  List<String> itemId = [];
  List<bool> editPressed = [];

  List<TextEditingController> _controllers = [];

  var _controller = TextEditingController();
  @override
  // void initState() {
  //   Services().fetchData().then(
  //     (value) {
  //       value.docs.forEach((element) {
  //         setState(() {
  //           itemList.add(element['description']);
  //           itemId.add(element.id);
  //           _controllers.add(
  //             new TextEditingController(text: element['description']),
  //           );
  //           editPressed.add(false);
  //         });
  //       });
  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ToDo').snapshots(),
        builder: (context, snapshot) {
          itemList = [];
          itemId = [];
          _controllers = [];
          editPressed = [];
          snapshot.data!.docs.forEach((element) {
            // setState(() {
            itemList.add(element['description']);
            itemId.add(element.id);
            _controllers.add(
              new TextEditingController(text: element['description']),
            );
            editPressed.add(false);
            log(editPressed.toString());
          });
          // });
          return Scaffold(
            backgroundColor: Color(0xffEBEBEB),
            appBar: AppBar(
              title: Text(
                "TO DO App",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Color(0xffEBEBEB),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          margin: EdgeInsets.only(left: 16, right: 5),
                          elevation: 3.0,
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: InputBorder.none,
                              hintText: "Type Something here",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            if (_controller.text.isNotEmpty) {
                              Services().addData(_controller.text);
                              _controller.clear();
                            }
                          },
                          child: Icon(
                            Icons.add_circle_rounded,
                            size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        color: Color(0xFFFBFBFB),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 3.0,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_controllers[index].text.isNotEmpty) {
                                  Services().updateData(
                                      _controllers[index].text, itemId[index]);
                                  setState(() {
                                    editPressed[index] = false;
                                  });
                                  print(editPressed[index]);
                                }
                              },
                              icon: Icon(Icons.done_outlined),
                            ),
                            // editPressed
                            Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: TextFormField(
                                    maxLines: null,
                                    controller: _controllers[index],
                                    enabled: editPressed[index],
                                  ),
                                ),
                              ),
                            ),
                            // : Text(itemList[index]),
                            Container(
                              padding: EdgeInsets.only(left: 2),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    editPressed[index] = true;
                                  });
                                  print(editPressed[index]);
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: IconButton(
                                onPressed: () {
                                  Services().deleteData(itemId[index]);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
