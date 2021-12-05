class Wheel{
  final DateTime dateTime;
  final String id;
  final String tireSize;
  final String treadType;
  final String treadWidth;
  final String tireBrand;
  final String client;
  final String patchNumbers;
  final String newTreadType;
  final String newTreadWidth;
  int number;

  Wheel(this.dateTime, {
    this.tireSize = '',
    this.treadType = '',
    this.treadWidth = '',
    this.tireBrand = '',
    this.client = '',
    this.patchNumbers = '',
    this.newTreadType = '',
    this.newTreadWidth = '',
    this.number = 0,
    this.id = '',
  });
}
