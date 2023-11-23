import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        //Test for async without api call
        //child: TextButton(
        //  child: const Text('Async without api'),
        //  onPressed: () async {
        //    asyncFunctionOne();
        //    asyncFunctionTwo();
        //    asyncFunctionThree();
        //  },
        //),
        child: TextButton(
          child: const Text('Async with api'),
          onPressed: () async {
            asyncFunctionOne();
            asyncFunctionTwoWithApiCall();
            asyncFunctionThree();
          },
        ),
      ),
    );
  }

  Future<void> asyncFunctionOne() async {
    for (int i = 0; i < 10; ++i) {
      print('This is first async function $i');
    }
  }

  Future<void> asyncFunctionTwo() async {
    for (int i = 0; i < 10; ++i) {
      print('This is second async before function $i');
    }
    for (int i = 0; i < 10; ++i) {
      print('This is second async after function $i');
    }
  }

  Future<void> asyncFunctionTwoWithApiCall() async {
    for (int i = 0; i < 10; ++i) {
      print('This is second async function before api call $i');
    }

    await http.get(Uri.parse('https://www.google.com'));

    for (int i = 0; i < 10; ++i) {
      print('This is second async function after api call $i');
    }
  }

  Future<void> asyncFunctionThree() async {
    for (int i = 0; i < 20; ++i) {
      sleep(const Duration(milliseconds: 50));
      print('This is third async function $i');
    }
  }
}
