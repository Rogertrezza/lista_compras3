import 'package:flutter/material.dart';
import 'package:lista_compras3/model/lista_compra.dart';
import 'package:lista_compras3/model/produto.dart';
import 'package:lista_compras3/model/repos_lista.dart';

class home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  final ListaDeComprasRepository listaDeComprasRepository =
      ListaDeComprasRepository();

  @override
  void initState() {
    super.initState();
    preencherListasDeCompras();
  }

  // Função para preencher a lista de compras
  void preencherListasDeCompras() {
    listaDeComprasRepository.adicionarListaDeCompras(
      ListaDeCompras(
        nome: "Savegnago",
        dataCriacao: DateTime(2024, 1, 1),
        listaProdutos: [
          Produto(nome: "Limao", valor: 10.0, quantidade: 2),
          Produto(nome: "Pinga", valor: 15.0, quantidade: 1),
        ],
      ),
    );
    listaDeComprasRepository.adicionarListaDeCompras(
      ListaDeCompras(
        nome: "Mercadão",
        dataCriacao: DateTime(2024, 1, 2),
        listaProdutos: [
          Produto(nome: "Biscoito", valor: 20.0, quantidade: 3),
          Produto(nome: "Bolacha", valor: 25.0, quantidade: 2),
        ],
      ),
    );
    listaDeComprasRepository.adicionarListaDeCompras(
      ListaDeCompras(
        nome: "Supermercado ABC",
        dataCriacao: DateTime(2024, 1, 3),
        listaProdutos: [
          Produto(nome: "Arroz", valor: 30.0, quantidade: 1),
          Produto(nome: "Feijao", valor: 35.0, quantidade: 4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nomeUsuario = ModalRoute.of(context)!.settings.arguments;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Olá $nomeUsuario",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("lib/img/logo.png"),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // ListView para organizar as listas de compras em uma coluna
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (listaDeComprasRepository.getNomesListas().length / 2)
                .ceil(), // Calcula o número de linhas necessárias
            itemBuilder: (context, index) {
              // Organiza 2 itens por linha
              int startIndex = index * 2;
              int endIndex = (index + 1) * 2;
              if (endIndex >
                  listaDeComprasRepository.getNomesListas().length) {
                endIndex =
                    listaDeComprasRepository.getNomesListas().length;
              }
              List<String> rowListasCompras = listaDeComprasRepository
                  .getNomesListas()
                  .sublist(startIndex, endIndex);

              // Cria uma linha com 2 itens
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (String listaNome in rowListasCompras)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Ação ao clicar na lista de compras
                          _showListaDetails(listaNome);
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFF7165D6),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.list_alt,
                                  color: Color(0xFF7165D6),
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                listaNome,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showListaDetails(String listaNome) {
    // Buscar informações da lista pelo nome
    ListaDeCompras? lista =
        listaDeComprasRepository.buscarListaDeCompras(listaNome);

    if (lista != null) {
      // Exibir informações da lista em uma nova tela ou diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Detalhes da Lista"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Nome da Lista: ${lista.nome}"),
                Text("Data de Criação: ${lista.dataCriacao}"),
                Text("Itens da Lista:"),
                Column(
                  children: lista.listaProdutos.map((produto) {
                    return ListTile(
                      title: Text(produto.nome),
                      subtitle:
                          Text("Quantidade: ${produto.quantidade}, Valor: ${produto.valor}"),
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Text('Modificar'),
                              value: 'Modificar',
                            ),
                            PopupMenuItem(
                              child: Text('Excluir'),
                              value: 'Excluir',
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 'Modificar') {
                            // Abrir diálogo para editar o item
                            _showEditarItem(produto);
                          } else if (value == 'Excluir') {
                            // Lógica para excluir o item
                            print('Excluir: ${produto.nome}');
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Fechar"),
              ),
              TextButton(
                onPressed: () {
                  // Lógica para excluir a lista de compras
                  print('Excluir lista de compras: ${lista.nome}');
                },
                child: Text("Excluir Lista"),
              ),
            ],
          );
        },
      );
    } else {
      // Se a lista não for encontrada, exiba uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lista de compras não encontrada!"),
        ),
      );
    }
  }

  void _showEditarItem(Produto produto) {
    // Abrir diálogo para editar o item
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Item"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: produto.nome),
                decoration: InputDecoration(labelText: 'Nome do Item'),
              ),
              TextField(
                controller:
                    TextEditingController(text: produto.quantidade.toString()),
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: TextEditingController(text: produto.valor.toString()),
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Lógica para salvar as alterações
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
}