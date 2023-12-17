import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing/user_model.dart';
import 'package:testing/user_repository.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRepository = UserRepository(mockHttpClient);
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
          when(() => mockHttpClient.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/users/1')))
              .thenAnswer((invocation) async {
            return Response("""
                {
                 "id": 1,
                 "name": "Leanne Graham",
                 "username": "Bret",
                 "email": "Sincere@april.biz",
                 "website": "hildegarde.org"
                }
                """, 200);
          });
          // Act
          final user = await userRepository.getUser();
          // Assert
          expect(user, isA<User>());
        },
      );

      test(
        """
          given userRepository class when getUer function is called
          and status code is not 200 then an exception should be thrown
          """,
        () async {
          // Arrange
          when(() {
            return mockHttpClient
                .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
          }).thenAnswer(
            (invocation) async {
              return Response("{}", 500);
            },
          );

          // Act
          final user = userRepository.getUser();
          // Assert
          expect(user, throwsException);
        },
      );
    });


  });
}
