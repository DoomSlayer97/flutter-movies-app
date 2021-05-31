import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/theme/theme.dart' as colors;

class MovieDetailPage extends StatefulWidget {

  MovieDetailPage({
    Key key,
    this.movieModel
  }) : super(key: key);

  final MovieModel movieModel;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {


  final _title = new TextStyle(
    fontSize: 20.5,
    fontWeight: FontWeight.bold
  );

  EdgeInsets _padding;

  void _exit() {

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {

    this._padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [

              _buildTitleImage(),

              SizedBox( height: 20.5 ),

              _buildDetailContent()

            ]
          )
        ),
      )
    );
  }

  Widget _buildDetailContent() {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 15.0 ),
      child: Column(
        children: [

          Row(
            children: [
              Text( 'Overview', style: this._title, textAlign: TextAlign.start ),
            ],
          ),

          SizedBox( height: 10.5 ),

          Text( this.widget.movieModel.overview ),


          
        ],
      ),
    );
  }

  Widget _buildTitleImage() {
    return CachedNetworkImage(
      imageUrl: this.widget.movieModel.obtenerBackgroundImg(),
      imageBuilder: ( context, imageProvider ) => Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [

            Positioned(
              top: this._padding.top,
              child: IconButton(icon: Icon( Icons.keyboard_arrow_left, size: 40.0, ), onPressed: () => this._exit() ),
            ),

            Positioned(
              bottom: 40,
              left: 15,
              child: Container(
                width: 300,
                child: Text( 
                  this.widget.movieModel.title,
                  style: this._title,
                ),
              )
            ),
          ],
        ),
      ),
      placeholder: ( context, url ) => Center(child: CircularProgressIndicator()),
    );
  }
}