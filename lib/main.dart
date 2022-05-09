import 'package:dialog/meansTR.dart';
import 'package:flutter/material.dart';
import 'meansTR.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Favorite Mean of transport'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _clickedElement = 'Nothing';
  IconData? _icon;
  final ButtonStyle style = ElevatedButton.styleFrom(
    primary: Colors.cyan,
    textStyle: const TextStyle(fontSize: 20, color: Colors.black),
    minimumSize: const Size(300, 40),
  );
  String? _selectedMean = 'Not yet selected';

  List<MeanTR> means = [
    MeanTR('Plane', Icons.flight),
    MeanTR('Vehicle', Icons.car_rental),
    MeanTR('Bicycle', Icons.pedal_bike),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.indigo),
                  minimumSize: const Size(300, 40),
                ),
                onPressed: () => _displayBottomSheet(),
                child: const Text('Bottom Sheet')),
            ElevatedButton(
                style: style,
                onPressed: () => _displaySimpleDialog(),
                child: const Text('Simple Dialog')),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Choice made with $_clickedElement',
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 80),
              //You can use EdgeInsets like above
              child: Text(
                '$_selectedMean',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(_icon, size: 50),
          ],
        ),
      ),
    );
  }

  _displaySimpleDialog() {
    List<SimpleDialogOption> dialogOptions = means
        .map((MeanTR mean) => SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, mean);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(mean.icon),
                Text(mean.value),
              ],
            )))
        .toList();

    showDialog(
        context: context,
        builder: (BuildContext build) {
          return SimpleDialog(
            title: const Text('Select your favorite mean of transport'),
            children: dialogOptions,
          );
        }).then((valueFromDialog) {
      setState(() {
        _clickedElement = 'Simple Dialog';
        _selectedMean = (valueFromDialog == null) ? _selectedMean : valueFromDialog.value;
        _icon = valueFromDialog.icon;
      });
    });
  }

  _displayBottomSheet() {
    List<ListTile> listTiles = means
        .map((mean) => ListTile(
              onTap: () {
                Navigator.pop(context, mean);
              },
              leading: Icon(mean.icon),
              title: Text(mean.value),
            ))
        .toList();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext build) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: listTiles,
            ),
          );
        }).then((value) {
      setState(() {
        _clickedElement = 'Bottom Sheet';
        _selectedMean = (value == null) ? _selectedMean : value.value;
        _icon = value.icon;
      });
    });
  }
}
