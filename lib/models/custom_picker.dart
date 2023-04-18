import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as pick;

class CustomMonthPicker extends pick.DatePickerModel {
  CustomMonthPicker({required DateTime currentTime, required DateTime minTime, required DateTime maxTime,
    required pick.LocaleType locale}) : super(locale: locale, minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}