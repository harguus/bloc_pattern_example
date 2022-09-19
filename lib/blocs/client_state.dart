import 'package:bloc_pattern_example/models/client_model.dart';

abstract class ClientState {
  List<ClientModel> clients;

  ClientState({
    required this.clients,
  });
}

class ClientInitialState extends ClientState {
  ClientInitialState() : super(clients: []);
}

class ClientSuccessState extends ClientState {
  ClientSuccessState({required List<ClientModel> clients})
      : super(clients: clients);
}
