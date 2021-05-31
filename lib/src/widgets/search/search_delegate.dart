import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/blocs/provider.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/pages/movie_detail.dart';
import 'package:movieapp/src/utils/debounce.dart';


class DataSearch extends SearchDelegate {

  String seleccionado = "";

  Debouncer _debouncer = new Debouncer( milliseconds: 800 );
  
  DataSearch({
    String hinText
  }) : super(
    searchFieldLabel: hinText,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {

          query = '';

        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {

        close( context, null );

      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {

    final busquedaProductosBloc = Provider.homeBloc( context );

    // TODO: implement buildResults
    return StreamBuilder(
      stream: busquedaProductosBloc.moviesSearchStream,
      builder: ( BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot ) {

        if ( !snapshot.hasData ) return Center(
          child: Text("Buscar productos"),
        );

        final movies = snapshot.data;

        if ( movies.length <= 0 ) return Center(
          child: Text("No se encontro resultados :("),
        );

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( BuildContext context, int i ) {
            return ListTile(
              onTap: () => _goDetail( movies[i], context ),
              leading: ClipRRect(
                borderRadius: BorderRadius.all( Radius.circular(15.0) ),
                child: _buildImagenProducto( movies[i] ),
              ),
              title: Text( movies[i].title ),
              subtitle: Text( movies[i].releaseDate ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

   final busquedaProductosBloc = Provider.homeBloc( context );

    if ( query.isNotEmpty ) {

      _debouncer.run( () {

        if ( query.isNotEmpty )  
          busquedaProductosBloc.getSearchMovie( query );

      });

    }
    
    return StreamBuilder(
      stream: busquedaProductosBloc.moviesSearchStream,
      builder: ( BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot ) {

        if ( !snapshot.hasData ) return Center(
          child: Text("Search your movie :D"),
        );

        final movies = snapshot.data;

        if ( movies.length <= 0 ) return Center(
          child: Text("No movies found :("),
        );

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( BuildContext context, int i ) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.5
              ),
              onTap: () => _goDetail( movies[i], context ),
              leading: Container(
                width: 55,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.all( Radius.circular(15.0) ),
                  child: _buildImagenProducto( movies[i] )
                ),
              ),
              title: Text( movies[i].title ),
              subtitle: Text( movies[i].releaseDate ),
              
            );
          },
        );
      },
    );

  }

  Widget _buildImagenProducto( MovieModel movie ) {

    return CachedNetworkImage(
      height: 200,
      imageUrl: movie.obtenerPoster(),
      fit: BoxFit.cover,
      placeholder: ( context, url ) => Center(child: CircularProgressIndicator()),
      errorWidget: ( context, url, data ) => Icon( Icons.movie ),
    );

  }

  void _goDetail( MovieModel movie, BuildContext context ) {

    Navigator.push(
      context,
      MaterialPageRoute( builder: ( BuildContext context ) => MovieDetailPage( movieModel: movie, ) )
    );

  }
  

}