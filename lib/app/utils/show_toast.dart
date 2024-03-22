import 'package:motion_toast/motion_toast.dart';

import '../exports.dart';

void showToast(String message) {
  MotionToast.warning(
    description: Text(message),
  ).show(Get.context!);
}
