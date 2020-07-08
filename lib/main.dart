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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result, _value = 'Nada scaneado até o momento!';

  bool _statusRead = false;

  Future _scanCode() async {
    _result = await FlutterBarcodeScanner.scanBarcode(
        '#004297', "Cancelar", true, ScanMode.DEFAULT);

    if (_result.compareTo("-1") != 0) {
      setState(() {
        _value = _result;
        _statusRead = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Reader'),
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
                    Share.text('Barcode Reader', _value, 'text/plain');
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
