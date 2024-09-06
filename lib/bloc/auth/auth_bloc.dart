import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService _firebaseAuth = AuthService();

  AuthBloc() : super(AuthState()) {
    on<SignInWithGoogleEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true, error: null));
        bool success = await _firebaseAuth.signinWithGoogle();
        if (success) {
          emit(state.copyWith(isSignedIn: true, isLoading: false));
        } else {
          emit(state.copyWith(isLoading: false, error: 'Sign in failed'));
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        await _firebaseAuth.signOut();
        emit(state.copyWith(isSignedIn: false));
      },
    );
  }
}
