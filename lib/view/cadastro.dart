import 'package:flutter/material.dart';
import 'package:lista_compras3/model/repos_usuario.dart';
import 'package:lista_compras3/model/usuario.dart';

class cadastro extends StatefulWidget {
  final UserRepository userRepository;

  cadastro({required this.userRepository});

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {
  // Chave identificador do Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Atributos
  bool senhapasse = true;

  //Chave identificado do Form
  var formKey = GlobalKey<FormState>();
  final TextEditingController nomeCadastro = TextEditingController();
  final TextEditingController telefoneCadastro = TextEditingController();
  final TextEditingController emailCadastro = TextEditingController();
  final TextEditingController senhaCadastro = TextEditingController();

  bool _containsLetterAndNumber(String value) {
    // Verifica se a senha contém pelo menos uma letra e um número
    return RegExp(r'[a-zA-Z]').hasMatch(value) && RegExp(r'\d').hasMatch(value);
  }

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
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      "lib/img/logo.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: nomeCadastro,
                      decoration: InputDecoration(
                        labelText: "Nome completo",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe um nome.';
                        }
                        // Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: emailCadastro,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: telefoneCadastro,
                      decoration: InputDecoration(
                        labelText: "Telefone",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null) {
                          return 'Informe um telefone.';
                        } else if (value.isEmpty) {
                          return 'Informe um telefone.';
                        } else if (double.tryParse(value) == null) {
                          return 'Apenas numero.';
                        }
                        //Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: senhaCadastro,
                      obscureText: senhapasse ? true : false,
                      decoration: InputDecoration(
                        labelText: "senha",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (senhapasse == true) {
                              senhapasse = false;
                            } else {
                              senhapasse = true;
                            }
                            setState(() {});
                          },
                          child: senhapasse
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye_rounded),
                        ),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma senha';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        } else if (!_containsLetterAndNumber(value)) {
                          return 'A senha deve conter letras e números';
                        }
                        // Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: Color(0xFF7165d6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            var nome = nomeCadastro.text;

                            if (formKey.currentState!.validate()) {
                              // Se o formulário for válido, crie o usuário
                              final novoUsuario = Usuario(
                                nome: nomeCadastro.text,
                                telefone: telefoneCadastro.text,
                                email: emailCadastro.text,
                                senha: senhaCadastro.text,
                              );
                              // Adicione o usuário ao repositório
                              widget.userRepository
                                  .adicionarUsuario(novoUsuario);
                              Navigator.pushNamed(
                                context,
                                'login',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Conta criada com sucesso: ${nome}'),
                                  duration: Duration(seconds: 6),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Criar Conta",
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
                        "Já possui uma conta?",
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
                          "Logar",
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
