import 'pessoa.dart';

class Cliente extends Pessoa {
  String id;
  String cpf;

  Cliente({
    required this.id,
    required this.cpf,
    required String name,
    required String sobrenome,
  }) : super(name: name, sobrenome: sobrenome);
}
