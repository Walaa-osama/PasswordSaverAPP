import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key, required this.addItem});

  final addItem;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
              controller: passController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              )),
        ),
        Container(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  widget.addItem(emailController.text, passController.text);
                  Navigator.of(context).pop();
                },
                child: Text('Submit')))
      ],
    );
  }
}
