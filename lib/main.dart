import 'package:flutter/material.dart';
import 'package:pokeapp/presentation/pages/home_page.dart';
import 'package:pokeapp/presentation/widgets/bloc_di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Pokeapp());
}

class Pokeapp extends StatelessWidget {
  const Pokeapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocDI(
      child: MaterialApp(
        title: 'Pokeapp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
