import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:investtrack/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:investtrack/res/constants/constants.dart' as constants;

@module
abstract class RetrofitHttpClientModule {
  @lazySingleton
  RetrofitClient getRetrofitHttpClient(Dio dio) {
    return RetrofitClient(dio, baseUrl: constants.apiBaseUrl);
  }
}
