import 'package:flutter/material.dart';

class TextFieldExampleState extends StatefulWidget {
  const TextFieldExampleState({super.key});

  @override
  State<TextFieldExampleState> createState() => _TextFieldExampleStateState();
}

class _TextFieldExampleStateState extends State<TextFieldExampleState> {
  bool textField1Selected = false;
  bool textField2Selected = false;
  bool textField3Selected = false;
  bool textField4Selected = false;
  bool textField5Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField Örneği'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: textField1Selected ? 200 : 300,
              height: 50,
              duration: Duration(milliseconds: 200),
              child: TextField(
                onTap: () {
                  setState(() {
                    textField1Selected = false;
                    textField2Selected = true;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'TextField 1',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              width: textField2Selected ? 200 : 300,
              height: 50,
              duration: Duration(milliseconds: 200),
              child: TextField(
                onTap: () {
                  setState(() {
                    textField1Selected = true;
                    textField2Selected = false;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'TextField 2',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
