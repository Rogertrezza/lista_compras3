import 'package:lista_compras3/model/produto.dart';

class ListaDeCompras {
  String nome;
  DateTime dataCriacao;
  List<Produto> listaProdutos;

  ListaDeCompras({
    required this.nome,
    required this.dataCriacao,
    required this.listaProdutos,
  });
}