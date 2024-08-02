import 'package:flutter/material.dart';
import 'package:havadurumu/screens/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}
