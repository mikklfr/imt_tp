import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_tp/http_client.dart';

// TODO extract to a separate file and class
Future<List<Post>> getData() async => RestClient(Dio()).getPosts();

class CounterCubit extends Cubit<List<Post>> {
  CounterCubit() : super([]);

  void increment() async => emit(await getData());
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO replace with BlocBuilder and BlocProvider
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title),
                );
              });
        } else {
          return const Text('...');
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => CounterCubit(),
          child: const CounterPage(),
        ),
      ),
    );
  }
}
