import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let batteryChannel = FlutterMethodChannel(
      name: "samples.flutter.dev/battery",
      binaryMessenger: controller.binaryMessenger
    )
     batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      guard call.method == "getBatteryLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.receiveBatteryLevel(result: result)
      // Handle battery messages.
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func receiveBatteryLevel(result: FlutterResult) {
  print("Platform channel worked")
  
  let device = UIDevice.current
  device.isBatteryMonitoringEnabled = true
  if device.batteryState == UIDevice.BatteryState.unknown {
    result(
      FlutterError(
        code: "UNAVAILABLE",
        message: "Battery level not available.",
        details: nil
    ))
  } else {
    result(Int(device.batteryLevel * 100))
  }
}
// private func disableDnD() {
//   do {
//     try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//     try AVAudioSession.sharedInstance().setActive(true)
//   } catch {
//     print(error)
//   }
// }

