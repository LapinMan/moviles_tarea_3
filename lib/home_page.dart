import 'dart:math';

import 'package:ejercicio_route/donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var radioAssets = {0: "assets/paypal.png", 1: "assets/credit_card.png"};

  var radioGroup = {0: "Paypal", 1: "Credit Card"};

  int _donacionMax = 10000;
  int _totalDonacion = 0;
  double _porcentajeDonacion = 0.0;

  int? radioValue = 0;

  radioGroupGenerator() {
    return radioGroup.entries
        .map((radioItem) => ListTile(
              leading: Image.asset(radioAssets[radioItem.key]!),
              title: Text(
                "${radioItem.value}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Radio(
                value: radioItem.key,
                groupValue: radioValue,
                onChanged: (int? newSelectedRadio) {
                  radioValue = newSelectedRadio;
                  setState(() {});
                },
              ),
            ))
        .toList();
  }

  int _paypal = 0;
  int _tarjeta = 0;

  int? _dropDownValue = null;
  var _dropDownOptions = {
    100: "100",
    350: "350",
    850: "850",
    1050: "1050",
    9999: "9999"
  };

  bool _metaCumplida = false;

  dropDownOptionGenerator() {
    return _dropDownOptions.entries
        .map((item) =>
            DropdownMenuItem(child: Text(item.value), value: item.key))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Es para una buena causa",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Elija modo de donativo",
                  style: TextStyle(fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: radioGroupGenerator(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Cantidad a donar"),
                    trailing: DropdownButton<int>(
                      value: _dropDownValue,
                      hint: Text(""),
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.grey[300],
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          // Redundate el check de 0 pero x
                          _dropDownValue = newValue ?? 0;
                        });
                      },
                      items: dropDownOptionGenerator(),
                    ),
                  ),
                  LinearProgressIndicator(
                    value: _porcentajeDonacion,
                    semanticsLabel: "Probando esto",
                    minHeight: 25.0,
                    backgroundColor: Colors.transparent,
                  ),
                  Text("${(_porcentajeDonacion * 100).toStringAsFixed(2)}%"),
                  SizedBox(height: 25),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                        ),
                        onPressed: () {
                          if (_dropDownValue != null) {
                            // Checar a que elemento le suma la donacion
                            if (radioValue == 0) {
                              _paypal += _dropDownValue!;
                            } else {
                              _tarjeta += _dropDownValue!;
                            }
                            // Esta variable sirve para calcular
                            _totalDonacion = _paypal + _tarjeta;
                            // Como la barra va de 0 a 1, se divide la donacion total entre la maxima
                            // Se toma el numero mas pequeño entre la division o el 1.0 para que no se salga del rango
                            _porcentajeDonacion =
                                min(_totalDonacion / _donacionMax, 1.0);
                          }
                          // Checar si se llega a la meta
                          if (_totalDonacion >= _donacionMax) {
                            _metaCumplida = true;
                          }
                          setState(() {});
                        },
                        child: Text("Donar")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Donativos(
                  donativos: {
                    "_paypal": _paypal,
                    "_tarjeta": _tarjeta,
                    "_metaCumplida": _metaCumplida
                  },
                ),
              ),
            );
          },
          child: Icon(Icons.remove_red_eye)),
    );
  }
}
