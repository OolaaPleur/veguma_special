import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTireWidget extends StatefulWidget {
  const NewTireWidget({Key? key, this.indexNumber = 0}) : super(key: key);
  final int indexNumber;

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
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(' №' + widget.indexNumber.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    hint: Text(AppLocalizations.of(context)!.tireSize),
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
                    items: <String>[
                      AppLocalizations.of(context)!.tireSize,
                      '315/70',
                      '315/80',
                      '295/80'
                    ].map<DropdownMenuItem<String>>((String value) {
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
                    hint: Text(AppLocalizations.of(context)!.treadType),
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
                    items: <String>[
                      AppLocalizations.of(context)!.treadType,
                      'RDE',
                      'RDF',
                      'RDW'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
