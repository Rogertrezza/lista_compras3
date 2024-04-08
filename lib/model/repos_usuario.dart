import 'usuario.dart';

class UserRepository {
  List<Usuario> _usuarios = [];

  void adicionarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  List<Usuario> get usuarios => _usuarios;
}
