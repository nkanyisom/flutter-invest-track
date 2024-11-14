import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:investtrack/application_services/blocs/authentication/authentication.dart';
import 'package:investtrack/application_services/blocs/menu/menu_bloc.dart';
import 'package:investtrack/ui/app/app.dart';
import 'package:investtrack/ui/sign_in/sign_in_page.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  // Set up the mock dependencies.
  final MockAuthenticationRepository authenticationRepository =
      MockAuthenticationRepository();
  final MockUserRepository userRepository = MockUserRepository();
  final AuthenticationBloc authenticationBloc = AuthenticationBloc(
    authenticationRepository: authenticationRepository,
    userRepository: userRepository,
  );
  final MockMenuBloc menuBloc = MockMenuBloc();

  // Register the mock dependencies with GetIt.
  GetIt.instance
      .registerSingleton<AuthenticationRepository>(authenticationRepository);
  GetIt.instance.registerSingleton<AuthenticationBloc>(authenticationBloc);
  GetIt.instance.registerSingleton<UserRepository>(userRepository);
  GetIt.instance.registerSingleton<MenuBloc>(menuBloc);

  testWidgets('App loads and displays the sign-in page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      App(
        authenticationRepository: authenticationRepository,
        authenticationBloc: authenticationBloc,
        menuBloc: menuBloc, // Provide the mock MenuBloc
      ),
    );

    // Verify that the sign-in page is displayed.
    expect(find.byType(SignInPage), findsOneWidget);
  });
}

// Define the mock classes
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  @override
  Stream<AuthenticationStatus> get status =>
      Stream<AuthenticationStatus>.value(const AuthenticatedStatus());
}

class MockUserRepository extends Mock implements UserRepository {}

class MockMenuBloc extends Mock implements MenuBloc {}
