import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    
  
_ application: UIApplication,
    
    didFinishLaunchingWithOptions lau

    d
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register all the generated plugins with the Flutter app
    GeneratedPluginRegistrant.register(with: self)
    
    // Additional setup can be added here if needed
    // For example, configuring third-party services or setting initial states

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}