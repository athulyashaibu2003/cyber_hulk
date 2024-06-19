import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false)
        .toggleTheme(ThemeMode.system == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    final themeVarProvider = Provider.of<ThemeProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(
        //   themeProvider.themeMode == ThemeMode.light
        //       ? Icons.wb_sunny
        //       : Icons.nights_stay,
        //   color: themeProvider.themeMode == ThemeMode.light
        //       ? Colors.yellow
        //       : Colors.grey,
        // ),
        Switch(
          inactiveThumbColor: ColorConstant.pantonemessage,
          activeColor: ColorConstant.pantonebackground,
          value: themeProvider.themeMode == ThemeMode.dark,
          onChanged: (value) {
            themeVarProvider.toggleTheme(value);
          },
        ),
        Icon(
          themeVarProvider.themeMode == ThemeMode.dark
              ? Icons.nights_stay
              : Icons.wb_sunny,
          color: themeVarProvider.themeMode == ThemeMode.dark
              ? ColorConstant.mainblack
              : Colors.yellow,
        ),
      ],
    );
  }
}
