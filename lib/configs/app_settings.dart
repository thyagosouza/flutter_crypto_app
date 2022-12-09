import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  //late SharedPreferences _prefs;
  //* HIVE - BOX = FORMATO QUE O HIVE TRABALHA
  //? CAIXA ONDE VÃO SER COLOCADAS INFORMAÇÕES TIPO CHAVE/VALOR
  late Box box;

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
    //! NÃO PEGARÁ MAIS INSTÂNCIA DO SHAREDPREFERENCES
    //_prefs = await SharedPreferences.getInstance();
    //? SERÁ INCIALIZADO O BOX - ABRINDO O BOX E PASSAR UM NOME
    box = await Hive.openBox('preferencias');
  }

  //* CODIFICAÇÃO DO METODO _readLocale
  //* lê as informações que já estão salvas no sharedPreferences

  _readLocale() {
    //!final local = _prefs.getString('local') ??
    //!    'pt_BR'; //* caso retorne nulo, default pt_BR
    //!final name =
    //!    _prefs.getString('name') ?? 'R\$'; //* caso retorne nulo, default R\$
    final local =
        box.get('local') ?? 'pt_BR'; //* caso retorne nulo, default pt_BR
    final name = box.get('name') ?? 'R\$'; //* caso retorne nulo, default R\$

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
    //!await _prefs.setString('local', local);
    //!await _prefs.setString('name', name);
    await box.put('local', local);
    await box.put('name', name);
    //* READLOCALE para que ele atualize o locale conforme houver mudanças
    //* também para notificar os listeners
    await _readLocale();
  }
}
