// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'cartao.dart';
import 'cliente.dart';
import 'fatura.dart';

class Conta {
  Cliente cliente;
  Cartao cartao;
  List<Fatura> faturas;
  Conta({
    required this.cliente,
    required this.cartao,
    required this.faturas,
  });
}
