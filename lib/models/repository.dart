import 'type_width_model.dart';

class Repository {
  List getAll() => _tyreTypeAndWidth;

  getTreadWidthByType(String treadType) => _tyreTypeAndWidth
      .map((map) => TypeWidthModel.fromJson(map))
      .where((item) => item.treadType == treadType)
      .map((item) => item.treadWidth)
      .expand((i) => i)
      .toList();


  List<String> getTreadType() => _tyreTypeAndWidth
      .map((map) => TypeWidthModel.fromJson(map))
      .map((item) => item.treadType)
      .toList();

  final List _tyreTypeAndWidth = [{'treadType' : 'RDE', 'treadWidth': ['230', '250', '265']},
    {'treadType' : 'RDE2', 'treadWidth': ['245']},
    {'treadType' : 'RDF', 'treadWidth': ['260', '275']},
    {'treadType' : 'RDN', 'treadWidth': ['245', '260']},
    {'treadType' : 'RDW', 'treadWidth': ['235', '250', '265']},
    {'treadType' : 'RDY3', 'treadWidth': ['250', '265']},
    {'treadType' : 'RSK', 'treadWidth': ['235', '250', '265', '280']},
    {'treadType' : 'RTE2', 'treadWidth': ['295']},
    {'treadType' : 'VZA', 'treadWidth': ['295']},
    {'treadType' : 'R8S', 'treadWidth': ['295']},
    {'treadType' : 'STR', 'treadWidth': ['295']},
    {'treadType' : 'R164', 'treadWidth': ['300']},
    {'treadType' : 'RZY3', 'treadWidth': ['300']},];
}