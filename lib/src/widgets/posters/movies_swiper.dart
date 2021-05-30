import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/widgets/posters/movie_poster.dart';

class MoviesSwiper extends StatelessWidget {

  const MoviesSwiper({
    Key key,
    @required this.movies
  }) : super(key: key);

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.0,
      child: Swiper(
        itemCount: movies.length,
        itemHeight: 360.0,
        itemWidth: 220.0,
        layout: SwiperLayout.STACK,
        itemBuilder: ( context, i ) {
          return MoviePoster(
            title: movies[i].title,
            imageUrl: movies[i].obtenerPoster(),
          );
        },
      ),
    );
  }
}