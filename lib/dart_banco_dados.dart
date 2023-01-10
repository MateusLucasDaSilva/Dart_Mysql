import 'package:dart_banco_dados/database.dart';
import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  //Criando instancia do classe de conexão com o banco de dados
  final database = Database();

  //Chamando o método que realzia a abertura da conexão
  var mysqlConnection = await database.openConnection();

  print(mysqlConnection.toString());

//Esse método castrastra um registro do banco de dados
  var resultado = await mysqlConnection
      .query('insert into aluno(id, nome) values(?,?)', [null, 'Samuel Lucas']);

  print(resultado.affectedRows);

//Esse método realiza a busca de todo os registros de uma tabela do banco de dados
  var resultadoSelect = await mysqlConnection.query('select * from aluno');

  resultadoSelect.forEach((row) {
    print('Resultado por indice:');
    print(row[0]);
    print(row[1]);

    print('Resultado por coluna:');
    print(row['id']);
    print(row['nome']);
  });

//Esse método realiza uma busca por um registro expecifico do banco de dados.
  var resultadoSelectUnico =
      await mysqlConnection.query('select * from aluno where id = ?', [1]);
  print('Parametro Unico: ');

  if (resultadoSelectUnico.isNotEmpty) {
    var rowUnico = resultadoSelectUnico.first;
    print('Resultado por indice:');
    print(rowUnico[0]);
    print(rowUnico[1]);

    print('Resultado por coluna:');
    print(rowUnico['id']);
    print(rowUnico['nome']);
  }

// Esse método realiza a atualização de um registro do banco de dados
  try {
    await mysqlConnection.query(
        'update aluno set nome = ? where id = ?', ['Mateus Lucas da Silva', 1]);
  } catch (e) {
    print(e);
    print('Erro ao atualizar aluno!');
  }

//Esse metodo veririca se a primeira quary foi executada sem erros, se sim,
//ela grava o dado numa tabela temporaria do banco de dados, caso as proximas
// quarys dêem algum erro, a primeira quary é revertida
  await mysqlConnection.transaction((x) async {
    print(x);
    await mysqlConnection.query('insert into aluno(id, nome) values(?,?)',
        [null, 'teste de transacao']);

    await mysqlConnection.query('update aluno set nome = ? where id = ?',
        ['Mateus Lucas da Silva', 10]);
  });

  mysqlConnection.close();
}
