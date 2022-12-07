import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:crypto_moedas/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_Br', name: 'R\$');
  List<MoedaModel> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text('Crypto Moedas'),
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

  //
  @override
  Widget build(BuildContext context) {
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
              title: Text(
                tabela[moeda].nome,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  //color: Theme.of(context).primaryColor,
                ),
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
              onPressed: () {},
            )
          : null,
    );
  }
}
