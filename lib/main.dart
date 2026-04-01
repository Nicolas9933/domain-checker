import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/domain_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DomainViewModel(),
      child: MaterialApp(
        title: 'Consulta de Domínios .br',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const HomeView(),
      ),
    );
  }
}