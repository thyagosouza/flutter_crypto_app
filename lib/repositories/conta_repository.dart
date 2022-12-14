// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../models/posicao.dart';

class ContaRepository extends ChangeNotifier {
  //? RECUPERAR INSTANCIA DO BANCO DE DADOS
  late Database db;
  //? LISTA COM TODAS AS POSIÇÕES QUE TEM NA CARTEIRA
  List<Posicao> _carteira = [];
  double _saldo = 0;

  //? RETORNAR DADOS DE FORMA PÚBLICA COM GET
  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;

  ContaRepository() {
    //? PARA TRABALHAR COM DADOS DO TIPO ASYNC
    //* QUE NÃO PEODE SER FEITO DENTRO DO CONSTRUTOR
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
  }

  _getSaldo() async {
    //* INTANCIAR O DB
    db = await DB.instance.database;
    //* CONSULTA AO BANCO DE DADOS / para otimizar a consulta, limita para somente 1 conta
    List conta = await db.query('conta', limit: 1);
    //* tendo a conta retornada..ACESSA O SALDO, ACESSANDO A CHAVE 'SALDO'
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  //? METODO PARA QUE USUARIO POSSA MODIFICAR O SALDO NAS CONFIGURAÇÕES
  setSaldo(double valor) async {
    db = await DB.instance.database;
    //? TENDO A INSTANCIA DO DB, PODE FAZER UM UPDATE NA TABELA
    //* passa o mapa para saldo e valor
    db.update('conta', {
      //? O VALOR QUE O USUARIO VAI INFORMAR NAS CONFIGURACOES DO APP
      'saldo': valor,
    });
    //* ATUALIZAR AS PROPRIEDADES SALDO
    _saldo = valor;
    notifyListeners();
  }
}
