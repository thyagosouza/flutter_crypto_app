import 'package:crypto_moedas/models/moeda_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoedaHiveAdapter extends TypeAdapter<MoedaModel> {
  //? ID UNICO DESSE ADAPTADOR, COMEÇA SEMPRE COM 0 PODE DIR ATÉ 200
  //! SÓ É NECESSÁRIO PARA DADOS MAIS COMPLEXOS
  @override
  final typeId = 1;
  //? METODO DO PROPRIO TYPEADAPTER
  @override
  MoedaModel read(BinaryReader reader) {
    //? QUANDO LER DO HIVE RETORNA UMA MOEDA
    return MoedaModel(
      icone: reader.readString(),
      nome: reader.readString(),
      sigla: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MoedaModel obj) {
    //? acessar writer
    writer.writeString(obj.icone);
    writer.writeString(obj.nome);
    writer.writeString(obj.sigla);
    writer.writeDouble(obj.preco);
  }
}
