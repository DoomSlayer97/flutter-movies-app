import "package:http/http.dart" as http;
import "dart:convert";
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/provider_http.dart';

class MoviesProvider extends ProviderHttp {

  Future<List<MovieModel>> getPopularMovies() async {

    final uri = this.getUriUrl( '/movie/now_playing', params: {
      'language': 'en-US',
      'page': 1.toString()
    });

    final resp = await http.get( uri );

    if ( resp.statusCode != 200 ) return null;
    
    final jsonData = json.decode( resp.body );

    final List moviesJson = jsonData['results'];
    final List<MovieModel> movies = <MovieModel> [];

    moviesJson.forEach(( item ) { movies.add( MovieModel.fromJson( item ) ); });

    return movies;

  }

  Future<List<MovieModel>> getMoviesSearch( String query ) async {

    final uri = this.getUriUrl( '/search/movie', params: {
      'language': 'en-US',
      'query': query
    });

    print( uri.toString() );

    final resp = await http.get( uri );

    if ( resp.statusCode != 200 ) return null;
    
    final jsonData = json.decode( resp.body );

    final List moviesJson = jsonData['results'];
    final List<MovieModel> movies = <MovieModel> [];

    moviesJson.forEach(( item ) { movies.add( MovieModel.fromJson( item ) ); });

    return movies;

  }  

}