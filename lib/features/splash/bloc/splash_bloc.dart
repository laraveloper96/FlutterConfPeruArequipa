import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

typedef SplashEmitter = Emitter<SplashState>;

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadAppEv>(_onLoadApp);
  }

  Future<void> _onLoadApp(LoadAppEv ev, SplashEmitter emit) async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 2), () {});
    emit(SplashSuccess());
  }
}
