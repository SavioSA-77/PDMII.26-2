import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  // Inicializa o FFI do SQLite para uso em Dart puro (sem Flutter)
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  
  String dbPath = 'alunos.db';
  late Database db;

  // 1 e 2: Criar/Abrir banco de dados e criar tabela tb_alunos (se não existir)
  try {
    print('1 e 2. Inicializando o banco de dados e criando a tabela...');
    
    db = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE tb_alunos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT,
              curso TEXT
            )
          ''');
          print('--> Tabela tb_alunos criada com sucesso!');
        },
      ),
    );
    print('--> Conexão com alunos.db estabelecida!');
  } catch (e) {
    print('Erro ao criar/abrir o banco de dados: $e');
    return; // Interrompe se não houver banco
  }

  // 3: Incluir três alunos na tabela
  try {
    print('\n3. Inserindo três alunos na tabela...');
    
    await db.insert('tb_alunos', {'nome': 'Ana Silva', 'curso': 'Ciência da Computação'});
    await db.insert('tb_alunos', {'nome': 'Carlos Souza', 'curso': 'Sistemas de Informação'});
    await db.insert('tb_alunos', {'nome': 'Mariana Costa', 'curso': 'Engenharia de Software'});
    
    print('--> 3 alunos inseridos com sucesso!');
  } catch (e) {
    print('Erro ao inserir os alunos: $e');
  }

  // 4: Listar o conteúdo da tabela tb_alunos
  try {
    print('\n4. Listando o conteúdo da tabela tb_alunos:');
    
    // O retorno exato do SQLite no Dart moderno é Map<String, Object?>
    List<Map<String, Object?>> resultados = await db.query('tb_alunos');

    if (resultados.isEmpty) {
      print('--> Nenhum aluno encontrado na tabela.');
    } else {
      for (var aluno in resultados) {
        print('ID: ${aluno['id']} | Nome: ${aluno['nome']} | Curso: ${aluno['curso']}');
      }
    }
  } catch (e) {
    print('Erro ao consultar a tabela: $e');
  }

  // Finalização: Fechar o banco de dados
  try {
    await db.close();
    print('\n--> Conexão com o banco de dados encerrada.');
  } catch (e) {
    print('Erro ao fechar a conexão com o banco de dados: $e');
  }
}