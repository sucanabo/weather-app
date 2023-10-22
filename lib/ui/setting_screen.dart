import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/setting_provider.dart';
import 'package:weather_app/utils/common_functions.dart';
import 'package:weather_app/utils/enums.dart';
import 'package:weather_app/utils/extension/context_extension.dart';
import 'package:weather_app/utils/extension/widget_extension.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<SettingProvider>(
            builder: (context,provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Units', style: context.textTheme.displaySmall),
                  32.vBox,
                  _Tile(
                  onTap: chooseTempUnit,
                  title: 'Temperature units',
                  currentVal: getDegreeSymbol(provider.tUnit),
                ),
                  24.vBox,
                  _Tile(
                    onTap: chooseWUnit,
                    title: 'Wind speed units',
                    currentVal: provider.wUnit.name,
                  ),
                  24.vBox,
                  _Tile(
                    onTap: chooseAUnit,
                    title: 'Atmospheric pressure units',
                    currentVal: provider.aUnit.name,
                  ),
              ],
              );
            }
          ),
        ),
      ),
    );
  }

  chooseTempUnit(){
    showDialog(context: context, builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeTemp(TempUnit.c),
            active: context.read<SettingProvider>().tUnit == TempUnit.c,
            val: getDegreeSymbol(TempUnit.c),
          ),
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeTemp(TempUnit.f),
            active: context.read<SettingProvider>().tUnit == TempUnit.f,
            val: getDegreeSymbol(TempUnit.f),
          )
        ],
      ),
    ));
  }
  chooseWUnit(){
    showDialog(context: context, builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeWind(WindSpeedUnit.kmh),
            active: context.read<SettingProvider>().wUnit == WindSpeedUnit.kmh,
            val: WindSpeedUnit.kmh.name,
          ),
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeWind(WindSpeedUnit.mph),
            active: context.read<SettingProvider>().wUnit == WindSpeedUnit.mph,
            val: WindSpeedUnit.mph.name,
          ),
        ],
      ),
    ));
  }
  chooseAUnit(){
    showDialog(context: context, builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeAtmospheric(AtmosphericPressureUnit.mb),
            active: context.read<SettingProvider>().aUnit == AtmosphericPressureUnit.mb,
            val: AtmosphericPressureUnit.mb.name,
          ),
          _ItemChoose(
            onTap: () => context.read<SettingProvider>().changeAtmospheric(AtmosphericPressureUnit.inHg),
            active: context.read<SettingProvider>().aUnit == AtmosphericPressureUnit.inHg,
            val: AtmosphericPressureUnit.inHg.name,
          ),
        ],
      ),
    ));
  }

}
class _ItemChoose extends StatelessWidget {
  const _ItemChoose({super.key, required this.val, this.onTap, this.active = false});
  final Function()? onTap;
  final String val;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap?.call();
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: active ? context.colors.primaryContainer : null,
          borderRadius: BorderRadius.circular(16)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(val,style: context.textTheme.titleLarge?.copyWith(color: active? context.colors.primary : null)),
            if(active) Icon(Icons.check_rounded,color: context.colors.primary),
          ],
        ),
      ),
    );
  }
}


class _Tile extends StatelessWidget {
  const _Tile({required this.title, required this.currentVal, this.onTap});
  final Function()? onTap;
  final String title;
  final String currentVal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title,style: context.textTheme.titleLarge,)),
          50.hBox,
          Row(
            children: [
              Text(
                currentVal,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.hBox,
              const Icon(Icons.chevron_right_rounded,size: 30),
            ],
          )
        ],
      ),
    );
  }
}

