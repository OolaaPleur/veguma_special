class Wheel{
  final String id;
  final String tireSize;
  final String threadType;
  final String threadWidth;
  final String tireBrand;
  final String client;
  final String patchNumbers;
  final String newTireSize;
  final String newThreadType;
  final String newThreadWidth;

  Wheel({
    required this.tireSize,
    required this.threadType,
    required this.threadWidth,
    required this.tireBrand,
    required this.client,
    this.patchNumbers = '',
    this.newTireSize = '',
    this.newThreadType = '',
    this.newThreadWidth = '',
    this.id = '',
  });
}
