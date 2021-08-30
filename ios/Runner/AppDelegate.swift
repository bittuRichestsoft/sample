import UIKit
import Flutter
//import Braintree


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
   // BTAppContextSwitcher.setReturnURLScheme("com.app.ecanada.braintree")
//    BTAppSwitch.setReturnURLScheme("com.app.ecanada.braintree")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
