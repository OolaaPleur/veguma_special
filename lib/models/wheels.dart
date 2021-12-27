import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:veguma_special/models/secret.dart';

import 'wheel.dart';

class Wheels with ChangeNotifier {
  List<Wheel> _tires = [];

  List<Wheel> get tires {
    return [..._tires];
  }

  Future<void> updateWheel({
    required int number,
    required String tireSize,
    required String treadType,
    required String treadWidth,
    required String patchNumbers,
    required String interlayer,
    required String client,
    required String warehouse,
    required String newTreadType,
    required String newTreadWidth,
    required bool newTread,
    required bool treadDefect,
    required String tireBrand,
    required String tireSizeLength,
    required String treadDate,
    required String mixtureNumber,
    required String hardness,
  }) async {
    String todayFormattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    if (_tires[number].id == '') {
      final url = Uri.parse(
          '${Secret.LINK}$todayFormattedDate.json');
      try {
        print(tires[number].number);
        String datetime = tires[number].dateTime;
        _tires.removeAt(number);
        final response = await http.post(url,
            body: json.encode({
              'number': number,
              'dateTime': datetime,
              'tireSize': tireSize,
              'treadType': treadType,
              'treadWidth': treadWidth,
              'patchNumbers': patchNumbers,
              'interlayer': interlayer,
              'client': client,
              'warehouse': warehouse,
              'newTreadType': newTreadType,
              'newTreadWidth': newTreadWidth,
              'newTread': newTread,
              'treadDefect': treadDefect,
              'tireBrand': tireBrand,
              'tireSizeLength': tireSizeLength,
              'treadDate': treadDate,
              'mixtureNumber': mixtureNumber,
              'hardness': hardness
            }));
        final wheel = Wheel(
            id: json.decode(response.body)['name'],
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
            tireSizeLength: tireSizeLength,
            treadDate: treadDate,
            mixtureNumber: mixtureNumber,
            hardness: hardness);
        _tires.insert(number, wheel);
        print(tires[number].id);
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      final url = Uri.parse(
          '${Secret.LINK}$todayFormattedDate/${_tires[number].id}.json');
      try {
        print(tires[number].number);
        String datetime = tires[number].dateTime;
        String id = _tires[number].id;
        _tires.removeAt(number);
        final response = await http.patch(url,
            body: json.encode({
              'number': number,
              'dateTime': datetime,
              'tireSize': tireSize,
              'treadType': treadType,
              'treadWidth': treadWidth,
              'patchNumbers': patchNumbers,
              'interlayer': interlayer,
              'client': client,
              'warehouse': warehouse,
              'newTreadType': newTreadType,
              'newTreadWidth': newTreadWidth,
              'newTread': newTread,
              'treadDefect': treadDefect,
              'tireBrand': tireBrand,
              'tireSizeLength': tireSizeLength,
              'treadDate': treadDate,
              'mixtureNumber': mixtureNumber,
              'hardness': hardness
            }));
        final wheel = Wheel(
            id: id,
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
            tireSizeLength: tireSizeLength,
            treadDate: treadDate,
            mixtureNumber: mixtureNumber,
            hardness: hardness);
        _tires.insert(number, wheel);
        print(tires[number].id);
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    }
  }

  int i = 0;
  int j = 0;

  int checkSameValuesInARow(int currentIndex) {
    int foo = 0;
    if (currentIndex == 0) return 0;
    if (currentIndex == 1) return 0;
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

  Future<void> addWheel({
    required int number,
    required String tireSize,
    required String treadType,
    required String treadWidth,
    required String patchNumbers,
    required String interlayer,
    required String client,
    required String warehouse,
    required String newTreadType,
    required String newTreadWidth,
    required bool newTread,
    required bool treadDefect,
    required String tireBrand,
    required String tireSizeLength,
    required String treadDate,
    required String mixtureNumber,
    required String hardness,
  }) async {
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
        tireSizeLength: tireSizeLength,
        treadDate: treadDate,
        mixtureNumber: mixtureNumber,
        hardness: hardness);
    _tires.add(wheel);
    notifyListeners();
  }

  Future<void> deleteWheel() async {
    Wheel lastWheel = _tires.last;
    String todayFormattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    final url = Uri.parse(
        '${Secret.LINK}$todayFormattedDate/${lastWheel.id}.json');
    final response = await http.delete(url);
    _tires.remove(lastWheel);
    notifyListeners();
    if (response.statusCode >= 400) {
      _tires.add(lastWheel);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    String todayFormattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    var url = Uri.parse(
        '${Secret.LINK}$todayFormattedDate.json');
    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        _tires = [];
        notifyListeners();
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Wheel> loadedTires = [];
      extractedData.forEach((wheelId, wheelData) {
        loadedTires.add(Wheel(
            id: wheelId,
            dateTime: wheelData['dateTime'],
            number: wheelData['number'],
            tireSize: wheelData['tireSize'],
            treadType: wheelData['treadType'],
            treadWidth: wheelData['treadWidth'],
            patchNumbers: wheelData['patchNumbers'],
            interlayer: wheelData['interlayer'],
            client: wheelData['client'],
            warehouse: wheelData['warehouse'],
            newTreadType: wheelData['newTreadType'],
            newTreadWidth: wheelData['newTreadWidth'],
            newTread: wheelData['newTread'],
            treadDefect: wheelData['treadDefect'],
            tireBrand: wheelData['tireBrand'],
            tireSizeLength: wheelData['tireSizeLength'],
            treadDate: wheelData['treadDate'],
            mixtureNumber: wheelData['mixtureNumber'],
            hardness: wheelData['hardness']));
      });
      _tires = loadedTires;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
