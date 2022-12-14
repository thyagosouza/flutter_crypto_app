import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  //? É NECESSÁRIO PARA FAZER TODA A ABERTURA DO BANCO, CONFIGURAÇÃO DAS TABELAS
  //? INICIALIZAÇÃO DAS OPERAÇÕES INICIAIS
  //* PADRÃO SINGLETON: PERMITE QUE A CLASSE GERENCIE SUA PROPRIA INSTANCIAÇÃO
  //* SOMENTE UMA CLASSE DESSA INSTÂNCIA POSSA SER CRIADA

  //? CONSTRTUROR COM ACESSO PRIVADO
  DB._();
  //? CRIAR UMA INSTÂNCIA DE DB
  static final DB instance = DB._();
  //? INSTÂNCIA DO SQLITE
  static Database? _database;

  get database async {
    //? VERIFICAR SE O DATABASE É DIFERENTE DE NULL, SE FOR, RETORNA DATABASE
    //? FORMA DE RETORNAR SOMENTE UMA INSTÂNCIA
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      //? JOIN PRA UNIR O GETDATABASEPATH - PEGAR O CAMINHO NO ANDROID IOS PRA SALVAR O BANCO DE DADOS
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      //? FUNÇÃO QUE SERÁ EXECUTADA NA PRIMEIRA VEZ QUE O BANCO SERÁ CRIADO
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    //? FAZER A EXECUÇÃO DE UM DETERMINADO SCRIPT
    await db.execute(_conta);

    //? TODAS AS POSIÇÕES DE MOEDAS QUE O USUÁRIO COMPROU
    await db.execute(_carteira);
    //? HISTORICO DE OPERAÇÕES
    await db.execute(_historico);
    //? INSERIR A CONTA COM O SALDO ZERADO
    await db.insert('conta', {'saldo': 0});
  }

  //* ESTRUTURAS DAS TABELAS
  //* STRING EM BLOCO NO DAR = '''  conteudo '''

  String get _conta => '''
    CREATE TABLE conta (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      saldo REAL
    );
  
  ''';
  String get _carteira => '''
    CREATE TABLE carteira (
      sigla TEXT PRIMARY KEY,
      moeda TEXT,
      quantidade TEXT
    );
  
  ''';
  String get _historico => '''
    CREATE TABLE historico (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_operacao INT,
      tipo_operacao TEXT,
      moeda TEXT,
      sigla TEXT,
      valor REAL,
      quantidade TEXT
    );
  
  ''';
}
