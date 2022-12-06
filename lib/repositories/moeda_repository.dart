//? CLASSE RESPONSAVEL POR SE CONNECTAR COM AS FONTES DE DADOS
//? API EXTERNA, BANCO DE DADOS...

import 'package:crypto_moedas/models/moeda_model.dart';

class MoedaRepository {
  static List<MoedaModel> tabela = [
    MoedaModel(
      icone: 'assets/images/bitcoin.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 163603.00,
    ),
    MoedaModel(
      icone: 'assets/images/ethereum.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 9716.00,
    ),
    MoedaModel(
      icone: 'assets/images/xrp.png',
      nome: 'XRP',
      sigla: 'XRP',
      preco: 3.34,
    ),
    MoedaModel(
      icone: 'assets/images/cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 6.32,
    ),
    MoedaModel(
      icone: 'assets/images/usdcoin.png',
      nome: 'USD Coin',
      sigla: 'USDC',
      preco: 5.02,
    ),
    MoedaModel(
      icone: 'assets/images/litecoin.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 669.93,
    ),
  ];
}
