import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:crypto_moedas/pages/moedas_detalhes_page.dart';
import 'package:crypto_moedas/repositories/favoritas_repository.dart';
import 'package:crypto_moedas/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_Br', name: 'R\$');
  List<MoedaModel> selecionadas = [];
  late FavoritasRepository favoritas = FavoritasRepository();

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Crypto Moedas'),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas.clear();
            });
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text(
          ' ${selecionadas.length} selecionadas',
        ),
      );
    }
  }

  mostrarDetalhes(MoedaModel moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    //* INSTÂNCIA DO PROVIDER
    //favoritas = Provider.of<FavoritasRepository>(context);
    //? ACESSAR PROVIDER PELO CONTEXT
    favoritas = context.watch<FavoritasRepository>();

    //
    return Scaffold(
      appBar: appBarDinamica(),
      //* itemBuilder = construir cada uma das nossas linhas
      body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            //* RETORNA 1 LINHA COM LISTTILE
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              //* leading = icone que vai à esquerda
              leading: selecionadas.contains(tabela[moeda])
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      width: 40,
                      child: Image.asset(tabela[moeda].icone),
                    ),
              title: Row(
                children: [
                  Text(
                    tabela[moeda].nome,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      //color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (favoritas.lista.contains(tabela[moeda]))
                    Icon(Icons.star, color: Colors.amber, size: 8),
                ],
              ),
              trailing: Text(real.format(tabela[moeda].preco)),

              selected: selecionadas.contains(tabela[moeda]),
              selectedTileColor: Colors.indigo[50],
              onLongPress: () {
                setState(() {
                  selecionadas.contains(tabela[moeda])
                      ? selecionadas.remove(tabela[moeda])
                      : selecionadas.add(tabela[moeda]);
                  print(tabela[moeda].nome);
                  //isSeleted = !isSeleted;
                });
              },
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: tabela.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              icon: Icon(Icons.star),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                //? NÃO PRECISA DO SET STATE
                //? NOTIFYLISTERNERS JÁ ESTÁ ATUALIZANDO
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
            )
          : null,
    );
  }
}
