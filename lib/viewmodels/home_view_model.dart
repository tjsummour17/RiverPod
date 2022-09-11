import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/api/api_client.dart';
import 'package:riverpod_app/models/university.dart';

class HomeViewModel extends StateNotifier<List<University>?> {
  HomeViewModel({List<University>? universities}) : super(universities) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    _client = ApiClient(dio);
    fetchInitialData();
  }

  late ApiClient _client;
  String _selectedCountry = 'Jordan';
  int _start = 0;
  int _end = 15;
  int _dataLength = 0;

  bool get hasNextPage => _dataLength < _end;

  Future fetchInitialData() async {
    final data = await _client.getUniversities(_selectedCountry);
    state = data.safeSublist(
      _start,
      _end,
    );
    _start += 15;
    _end += 15;
  }

  Future<void> fetchUniversities({
    required String countryName,
  }) async {
    _selectedCountry = countryName;
    final data = await _client.getUniversities(_selectedCountry);
    _dataLength = data.length;
    state = data.safeSublist(
      _start,
      _end,
    );
    _start += 15;
    _end += 15;
  }

  void onSearch(String value) async {
    final data = await _client.getUniversities(_selectedCountry);
    state = data.where((element) {
      final name = element.name;
      if (name != null) {
        if (name.toLowerCase().contains(value.toLowerCase())) return true;
      }
      return false;
    }).toList();
  }

  Future<void> loadMore() async {
    if (hasNextPage) await fetchUniversities(countryName: _selectedCountry);
  }

  void removeUniFromFav(University university) {
    state?.firstWhere((element) => element.name == university.name).inFav =
        false;
  }

  void addUniToFav(University university) {
    state?.firstWhere((element) => element.name == university.name).inFav =
        true;
  }
}

final universitiesNotifier =
    StateNotifierProvider<HomeViewModel, List<University>?>(
  (ref) => HomeViewModel(),
);

extension ListX<T> on List<T> {
  List<T> safeSublist(int start, [int? end]) {
    start = start.clamp(0, length).toInt();

    if (end != null) {
      end = end.clamp(0, length).toInt();
    }

    return sublist(start, end);
  }
}
