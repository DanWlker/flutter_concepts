# flutter_concepts

### Dart Tips

1. Object? is better than dynamic (in most cases) as it has null checking
2. Multiline strings for readability do not need to use the + symbol (implicit string concatenation)

    ```dart
    final s1 = 'String '
    'concatenation'
    " even works over line breaks.";
    ```

3. There's a null aware spread operator `...?` so don't have to check null for spread, just use this
4. In Swift (and many other programming languages), the result of `let x = 5/2` is 2 (an integer). In Dart, `int x = 5/2`, results in a value of 2.5 (a floating point value). To get an integer result, use Dart’s truncating division operator (~/).
5. A final List using the unmodifiable constructor (shown in the following example), creates a List that can’t change its size or content (or just use a const constructor).

    ```dart
    final fruits = List<String>.unmodifiable(['apple', 'orange', 'pear']);
    ```

6. Also this is a thing. Note that if this (??=) is used for provider.value, the dispose methods for the models must be called MANUALLY inside the widget's state's dispose method as it will not be disposed automatically.

    ```dart
    class Logger {
        static final Map<String, Logger> _cache =
        <String, Logger>{};

        final String name;

        // Factory constructor that returns a cached copy,
        // or creates a new one if it's not yet available.
        // Focus on this line and what its doing
        factory Logger(String name)=> _cache[name] ??= Logger._internal(name);
        // Private constructor used only in this library
        Logger._internal(this.name);
    }
    ```

7. If the name of an extension begins with an underscore, the extension is only available within the library in which it’s defined.

    ```dart
    // The `shout()` method is only available within this library.
    extension _Private on String {
    String shout() => this.toUpperCase();
    }
    ```

8. In Dart, you can’t use extensions to add additional constructors to a class, but you can add a static extension method that creates an instance of the type.

    ```dart
    class Person {
            Person(this.fullName);

            final String fullName;
    }

    extension ExtendedPerson on Person {
            static Person create(String firstName, String lastName) {
            return Person("$firstName $lastName");
            }
    }

    // To use the factory method, use the name of
    // the extension, not the type.
    final person = ExtendedPerson.create('John', 'Doe');
    ```

9. You can use generics to restrict your code to a family of types using extends. This ensures that your class is instantiated with a generic type that extends a specific type ex. `<T extends num>`
10. Any exception that occurs in the `async` function can be handled in the same way as handling a failed Future, using the `catchError` method.
11. [Coming from swift to dart](https://dart.dev/guides/language/coming-from/swift-to-dart) and [Enhanced Enums](https://dart.dev/language/enums#declaring-enhanced-enums)
12. [Don't use build context in async code, if needed, cache what needs to be retrieved at the top part of the function call before you run the async code, then use .then maybe](https://youtu.be/bzWaMpD1LHY)
13. [You can run expensive functions that depend on a .of value inside didChangeDependencies](https://youtu.be/og-vJqLzg2c)
14. [Why type promotion sometimes doesn't work](https://youtu.be/2Cl0C-9dK48), [this too](https://stackoverflow.com/a/56764992), ~note although there's a way in the video to ensure it works, it opens you to errors~ (Edit: [you can use the same name for the variables in local scope, this also states non promotion reason, and a tip: When creating a local variable to hold a field’s value, make the variable final. That way, you can’t accidentally update the local variable when you intend to update the field.](https://dart.dev/tools/non-promotion-reasons))
15. [Theming, may need to explore](https://youtu.be/8-szcYzFVao)
16. [What sequence to call super.initState and super.dispose](https://medium.com/flutter-senior/call-super-initstate-first-call-super-dispose-last-9de47fdb932d), [doc comment for super.initState](https://github.com/flutter/flutter/blob/5187b45e4d1468c13ca9ab1795b300d876fd9453/packages/flutter/lib/src/widgets/framework.dart#L998-L999), [doc comment for super.dispose](https://github.com/flutter/flutter/blob/5187b45e4d1468c13ca9ab1795b300d876fd9453/packages/flutter/lib/src/widgets/framework.dart#L1232-L1233)
17. [This is about linting, but can maybe use for checking object is null or empty in future](https://github.com/dart-lang/linter/pull/3392#issue-1231699081), [this article also mentions it is useful to call functions on null](https://medium.com/flutter-senior/the-3-new-lints-in-dart-2-18-113354ec641e)
18. [Using Dart 3 Records to await multiple futures](https://stackoverflow.com/a/71178612)

    ```dart
        // Calling this will start the function execution
        Future<List<Foo>> foos = downloader.getFoos();
        Future<List<Bar>> bars = downloader.getBars();

        // Will run in parallel until both are done
        final (foos, bars) = await (foosFunction, barsFunction).wait;

        // Do stuff with the results since both are complete - and type safe!
        print(foos[0]);
        print(bars[0]);
    ```

19. You can specify a special function named `call` inside a class, this allows its objects to be invoked. Ex.

    ```dart
        class PasswordValidator {
            bool call(String password) {
                return password.length > 10;
            }
        }

        void main() {
            final validator = PasswordValidator();
            validator('test');
            validator('test1234');
        }
    ```

20. Named constructors

    ```dart
        class Temperature {
            Temperature.celsius(this.celsius);
            Temperature.farenheit(double farenheit) : celsius = (farenheit * 32) / 1.0
            double celsius;
        }

        void main() {
            final temp1 = Temperature.celsius(10);
            final temp2 = Temperature.farenheit(10);
        }
    ```

21. You can decare default constructors to be private, it is most useful for singleton members

    ```dart
        class FileSystem {
            FileSystem._()
            static final instance = FileSystem._();
        }
    ```

22. Sets have more functions like `.union`, `.difference`, `.intersection`. Use them if you need lists of unique items.
23. Iterable and Stream stuff:

    ```dart
        Iterable<int> count(int n) sync* {
            for(var i = 1; i <=n; ++i) {
                yield i;
            }
        }

        Stream<int> countStream(int n) async* {
            for(var i = 1; i <=n; ++i) {
                await Future.delayed(Duration(seconds: 1));
                yield i;
            }
        }
    ```

24. Dart 3 pattern matching and records possibilities, with a [Guard clause](https://dart.dev/language/branches#guard-clause) example as well:
    ```dart
    String getTimePassedDescription(DateTime fromDate) {

        final difference = DateTime.now().difference(fromDate);

        final (Duration(:inSeconds, :inMinutes, :inHours, :inDays), inMonths) = (difference, (difference.inDays / 30).round());

        getSIfRequired(int value) => value == 1 ? 's' : '';

        var randomEasterEgg = Random().nextInt(100);

        return switch (inSeconds) {
            < 60 when randomEasterEgg > 98 => 'quite possibly.. just did it',
            < 60 => 'now',
            < 3600 => '$inMinutes minute${getSIfRequired(inMinutes)} ago',
            < 86400 => '$inHours hour${getSIfRequired(inHours)} ago',
            < 2592000 => '$inDays day${getSIfRequired(inDays)} ago',
            _ => '$inMonths month${getSIfRequired(inMonths)} ago'
        };
    }
    ```
25. For more pattern matching possibilities, read these: [Branches](https://dart.dev/language/branches), [Patterns](https://dart.dev/language/patterns), [Pattern types](https://dart.dev/language/pattern-types)
26. [Dart's notion of "private methods" and why its different](https://stackoverflow.com/questions/57798124/should-subclasses-inherit-private-mixin-variables-in-dart). The short of it is, private names are private to that "library"
27. Always remember the order in which you declare mixins, this is very important because it decides which class is more important. If mixins contains identical methods then the mixin class that is declared later will be executed(Declaring a mixin after another raises its “Importance”). [What happens when multiple mixins have the same method or field declaration](https://medium.com/flutter-community/https-medium-com-shubhamhackzz-dart-for-flutter-mixins-in-dart-f8bb10a3d341)

### Firebase Analytics Troubleshooting

#### Android

1. If you are testing on a mock firebase account, [check if the google services values in these files are updated](https://github.com/google/play-services-plugins/issues/144#issue-620924263) after you changed `google-services.json`
      1. app/build/generated/res/google-services/debug/values/values.xml
      2. app/build/intermediates/incremental/mergeDebugResources/merger.xml
      3. app/build/intermediates/incremental/mergeDebugResources/merged.dir/values/values.xml
2. To [enable verbose logging](https://stackoverflow.com/a/75813358), run this code, verify details (ex. `gmp_app_id`) are correct

        adb shell setprop log.tag.FA VERBOSE
        adb shell setprop log.tag.FA-SVC VERBOSE
        adb logcat -v time -s FA FA-SVC

#### iOS

1. [To enter debug mode, you need to add -FIRDebugEnabled as documented here](https://firebase.google.com/docs/analytics/debugview#enable_debug_mode), [this is a stack overflow issue asking where to add it](https://stackoverflow.com/questions/50379612/how-to-pass-command-line-arguments-like-firanalyticsdebugenabled-to-a-flutter), [and here is where you have to add it](https://github.com/flutter/flutter/issues/17043#issuecomment-408134911). You will have to build and run from Xcode.
2. If this line is not showing means its working correctly: `To enable debug logging set the following application argument: -FIRAnalyticsDebugEnabled`

### Deep Link Troubleshooting

#### iOS

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

#### Android

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

### Notification Troubleshooting

#### iOS

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

#### Android

1. Permission Handler has changed to require manually specifying required [Android Manifest](/android/app/src/main/AndroidManifest.xml) entries, refer comments in those files to learn more.
2. [If you cant see notifications in the background, check this page and make sure your notification sent out adheres to guidelines](https://firebase.google.com/docs/cloud-messaging/concept-options). Mainly the 'notification' field should be populated.
3. You can use the `flutter logs` command to see contents of notification being sent to your device at background as firebase will launch the callback and log it.
