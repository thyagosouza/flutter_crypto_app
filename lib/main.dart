import 'package:crypto_moedas/configs/app_settings.dart';
import 'package:crypto_moedas/repositories/conta_repository.dart';
import 'package:crypto_moedas/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aula_01/main_aula3.dart';
import 'configs/hive_config.dart';
import 'meu_aplicativo.dart';

void main() async {
  //* Garante que códigos executados antes do runApp não dê erro
  WidgetsFlutterBinding.ensureInitialized();

  //* como o hive será usado em varias partes, cria-se uma inicialização
  //* PARA QUE NÃO PRECISE FICAR INCIALIZANDO TODA HORA O SISTEMA DE BD
  await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
