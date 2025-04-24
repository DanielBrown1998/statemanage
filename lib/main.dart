import 'package:client_control/pages/client_types_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/clients_page.dart';
import "models/clients.dart";
import "models/types.dart";
import "models/client_type.dart";

//Debug
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Clients(clients: []),
        ),
        ChangeNotifierProvider(
          create: (context) => Types(types: [
            ClientType(name: 'Platinum', icon: Icons.credit_card),
            ClientType(name: 'Golden', icon: Icons.card_membership),
            ClientType(name: 'Titanium', icon: Icons.credit_score),
            ClientType(name: 'Diamond', icon: Icons.diamond),
          ]),
        ),
      ],
      child: MaterialApp(
      title: 'Controle de clientes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ClientsPage(title: 'Clientes'),
        '/tipos': (context) => const ClientTypesPage(title: 'Tipos de cliente'),
      },
    ),
    ),
  );
}

//T
void test(
  List<String> args,
  GlobalKey<State<StatefulWidget>>? keyForProvider,
) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Clients(clients: []),
        ),
        ChangeNotifierProvider(
          create: (context) => Types(types: [
            ClientType(name: 'Platinum', icon: Icons.credit_card),
            ClientType(name: 'Golden', icon: Icons.card_membership),
            ClientType(name: 'Titanium', icon: Icons.credit_score),
            ClientType(name: 'Diamond', icon: Icons.diamond),
          ]),
        ),
      ],
      child: MaterialApp(
      key: keyForProvider,
      title: 'Controle de clientes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ClientsPage(title: 'Clientes'),
        '/tipos': (context) => const ClientTypesPage(title: 'Tipos de cliente'),
      },
    ),
    ),
  );
}

