import Flutter
import UIKit
import TwitterKit



public class SwiftFlTwitterLoginPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fl_twitter_login", binaryMessenger: registrar.messenger())
    let instance = SwiftFlTwitterLoginPlugin()
    
    channel.setMethodCallHandler({
        [self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "twitterLogin" {
            guard let args = call.arguments else {
                return
            }
            let received = args as? [String:Any]
            TWTRTwitter.sharedInstance().start(withConsumerKey:(received!["consumerKey"] as? String)!, consumerSecret:(received!["secret"] as? String)!)
            loginOnTwitter(result: result)
        }
        else{
            result(FlutterMethodNotImplemented)
        }
        
    })
    
    
    
    registrar.addMethodCallDelegate(instance, channel: channel)
    
  }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
  static  func loginOnTwitter(result: @escaping FlutterResult){
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                var error = true;
                if session?.authToken != nil{
                    error = false
                }
                let res = ["error":error, "userID":session?.userID, "userName":session?.userName,"authToken":session?.authToken,"authTokenSecret":session?.authTokenSecret] as [String : Any]
                result(res);
            } else {
                let res = ["error":true] as [String:Any]
                result(res)
            }
        })
    }
}
