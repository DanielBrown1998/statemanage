import "package:flutter/material.dart";
import 'client_type.dart';

class Types extends ChangeNotifier {
  List<ClientType> types;

  Types({required this.types});

  addTypeClient(ClientType clientType) {
    types.add(clientType);
    notifyListeners();
  }

  removeTypeClient(int index) {
    types.removeAt(index);
    notifyListeners();
  }
}
