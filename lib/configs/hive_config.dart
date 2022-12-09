import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig {
  static start() async {
    //? ACESSAR O DIRETÓRIO ONDE OS DOCUMENTOS DESSE APP VÃO FICAR LOCALIZADOS
    Directory dir = await getApplicationDocumentsDirectory();
    //? INCIALIZAR O HIVE
    await Hive.initFlutter(dir.path);
  }
}
