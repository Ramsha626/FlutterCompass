import 'dart:math';

import 'package:compass/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:provider/provider.dart';

import 'change_theme_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? heading = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final text = MediaQuery.of(context).platformBrightness == Brightness ? 'DarkTheme' : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
        elevation: 0,
        foregroundColor:
            (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark)
                ? Colors.white
                : Colors.black,
        backgroundColor:
            (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark)
                ? Colors.grey.shade900
                : Colors.white,
        centerTitle: true,
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "${heading!.ceil()}°",
            style: const TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? Image.asset('assets/images/cadrant.png')
                      : Image.asset('assets/images/cadrant_dark.png'),
                  Transform.rotate(
                    angle: ((heading ?? 0) * (pi / 180) * -1),
                    child: Provider.of<ThemeProvider>(context).themeMode ==
                            ThemeMode.dark
                        ? Image.asset('assets/images/compass.png', scale: 1.1)
                        : Image.asset('assets/images/compass_dark.png',
                            scale: 1.1),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
