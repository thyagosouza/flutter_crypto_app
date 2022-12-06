// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'compra.dart';

class Fatura {
  List<Compra> compras;
  int mes;
  int ano;
  Fatura({
    required this.compras,
    required this.mes,
    required this.ano,
  });
}
