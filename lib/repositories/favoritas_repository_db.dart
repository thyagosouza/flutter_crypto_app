import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/moeda_model.dart';

class FavoritasRepositoryDb extends ChangeNotifier {
  late Database db;
  List<MoedaModel> _lista = [];

  List<MoedaModel> get lista => _lista;
}
