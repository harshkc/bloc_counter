part of 'internet_cubit.dart';

@immutable
abstract class InternetState {
  const InternetState();
}

class InternetLoading extends InternetState {
  const InternetLoading();
}

class InternetConnected extends InternetState {
  const InternetConnected({required this.connectionType});

  final ConnectionType connectionType;
}

class InternetDisconnected extends InternetState {
  const InternetDisconnected();
}
