import 'package:newapp/model/article.dart';

class ArticleResponse {
  final List<ArticleModel> article;
  final String error;

  ArticleResponse(this.article, this.error);

  ArticleResponse.formJson(Map<String, dynamic> json)
      : article = (json['articles'] as List)
            .map((e) => new ArticleModel.formJson(e))
            .toList(),
        error = "";

  ArticleResponse.withError(String errorValue)
      : article = List(),
        error = errorValue;
}
