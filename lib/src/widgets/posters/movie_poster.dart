import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {

  MoviePoster({
    Key key,
    @required this.title,
    @required this.imageUrl,
    this.onTap
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final Function onTap;

  final _titleStyle = new TextStyle(
    fontSize: 15.5,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(),
      child: Container(
        child: Stack(              
          children: [

            _buildMoviePosterImage(),
            _buildBoxDecoration(),

            _buildTitle(),

          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      bottom: 40,
      left: 10,
      child: Container(
        width: 200,
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.0,
          ),
          child: Text(this.title, style: this._titleStyle),
        ),
      ),
    );
  }

  Widget _buildBoxDecoration() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all( Radius.circular(20.5) ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
          ]
        )
      ),
    );
  }

  Widget _buildMoviePosterImage() {
    return Container(
      width: double.infinity,    
      child: ClipRRect(
        borderRadius: BorderRadius.all( Radius.circular(20.5) ),
        child: CachedNetworkImage(
          imageUrl: this.imageUrl,
          fit: BoxFit.cover,
          placeholder: ( context, title ) => Center( child: CircularProgressIndicator() ),
        ),
      ),
    );
  }
}