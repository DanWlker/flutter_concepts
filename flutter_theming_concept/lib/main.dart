import 'package:flutter/material.dart';
import 'package:flutter_theming_concept/active_theme_extension_provider.dart';
import 'package:flutter_theming_concept/context_extension_methods.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveThemeExtensionProvider(),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          extensions: <ThemeExtension<dynamic>>{
            context.watch<ActiveThemeExtensionProvider>().currentActiveProvider
          },
          useMaterial3: false,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.extendedThemeStyle()?.surfaceColorOne,
      appBar: AppBar(
        backgroundColor: context.extendedThemeStyle()?.surfaceColorOne,
        title: Text(
          widget.title,
          style: TextStyle(
            color: context.extendedThemeStyle()?.floatingActionButtonColor,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Card(
            color: context.extendedThemeStyle()?.surfaceColorTwo,
            child: const SizedBox(height: 50),
          ),
          Card(
            color: context.extendedThemeStyle()?.surfaceColorThree,
            child: const SizedBox(height: 50),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor:
                context.extendedThemeStyle()?.floatingActionButtonColor,
            onPressed: () {
              context
                  .read<ActiveThemeExtensionProvider>()
                  .generateRandomTheme();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Random theme generated'),
                ),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            backgroundColor:
                context.extendedThemeStyle()?.floatingActionButtonColor,
            onPressed: () {
              context.read<ActiveThemeExtensionProvider>().cycleActiveTheme();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.app_registration_rounded),
          ),
        ],
      ),
    );
  }
}
