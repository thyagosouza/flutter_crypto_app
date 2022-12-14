// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crypto_moedas/models/moeda_model.dart';

class Posicao {
  MoedaModel moeda;
  double quantidade; //? quantidade comprada
  Posicao({
    required this.moeda,
    required this.quantidade,
  });
}
