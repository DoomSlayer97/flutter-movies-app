
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/movies_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {

  MoviesProvider _moviesProvider = new MoviesProvider();

  final _moviesController = new BehaviorSubject<List<MovieModel>>();

  Stream<List<MovieModel>> get moviesStream => _moviesController.stream;

  void dispose() {

    _moviesController?.close();

  }

  void getPopularMovies() async {

    final movies = await _moviesProvider.getPopularMovies();

    _moviesController.sink.add( movies );

  }


}