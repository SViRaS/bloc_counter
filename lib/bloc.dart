import 'package:flutter_bloc/flutter_bloc.dart';
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterAdd>(_onIncrement);
    on<CounterDel>(_onDecrement);
  }
  

  _onIncrement(CounterAdd event, Emitter<int> emit) {
    emit(state + 1);
  }
  _onDecrement(CounterDel event, Emitter<int> emit) {
    emit(state - 1);
  }
}

abstract class CounterEvent {}
class CounterAdd extends CounterEvent{}
class CounterDel extends CounterEvent{}