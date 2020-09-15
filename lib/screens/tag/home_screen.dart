import 'package:flutter/material.dart';
import 'package:newapp/widgets/home_widgets/headline_slider.dart';
import 'package:newapp/widgets/home_widgets/hot_news.dart';
import 'package:newapp/widgets/home_widgets/top_channels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Top channels",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Hot news",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        HotNews(),
      ],
    );
  }
}
