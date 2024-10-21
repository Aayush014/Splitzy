import 'package:get/get.dart';
import '../Theme/dark_mode.dart';
import '../Theme/light_mode.dart';

class ThemeController extends GetxController {
  var isDark = true.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeTheme(isDark.value ? darkMode : lightMode);
  }
}
