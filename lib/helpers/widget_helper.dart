import 'package:cura_vision/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetHelper {
    static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<dynamic> loadingDialog({
    String? title,
    String? message,
    Duration duration = const Duration(seconds: 45),
  }) {
    var isDialogOpen = true;
    Get.defaultDialog(
      radius: 20,
      titleStyle: const TextStyle(color: Color(Constants.appBlack)),
      backgroundColor: const Color(Constants.appbackgroundColor),
      title: title ?? "Please wait",
      barrierDismissible: false,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(
            backgroundColor: Color(Constants.appDarkGrey),
          ),
          const SizedBox(width: 10),
          Text(
            message ?? "Loading",
            style: const TextStyle(color: Color(Constants.appBlack)),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).then((value) {
      isDialogOpen = false;
    });
    Future.delayed(duration, () {
      if (isDialogOpen == true && Get.isDialogOpen == true) {
        Get.back();
      }
    });
    return Future.delayed(duration);
  }

  static Widget loadingWidget({String message = "Loading..."}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(Constants.appBlack))),
          )
        ],
      ),
    );
  }

  static SnackbarController snackbar(String title, String message,
          [int? duration, double? marginTop]) =>
      Get.snackbar(
        title,
        message,
        animationDuration: const Duration(milliseconds: 500),
        overlayColor: Colors.black.withOpacity(.5),
        overlayBlur: 4,
        maxWidth: 450,
        titleText: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.transparent,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: title == "Error" ||
                            title == 'Could not launch' ||
                            title == "Session expired"
                        ? const Color(0xFFF04438)
                        : title == "Warning" || title == "Info"
                            ? const Color(0xFFF79009)
                            : const Color(0xFF12B76A),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Get.closeAllSnackbars();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Color(Constants.appDarkGrey),
                  ),
                )
              ],
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff3F3532),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: title == "Error" ||
                      title == 'Could not launch' ||
                      title == "Session expired"
                  ? const Color(0xFFF04438)
                  : title == "Warning" || title == "Info"
                      ? const Color(0xFFF79009)
                      : const Color(0xFF12B76A),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        messageText: const SizedBox(),
        colorText: const Color(0xFF008744),
        backgroundColor: const Color(0xFFf7fbf9),
        duration: Duration(seconds: duration ?? 4),
        borderWidth: 1,
        borderColor: title == "Error" ||
                title == 'Could not launch' ||
                title == "Session expired"
            ? const Color(0xFFF04438)
            : title == "Warning" || title == "Info"
                ? const Color(0xFFF79009)
                : const Color(0xFF12B76A),
        isDismissible: true,
        margin: EdgeInsets.only(top: marginTop ?? 5, left: 14, right: 14),
      );


}