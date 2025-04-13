import "package:flutter/material.dart";
import 'client.dart';

class Clients extends ChangeNotifier {
  List<Client> clients;

  Clients({required this.clients});

  addClient(Client client) {
    clients.add(client);
    notifyListeners();
  }

  removeClient(int index) {
    clients.removeAt(index);
    notifyListeners();
  }
}
