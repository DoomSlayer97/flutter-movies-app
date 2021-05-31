import 'package:flutter/material.dart';
import 'package:movieapp/src/blocs/provider.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/pages/movie_detail.dart';
import 'package:movieapp/src/widgets/page_template.dart';
import 'package:movieapp/src/widgets/posters/movies_swiper.dart';
import 'package:movieapp/src/helpers/push_transitions.dart' as pageTransitions;
import 'package:movieapp/src/widgets/search/search_delegate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _titleStyle = TextStyle(
    fontSize: 25.5,
    fontWeight: FontWeight.bold
  );

  final _subTitleStyle = TextStyle(
    fontSize: 20.5,
    fontWeight: FontWeight.bold
  );

  HomeBloc _homeBloc;

  void _goDetailMovie( MovieModel movieModel ) {

    Navigator.push(context, pageTransitions.createRoute( MovieDetailPage( movieModel: movieModel ) ));

  }

  void _goSearchMovie() {

    showSearch(context: context, delegate: DataSearch());

  }

  @override
  Widget build(BuildContext context) {

    this._homeBloc = Provider.homeBloc(context);

    this._homeBloc.getPopularMovies();

    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.5
              ),
              child: Column(
                children: [
                  _buildMainTitle(),

                  SizedBox(
                    height: 15.0,
                  ),

                  _buildSubTitle(
                    title: 'Most popular',
                  ),

                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),

            /* Popular movies swiper */
            _builderSwiperPopularMovies()

          ],
        ),
      ),
    );
    
  }

  StreamBuilder<List<MovieModel>> _builderSwiperPopularMovies() {
    return StreamBuilder<List<MovieModel>>(
      stream: this._homeBloc.moviesStream,
      initialData: [],
      builder: ( BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot ) {

        final List<MovieModel> movies = snapshot.data;

        if ( movies.length <= 0 ) return Center(
          child: CircularProgressIndicator()
        );

        return MoviesSwiper(
          movies: movies,
          onTap: ( movie ) => this._goDetailMovie( movie ),
        );  
      },
    );
  }

  Widget _buildSubTitle({ String title, String actionText }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(title,
          style: this._subTitleStyle,
        ),
      ],
    );
  }

  Widget _buildMainTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text('Movie app',
          style: this._titleStyle,
        ),

        IconButton(
          icon: Icon( Icons.search, size: 25.5, ),
          tooltip: "Search",

          onPressed: () => _goSearchMovie()
        )
        
      ],
    );
  }
}