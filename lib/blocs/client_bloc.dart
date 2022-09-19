import 'dart:async';

import 'package:bloc_pattern_example/blocs/client_events.dart';
import 'package:bloc_pattern_example/blocs/client_state.dart';
import 'package:bloc_pattern_example/models/client_model.dart';
import 'package:bloc_pattern_example/repositories/clients_repository.dart';

class ClientBloc {
  final _clientRepository = ClientsRepository();

  final StreamController<ClientEvents> _inputClientController =
      StreamController<ClientEvents>();
  final StreamController<ClientState> _outputClientController =
      StreamController<ClientState>();

  Sink<ClientEvents> get inputClient => _inputClientController.sink;
  Stream<ClientState> get outputClient => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvents event) {
    List<ClientModel> clients = [];

    if (event is LoadClientEvent) {
      clients = _clientRepository.loadClients();
    } else if (event is AddClientEvent) {
      clients = _clientRepository.addClient(event.client);
    } else if (event is RemoveClientEvent) {
      clients = _clientRepository.removeClient(event.client);
    }

    _outputClientController.add(ClientSuccessState(clients: clients));
  }
}
