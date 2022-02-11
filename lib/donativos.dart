import 'package:flutter/material.dart';
import 'dart:math';

class Donativos extends StatefulWidget {
  final donativos;
  Donativos({Key? key, required this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  show_thank_you(bool n) {
    var rng = Random();
    if (n) {
      switch (rng.nextInt(3)) {
        case 0:
          return Image.asset("assets/thank_you.png");
          break;

        case 1:
          return Image.asset("assets/thank_you2.png");
          break;

        default:
          return Image.asset("assets/sonic.jpg");
          break;
      }
    }
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Donativos Obtenidos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("assets/paypal.png"),
                trailing: Text("${widget.donativos["_paypal"] ?? 0.0}",
                    style: const TextStyle(fontSize: 30)),
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                leading: Image.asset("assets/credit_card.png"),
                trailing: Text("${widget.donativos["_tarjeta"] ?? 0.0}",
                    style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(
                height: 24,
              ),
              Divider(),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  size: 50,
                ),
                trailing: Text(
                    "${(widget.donativos["_paypal"] + widget.donativos["_tarjeta"]) ?? 0.0}",
                    style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    child: show_thank_you(widget.donativos["_metaCumplida"]),
                    height: 250,
                    width: 250,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
