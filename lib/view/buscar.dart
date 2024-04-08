import 'package:flutter/material.dart';
import 'package:lista_compras3/model/lista_compra.dart';
import 'package:lista_compras3/model/repos_lista.dart';

class buscaItem extends StatefulWidget {
  final ListaDeComprasRepository listaDeComprasRepository;

  const buscaItem({Key? key, required this.listaDeComprasRepository})
      : super(key: key);

  @override
  _buscaItemState createState() => _buscaItemState();
}

class _buscaItemState extends State<buscaItem> {
  TextEditingController _searchController = TextEditingController();
  List<ListaDeCompras> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = widget.listaDeComprasRepository.getAllListasDeCompras();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    String searchTerm = _searchController.text;
    setState(() {
      _searchResults = widget.listaDeComprasRepository
          .getAllListasDeCompras()
          .where((lista) => lista.nome.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar lista"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Pesquisar",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _search,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index].nome),
                  onTap: () {
                    _showListaDetails(_searchResults[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showListaDetails(ListaDeCompras lista) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(lista.nome),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Data de Criação: ${lista.dataCriacao}"),
              SizedBox(height: 10),
              Text("Produtos:"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lista.listaProdutos.map((produto) {
                  return Text(
                      "${produto.nome} - R\$${produto.valor} - ${produto.quantidade}");
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
