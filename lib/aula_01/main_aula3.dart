import 'cartao.dart';
import 'cliente.dart';
import 'compra.dart';
import 'conta.dart';
import 'fatura.dart';
import 'package:flutter/material.dart';

class MainAula3 extends StatelessWidget {
  const MainAula3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var conta = Conta(
      cliente: Cliente(
        id: '1',
        cpf: '122225222',
        name: 'Thyago',
        sobrenome: 'Souza',
      ),
      cartao: Cartao(
        limite: 2252,
        numero: 'numero',
        mes: 12,
        ano: 2025,
        codigo: 123,
      ),
      faturas: [
        Fatura(
          compras: [
            Compra(
              valor: 22,
              descricao: 'descricao',
              data: '12/12/21',
            ),
            Compra(
              valor: 17,
              descricao: 'descricao',
              data: '12/12/21',
            ),
          ],
          mes: 12,
          ano: 21,
        ),
      ],
    );

    return Scaffold(
      body: Center(
        child: Container(
          child: Text(conta.cliente.cpf.toString()),
        ),
      ),
    );
  }
}
