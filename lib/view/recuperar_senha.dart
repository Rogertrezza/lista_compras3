import 'package:flutter/material.dart';

import 'package:lista_compras3/model/repos_usuario.dart';
import 'package:lista_compras3/model/usuario.dart';

class recuperar_senha extends StatefulWidget {
  final UserRepository userRepository;
  recuperar_senha({required this.userRepository});

  @override
  _recuperar_senhaState createState() => _recuperar_senhaState();
}

class _recuperar_senhaState extends State<recuperar_senha> {
  // Chave identificador do Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// Identificador do Form
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Atribuição da scaffoldKey ao Scaffold
      appBar: AppBar(
        title: Text("Cadastro de usuário"),
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Recuperar senha",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      "lib/img/logo.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: emailLogin,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // Verifica se o campo está vazio
                          return 'Informe um e-mail.';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          // Verifica se o e-mail está em um formato válido usando uma expressão regular
                          return 'Informe um e-mail válido.';
                        }
                        // Retornar null significa que a validação passou
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: Color(0xFF7165d6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            var email = emailLogin.text;

                            if (formKey.currentState!.validate()) {
                              final usuario =
                                  widget.userRepository.usuarios.firstWhere(
                                (user) => user.email == email,
                                orElse: () => Usuario(
                                    nome: '',
                                    telefone: '',
                                    email: '',
                                    senha: ''),
                              );
                              if (usuario.nome.isNotEmpty) {
                                final nomeUsuario = usuario.senha;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Sua senha é ${nomeUsuario}'),
                                  ),
                                );
                                // Navegar para a próxima tela após o login bem-sucedido
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Email não encontrado'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Recuperar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já recuperou a senha?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'login',
                          );
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7165D6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
