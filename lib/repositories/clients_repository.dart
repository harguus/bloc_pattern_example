import 'package:bloc_pattern_example/models/client_model.dart';

class ClientsRepository {
  final List<ClientModel> _clients = [];

  List<ClientModel> loadClients() {
    _clients.addAll([
      ClientModel(nome: 'José Armando'),
      ClientModel(nome: 'Anastácia Silva'),
      ClientModel(nome: 'Marineiva Gonçalvez'),
      ClientModel(nome: 'Bruno Marcondez'),
    ]);
    return _clients;
  }

  List<ClientModel> addClient(ClientModel client) {
    _clients.add(client);
    return _clients;
  }

  List<ClientModel> removeClient(ClientModel client) {
    _clients.remove(client);
    return _clients;
  }
}
