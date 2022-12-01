import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joulelys',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Styre lysa baby'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _rotateColors() async {
    var url = Uri.http("10.0.0.22", "/rotate");
    await http.get(url);
  }

  void _turnOff() async {
    var url = Uri.http("10.0.0.22", "/off");
    await http.get(url);
  }

  void _setRedWhite() async {
    var url = Uri.http("10.0.0.22", "/program");
    await http.post(url, body: "0");
  }

  void _setBlueWhite() async {
    var url = Uri.http("10.0.0.22", "/program");
    await http.post(url, body: "1");
  }

  void _setRotating() async {
    var url = Uri.http("10.0.0.22", "/program");
    await http.post(url, body: "2");
  }

  List<Color> currentColors = [Colors.yellow, Colors.green];
  Color color1 =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  Color color2 =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  Color color3 =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  Color color4 =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  // Unit is 10ths of a second, will wrap if it exceeds 255 (luckily)
  int delay = 20;

  void _setCustom() async {
    var url = Uri.http("10.0.0.22", "/custom");
    await http.post(url, body: [
      color1.red, color1.green, color1.blue, // RGB1
      color2.red, color2.green, color2.blue, // RGB2
      color3.red, color3.green, color3.blue, // RGB3
      color4.red, color4.green, color4.blue, // RGB4
      delay,
    ]);
  }

  final bool _portraitOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(6),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: color1,
                              onColorChanged: (Color color) => setState(() {
                                color1 = color;
                              }),
                              portraitOnly: _portraitOnly,
                              enableAlpha: false,
                              displayThumbColor: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: color1,
                  child: const Text("1"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: color2,
                              onColorChanged: (Color color) => setState(() {
                                color2 = color;
                              }),
                              portraitOnly: _portraitOnly,
                              enableAlpha: false,
                              displayThumbColor: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: color2,
                  child: const Text("2"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: color3,
                              onColorChanged: (Color color) => setState(() {
                                color3 = color;
                              }),
                              portraitOnly: _portraitOnly,
                              enableAlpha: false,
                              displayThumbColor: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: color3,
                  child: const Text("3"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: color4,
                              onColorChanged: (Color color) => setState(() {
                                color4 = color;
                              }),
                              portraitOnly: _portraitOnly,
                              enableAlpha: false,
                              displayThumbColor: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: color4,
                  child: const Text("4"),
                ),
              ]),
            ),
            Slider(
              value: (delay / 10).toDouble(),
              min: 0.1,
              max: 4,
              divisions: 39,
              label: "Tidsintervall mellom lyskonfigurasjon".toString(),
              onChanged: (double value) =>
                  setState(() => delay = (value * 10).round()),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              child: OutlinedButton(
                onPressed: _setCustom,
                child: Text(
                    "Bruk de gitte fargene med tidsintervall ${(delay * 0.1).toStringAsFixed(1)} s"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              child: OutlinedButton(
                onPressed: _setRedWhite,
                child: const Text("Set to red and white"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              child: OutlinedButton(
                onPressed: _setBlueWhite,
                child: const Text("Set to blue and white"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              child: OutlinedButton(
                onPressed: _setRotating,
                child: const Text("Set to rotating"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              child: ElevatedButton(
                onPressed: _rotateColors,
                child: const Text("Rotate colors"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _turnOff,
        tooltip: 'Turn off',
        backgroundColor: Colors.black,
        child: const Icon(Icons.power_off_outlined),
      ),
    );
  }
}
