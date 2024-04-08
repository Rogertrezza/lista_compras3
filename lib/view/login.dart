import 'package:flutter/material.dart';
import 'package:lista_compras3/model/repos_usuario.dart';
import 'package:lista_compras3/model/usuario.dart';

class login extends StatefulWidget {
  final UserRepository userRepository;

  login({required this.userRepository});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // Chave identificador do Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool passe_email = false;
  bool passe_senha = true;

  //Chave identificado do Form
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailLogin = TextEditingController();
  final TextEditingController senhaLogin = TextEditingController();

  bool validarCampos(String email, String senha) {
    // Verifica se o campo de e-mail está vazio
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail não pode estar vazio')),
      );
      return false;
    }

    // Verifica se o campo de e-mail possui um formato válido
    final emailValido =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!emailValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail inválido')),
      );
      return false;
    }

    // Verifica se o campo de senha está vazio
    if (senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha não pode estar vazia')),
      );
      return false;
    }

    // Verifica se a senha tem pelo menos 6 caracteres
    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('A senha deve ter pelo menos 6 caracteres')),
      );
      return false;
    }

    // Se passou por todas as verificações, retorna verdadeiro
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Atribuição da scaffoldKey ao Scaffold
      appBar: AppBar(
        title: Text("Tela de login"),
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  "Login",
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
                  child: TextField(
                    controller: emailLogin,
                    obscureText: passe_email ? true : false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: senhaLogin,
                    obscureText: passe_senha ? true : false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("senha"),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          if (passe_senha == true) {
                            passe_senha = false;
                          } else {
                            passe_senha = true;
                          }
                          setState(() {});
                        },
                        child: passe_senha
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
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
                          var senha = senhaLogin.text;

                          if (validarCampos(email, senha)) {
                            final usuario =
                                widget.userRepository.usuarios.firstWhere(
                              (user) =>
                                  user.email == email && user.senha == senha,
                              orElse: () => Usuario(
                                  nome: '', telefone: '', email: '', senha: ''),
                            );
                            if (usuario.nome.isNotEmpty) {
                              final nomeUsuario = usuario.nome;
                              Navigator.pushNamed(
                                context,
                                'navBar',
                                arguments: nomeUsuario,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login bem-sucedido!'),
                                ),
                              );
                              // Navegar para a próxima tela após o login bem-sucedido
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Credenciais inválidas. Tente novamente.'),
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
                              "Entrar",
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
                      "Esqueceu sua senha?",
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
                          'recuperar_senha',
                        );
                      },
                      child: Text(
                        "Recuperar senha",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não possui uma conta?",
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
                          'cadastro',
                        );
                      },
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6)),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Saiba mais sobre o projeto",
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
                          'sobre',
                        );
                      },
                      child: Text(
                        "Clique aqui",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6)),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
