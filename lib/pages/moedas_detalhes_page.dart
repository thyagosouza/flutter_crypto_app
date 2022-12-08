// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../configs/app_settings.dart';

class MoedasDetalhesPage extends StatefulWidget {
  final MoedaModel moeda;

  const MoedasDetalhesPage({
    Key? key,
    required this.moeda,
  }) : super(key: key);

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  late NumberFormat real;
  late Map<String, String> loc;
  // NumberFormat real = NumberFormat.currency(locale: 'pt_Br', name: 'R\$');
  final _formKey = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  //* metodo para fazer a inicialização da Localização quanto do numberformat
  readNumberFormat() {
    //? a preferencia ficará dinamica
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(
      locale: loc['locale'],
      name: loc['name'],
    );
  }

  comprar() {
    //? validate pode ser null, por isso o ponto de exclamação
    if (_formKey.currentState!.validate()) {
      //? SALVAR A COMPRA NO BANCO LOCAL

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Compra realizada com sucesso!')));
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 50, child: Image.asset(widget.moeda.icone)),
                SizedBox(width: 10),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                      fontSize: 26,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800]),
                )
              ],
            ),
            SizedBox(height: 24),
            (quantidade > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Text(
                        '$quantidade ${widget.moeda.sigla}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 24),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration:
                          BoxDecoration(color: Colors.teal.withOpacity(.05)),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 24),
                  ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _valor,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                  ),
                  suffix: Text(
                    'reais',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < 50) {
                    return 'Compra minima é R\$ 50,00 reais';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                        ? 0
                        : double.parse(value) / widget.moeda.preco;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              // width: double.maxFinite,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: comprar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'COMPRAR',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
