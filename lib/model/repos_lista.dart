// Repositório para gerenciar as listas de compras
import 'package:lista_compras3/model/lista_compra.dart';

class ListaDeComprasRepository {
  List<ListaDeCompras> _listasDeCompras = [];

  // Método para adicionar uma nova lista de compras ao repositório
  void adicionarListaDeCompras(ListaDeCompras lista) {
    _listasDeCompras.add(lista);
  }

  // Método para buscar uma lista de compras pelo nome
  ListaDeCompras? buscarListaDeCompras(String nomeLista) {
    try {
      return _listasDeCompras.firstWhere(
        (lista) => lista.nome == nomeLista,
      );
    } catch (e) {
      return null;
    }
  }

  // Método para deletar uma lista de compras pelo nome
  void deletarListaDeCompras(String nomeLista) {
    _listasDeCompras.removeWhere((lista) => lista.nome == nomeLista);
  }

  // Método para modificar uma lista de compras pelo nome
  void modificarListaDeCompras(
      String nomeListaAntiga, ListaDeCompras novaLista) {
    final index =
        _listasDeCompras.indexWhere((lista) => lista.nome == nomeListaAntiga);
    if (index != -1) {
      _listasDeCompras[index] = novaLista;
    }
  }

  // Retorna todas as listas cadastradas
  List<String> getNomesListas() {
    return _listasDeCompras.map((lista) => lista.nome).toList();
  }

    // Retorna todas as listas de compras
  List<ListaDeCompras> getAllListasDeCompras() {
    return List.from(_listasDeCompras);
  }
}
