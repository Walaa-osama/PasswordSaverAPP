import 'package:flutter/material.dart';
import 'package:password_saver/data.dart';
import 'package:password_saver/databases/database_helper.dart';
import 'package:password_saver/widgets/list_item.dart';
import 'package:password_saver/widgets/my_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<void> fetch;

  @override
  void initState() {
    fetch = fetchAndSetData();
    print('hi from initstate');
    // TODO: implement initState
    super.initState();
  }

  void addItem(email, password) async {
    int id =
        await DbHelper.addToDb('Users', {'email': email, 'password': password});
    print('id is $id');
    setState(() {
      data.add({'email': email, 'password': password, 'id': id});
    });
  }

  Future<void> fetchAndSetData() async {
    // await Future.delayed(Duration(seconds: 10));
    List<dynamic> retrievedData = await DbHelper.getData('Users');

    data = [...retrievedData];
  }

  @override
  Widget build(BuildContext context) {
    print('hi from build');
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: fetch,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //if data is still loading
              return const SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Data is Loading...',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              );
            }

            return data.isEmpty
                ? Center(
                    child: Text(
                    'No passwords yet, start adding some 😊',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      //Dismissible is here
                      return ListItem(index: index);
                    },
                    itemCount: data.length,
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(height: 300, child: MyForm(addItem: addItem));
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
