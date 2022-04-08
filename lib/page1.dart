import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'page2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var retorno;
  String isOnline = '';

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

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
            const Text(
              'App para teste de conectividade',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Connection Status: ${_connectionStatus.toString()}',
            ),
            SizedBox(
              height: 20,
            ),
            if (isOnline != 'none')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Online:   ',
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            if (isOnline == 'none')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Offline:   ',
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () async {
                retorno = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
                print(retorno);
              },
              child: const Text('Próxima página'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      return;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      isOnline = _connectionStatus.toString();
      isOnline = isOnline.replaceAll("ConnectivityResult.", "");
    });
  }
}
