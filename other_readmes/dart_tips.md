# Dart Tips

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
14. [Why type promotion sometimes doesn't work](https://youtu.be/2Cl0C-9dK48), [this too](https://stackoverflow.com/a/56764992), ~note although there's a way in the video to ensure it works, it opens you to errors~ (Edit: [you can use the same name for the variables in local scope, this also states non promotion reason, and a tip: When creating a local variable to hold a field’s value, make the variable final. That way, you can’t accidentally update the local variable when you intend to update the field.](https://dart.dev/tools/non-promotion-reasons#property:~:text=When%20creating%20a%20local%20variable%20to%20hold%20a%20field%27s%20value%2C%20make%20the%20variable%20final.%20That%20way%2C%20you%20can%27t%20accidentally%20update%20the%20local%20variable%20when%20you%20intend%20to%20update%20the%20field.))
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
28. [A good video on patterns in dart 3](https://www.youtube.com/watch?v=aLvlqD4QS7Y)
29. You can validate and destructure patterns (create a variable that you can use) at the same time using ```if(case)```

    ```dart
        if(data case Circle(radius: var rad) when rad == 1)
            return true;
    ```

30. Instead of using `['A', 'B'].contains(yourStringVariable)`, we can use pattern matching:

    ```dart
      if(randomString case 'hello' || 'something' || 'this') {
        // do stuff
      }
    ```
31. [Never for unreachable code](https://dart.dev/null-safety/understanding-null-safety#never-for-unreachable-code) allows for improved flow analysis
32. Dart supports string multiplication

    ```dart
        print('s' * 5)
    ```
32. [You can mark a class field as late even with an initialization to make it lazy](https://dart.dev/null-safety/understanding-null-safety#lazy-initialization)
33. Dart follows the Uniform access principle, which makes [fields indistinguishable from getters and setters](https://dart.dev/null-safety/understanding-null-safety#abstract-fields), ~this causes the null safety promotion to not occur for fields~[Correction](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f#:~:text=This%20limitation%20was%20due%20to%20several%20complex%20cases%20where%20flow%20analysis%20could%20not%20safely%20determine%20when%20or%20how%20a%20field%20might%20change.%20In%20the%20case%20of%20field%20promotion%20on%20a%20class%2C%20for%20example%2C%20it%20could%20be%20an%20issue%20if%20a%20subclass%20overrides%20a%20field%20with%20a%20getter%2C%20which%20sometimes%20returns%20null.)[, and a video showing it](https://www.youtube.com/watch?v=rqS_Q34RcUk). Also this is about the abstract keyword for fields cuz of null safety but yeah
34. [Very good non promotion reasons documentation](https://dart.dev/tools/non-promotion-reasons), [this section](https://dart.dev/null-safety/understanding-null-safety#nullability-and-generics:~:text=Flow%2Dbased%20type,it%20is%20called.) too
35. [Nullability and generics](https://dart.dev/null-safety/understanding-null-safety#nullability-and-generics), why we should use [`as T` instead of !](https://dart.dev/null-safety/understanding-null-safety#nullability-and-generics:~:text=When%20you%20make%20a%20type%20parameter%20type%20nullable%20like%20T%3F%20here%2C%20you%20may%20need%20to%20cast%20the%20nullability%20away.%20The%20correct%20way%20to%20do%20that%20is%20using%20an%20explicit%20as%20T%20cast%2C%20not%20the%20!%20operator%3A) for casting the nullability away
36. [Dart 3.2 allows null safety promotion on private final fields](https://github.com/dart-lang/language/issues/2020), and [this](https://dart.dev/null-safety/understanding-null-safety#nullability-and-generics:~:text=Flow%20analysis%20is%20one%20of%20the%20primary%20ways%20to%20do%20this%20for%20local%20variables%20and%20parameters%20(and%20private%20final%20fields%2C%20as%20of%20Dart%203.2).), this is the [medium article](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f#:~:text=Non%2Dnull%20promotion%20for%20private%20final%20fields) that describes the change
37. You can override [`noSuchMethod()`](https://dart.dev/language/extend#nosuchmethod), which causes issues with type promotion: [Conflict with implicit noSuchMethodForwarder](https://dart.dev/tools/non-promotion-reasons#nosuchmethod) ... why is this a thing?.... idk
