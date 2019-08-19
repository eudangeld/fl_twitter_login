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
        guard call.method == "twitterLogin" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self?.log(result: result)
    })
    
    
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func log(result:@escaping FlutterResult){
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                result("signed in as \(String(describing: session?.authToken))");
            } else {
                result("error: \(error?.localizedDescription)");
            }
        })
    }
}
