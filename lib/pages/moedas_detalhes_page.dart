// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crypto_moedas/models/moeda_model.dart';

class MoedasDetalhesPage extends StatefulWidget {
  final MoedaModel moeda;

  const MoedasDetalhesPage({
    Key? key,
    required this.moeda,
  }) : super(key: key);

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 50, child: Image.asset(widget.moeda.icone)),
            ],
          ),
        ],
      ),
    );
  }
}
