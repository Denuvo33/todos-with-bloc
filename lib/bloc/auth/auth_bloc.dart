import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthState()) {
    on<SignInWithGoogleEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true, error: null));
        try {
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if (googleUser == null) {
            emit(state.copyWith(isLoading: false));
            return;
          }

          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          await _firebaseAuth.signInWithCredential(credential);

          emit(state.copyWith(isSignedIn: true, isLoading: false));
        } catch (e) {
          emit(state.copyWith(isLoading: false, error: e.toString()));
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        await _firebaseAuth.signOut();
        await _googleSignIn.signOut();
        emit(state.copyWith(isSignedIn: false));
      },
    );
  }
}
