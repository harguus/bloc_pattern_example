import 'dart:math';

import 'package:flutter/material.dart';

import 'package:bloc_pattern_example/blocs/client_bloc.dart';
import 'package:bloc_pattern_example/blocs/client_events.dart';
import 'package:bloc_pattern_example/blocs/client_state.dart';
import 'package:bloc_pattern_example/models/client_model.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ['Maria Almeida', 'Vinicius Silva', 'Luiz Williams', 'Bianca Nevis']
        .elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () => bloc.inputClient.add(
              AddClientEvent(
                client: ClientModel(
                  nome: randomName(),
                ),
              ),
            ),
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: StreamBuilder<ClientState>(
          stream: bloc.outputClient,
          builder: (context, AsyncSnapshot<ClientState> snapshot) {
            final clientList = snapshot.data?.clients ?? [];
            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: clientList.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Text(
                      clientList[index].nome.substring(0, 1),
                    ),
                  ),
                ),
                title: Text(clientList[index].nome),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => bloc.inputClient.add(
                    RemoveClientEvent(
                      client: clientList[index],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
