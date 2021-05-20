import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/constants/enums.dart';
import 'package:learning_bloc/counter/counter.dart';
import 'package:learning_bloc/counter/cubit/internet_cubit.dart';
import 'package:learning_bloc/l10n/l10n.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count =
        context.select((CounterCubit cubit) => cubit.state.counterValue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected &&
                state.connectionType == ConnectionType.wifi) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connected to WiFi'),
                  duration: Duration(milliseconds: 3000),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is InternetConnected &&
                state.connectionType == ConnectionType.mobile) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connected to Mobile'),
                  duration: Duration(milliseconds: 3000),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is InternetDisconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Disconnected'),
                  duration: Duration(milliseconds: 9000),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('$count', style: theme.textTheme.headline1),
        ),
      ],
    );
  }
}
