import 'package:flutter/material.dart';

class NewTireWidget extends StatefulWidget {
  const NewTireWidget({Key? key}) : super(key: key);

  @override
  _NewTireWidgetState createState() => _NewTireWidgetState();
}

class _NewTireWidgetState extends State<NewTireWidget> {
  String tireSize = '';
  String threadType = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Row(
              children: [
                const Text(' Tire Size '),
                DropdownButton<String>(
                  value: tireSize,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      tireSize = newValue!;
                    });
                  },
                  items: <String>['', '315/70', '315/80', '295/80']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Text(' Tire Type '),
                DropdownButton<String>(
                  value: threadType,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      threadType = newValue!;
                    });
                  },
                  items: <String>['', 'RDE', 'RDF', 'RDW']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
