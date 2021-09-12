part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;
  final String message;

  UserLoaded(this.user, {this.message});

  @override
  List<Object> get props => [user, message];
}

class UserLoadingFailed extends UserState {
  final String message;

  UserLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
