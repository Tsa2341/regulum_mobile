part of 'userbloc_bloc.dart';

@immutable
abstract class UserblocEvent extends Equatable {}

class CreateUser extends UserblocEvent {
  final Map<String, dynamic> userData;

  CreateUser(this.userData);

  @override
  List<Object?> get props => [userData];
}
