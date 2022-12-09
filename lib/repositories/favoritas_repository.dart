import 'dart:collection';

import 'package:crypto_moedas/adapters/moeda_hive_adapter.dart';
import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritasRepository extends ChangeNotifier {
  List<MoedaModel> _lista = [];
  //? CARREGAR HIVE DE FORMA LAZY, CONTRÁRIO DO ASYNC
  late LazyBox box;
  FavoritasRepository() {
    _startRepository();
  }
  //? RESPONSÁVEL POR INICIALIZAR O BOX DO HIVE
  _startRepository() async {
    await _openBox();
    //? LER AS FAVORITAS QUE VÃO ESTAR SALVAS
    await _readFavoritas();
  }

  _openBox() async {
    //? primeira coisa a ser feita antes de abrir o box
    //? criar ADAPTER = hive trabalha com tipos primitivos, int, bool, string, doubles etc
    //* não dá para salvar de forma padrão um objeto tipo MoedaModel
    //* para salvar dados mais complexos é preciso criar um ADAPTER
    Hive.registerAdapter(MoedaHiveAdapter());
    //
    //* ABRIR O BOX USANDO ADAPTER CRIADO PARA SALVAR AS MOEDAS DENTRO DO HIVE
    //* DAR O NOME DO BOX
    box = await Hive.openLazyBox<MoedaModel>('moedas_favoritas');
  }

  _readFavoritas() {
    //* ACESSAR O BOX ATRAVÉS DA CHAVE CRIADA 0
    //* CDDA UM DOS ELEMENTOS SERA UMA MOEDA
    //* TENDO CADA UMA DESSAS MOEDAS
    box.keys.forEach((moeda) async {
      MoedaModel m =
          await box.get(moeda); //? PARA QUE A INFORMAÇÃO DO HIVE SEJA LIDA
      //* PEGA A LISTA DE FAVORITOS QUE ESTÁ VAZIA E ADD A MOEDA
      _lista.add(m);
      //? ATUALIZA E MOSTRA LISTA NA TELA
      notifyListeners();
    });
  }

  UnmodifiableListView<MoedaModel> get lista => UnmodifiableListView(_lista);

  saveAll(List<MoedaModel> moedas) {
    moedas.forEach((moeda) {
      //if (!_lista.contains(moeda)) _lista.add(moeda);
      //? VERIFICAR NA LISTA CADA UM DOS ELEMENTOS
      //? SALVAR OBJETOS, PORQUE QUANDO SÃO INCIALIZADOS, VÃO SER DIFERENTES, POR MAIS QUE TENHAM OS MESMO DADOS
      //* SENDO ASSIM, SE OMPARA UM IDENTIFICADOR UNICO, QUE SERÁ O SIGLA
      if (!_lista.any((atual) => atual.sigla == moeda.sigla)) {
        _lista.add(moeda);
        //* ADD NO BOX - USA A CHAVE MOEDA.SIGLA E NA SEQUENCIA, ADD MOEDA
        //* só aceita tudo iisso por causa do ADAPTER
        box.put(moeda.sigla, moeda);
      }
    });
    notifyListeners();
  }

  remove(MoedaModel moeda) {
    _lista.remove(moeda);
    box.delete(moeda.sigla);
    notifyListeners();
  }
}
