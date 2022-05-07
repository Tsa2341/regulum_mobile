import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regulum/models/user.model.dart';

abstract class UserEvents {}

class GetUser extends UserEvents {}

class CreateUser extends UserEvents {}

class UserBloc extends Bloc<UserEvents, User?> {
  UserBloc() : super(null) {
    on<GetUser>((event, emit) {});
  }
}
