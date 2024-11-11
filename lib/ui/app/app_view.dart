import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investtrack/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:investtrack/res/constants/constants.dart' as constants;
import 'package:investtrack/router/app_route.dart';
import 'package:investtrack/router/routes.dart' as routes;
import 'package:investtrack/ui/investments/investments_page.dart';
import 'package:investtrack/ui/sign_in/sign_in_page.dart';
import 'package:investtrack/ui/splash_page.dart';

/// [AppView] is a [StatefulWidget] because it maintains a [GlobalKey] which is
/// used to access the [NavigatorState]. By default, [AppView] will render the
/// [SplashPage] and it uses [BlocListener] to navigate to different pages
/// based on changes in the [AuthenticationState].
/// Upon a successful `signIn` request, the state of the [AuthenticationBloc]
/// will change to authenticated and the user will be navigated to the
/// [InvestmentsPage] where we display the user’s investments as well as a
/// button to sign out.
@immutable
class AppView extends StatefulWidget {
  const AppView({required this.authenticationBloc, super.key});

  final AuthenticationBloc authenticationBloc;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  final bool _isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.appName,
      initialRoute: AppRoute.signIn.path,
      routes: routes.routeMap,
      theme: _isDarkTheme
          ? ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.teal,
                secondary: Colors.amber,
              ),
              textTheme: TextTheme(
                headlineLarge: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey[300]),
              ),
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.teal,
              ),
            )
          : ThemeData.light(),
      navigatorKey: _navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            final AuthenticationStatus status = state.status;
            switch (status) {
              case DeletingAuthenticatedUserStatus():
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deletion in progress...'),
                  ),
                );
              case AuthenticatedStatus():
                _navigator?.pushAndRemoveUntil<void>(
                  InvestmentsPage.route(widget.authenticationBloc),
                  (Route<void> route) => false,
                );
              case UnauthenticatedStatus():
                _navigator?.pushAndRemoveUntil<void>(
                  SignInPage.route(),
                  (Route<void> route) => false,
                );
                if (status.message.isNotEmpty) {
                  final String message = status.message;
                  Fluttertoast.showToast(
                    msg: message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0,
                  );
                }
              case UnknownAuthenticationStatus():
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
