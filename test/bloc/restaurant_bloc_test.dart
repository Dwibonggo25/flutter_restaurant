import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:submission2_flutter_expert/data/repositories/remotes/restaurant_repositories.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final Dio tdio = Dio();
  DioAdapterMock dioAdapterMock;
  var apiService = RestaurantRepositories();

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    tdio.httpClientAdapter = dioAdapterMock;
    apiService = RestaurantRepositories();
  });

  test('Fetch list', () async {
    final responsepayload = jsonEncode({
      "error": false,
      "message": "success",
    });
    final httpResponse = ResponseBody.fromString(
      responsepayload,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((_) async => httpResponse);

    final String _baseUrl = "https://restaurant-api.dicoding.dev/";

    var response = await apiService.dio.get(_baseUrl+"/list");

    var expected = RestaurantResponse(error: false, message: "success");

    var data = RestaurantResponse.fromJson(response.data);
    expect(data.message, expected.message);
  });
}