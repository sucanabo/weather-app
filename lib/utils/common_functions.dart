import 'package:flutter/foundation.dart';

import 'enums.dart';

DateTime? dateTimeOrNull(dynamic val){
    try{
      if(val == null) return null;
      if(val is num){
        return DateTime.fromMillisecondsSinceEpoch(val.toInt() * 1000);
      }
      if(val is String){
        return DateTime.tryParse(val);
      }
      return null;

    } catch (e){
      debugPrint('error when Convert[dateTimeOrNull] \n $e');
      return null;
    }
}

String removeZeroDouble(num number){
  if(number == 0) return '0';
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return number.toString().replaceAll(regex, '');
}

String addSchemeImgHost(String? url){
  if(url == null || url.isEmpty || !url.contains('//cdn.weatherapi.com')) return '';
  return 'https:$url';
}

String getDegreeSymbol(TempDegreeMode mode, {bool noCharUnit = false}){
  if(noCharUnit) return '\u00B0';
  switch(mode){
    case TempDegreeMode.f: return '\u2109';
    default: return '\u2103';
  }
}