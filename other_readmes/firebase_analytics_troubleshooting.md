# Firebase Analytics Troubleshooting

## Android

1. If you are testing on a mock firebase account, [check if the google services values in these files are updated](https://github.com/google/play-services-plugins/issues/144#issue-620924263) after you changed `google-services.json`
      1. app/build/generated/res/google-services/debug/values/values.xml
      2. app/build/intermediates/incremental/mergeDebugResources/merger.xml
      3. app/build/intermediates/incremental/mergeDebugResources/merged.dir/values/values.xml
2. To [enable verbose logging](https://stackoverflow.com/a/75813358), run this code, verify details (ex. `gmp_app_id`) are correct

        adb shell setprop log.tag.FA VERBOSE
        adb shell setprop log.tag.FA-SVC VERBOSE
        adb logcat -v time -s FA FA-SVC

## iOS

1. [To enter debug mode, you need to add -FIRDebugEnabled as documented here](https://firebase.google.com/docs/analytics/debugview#enable_debug_mode), [this is a stack overflow issue asking where to add it](https://stackoverflow.com/questions/50379612/how-to-pass-command-line-arguments-like-firanalyticsdebugenabled-to-a-flutter), [and here is where you have to add it](https://github.com/flutter/flutter/issues/17043#issuecomment-408134911). You will have to build and run from Xcode.
2. If this line is not showing means its working correctly: `To enable debug logging set the following application argument: -FIRAnalyticsDebugEnabled`
