import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'wheel.dart';

class Wheels with ChangeNotifier {
  List<Wheel> _tires = [];


  List<Wheel> get tires {

    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._tires];
  }

  Future<void> addWheel(Wheel wheel) async{
    wheel.number = _tires.length+1;
    _tires.add(wheel);
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
            tireSize: prodData['tireSize'],
            threadType: prodData['threadType'],
            threadWidth: prodData['threadWidth'],
            tireBrand: prodData['tireBrand'],
            client: prodData['client'],
            patchNumbers:  prodData['patchNumbers'],
            newTireSize: prodData['newTireSize'],
            newThreadType: prodData['newThreadType'],
            newThreadWidth: prodData['newThreadWidth']));
      });
      _tires = tire;
    } catch (error) {
      throw (error);
    }
  }
}