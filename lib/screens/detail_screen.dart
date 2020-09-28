import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_web_screen/bloc/actors_bloc.dart';
import 'package:flutter_web_screen/models/actor_model.dart';
import 'package:flutter_web_screen/models/actor_response.dart';
import 'package:flutter_web_screen/screens/widgets/error_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class DetailScreen extends StatefulWidget {
  final dataModel;
  final String type;

  DetailScreen(this.dataModel, this.type);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  var _model;
  String _type;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.dataModel.id);
    _model = widget.dataModel;
    _type = widget.type;
    actorsBloc..getCredits(_model.id, _type);
    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 0.3).animate(controller)
      ..addListener(() {
        setState(() {
        });
        // #enddocregion addListener
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 200),
            () => controller.forward(),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_model.name),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: [
          Hero(
              tag: 'image' + _model.name,
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_model.poster),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              )),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
          expand: false,
          initialChildSize: animation.value,
          minChildSize: animation.value ,
          maxChildSize: 1,
          builder: (context, ScrollController scrollController) {
            print('Here');
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xcc4E4E53), Color(0xcc232326)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 15),
                          child: Container(
                            height: 5,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height *0.223,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                _model.name,
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RatingBar(
                                      itemSize: 45,
                                      initialRating: _model.votes,
                                      onRatingUpdate: (double value) {
                                        print(value);
                                      },
                                      itemBuilder: (context, _) {
                                        return Container(
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 20,
                                                spreadRadius: 0.1)
                                          ]),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '${_model.votes}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),],
                          ),
                        ),
                        StreamBuilder(
                            stream: actorsBloc.subject.stream,
                            builder: (context,
                                AsyncSnapshot<ActorResponse> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.error != null &&
                                    snapshot.data.error.length > 0) {
                                  return buildErrorWidget(snapshot.error);
                                }
                                return buildActorsWidget(snapshot.data);
                              }
                              if (snapshot.hasError) {
                                return buildErrorWidget(snapshot.error);
                              } else {
                                return Center(
                                  child: LinearProgressIndicator(),
                                );
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Overview',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(
                            _model.overview,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )
                      ]),
                ),
              ),
            );
          }),
    );
  }

  Widget buildActorsWidget(ActorResponse data) {
    List<ActorModel> actors = data.casts;
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 160,
      child: ListView.builder(
          itemExtent: 120,
          itemCount: actors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: actors[i].image !=
                                  'https://image.tmdb.org/t/p/w185/null'
                                  ? NetworkImage(actors[i].image) : AssetImage('assets/User.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        )),
                    SizedBox(height: 15),
                    Text(
                      actors[i].name,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
