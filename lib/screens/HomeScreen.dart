import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List itemList = [1, 3, 5];
  bool editPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "TO DO App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Type Something here",
                      fillColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  iconSize: 34,
                  onPressed: () {},
                  icon: Icon(Icons.add_circle_rounded),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.done_outlined),
                          ),
                          editPressed
                              ? Expanded(child: TextFormField())
                              : Text("something"),
                          Container(
                            padding: EdgeInsets.only(left: 127),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  editPressed = true;
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // child: ListTile(
                  //   leading: Icon(Icons.done_outlined),
                  //   title: Text(
                  //     "Something",
                  //   ),
                  //   trailing: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.edit),
                  // ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.delete),
                  // ),
                  //     ],
                  //   ),
                  // ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
