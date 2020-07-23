import 'package:barcodereader/app/pages/about/about_page.dart';
import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (cxt) => AboutPage()));
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_statusRead)
                    FlatButton(
                      onPressed: () {
                        Share.text('QRCode Reader', _value, 'text/plain');
                      },
                      child: Text(
                        _value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  if (_statusRead)
                    SizedBox(
                      height: 30.0,
                    ),
                  Card(
                    child: FlatButton.icon(
                      onPressed: _scanCode,
                      icon: Icon(Icons.camera),
                      label: Text(
                          _statusRead ? "Scan Novo QRCode" : "Scan QRCode"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
