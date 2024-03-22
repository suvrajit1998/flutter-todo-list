import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showAppDialog(
  Widget container, {
  String title = "",
  bool showTransition = true,
  bool showCloseButton = true,
}) {
  final result = Get.generalDialog(
    // context: Get.context!,
    barrierLabel: "",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: showTransition ? 500 : 0),
    pageBuilder: (context, animation, secondaryAnimation) {
      // Get.dialog(widget);
      return Dialog(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  container,
                ],
              ),
            ),
            if (showCloseButton)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.grey[100],
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close, size: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    },
    transitionBuilder: !showTransition
        ? null
        : (_, anim, __, child) {
            Tween<Offset> tween;
            if (anim.status == AnimationStatus.reverse) {
              tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
            } else {
              tween = Tween(begin: Offset(1, 0), end: Offset.zero);
            }

            return SlideTransition(
              position: tween.animate(anim),
              child: FadeTransition(
                opacity: anim,
                child: child,
              ),
            );
          },
  );

  return result;
}
