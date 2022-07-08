import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psso/features/auth/presentation/pages/sign_in_page.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../pages/sign_up_page.dart';

class AccountEntryWidget extends StatefulWidget {
  final bool isSignIn;
  const AccountEntryWidget({
    Key? key,
    required this.isSignIn,
  }) : super(key: key);

  @override
  State<AccountEntryWidget> createState() => _AccountEntryWidgetState();
}

class _AccountEntryWidgetState extends State<AccountEntryWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    String accountAction = widget.isSignIn ? 'Sign In' : 'Sign Up';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration:
                const InputDecoration(hintText: "Please enter your email"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _passwordController,
            decoration:
                const InputDecoration(hintText: "Please enter your password"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed:
                    (widget.isSignIn ? _dispatchSignIn : _dispatchSignUp),
                child: const Text('Submit'),
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    _dispatchGoogleSignIn();
                  },
                  child: Row(
                    children: [
                      Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                        height: 15,
                        width: 15,
                      ),
                      Text('$accountAction With Google'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widget.isSignIn
                              ? const SignUpPage()
                              : const SignInPage()),
                    );
                  },
                  child: Text(widget.isSignIn ? 'Sign Up' : 'Sign In'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  void _dispatchSignIn() {
    BlocProvider.of<AuthBloc>(context)
        .add(SignInRequested(_emailController.text, _passwordController.text));
  }

  void _dispatchSignUp() {
    BlocProvider.of<AuthBloc>(context)
        .add(SignUpRequested(_emailController.text, _passwordController.text));
  }

  void _dispatchGoogleSignIn() {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
  }
}
