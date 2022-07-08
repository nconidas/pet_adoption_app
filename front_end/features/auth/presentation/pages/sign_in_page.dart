import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psso/features/adoptable_pets/presentation/pages/adoptable_pet_browser.dart';
import 'package:psso/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:psso/features/auth/presentation/bloc/auth_event.dart';
import 'package:psso/features/auth/presentation/bloc/auth_state.dart';
import 'package:psso/features/auth/presentation/pages/sign_up_page.dart';

import '../../domain/use_cases/auth.dart';
import '../widgets/account_entry_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdoptablePetBrowser()));
          }
          if (state is Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return const Center(child: AccountEntryWidget(isSignIn: true));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
