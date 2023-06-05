import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter {
  int value = 0;

  Counter(this.value);
}

class CounterCubit extends Cubit<Counter> {
  CounterCubit() : super(Counter(0));

  void increment() => emit(Counter(state.value + 1));

  void decrement() => emit(Counter(state.value - 1));

  void reset() => emit(Counter(0));
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CounterCubit>();

    return BlocBuilder<CounterCubit, Counter>(
      builder: (context, state) => Column(
        children: [
          Center(
            child: Text('${state.value}'),
          ),
          ElevatedButton(onPressed: () {
            cubit.increment();
          }, child: Text('Increment')),
        ],
      ),
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
          child: CounterPage(),
        ),
      ),
    );
  }
}
