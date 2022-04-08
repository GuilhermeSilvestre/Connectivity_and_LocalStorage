import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'page1.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int? score;
  int aux = 99;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      score = (prefs.getInt('score') ?? 0);
      print(score);
    });
  }

  incrementData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aux = (prefs.getInt('score') ?? 0);
      prefs.setInt('score', aux + 1);
    });
  }

  resetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('score', 0);
    });
  }

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('score');
      print(prefs.getInt('score'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Esta é a segunda página'),
            SizedBox(
              height: 30,
            ),
            Text('Valor: $score'),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () {
                setState(() {
                  incrementData();
                  getData();
                });
              },
              child: const Text('Aumentar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () {
                setState(() {
                  resetData();
                  getData();
                });
              },
              child: const Text('Zerar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () {
                removeData();
                getData();
              },
              child: const Text('Remover Score'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () {
                Navigator.pop(context, 'voltou');
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
