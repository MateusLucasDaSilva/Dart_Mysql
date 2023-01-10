import 'package:dart_banco_dados/database.dart';
import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  final database = Database();
  var mysqlConnection = await database.openConnection();

  print(mysqlConnection.toString());
/*
  var resultado = await mysqlConnection
      .query('insert into aluno(id, nome) values(?,?)', [null, 'Samuel Lucas']);

  print(resultado.affectedRows);
*/
  var resultadoSelect = await mysqlConnection.query('select * from aluno');

  resultadoSelect.forEach((row) {
    print('Resultado por indice:');
    print(row[0]);
    print(row[1]);

    print('Resultado por coluna:');
    print(row['id']);
    print(row['nome']);
  });

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

  try {
    await mysqlConnection.query(
        'update aluno set nome = ? where id = ?', ['Mateus Lucas da Silva', 1]);
  } catch (e) {
    print(e);
    print('Erro ao atualizar aluno!');
  }

//Esse metodo veririca se a primeira quary 
  await mysqlConnection.transaction((x) async {
    print(x);
    await mysqlConnection.query(
        'insert into aluno(id, nome) values(?,?)', [null, 'teste de transacao']);

    await mysqlConnection.query(
        'update aluno set nome = ? where id = ?', ['Mateus Lucas da Silva', 10]);

  });

}
