enum AppRoute {
  investments('/investments'),
  signIn('/sign-in'),
  code('/code'),
  privacyPolity('/privacy-policy'),
  signUp('/sign-up');

  const AppRoute(this.path);

  final String path;
}
