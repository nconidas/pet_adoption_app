import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/features/auth/domain/repositories/auth_repository.dart';
import 'package:psso/features/auth/domain/use_cases/auth.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  const email = 'test@gmail.com';
  const password = '123';
  var mockAuthRepository = MockAuthRepository();
  var usecase = SignIn(mockAuthRepository);

  test(
    'should log the user in',
    () async {
      when(mockAuthRepository.signIn(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((realInvocation) async => {});
      await usecase(email: email, password: password);
      verify(mockAuthRepository.signIn(email: email, password: password));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
