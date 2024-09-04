part of 'auth_bloc.dart';

class AuthState {
  final bool isSignedIn;
  final String? error;
  final bool isLoading;

  AuthState({this.isSignedIn = false, this.error, this.isLoading = false});

  AuthState copyWith({
    bool? isSignedIn,
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
