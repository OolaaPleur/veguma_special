import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:veguma_special/models/custom_picker.dart';
import 'package:veguma_special/models/repository.dart';
import 'package:veguma_special/models/wheel.dart';
import 'package:veguma_special/models/wheels.dart';

enum Indexes {
  tireSize,
  treadType,
  treadWidth,
  patchNumbers,
  interlayer,
  client,
  warehouse,
  newTreadType,
  newTreadWidth,
  newTread,
  treadDefect,
  tireBrand,
  tireSizeLength,
  treadDate,
  mixtureNumber,
  hardness,
}

class NewTireWidget extends StatefulWidget {
  final Wheel wheel;

  const NewTireWidget({Key? key, required this.wheel}) : super(key: key);

  @override
  _NewTireWidgetState createState() => _NewTireWidgetState();
}

class _NewTireWidgetState extends State<NewTireWidget> {
  @override
  void initState() {
    _treadType = List.from(_treadType)..addAll(repo.getTreadType());
    _newTreadType = List.from(_newTreadType)..addAll(repo.getTreadType());

    _treadWidth = List.from(_treadWidth)
      ..addAll(repo.getTreadWidthByType(widget.wheel.treadType));
    _newTreadWidth = List.from(_newTreadWidth)
      ..addAll(repo.getTreadWidthByType(widget.wheel.newTreadType));

    _selectedTreadType = widget.wheel.treadType;
    _selectedTreadWidth = widget.wheel.treadWidth;

    _selectedNewTreadType = widget.wheel.newTreadType;
    _selectedNewTreadWidth = widget.wheel.newTreadWidth;

    if (_treadWidth.length == 2) {
      _selectedTreadWidth = _treadWidth.last;
    }

    if (_newTreadWidth.length == 2) {
      _selectedNewTreadWidth = _newTreadWidth.last;
    }

    dropdownValues = [
      widget.wheel.tireSize,
      widget.wheel.treadType,
      widget.wheel.treadWidth,
      widget.wheel.patchNumbers,
      widget.wheel.interlayer,
      widget.wheel.client,
      widget.wheel.warehouse,
      widget.wheel.newTreadType,
      //new tread type
      widget.wheel.newTreadWidth,
      //new tread width
      widget.wheel.newTread,
      widget.wheel.treadDefect,
      widget.wheel.tireBrand,
      widget.wheel.tireSizeLength,
      widget.wheel.treadDate,
      widget.wheel.mixtureNumber,
      widget.wheel.hardness,
    ]; // dropdown values, starting from 0
    print(dropdownValues);

    _tireSizeLengthController.text = widget.wheel.tireSizeLength;
    _clientController.text = widget.wheel.client;
    _tireBrandController.text = widget.wheel.tireBrand;

    _mixtureNumberController.text = widget.wheel.mixtureNumber;
    _hardnessController.text = widget.wheel.hardness;
    isCheckedNewTread = widget.wheel.newTread;
    isCheckedTradeDefect = widget.wheel.treadDefect;
    setState(() {});

    super.initState();
  }

  late bool isCheckedNewTread;
  late bool isCheckedTradeDefect;

  List<dynamic> dropdownValues = [];

  List<String> tireSize = [
    tr('tireSize'),
    '315/70',
    '315/80',
    '295/80',
    '315/60'
  ];
  List<String> client = ['Ladu', 'Ladu II', 'Уценка', 'Gold'];
  List<String> warehouse = [tr('warehouse'), 'C', 'У', 'К'];
  List<String> tireBrand = ['Michelin', 'Pirelli', 'Sailun'];

  final _tireSizeLengthController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _tireBrandController = TextEditingController();

  final TextEditingController _mixtureNumberController =
      TextEditingController();
  final TextEditingController _hardnessController = TextEditingController();

  Repository repo = Repository();
  List<String> _treadType = [tr('treadType')];
  List<String> _newTreadType = [tr('treadType')];

  List<String> _treadWidth = [tr('treadWidth')];
  List<String> _newTreadWidth = [tr('treadWidth')];

  String _selectedTreadType = '';
  String _selectedTreadWidth = '';
  String _selectedNewTreadType = '';
  String _selectedNewTreadWidth = '';

  int patchCount = 0;

  DateTime lastPickedDate = DateTime.now();

  void length() {
    if (dropdownValues[Indexes.tireSize.index] == '315/70') {
      _tireSizeLengthController.text = '310';
    }
    if (dropdownValues[Indexes.tireSize.index] == '315/80') {
      _tireSizeLengthController.text = '326';
    }
    if (dropdownValues[Indexes.tireSize.index] == '295/80') {
      _tireSizeLengthController.text = '321';
    }
    if (dropdownValues[Indexes.tireSize.index] == '315/60') {
      _tireSizeLengthController.text = '291';
    }
  }

  void saveTextFieldValues() {
    dropdownValues[Indexes.tireBrand.index] = _tireBrandController.text;
    dropdownValues[Indexes.client.index] = _clientController.text;
    dropdownValues[Indexes.tireSizeLength.index] =
        _tireSizeLengthController.text;
    dropdownValues[Indexes.mixtureNumber.index] = _mixtureNumberController.text;
    dropdownValues[Indexes.hardness.index] = _hardnessController.text;
  }

  void updateValues() {
    Provider.of<Wheels>(context, listen: false).updateWheel(
        number: widget.wheel.number,
        tireSize: dropdownValues[Indexes.tireSize.index],
        treadType: dropdownValues[Indexes.treadType.index],
        treadWidth: dropdownValues[Indexes.treadWidth.index],
        patchNumbers: dropdownValues[Indexes.patchNumbers.index],
        interlayer: dropdownValues[Indexes.interlayer.index],
        client: dropdownValues[Indexes.client.index],
        warehouse: dropdownValues[Indexes.warehouse.index],
        newTreadType: dropdownValues[Indexes.newTreadType.index],
        newTreadWidth: dropdownValues[Indexes.newTreadWidth.index],
        newTread: dropdownValues[Indexes.newTread.index],
        treadDefect: dropdownValues[Indexes.treadDefect.index],
        tireBrand: dropdownValues[Indexes.tireBrand.index],
        tireSizeLength: dropdownValues[Indexes.tireSizeLength.index],
        treadDate: dropdownValues[Indexes.treadDate.index],
        mixtureNumber: dropdownValues[Indexes.mixtureNumber.index],
        hardness: dropdownValues[Indexes.hardness.index]);
  }

  void treadDateUpdating(DateTime date) {
    lastPickedDate = date;
    String? month =
        toBeginningOfSentenceCase(DateFormat.LLLL('ru').format(date));
    String? year = toBeginningOfSentenceCase(DateFormat.y('ru').format(date));
    dropdownValues[Indexes.treadDate.index] = '$month $year';
    updateValues();
  }

  bool checkDropdownValuesEqualsWheelValues = false;

  void checkDropdownValuesEqualsWheelValuesFunction() {
    setState(() {
      Wheel wheel = Provider.of<Wheels>(context, listen: false)
          .tires[widget.wheel.number];
      if (wheel.tireSize == dropdownValues[Indexes.tireSize.index] &&
          wheel.treadType == dropdownValues[Indexes.treadType.index] &&
          wheel.treadWidth == dropdownValues[Indexes.treadWidth.index] &&
          wheel.patchNumbers == dropdownValues[Indexes.patchNumbers.index] &&
          wheel.interlayer == dropdownValues[Indexes.interlayer.index] &&
          wheel.client == dropdownValues[Indexes.client.index] &&
          wheel.warehouse == dropdownValues[Indexes.warehouse.index] &&
          wheel.newTreadType == dropdownValues[Indexes.newTreadType.index] &&
          wheel.newTreadWidth == dropdownValues[Indexes.newTreadWidth.index] &&
          wheel.newTread == dropdownValues[Indexes.newTread.index] &&
          wheel.treadDefect == dropdownValues[Indexes.treadDefect.index] &&
          wheel.tireBrand == dropdownValues[Indexes.tireBrand.index] &&
          wheel.tireSizeLength ==
              dropdownValues[Indexes.tireSizeLength.index] &&
          wheel.treadDate == dropdownValues[Indexes.treadDate.index] &&
          wheel.mixtureNumber == dropdownValues[Indexes.mixtureNumber.index] &&
          wheel.hardness == dropdownValues[Indexes.hardness.index]) {
        print('true');
        checkDropdownValuesEqualsWheelValues = true;
        return;
      }
      print('false');
      checkDropdownValuesEqualsWheelValues = false;
    });
  }

  checkIfValueEqualsToLocallySaved(String value, int index) {
    setState(() {
      if (value != dropdownValues[index]) {
        checkDropdownValuesEqualsWheelValues = false;
      } else {
        checkDropdownValuesEqualsWheelValues = true;
      }
    });
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' №' + (widget.wheel.number + 1).toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Provider.of<Wheels>(context, listen: false)
                          .tires[widget.wheel.number]
                          .dateTime),
                    ),
                  ],
                ),
                tireSizePadding(),
                tireSizeLengthSizedBox(mediaQuery),
                treadTypePadding(),
                treadWidthPadding(),
                _decrementButton(mediaQuery),
                Text(
                  '$patchCount',
                  style: const TextStyle(fontSize: 18.0),
                ),
                _incrementButton(mediaQuery),
                interlayerPadding(),
                warehousePadding(),
                clientPadding(mediaQuery),
                tireBrandPadding(mediaQuery),
                newTreadCheckbox(),
                isCheckedNewTread ? newTreadRow() : const SizedBox.shrink(),
                treadDefect(),
                treadDateButton(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: mediaQuery.size.width * 0.3,
                      child: TextField(
                          controller: _mixtureNumberController,
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            saveTextFieldValues();
                            checkDropdownValuesEqualsWheelValuesFunction();
                          },
                          onChanged: (value) {
                            setState(() {
                              checkIfValueEqualsToLocallySaved(
                                  value, Indexes.mixtureNumber.index);
                            });
                          },
                          decoration:
                              InputDecoration(labelText: tr('mixtureNumber')))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: mediaQuery.size.width * 0.3,
                    child: TextField(
                      controller: _hardnessController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: tr('hardness'),
                      ),
                      onSubmitted: (value) {
                        saveTextFieldValues();
                        checkDropdownValuesEqualsWheelValuesFunction();
                      },
                      onChanged: (value) {
                        checkIfValueEqualsToLocallySaved(
                            value, Indexes.hardness.index);
                      },
                    ),
                  ),
                ),
                oneMoreSaveAndDeleteButtons(context, mediaQuery),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Provider.of<Wheels>(context)
                                .checkSameValuesInARow(widget.wheel.number) ==
                            0
                        ? const SizedBox.shrink()
                        : Container(
                            color: const Color(0xFF42A5F5),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${tr('sameWheelsInARow')}: ${Provider.of<Wheels>(context).checkSameValuesInARow(widget.wheel.number) + 1}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding tireSizePadding() {
    return Padding(
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
            checkDropdownValuesEqualsWheelValuesFunction();
          });
        },
        items: tireSize.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  SizedBox tireSizeLengthSizedBox(MediaQueryData mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width * 0.3,
      child: TextField(
        decoration: InputDecoration(labelText: tr('length')),
        controller: _tireSizeLengthController,
        onSubmitted: (value) {
          saveTextFieldValues();
          checkDropdownValuesEqualsWheelValuesFunction();
        },
        onChanged: (value) {
          setState(() {
            checkIfValueEqualsToLocallySaved(
                value, Indexes.tireSizeLength.index);
          });
        },
      ),
    );
  }

  Padding treadTypePadding() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        items: _treadType.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedTreadWidth = tr('treadWidth');
            _treadWidth = [tr('treadWidth')];
            _selectedTreadType = value!;
            _treadWidth = List.from(_treadWidth)
              ..addAll(repo.getTreadWidthByType(value));
            if (_treadWidth.length == 2) {
              _selectedTreadWidth = _treadWidth.last;
              dropdownValues[Indexes.treadType.index] = _selectedTreadType;
              dropdownValues[Indexes.treadWidth.index] = _selectedTreadWidth;
              return;
            }
            dropdownValues[Indexes.treadType.index] = _selectedTreadType;
            dropdownValues[Indexes.treadWidth.index] = _selectedTreadWidth;
            checkDropdownValuesEqualsWheelValuesFunction();
          });
        },
        value: _selectedTreadType,
      ),
    );
  }

  Padding treadWidthPadding() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        items: _treadWidth.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedTreadWidth = value!;
            dropdownValues[Indexes.treadWidth.index] = value;
            checkDropdownValuesEqualsWheelValuesFunction();
          });
        },
        value: _selectedTreadWidth,
      ),
    );
  }

  Widget _decrementButton(mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width * 0.15,
      child: FloatingActionButton(
          onPressed: () {
            setState(() {
              patchCount--;
              dropdownValues[Indexes.patchNumbers.index] =
                  patchCount.toString();
            });
            checkDropdownValuesEqualsWheelValuesFunction();
          },
          child: const Icon(Icons.remove, color: Colors.black),
          backgroundColor: Colors.white),
    );
  }

  Widget _incrementButton(mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width * 0.15,
      child: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            patchCount++;
            dropdownValues[Indexes.patchNumbers.index] = patchCount.toString();
          });
          checkDropdownValuesEqualsWheelValuesFunction();
        },
      ),
    );
  }

  Padding interlayerPadding() {
    return Padding(
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
          checkDropdownValuesEqualsWheelValuesFunction();
        },
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem(
            child: Text(
              tr('green'),
              style: const TextStyle(color: Colors.green),
            ),
            value: tr('green'),
          ),
          DropdownMenuItem(
            value: tr('white'),
            child: Text(
              tr('white'),
              style: const TextStyle(color: Colors.black26),
            ),
          ),
          DropdownMenuItem(
            value: tr('interlayer'),
            child: Text(tr('interlayer')),
          ),
        ],
      ),
    );
  }

  Padding warehousePadding() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: dropdownValues.elementAt(Indexes.warehouse.index),
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
            dropdownValues[Indexes.warehouse.index] = newValue!;
            if (newValue == warehouse[2]) {
              _clientController.text = client[2];
            }
            if (newValue == warehouse[1]) {
              _clientController.text = client[0];
            }
          }
          );
          checkDropdownValuesEqualsWheelValuesFunction();
        },
        items: warehouse.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Padding clientPadding(MediaQueryData mediaQuery) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: mediaQuery.size.width * 0.3,
        child: TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            onSubmitted: (value) {
              saveTextFieldValues();
              checkDropdownValuesEqualsWheelValuesFunction();
            },
            controller: _clientController,
            decoration: InputDecoration(labelText: tr('client')),
          ),
          suggestionsCallback: (pattern) {
            return client;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.toString()),
            );
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: (suggestion) {
            _clientController.text = suggestion.toString();
            saveTextFieldValues();
            checkDropdownValuesEqualsWheelValuesFunction();
          },
        ),
      ),
    );
  }

  Padding tireBrandPadding(MediaQueryData mediaQuery) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: mediaQuery.size.width * 0.3,
        child: TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (value) {
                saveTextFieldValues();
                checkDropdownValuesEqualsWheelValuesFunction();
              },
              controller: _tireBrandController,
              decoration: InputDecoration(labelText: tr('tireBrand'))),
          suggestionsCallback: (pattern) {
            return tireBrand;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.toString()),
            );
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: (suggestion) {
            _tireBrandController.text = suggestion.toString();
            saveTextFieldValues();
            checkDropdownValuesEqualsWheelValuesFunction();
          },
        ),
      ),
    );
  }

  Row newTreadCheckbox() {
    return Row(
      children: [
        Text(tr('newTread')),
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.red,
          side: const BorderSide(color: Colors.red, width: 2),
          value: isCheckedNewTread,
          onChanged: (bool? value) {
            setState(() {
              print(_newTreadType);
              print(_newTreadWidth);
              isCheckedNewTread = value!;
              if (dropdownValues[Indexes.newTread.index] == false) {
                dropdownValues[Indexes.newTread.index] = true;
              } else if (dropdownValues[Indexes.newTread.index] == true) {
                dropdownValues[Indexes.newTread.index] = false;
              }
              checkDropdownValuesEqualsWheelValuesFunction();
            });
          },
        ),
      ],
    );
  }

  Row newTreadRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: _newTreadType.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedNewTreadWidth = tr('treadWidth');
                _newTreadWidth = [tr('treadWidth')];
                _selectedNewTreadType = value!;
                _newTreadWidth = List.from(_newTreadWidth)
                  ..addAll(repo.getTreadWidthByType(value));
                if (_newTreadWidth.length == 2) {
                  _selectedNewTreadWidth = _newTreadWidth.last;
                  dropdownValues[Indexes.newTreadType.index] =
                      _selectedNewTreadType;
                  dropdownValues[Indexes.newTreadWidth.index] =
                      _selectedNewTreadWidth;
                  return;
                }
                dropdownValues[Indexes.newTreadType.index] = value;
                checkDropdownValuesEqualsWheelValuesFunction();
              });
            },
            value: _selectedNewTreadType,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: _newTreadWidth.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedNewTreadWidth = value!;
                dropdownValues[Indexes.newTreadWidth.index] = value;
              });
              print(dropdownValues[Indexes.newTreadWidth.index]);
              print(value);
              checkDropdownValuesEqualsWheelValuesFunction();
            },
            value: _selectedNewTreadWidth,
          ),
        ),
      ],
    );
  }

  Row treadDefect() {
    return Row(
      children: [
        Text(tr('treadDefect')),
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.red,
          side: const BorderSide(color: Colors.red, width: 2),
          value: isCheckedTradeDefect,
          onChanged: (bool? value) {
            setState(() {
              isCheckedTradeDefect = value!;
            });
            if (dropdownValues[Indexes.treadDefect.index] == false) {
              dropdownValues[Indexes.treadDefect.index] = true;
            } else if (dropdownValues[Indexes.treadDefect.index] == true) {
              dropdownValues[Indexes.treadDefect.index] = false;
            }
            checkDropdownValuesEqualsWheelValuesFunction();
          },
        ),
      ],
    );
  }

  Row oneMoreSaveAndDeleteButtons(
      BuildContext context, MediaQueryData mediaQuery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget.wheel.number + 1 ==
                Provider.of<Wheels>(context, listen: false).tires.length
            ? ElevatedButton(
                onPressed: checkDropdownValuesEqualsWheelValues
                    ? () {
                        saveTextFieldValues();
                        Provider.of<Wheels>(context, listen: false).addWheel(
                            number: Provider.of<Wheels>(context, listen: false)
                                .tires
                                .length,
                            tireSize: dropdownValues[Indexes.tireSize.index],
                            treadType: dropdownValues[Indexes.treadType.index],
                            treadWidth:
                                dropdownValues[Indexes.treadWidth.index],
                            patchNumbers:
                                dropdownValues[Indexes.patchNumbers.index],
                            interlayer:
                                dropdownValues[Indexes.interlayer.index],
                            client: dropdownValues[Indexes.client.index],
                            warehouse: dropdownValues[Indexes.warehouse.index],
                            newTreadType:
                                dropdownValues[Indexes.newTreadType.index],
                            newTreadWidth:
                                dropdownValues[Indexes.newTreadWidth.index],
                            newTread: dropdownValues[Indexes.newTread.index],
                            treadDefect:
                                dropdownValues[Indexes.treadDefect.index],
                            tireBrand: dropdownValues[Indexes.tireBrand.index],
                            tireSizeLength:
                                dropdownValues[Indexes.tireSizeLength.index],
                            treadDate: dropdownValues[Indexes.treadDate.index],
                            mixtureNumber:
                                dropdownValues[Indexes.mixtureNumber.index],
                            hardness: dropdownValues[Indexes.hardness.index]);
                      }
                    : null,
                child: Text(tr("oneMore")))
            : const SizedBox.shrink(),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: checkDropdownValuesEqualsWheelValues
                    ? MaterialStateProperty.all(Colors.green)
                    : MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              saveTextFieldValues();
              print(dropdownValues);
              updateValues();
              checkDropdownValuesEqualsWheelValues = true;
            },
            child: const Icon(Icons.save)),
        widget.wheel.number + 1 ==
                Provider.of<Wheels>(context, listen: false).tires.length
            ? ElevatedButton(
                onPressed: () {
                  Provider.of<Wheels>(context, listen: false).deleteWheel();
                },
                child: Icon(
                  Icons.delete,
                  size: mediaQuery.size.height * 0.04,
                ),
              )
            : const SizedBox.shrink(),
        Tooltip(
          padding: const EdgeInsets.all(10.0),
          message: tr('hintAboutSameWheels'),
          child: Text(tr('hint')),
          showDuration: const Duration(seconds: 6),
          triggerMode: TooltipTriggerMode.tap,
        ),
      ],
    );
  }

  TextButton treadDateButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          DatePicker.showPicker(
            context,
            showTitleActions: true,
            pickerModel: CustomMonthPicker(
              minTime: DateTime(2015, 1, 1),
              maxTime: DateTime.now(),
              currentTime: lastPickedDate == DateTime.now()
                  ? DateTime.now()
                  : lastPickedDate,
              locale: LocaleType.ru,
            ),
            onChanged: (date) {
              treadDateUpdating(date);
            },
            onConfirm: (date) {
              treadDateUpdating(date);
            },
          );
        },
        child: dropdownValues[Indexes.treadDate.index] == ''
            ? Text(
                tr('treadDate'),
                style: const TextStyle(color: Colors.blue),
              )
            : Text(
                '${tr('treadDate')}: ${dropdownValues[Indexes.treadDate.index]}'));
  }
}
