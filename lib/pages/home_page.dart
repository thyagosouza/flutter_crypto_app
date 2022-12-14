import 'package:crypto_moedas/pages/moedas_page.dart';
import 'package:flutter/material.dart';

import 'carteira_page.dart';
import 'configuracoes_page.dart';
import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0; //? CONTROLAR OS INDICES DAS PAGINAS
  late PageController pc; //? CONTROLLAR AS PAGINAS

  @override
  void initState() {
    super.initState();

    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          MoedasPage(),
          FavoritasPage(),
          CarteiraPage(),
          ConfiguracoesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //? IMPEDE SCROLL DE ICONES COM MAIS DE 3 ICONES
        type: BottomNavigationBarType.fixed,
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(microseconds: 500),
            curve: Curves.ease,
          );
        },
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Carteira',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Conta',
          ),
        ],
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
