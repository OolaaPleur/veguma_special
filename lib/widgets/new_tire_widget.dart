import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:veguma_special/models/wheels.dart';

enum Indexes { tireSize, treadType, treadWidth, interlayer }

class NewTireWidget extends StatefulWidget {
  const NewTireWidget({Key? key, this.indexNumber = 0}) : super(key: key);
  final int indexNumber;

  @override
  _NewTireWidgetState createState() => _NewTireWidgetState();
}

class _NewTireWidgetState extends State<NewTireWidget> {
  List<String> tireSize = [tr('tireSize'), '315/70', '315/80', '295/80'];
  List<String> treadType = [tr('treadType'), 'RDW', 'RDF', 'RDE'];
  List<String> treadWidth = [tr('treadWidth'), '230', '245', '260'];

  List<String> dropdownValues = [
    tr('tireSize'),
    tr('treadType'),
    tr('treadWidth'),
    tr('interlayer'),
  ]; // dropdown values, starting from 0
  var textController = TextEditingController();

  void length() {
    if (dropdownValues[Indexes.tireSize.index] == '315/70') {
      textController.text = '310';
    }
    if (dropdownValues[Indexes.tireSize.index] == '315/80') {
      textController.text = '326';
    }
    if (dropdownValues[Indexes.tireSize.index] == '295/80') {
      textController.text = '321';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(' №' + widget.indexNumber.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Provider.of<Wheels>(context, listen: false).tires[widget.indexNumber-1].dateTime.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownValues.elementAt(Indexes.tireSize.index),
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
                        dropdownValues[Indexes.tireSize.index] = newValue!;
                        length();
                      });
                    },
                    items:
                        tireSize.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.3,
                  child: TextField(
                    controller: textController,
                    // onChanged: (text) => {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownValues.elementAt(Indexes.treadType.index),
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
                        dropdownValues[Indexes.treadType.index] = newValue!;
                      });
                    },
                    items:
                        treadType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownValues.elementAt(Indexes.treadWidth.index),
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
                        dropdownValues[Indexes.treadWidth.index] = newValue!;
                      });
                    },
                    items: treadWidth
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownValues.elementAt(Indexes.interlayer.index),
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
                        dropdownValues[Indexes.interlayer.index] = newValue!;
                      });
                    },
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        child: Text(tr('green'), style: const TextStyle(color: Colors.green),),
                        value: tr('green'),
                      ),
                      DropdownMenuItem(
                        value: tr('white'),
                        child: Text(tr('white'), style: const TextStyle(color: Colors.black26),),
                      ),
                      DropdownMenuItem(
                        value: tr('interlayer'),
                        child: Text(tr('interlayer')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
