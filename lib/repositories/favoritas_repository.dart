import 'dart:collection';

import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:flutter/material.dart';

class FavoritasRepository extends ChangeNotifier {
  List<MoedaModel> _lista = [];

  UnmodifiableListView<MoedaModel> get lista => UnmodifiableListView(_lista);

  saveAll(List<MoedaModel> moedas) {
    moedas.forEach((moeda) {
      if (!_lista.contains(moeda)) _lista.add(moeda);
    });
    notifyListeners();
  }

  remove(MoedaModel moeda) {
    _lista.remove(moeda);
    notifyListeners();
  }
}
