import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  Map<String, String> locale = {
    'local': 'pt_BR',
    'name': 'R\$',
  };

  AppSettings() {
    //? O CONSTRUTOR NÃO PODE SER ASYCRONO, DEVE SER CHAMADO POR FORA
    _startSettings();
  }

  //? O METODO ASYNCRONO DEVE SER CHAMADO POR FORA
  _startSettings() async {
    //* incialização do sharedPreferences
    await _startPreferences();
    //* metodo de confirmação do SharedPreferences
    await _readLocale();
  }

  //* CODIFICAÇÃO DO METODO _startPreferences
  Future<void> _startPreferences() async {
    //* inicializa o sistema de arquivos por meio do SharedPreferences
    _prefs = await SharedPreferences.getInstance();
  }

  //* CODIFICAÇÃO DO METODO _readLocale
  //* lê as informações que já estão salvas no sharedPreferences

  _readLocale() {
    final local = _prefs.getString('local') ??
        'pt_BR'; //* caso retorne nulo, default pt_BR
    final name =
        _prefs.getString('name') ?? 'R\$'; //* caso retorne nulo, default R\$

    //* Settings do MAP
    locale = {
      'locale': local,
      'name': name,
    };
    notifyListeners();
  }

  //* METODO PÚBLICO SETLOCALE
  //* PARA QUE QUALQUER CLASSE POSSA ALTERAR O LOCALE
  //* EM QUALQUER LUGAR DO APLICATIVO

  setLocale(String local, String name) async {
    await _prefs.setString('local', local);
    await _prefs.setString('name', name);
    //* READLOCALE para que ele atualize o locale conforme houver mudanças
    //* também para notificar os listeners
    await _readLocale();
  }
}
