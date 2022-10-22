import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radio_tool_flutter/radio_info.dart';
import 'dart:async';

import 'package:radio_tool_flutter/radio_tool.dart';
import 'package:radio_tool_flutter/radiotool_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<RadioInfo> _radios = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final rt = await RadioTool.create();
    final radios = rt.listRadios();
    setState(() => _radios = radios);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [..._radios.map((e) => Text(e.port))]),
        ),
      ),
    );
  }
}
