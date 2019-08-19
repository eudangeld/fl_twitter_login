import 'dart:async';

import 'package:flutter/services.dart';

class FlTwitterLogin {
  static const MethodChannel _channel =
      const MethodChannel('fl.dan.twitter/login');

  static Future<void> twitterLogin() async {
    final int version = await _channel.invokeMethod('twitterLogin');
    print(version);
  }
}
