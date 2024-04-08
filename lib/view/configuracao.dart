import 'package:flutter/material.dart';
import 'package:lista_compras3/model/repos_usuario.dart';
import 'package:lista_compras3/model/usuario.dart';

class configuracao extends StatefulWidget {
  final UserRepository userRepository;

  const configuracao({Key? key, required this.userRepository}) : 
  super(key: key);

  @override
  _configuracaoState createState() => _configuracaoState();
}

class _configuracaoState extends State<configuracao> {
  @override
  Widget build(BuildContext context) {
    final nomeUsuario = ModalRoute.of(context)!.settings.arguments;

    return Padding(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Configuração",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("lib/img/logo.png"),
              ),
              title: Text(
                "${nomeUsuario}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ),
            Divider(height: 50),
            ListTile(
              onTap: () {
                _showUserDetails(context, '$nomeUsuario', UserRepository());
              }, // Correção aqui
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade100, shape: BoxShape.circle),
                child: Icon(Icons.person, color: Colors.indigo, size: 25),
              ),
              title: Text(
                "Perfil",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100, shape: BoxShape.circle),
                child: Icon(Icons.notification_add,
                    color: Colors.deepPurple, size: 25),
              ),
              title: Text(
                "Notificação",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'sobre',
                  arguments: nomeUsuario,
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.orange.shade100, shape: BoxShape.circle),
                child: Icon(Icons.info, color: Colors.orange, size: 25),
              ),
              title: Text(
                "Sobre",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 100),
            Divider(height: 50),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'login',
                  arguments: nomeUsuario,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deslogado ${nomeUsuario} com sucesso'),
                    duration: Duration(seconds: 6),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.redAccent.shade100, shape: BoxShape.circle),
                child: Icon(Icons.logout, color: Colors.redAccent, size: 25),
              ),
              title: Text(
                "Sair",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

 void _showUserDetails(BuildContext context, String nomeUsuario, UserRepository userRepository) {
  
  final usuario = userRepository.usuarios.firstWhere(
    (user) => user.email == nomeUsuario,
    orElse: () => Usuario(nome: '', telefone: '', email: '', senha: ''),
  );

  final emailUsuario = usuario.email;
  final senhaUsuario = usuario.senha;
  final telefoneUsuario = usuario.telefone;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Detalhes do Usuário'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nome: $nomeUsuario'),
            SizedBox(height: 10),
            Text('Email: $emailUsuario'),
            SizedBox(height: 10),
            Text('Senha: $senhaUsuario'),
            SizedBox(height: 10),
            Text('Telefone: $telefoneUsuario'),
            SizedBox(height: 10),
            // Adicione outras informações do usuário aqui conforme necessário
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
