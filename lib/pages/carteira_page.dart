import 'package:crypto_moedas/configs/app_settings.dart';
import 'package:crypto_moedas/repositories/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/posicao.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({Key? key}) : super(key: key);

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  //? CONTROLE DE QUAL SEÇÃO CADA USUÁRIO ESTARÁ VENDO
  int index = 0;
  //? SOMATÓRIO DE TODO VALOR QUE O USUÁRIO TEM DENTRO DA CARTEIRA
  double totalCarteira = 0;
  //? VALOR BUSCADO NO CONTA-REPOSITORY
  double saldo = 0;
  //? CARREGA DO PROVIDER
  late NumberFormat real;
  late ContaRepository conta;

  String graficoLabel = '';
  double graficoValor = 0;
  List<Posicao> carteira = [];

  @override
  Widget build(BuildContext context) {
    //? RECUPERA A CONTA
    conta = context.watch<ContaRepository>();
    //? RECUPERA O APPSETTINGS
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = conta.saldo;

    setTotalCarteira();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Text(
              real.format(totalCarteira),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            loadGrafico(),
          ],
        ),
      ),
    );
  }

  //? RECRIAR METODO TOTAL
  setTotalCarteira() {
    final carteiraList = conta.carteira;
    setState(() {
      //? TOTAL CARTEIRA INCIALIZANDO COM SALDO DA CONTA
      totalCarteira = conta.saldo;
      for (var posicao in carteiraList) {
        //? PRA CADA QUANTIDADE DE MOEDA COMPRADA
        totalCarteira +=
            posicao.moeda.preco * posicao.quantidade; //* somando os valores
      }
    });
  }

  setGraficoDados(int index) {
    //? VERIFICAR SE O INDEX FOR MENOR QUE 0, RETORNA
    if (index < 0) return;
    //? SE TIVER ALGUMA MOEDA, GRAFICO LABEL RECEBE VALOR
    if (index == carteira.length) {
      graficoLabel = 'Saldo';
      graficoValor = conta.saldo;
    } else {
      //? CASO CONTRARIO, TERÁ UMA POSIÇÃO EM CARTEIRA
      graficoLabel = carteira[index].moeda.nome;
      graficoValor = carteira[index].moeda.preco * carteira[index].quantidade;
    }
  }

  loadCarteira() {
    //? PARA QUANDO ABRIR O GRAFICO, JÁ CARREGAR UMA DAS MOEDAS NA LABEL
    setGraficoDados(index);
    //? RECUPERAR CARTEIRA
    carteira = conta.carteira;
    //? POSIÇÃO EM CARTEIRA + O SALDO
    final tamanhoLista = carteira.length + 1;
    //? LISTA DE PIECHARTDATA
    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index; //* VERIFICA SE USUARIO TOCOU NA SEÇÃO
      final isSaldo = i == tamanhoLista - 1; //* VERIFICA SE A SEÇÃO É UM SALDO
      final fontSize =
          isTouched ? 18.0 : 14.0; //* TAMANHO DA LEGENDA QUANDO SE TOCADA
      final radius = isTouched ? 60.0 : 50.0; //* RAIO QUANDO TOCADO
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];

      //? VALORES QUE SERÃO COLOCADOS NO GRAFICO
      double porcentagens = 0;
      //* VERFICAÇÕES
      if (!isSaldo) {
        //? SE NÃO É SALDO, PORCENTAGEM RECEBE PREÇO DA CARTEIRA VEZES QUANTIDADE
        //? DIVIDIDO PELO TOTAL DA CARTEIRA
        porcentagens =
            carteira[i].moeda.preco * carteira[i].quantidade / totalCarteira;
      } else {
        //? CASO CONTRARIO, SERÁ TRABALHADO COM O SALDO, VERIFICA SE NÃO É ZERO PRIMEIRO
        porcentagens = (conta.saldo > 0) ? conta.saldo / totalCarteira : 0;
      }
      //? PARA AS PORCENTAGENS FICAREM CORRETAS, MULTIPLICA POR 100
      porcentagens *= 100;

      return PieChartSectionData(
        color: color,
        value: porcentagens,
        title: '${porcentagens.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    });
  }

  loadGrafico() {
    return (conta.saldo <= 0)
        ? Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              //? ASPCETRATIO PRA OCUPAR UMA PORÇÃO DA TELA
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 5,
                    centerSpaceRadius: 110,
                    sections: loadCarteira(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            index = -1;
                            return;
                          }
                          index = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                          setGraficoDados(index);
                        });
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    real.format(graficoValor),
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ],
              )
            ],
          );
  }
}
