import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newapp/bloc/get_top_headlines_bloc.dart';
import 'package:newapp/elements/error_element.dart';
import 'package:newapp/elements/loader.dart';
import 'package:newapp/model/article.dart';
import 'package:newapp/model/article_reponse.dart';
import 'package:newapp/screens/new_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSliderWidget extends StatefulWidget {
  @override
  _HeadlineSliderWidgetState createState() => _HeadlineSliderWidgetState();
}

class _HeadlineSliderWidgetState extends State<HeadlineSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHeadSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.article;
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        height: 200,
        viewportFraction: .9,
      ),
      items: getExpenseSlider(articles),
    ));
  }

  getExpenseSlider(List<ArticleModel> articles) {
    return articles
        .map((article) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNews(
                              article: article,
                            )));
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: article.img == null
                                ? AssetImage("assets/img/placeholder.jpg")
                                : NetworkImage(article.img)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.9
                            ],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.white.withOpacity(0.0)
                            ]),
                      ),
                    ),
                    Positioned(
                        bottom: 30.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 250.0,
                          child: Column(
                            children: <Widget>[
                              Text(
                                article.title,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        bottom: 10.0,
                        left: 10.0,
                        child: Text(
                          article.source.name,
                          style:
                              TextStyle(color: Colors.white54, fontSize: 9.0),
                        )),
                    Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: Text(
                          timeUntil(DateTime.parse(article.date)),
                          style:
                              TextStyle(color: Colors.white54, fontSize: 9.0),
                        )),
                  ],
                ),
              ),
            ))
        .toList();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
