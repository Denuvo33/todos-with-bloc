import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/auth/auth_bloc.dart';
import 'package:todos_bloc/screens/my_home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isSignedIn) {
            // Navigate to the homepage
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyHomeScreen()));
          } else if (state.error != null) {
            // Show error in a Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInWithGoogleEvent());
                },
                child: state.isLoading
                    ? CircularProgressIndicator(
                        color:
                            Colors.blue, // optional: to match button text color
                      )
                    : const Text('Sign in with Google'),
              ),
            );
          },
        ),
      ),
    );
  }
}
