part of 'userbloc_bloc.dart';

@immutable
abstract class UserblocState extends Equatable {}

class UserData extends UserblocState {
  final User profile;
  final String token;

  UserData(this.profile, this.token);

  @override
  List<Object?> get props => throw UnimplementedError();
}
