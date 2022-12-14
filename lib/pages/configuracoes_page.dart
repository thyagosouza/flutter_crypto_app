import 'package:crypto_moedas/configs/app_settings.dart';
import 'package:crypto_moedas/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    //? IMPORTAR E UTILIZAR OS PROVIDERS
    final conta = context.watch<ContaRepository>();
    //? IMPORTAR APPSETTINGS PARA ACESSAR OS NÚMEROS NO FORMATO NÚMERICO DOLAR E REAL
    //* PROVIDER DO APPSETTINGS PARA PEGAR O LOCALE
    final loc = context.read<AppSettings>().locale;
    //? RECEBER A CURRENCY SALVA
    NumberFormat real =
        NumberFormat.currency(locale: loc['locale'], name: loc['name']);

    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Saldo'),
              subtitle: Text(
                real.format(conta.saldo),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              trailing: IconButton(
                //? FAZER EDIÇÃO VALOR DO SALDO
                onPressed: updateSaldo,
                icon: Icon(Icons.edit),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  updateSaldo() async {
    //* DEFINIR UM FOR = PARA TER A KEY
    final form = GlobalKey<FormState>();
    //* DEFINIR VALOR = TEXTEDITINGCONTROLLER
    final valor = TextEditingController();
    //* RECUPERAR A CONTA POR MEIO DO CONTA REPOSITORY
    final conta = context.read<ContaRepository>();

    //* PEGAR O VALOR DIGITADO E SETAR COM O VALOR ATUAL QUE ESTÁ EM CONTA
    valor.text = conta.saldo.toString();

    //? ALERT DIALOG PARA MOSTRAR ESSA OPÇÃO PARA O USUÁRIO

    AlertDialog dialog = AlertDialog(
      title: Text('Atualizar o Saldo'),
      //? FORMULÁRIO
      content: Form(
        key: form,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            //? PERMITIR SOMENTE NUMEROS DO TIPO FLUTUANTE COM EXPRESSÃO REGULAR
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return 'Informe o valor do saldo';
            return null;
          },
        ),
      ),
      //? BOTÕES QUE IRÃO APARECER NO ALERT
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
        TextButton(
            onPressed: () {
              //? VERIFICAR SE O FORM ESTÁ VALIDADO
              if (form.currentState!.validate()) {
                conta.setSaldo(double.parse(valor.text));
                //? PARA FECHAR O ALERT
                Navigator.pop(context);
              }
            },
            child: Text('Salvar')),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}
