import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/router/app_route.dart';
import 'package:investtrack/ui/investments/investments_page.dart';
import 'package:investtrack/ui/privacy/privacy_policy_page.dart';
import 'package:investtrack/ui/sign_in/sign_in_page.dart';

Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  AppRoute.investments.path: (_) => BlocProvider<InvestmentsBloc>(
        create: (_) =>
            GetIt.I.get<InvestmentsBloc>()..add(const LoadInvestments()),
        child: const InvestmentsPage(),
      ),
  AppRoute.signIn.path: (_) => const SignInPage(),
  AppRoute.privacyPolity.path: (_) => const PrivacyPolicyPage(),
};
