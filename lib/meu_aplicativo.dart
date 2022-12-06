import 'package:crypto_moedas/pages/moedas_page.dart';
import 'package:flutter/material.dart';

import 'aula_01/main_aula3.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moedasbase',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MoedasPage(),
    );
  }
}
