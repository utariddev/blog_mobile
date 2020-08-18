import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /*
   * Method to handle launching of URL
   */
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//  static Future<String> getVersion() async {
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    return packageInfo.version;
  // }

  ///Method to get a random color
  static getRandomColor() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  static List<Color> buttonGradient = [Colors.cyan.shade600, Colors.blue.shade600];
}
