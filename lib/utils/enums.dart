enum TempUnit{c,f}
enum WindSpeedUnit{
  kmh('km/h'),mph('mph');
  final String name;
  const WindSpeedUnit(this.name);
}
enum AtmosphericPressureUnit{
  mb('mbar'),inHg('inHg');
  final String name;
  const AtmosphericPressureUnit(this.name);
}