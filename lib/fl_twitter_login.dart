import 'dart:async';

import 'package:fl_twitter_login/tw_user_data.dart';
import 'package:flutter/services.dart';

class FlTwitterLogin {
  static const MethodChannel _channel =
      const MethodChannel('fl.dan.twitter/login');

  static Future<TWUserData> twitterLogin(
      {String consumerKey, String secret}) async {
    final dynamic result = await _channel.invokeMethod(
        'twitterLogin', {"secret": secret, "consumerKey": consumerKey});
    if (result["error"]) {
      return TWUserData();
    } else {
      return TWUserData(
          error: false,
          userName: result["userName"],
          authToken: result["authToken"],
          authTokenSecret: result["authTokenSecret"],
          userID: result["userID"]);
    }
  }
}
