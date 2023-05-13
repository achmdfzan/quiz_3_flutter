import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'umkm.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ListUMKMCubit(),
        child: const HomePage(),
      ),
    );
  }
}
