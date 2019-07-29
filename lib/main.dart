import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(BarCodeReaderApp());

class BarCodeReaderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarCode Reader',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'BarCode Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result, _value = 'Nada scaneado até o momento!';

  bool _statusRead = false;

  Future _scanCode() async {
    _result =
        await FlutterBarcodeScanner.scanBarcode('#004297', "Cancelar", true);

    setState(() {
      _value = _result;
      _statusRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: _scanCode,
            tooltip: 'Scan',
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  if (_statusRead) {
                    Share.text('BarCode Reader', _value, 'text/plain');
                  }
                },
                child: Text(
                  _value,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
