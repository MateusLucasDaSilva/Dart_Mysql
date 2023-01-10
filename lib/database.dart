import 'package:mysql1/mysql1.dart';
//Classe responsável pela configuração do banco de dados
class Database {

  // Método responsável pela abertura da conexão com o banco de dados 
  Future<MySqlConnection> openConnection() async {
    var settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: '1234',
        db: 'dart_mysql');

    final connection = await MySqlConnection.connect(settings);
    await Future.delayed(Duration(seconds: 1));
    return connection;
  }
}

/*
ESCRIP DO BANCO DE DADOS:

create database dart_mysql;
use dart_mysql;

create table aluno(
 id int not null primary key auto_increment,
 nome varchar(200)
);

 */
