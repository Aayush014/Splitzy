import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/theme_controller.dart';

class MySwitch extends StatelessWidget {
  final void Function(bool)? onChanged;

  const MySwitch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    final ThemeController themeController = Get.find();
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Obx(
            () => Switch(
          thumbColor: WidgetStatePropertyAll(themeColor.surface),
          activeColor: themeColor.surface,
          value: themeController.isDarkMode.value,
          onChanged: (value) {
            themeController.toggleTheme();
          },
        ),
      ),
    );
  }
}