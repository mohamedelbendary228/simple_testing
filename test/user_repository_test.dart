import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:testing/user_model.dart';
import 'package:testing/user_repository.dart';

void main() {
  late UserRepository userRepository;

  setUp(() {
    userRepository = UserRepository(Client());
  });

  group("UserRepository - ", () {
    // a group for getUser function cases
    group("getUser function", () {
      test(
        """
        given userRepository class when getUer function is called 
        and status code is 200 then a userModel should be returned
        """,
        () async {
          // Arrange
          // Act
          final user = await userRepository.getUser();
          // Assert
          expect(user, isA<User>());
        },
      );


    });
  });
}
