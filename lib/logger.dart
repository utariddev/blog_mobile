import 'package:flutter/material.dart';
import 'package:utarid/constants.dart';

class Logger {
  static final Logger _logger = Logger._internal();

  factory Logger() {
    return _logger;
  }

  Logger._internal();

  void printLog(String message) {
    debugPrint(Constants().getCurrentDateTime() + ":" + message);
  }
}
