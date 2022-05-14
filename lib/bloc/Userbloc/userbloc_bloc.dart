import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:regulum/models/user.model.dart';

part 'userbloc_event.dart';
part 'userbloc_state.dart';

class UserblocBloc extends Bloc<UserblocEvent, UserblocState?> {
  UserblocBloc() : super(null) {
    on<CreateUser>((event, emit) {});
  }
}
