import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_app/models/university.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'http://universities.hipolabs.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/search')
  Future<List<University>> getUniversities(
    @Query('country') String countryName,
  );
}
