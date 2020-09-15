import 'package:dio/dio.dart';
import 'package:newapp/model/article_reponse.dart';
import 'package:newapp/model/source_response.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2";
  final String apiKey = "b17585f7a77f42a194b090e90d95fd56";
  final Dio _dio = Dio();
  var getSourceUrl = "$mainUrl/sources";
  var getTopHeadLineUrl = "$mainUrl/top-headlines";
  var everythingUrrl = "$mainUrl/everything";

  Future<SourceResponse> getSources() async {
    var params = {"apiKey": apiKey, "language": "en", "country": "us"};
    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stacktrace: $stacktrace");
      return SourceResponse.withError(error);
    }
  }

  Future<ArticleResponse> getTopHeadLines() async {
    var params = {"apiKey": apiKey, "country": "us"};
    try {
      Response response =
          await _dio.get(getTopHeadLineUrl, queryParameters: params);
      return ArticleResponse.formJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {"apiKey": apiKey, "q": "apple", "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrrl, queryParameters: params);
      return ArticleResponse.formJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {"apiKey": apiKey, "sources": sourceId};
    try {
      Response response =
          await _dio.get(getTopHeadLineUrl, queryParameters: params);
      return ArticleResponse.formJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> search(String value) async {
    var params = {"apiKey": apiKey, "q": value, "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrrl, queryParameters: params);
      return ArticleResponse.formJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }
}
