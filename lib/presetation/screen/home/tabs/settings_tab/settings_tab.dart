import 'package:flutter/material.dart';

import '../../../../../core/utils/colors_manager.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme = 'Light';
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Theme',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 8,),
          Container(
            height: 48,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ColorsManager.white,
                //borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorsManager.blue, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTheme,
                  style: TextStyle(fontSize: 16, color: ColorsManager.blue),
                ),
                DropdownButton<String>(

                   focusColor: Colors.transparent,
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  items: <String>['Light', 'Dark'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme = newTheme!;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text('Language'),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ColorsManager.white,
                //borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorsManager.blue, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedLanguage,
                  style: TextStyle(fontSize: 16, color: ColorsManager.blue),
                ),
                DropdownButton<String>(
                  elevation: 0,
                  focusColor: Colors.transparent,
                  underline: Container(color: Colors.transparent),
                  iconDisabledColor: Colors.transparent,
                  isDense: false,
                  isExpanded: false,
                  borderRadius: BorderRadius.zero,
                  focusNode: FocusNode(debugLabel: 'HH'),
                  autofocus: false,
                  items: <String>['English','Arabic'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLang) {
                    selectedLanguage = newLang!;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}