import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:psso/features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepositoryImpl(networkInfo: GetIt.instance()),
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepositoryImpl>(context),
          ),
          child: const MaterialApp(home: SignInPage()),
        ));
  }
}
