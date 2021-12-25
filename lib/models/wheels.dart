import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import 'wheel.dart';

class Wheels with ChangeNotifier {
  List<Wheel> _tires = [];

  List<Wheel> get tires {
    return [..._tires];
  }

  Future<void> updateWheel(
      {required int number,
      required String tireSize,
      required String treadType,
      required String treadWidth,
      required String patchNumbers,
      required String interlayer,
      required String client,
      required String warehouse,
      required String newTreadType,
      required String newTreadWidth,
      required String newTread,
      required String treadDefect,
      required String tireBrand,
      required String tireSizeLength}) async {
    String datetime = tires[number].dateTime;
    _tires.removeAt(number);
    Wheel wheel = Wheel(
        number: number,
        dateTime: datetime,
        tireSize: tireSize,
        treadType: treadType,
        treadWidth: treadWidth,
        patchNumbers: patchNumbers,
        interlayer: interlayer,
        client: client,
        warehouse: warehouse,
        newTreadType: newTreadType,
        newTreadWidth: newTreadWidth,
        newTread: newTread,
        treadDefect: treadDefect,
        tireBrand: tireBrand,
        tireSizeLength: tireSizeLength);

    _tires.insert(number, wheel);
    notifyListeners();
  }

  int i = 0;
  int j = 0;

  int checkSameValuesInARow(int currentIndex) {
    int foo = 0;
    if (currentIndex == 0) return 0;
    if (currentIndex == 1) return 1;
    for (j = currentIndex - 1; j >= 0; j--) {
      if (_tires[currentIndex].tireSize == _tires[j].tireSize &&
          _tires[currentIndex].treadType == _tires[j].treadType &&
          _tires[currentIndex].treadWidth == _tires[j].treadWidth &&
          _tires[currentIndex].client == _tires[j].client) {
        foo += 1;
      } else {
        return foo;
      }
    }
    return foo;
  }

  Future<void> addWheel(
      {required int number,
      required String tireSize,
      required String treadType,
      required String treadWidth,
      required String patchNumbers,
      required String interlayer,
      required String client,
      required String warehouse,
      required String newTreadType,
      required String newTreadWidth,
      required String newTread,
      required String treadDefect,
      required String tireBrand,
      required String tireSizeLength}) async {
    Wheel wheel = Wheel(
        number: number,
        dateTime:
            DateFormat('H:mm dd.MM.yyyy').format(DateTime.now()).toString(),
        tireSize: tireSize,
        treadType: treadType,
        treadWidth: treadWidth,
        patchNumbers: patchNumbers,
        interlayer: interlayer,
        client: client,
        warehouse: warehouse,
        newTreadType: newTreadType,
        newTreadWidth: newTreadWidth,
        newTread: newTread,
        treadDefect: treadDefect,
        tireBrand: tireBrand,
        tireSizeLength: tireSizeLength);
    _tires.add(wheel);
    notifyListeners();
  }

  Future<void> deleteWheel() async {
    _tires.remove(_tires.last);
    notifyListeners();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url = Uri.parse(
        'https://shopappflutter-b82e6-default-rtdb.europe-west1.firebasedatabase.app/tires.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Wheel> tire = [];
      extractedData.forEach((prodId, prodData) {
        tire.add(Wheel(
            id: prodId,
            dateTime: prodData['dateTime'],
            tireSize: prodData['tireSize'],
            treadType: prodData['threadType'],
            treadWidth: prodData['threadWidth'],
            tireBrand: prodData['tireBrand'],
            client: prodData['client'],
            patchNumbers: prodData['patchNumbers'],
            newTreadType: prodData['newThreadType'],
            newTreadWidth: prodData['newThreadWidth']));
      });
      _tires = tire;
    } catch (error) {
      rethrow;
    }
  }
}
