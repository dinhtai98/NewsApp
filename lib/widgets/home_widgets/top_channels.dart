import 'package:flutter/material.dart';
import 'package:newapp/bloc/get_source_bloc.dart';
import 'package:newapp/elements/error_element.dart';
import 'package:newapp/elements/loader.dart';
import 'package:newapp/model/source.dart';
import 'package:newapp/model/source_response.dart';
import 'package:newapp/screens/source_detail.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    getSourcesBloc.getSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildTopChannnels(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildTopChannnels(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("No sources")],
        ),
      );
    } else {
      return Container(
        height: 120,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              width: 80,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SourcesDetail(
                                source: sources[index],
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/logos/${sources[index].id}.png"))),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      sources[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      sources[index].category,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: sources.length,
        ),
      );
    }
  }
}
