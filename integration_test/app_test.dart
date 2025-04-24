import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;
import 'package:client_control/models/types.dart';
import 'package:client_control/models/clients.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Add your integration tests here
  testWidgets("Integration Test", (test) async {
    final GlobalKey<State<StatefulWidget>> providerKey = GlobalKey();
    //testing principal screen
    app.test([], providerKey);
    await test.pumpAndSettle();
    expect(find.text("Clientes"), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    //testind menu drawer
    await test.tap(find.byIcon(Icons.menu));
    await test.pumpAndSettle();
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Gerenciar clientes'), findsOneWidget);
    expect(find.text('Tipos de clientes'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);

    //testing screen types
    await test.tap(find.text("Tipos de clientes"));
    await test.pumpAndSettle();
    expect(find.text("Tipos de cliente"), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(Dismissible), findsNWidgets(4));
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.byType(Icon), findsNWidgets(6));

    //testing add type
    await test.tap(find.byType(FloatingActionButton));
    await test.pumpAndSettle();
    expect(find.text("Cadastrar tipo"), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await test.tap(find.byType(TextField));
    await test.enterText(find.byType(TextField), "Novo tipo");
    await test.pumpAndSettle();
    await test.tap(find.text("Selecionar icone"));
    await test.pumpAndSettle();
    await test.tap(find.byIcon(Icons.home));
    await test.pumpAndSettle();
    await test.tap(find.text("Salvar"));

    //testing if new type was added
    await test.pumpAndSettle();
    expect(find.text("Novo tipo"), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(
        Provider.of<Types>(providerKey.currentContext!, listen: false)
            .types
            .where((element) => element.name == "Novo tipo")
            .first
            .name,
        "Novo tipo");
    expect(
        Provider.of<Types>(providerKey.currentContext!, listen: false).types.last.icon, Icons.home);
    //testing remove type
    await test.drag(find.text("Novo tipo"), const Offset(1000, 0));
    await test.pumpAndSettle();
    expect(find.text("Novo tipo"), findsNothing);
    expect(find.byIcon(Icons.home), findsNothing);

    //testing back to main screen
    await test.tap(find.byIcon(Icons.menu));
    await test.pumpAndSettle();
    await test.tap(find.text("Gerenciar clientes"));
    await test.pumpAndSettle();

    //testing add client
    await test.tap(find.byType(FloatingActionButton));
    await test.pumpAndSettle();

    expect(find.text("Cadastrar cliente"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(TextButton), findsNWidgets(2));
    await test.tap(find.byType(TextFormField).first);
    await test.enterText(find.byType(TextFormField).first, "Novo cliente");
    await test.pumpAndSettle();
    await test.tap(find.byType(TextFormField).last);
    await test.enterText(find.byType(TextFormField).last, "newClient@xpto.com");
    await test.pumpAndSettle();
    await test.tap(find.byIcon(Icons.arrow_downward));
    await test.pumpAndSettle();
    await test.tap(find.text("Platinum").last);
    await test.pumpAndSettle();
    await test.tap(find.text("Salvar"));
    await test.pumpAndSettle();

    //testing if new client was added
    expect(find.text("Novo cliente (Platinum)"), findsOneWidget);

    expect(Provider.of<Clients>(providerKey.currentContext!, listen: false).clients.last.name,
        "Novo cliente");
    expect(Provider.of<Clients>(providerKey.currentContext!, listen: false).clients.last.email,
        "newClient@xpto.com");
    expect(Provider.of<Clients>(providerKey.currentContext!, listen: false).clients.last.type.name,
        "Platinum");

    //testing remove client
    await test.drag(
        find.text("Novo cliente (Platinum)"), const Offset(1000, 0));
    await test.pumpAndSettle();
    expect(find.text("Novo cliente (Platinum)"), findsNothing);

    //testing exit app
    //await test.tap(find.byIcon(Icons.menu));
    //await test.pumpAndSettle();
    //await test.tap(find.text("Sair"));
  });
}
