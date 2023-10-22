import 'package:flutter/material.dart';

import '../utils/common_functions.dart';
import '../utils/enums.dart';

class SettingProvider extends ChangeNotifier {
  TempUnit tUnit = TempUnit.c;
  WindSpeedUnit wUnit = WindSpeedUnit.kmh;
  AtmosphericPressureUnit aUnit= AtmosphericPressureUnit.mb;

  changeTemp(TempUnit unit) {
    tUnit = unit;
    notifyListeners();
  }

  changeWind(WindSpeedUnit unit) {
    wUnit = unit;
    notifyListeners();
  }
  changeAtmospheric(AtmosphericPressureUnit unit) {
    aUnit = unit;
    notifyListeners();
  }

  num degree(num? tempC, num? tempF) => getDegree(
    tUnit,
    tempC,
    tempF,
  );

  num windNum(num? kmNum, num? mphNum) {
    switch(wUnit){
      case WindSpeedUnit.mph: return mphNum ?? 0;
      default: return kmNum ?? 0;
    }
  }
  num atmNum(num? mbNum, num? inNum) {
    switch(aUnit){
      case AtmosphericPressureUnit.inHg: return inNum ?? 0;
      default: return mbNum ?? 0;
    }
  }

}