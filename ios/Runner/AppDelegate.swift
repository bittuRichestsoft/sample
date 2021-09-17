import UIKit
import Flutter
//import Braintree
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    if #available(iOS 10.0, *) {
              UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          }
    GeneratedPluginRegistrant.register(with: self)
   // BTAppContextSwitcher.setReturnURLScheme("com.app.ecanada.braintree")
//    BTAppSwitch.setReturnURLScheme("com.app.ecanada.braintree")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
