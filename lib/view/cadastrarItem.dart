import 'package:flutter/material.dart';
import 'package:lista_compras3/model/lista_compra.dart';
import 'package:lista_compras3/model/produto.dart';
import 'package:lista_compras3/model/repos_lista.dart';

class cadastrarItem extends StatefulWidget {
  final ListaDeComprasRepository listaDeComprasRepository;

  const cadastrarItem({Key? key, required this.listaDeComprasRepository}) : super(key: key);

  @override
  _cadastrarItemState createState() => _cadastrarItemState();
}

class _cadastrarItemState extends State<cadastrarItem> {
  TextEditingController nomeListaController = TextEditingController();
  TextEditingController nomeItemController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  List<Produto> itens = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de lista"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Criar Nova Lista de Compras",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nomeListaController,
              decoration: InputDecoration(
                labelText: "Nome da Lista",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Cadastro de Itens",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nomeItemController,
              decoration: InputDecoration(
                labelText: "Nome do Item",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: "Valor",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10),
            TextField(
              controller: quantidadeController,
              decoration: InputDecoration(
                labelText: "Quantidade",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Adiciona o item à lista de itens
                String nomeItem = nomeItemController.text;
                double valor = double.parse(valorController.text);
                int quantidade = int.parse(quantidadeController.text);
                Produto novoItem = Produto(
                  nome: nomeItem,
                  valor: valor,
                  quantidade: quantidade,
                );
                setState(() {
                  itens.add(novoItem);
                });
                // Limpa os campos após adicionar o item
                nomeItemController.clear();
                valorController.clear();
                quantidadeController.clear();
              },
              child: Text("Adicionar Item"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Cria a nova lista de compras e adiciona os itens
                String nomeLista = nomeListaController.text;
                ListaDeCompras novaLista = ListaDeCompras(
                  nome: nomeLista,
                  dataCriacao: DateTime.now(),
                  listaProdutos: itens,
                );
                widget.listaDeComprasRepository.adicionarListaDeCompras(novaLista);
                // Limpa os campos após criar a lista
                nomeListaController.clear();
                setState(() {
                  itens = [];
                });
                // Mostra um snackbar para confirmar a criação da lista
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lista de compras criada com sucesso!'),
                  ),
                );
              },
              child: Text("Criar Lista de Compras"),
            ),
            SizedBox(height: 30),
            Text(
              "Itens da Lista",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Mostra os itens adicionados à lista de compras
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                return ListTile(
                  title: Text(item.nome),
                  subtitle: Text("Quantidade: ${item.quantidade}, Valor: ${item.valor}"),
                );
              },
            ),
          ],
        ),
      ),
    );
    
  }
    void refreshList() {
    setState(() {
      // Atualiza a lista na home
    });
}
}