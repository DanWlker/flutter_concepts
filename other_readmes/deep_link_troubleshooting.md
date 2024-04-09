# Deep Link Troubleshooting

## iOS

1. [Explanation for deep linking iOS and how to do private server testing (start at 14:56)](https://developer.apple.com/videos/play/wwdc2020/10098)
2. [This too is a good reference](https://stackoverflow.com/questions/35609667/how-to-support-universal-links-in-ios-app-and-setup-server-for-it)
3. [This guide to troubleshoot](https://mac6classi.medium.com/universal-links-issue-on-ios-14-fd0aa8ae75f8)
4. On iOS to test deeplink after building app to a physical device (note, here it means not through jenkins), you would have to:
   1. Enable `Developer Mode` (Settings > Privacy & Security > Developer Mode)
   2. Enable `Associated Domains Development` (Settings > Developer > Section: Universal Links > Associated Domains Development) and insert internal link in `Diagnostics` to fetch the apple-app-site-association file. (the Developer section is quite low, so scroll lower, should be just before your 3rd party apps section)
5. To refresh apple cdn cache in case it becomes invalid for some reason, paste this link inside browser and go to it (Replace `igb-uat.fast-aws` with live link if needed, replace timestamp with current unix time stamp), you can also check if it is hosted correctly by omitting the timestamp

        https://app-site-association.cdn-apple.com/a/v1/igb-uat.ifast-aws.com?timestamp=1690769706

6. When testing, check if your open banking link ends with a `.`, if yes you will have to use apps like [this](https://apps.apple.com/my/app/deeplink-checker/id6448803970) and [this](https://play.google.com/store/apps/details?id=com.app.deeplinktester) to launch the links, since most text editors will not include the `.` when clicking and open the link
7. If your `rootViewController` is not a `FlutterViewController`, add these in `AppDelegate.swift`

    ```swift
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    // Assigning other ViewControllers as root...

    // Add this to enable universal link to launch when app is not open in background
    if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL { //Deeplink
        flutterViewController?.setInitialRoute("\(url)")
    }
    else if let activityDictionary = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any] { //Universal link
        for key in activityDictionary.keys {
        if let userActivity = activityDictionary[key] as? NSUserActivity {
            if let url = userActivity.webpageURL {
            flutterViewController?.setInitialRoute("\(url)")
            }
        }
        }
    }
    // Continue with other stuff...
    }
    override func application(_ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool{
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
        return false
    }
    print("path = \(incomingURL)")
    self.flutterViewController?.pushRoute("\(incomingURL)")

    return true
    }
    ```

8. [iOS universal links must be in https](https://stackoverflow.com/a/42190104), refer this as as a [backup link](https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html)
9. [Apple has some limitations for universal links, such as when navigating to the same domain without opening a new tab, deeplink will not be triggered](https://stackoverflow.com/a/78113039), [and this](https://stackoverflow.com/a/52480037). One of the ways to fix this is by opening a new tab for the link.

## Android

1. [Troubleshooting for android](https://medium.com/androiddevelopers/deep-links-crash-course-part-3-troubleshooting-your-deep-links-61329fecb93)
2. [If you hit 1024 when running get-app-links verification](https://stackoverflow.com/questions/73737278/how-to-resolve-android-get-app-links-returns-state-1024)
3. [Explanation on when app links are fetched](https://stackoverflow.com/questions/48425168/how-does-android-verifies-deep-links-with-digital-asset-links-at-server-side), [and this](https://developers.google.com/digital-asset-links/v1/getting-started)
4. To test if app links is setup correctly in app (Note: this does not test if app links is hosted and retrieved correctly in server)

        adb shell am start \
                -W -a android.intent.action.VIEW \
                -d "https://igb-uat.ifast-aws.com/" \
                com.ifast.gb.dev

5. [assetlinks.json must be public](https://issuetracker.google.com/issues/239724946?pli=1) unlike apple's implementation where you can fetch manually from local when in debug mode. Test the statement using [this](https://developers.google.com/digital-asset-links/tools/generator) and verify it is properly hosted by pasting this in the browser (Replace `igb-uat.fast-aws` with live link if needed)

        https://digitalassetlinks.googleapis.com/v1/statements:list?source.web.site=https://igb-uat.ifast-aws.com&relation=delegate_permission/common.handle_all_urls
