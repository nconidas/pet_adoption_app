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
  var usecase = SignOut(mockAuthRepository);

  test(
    'should log the user out',
    () async {
      when(mockAuthRepository.signOut())
          .thenAnswer((realInvocation) async => {});
      await usecase();
      verify(mockAuthRepository.signOut());
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
