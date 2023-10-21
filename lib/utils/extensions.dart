extension DateConverterEx on dynamic {
  DateTime? get dateTimeOrNull{
    try{
      if(this == null) return null;
      if(this is num){
        return DateTime.fromMillisecondsSinceEpoch(this.toInt() * 1000);
      }
      if(this is String){
        return DateTime.tryParse(this);
      }
      return null;

    } catch (e){
      debugPrint('error when Convert[dateTimeOrNull] \n $e');
      return null;
    }
  }
}