import 'package:crypto_moedas/configs/app_settings.dart';
import 'package:crypto_moedas/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aula_01/main_aula3.dart';
import 'meu_aplicativo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
