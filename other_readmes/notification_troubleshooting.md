# Notification Troubleshooting

## iOS

1. completionHandler in userNotificationCenter, if called asynchronously does not work. If you don't know what it means, then ignore it.
2. Permission Handler has changed to require manually specifying [Podfile](/ios/Podfile) macro entries, refer comments in those files to learn more.
3. flutter_apns if using firebase requires flutter_apns.disable_swizzling to be true, and FirebaseAppDelegateProxyEnabled to be false in info.plist for good measure.
4. Remember to add push notification capability in xcode > Runner > Signing & Capabilities > Push Notifications, to check if it is added, look for these lines in Runner.entitlements:

   ```xml
    <key>aps-environment</key>
    <string>development</string>
   ```

5. Apple has a [guide on using the Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console). It is very useful for debugging push issues.
6. The Device Token Validator in the console tells you which environment your token will receive notifications from, it should match the environment configured in back end.
7. To debug notifications in ios simulator, drag and drop the [iospush.apns](iospush.apns) file into the simulator, and compare what is sent back as the "message" at onMessageHandler. Or to just see if you can receive notifications in background.
8. If notifications isn't being received in foreground and you really don't know what else to look for, [here is a good place to start](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649527-requestauthorization). But in most cases it is not necessary as it is already included in flutter_apns_only.

## Android

1. Permission Handler has changed to require manually specifying required [Android Manifest](/android/app/src/main/AndroidManifest.xml) entries, refer comments in those files to learn more.
2. [If you cant see notifications in the background, check this page and make sure your notification sent out adheres to guidelines](https://firebase.google.com/docs/cloud-messaging/concept-options). Mainly the 'notification' field should be populated.
3. You can use the `flutter logs` command to see contents of notification being sent to your device at background as firebase will launch the callback and log it.
