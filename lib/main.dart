import 'package:flutter/material.dart';
import 'package:localies_app/providers/store_provider.dart';
import 'package:localies_app/screens/home_page.dart';
import 'package:localies_app/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoreProvider()),
      ],
      child: MaterialApp(
        title: 'Localies App',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: const HomePage(),
      ),
    );
  }
}
