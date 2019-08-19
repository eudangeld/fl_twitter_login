import UIKit
import Flutter
import TwitterKit


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    
    
    
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let twitterLoginChannel = FlutterMethodChannel(name: "fl.dan.twitter/login",
                                            binaryMessenger: controller as! FlutterBinaryMessenger)
    
    twitterLoginChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "twitterLogin" {
            guard let args = call.arguments else {
                return
            }
            let received = args as? [String:Any]
            TWTRTwitter.sharedInstance().start(withConsumerKey:(received!["consumerKey"] as? String)!, consumerSecret:(received!["secret"] as? String)!)
            self?.log(result: result )
        }
        else{
            result(FlutterMethodNotImplemented)
        }
        
    })
    
    
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    func log(result:@escaping FlutterResult){
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
