
class ProviderHttp {

  final String _domain = "api.themoviedb.org";
  final String _path = "3";
  String _baseUrl; 

  ProviderHttp() {

    _baseUrl = "$_domain/$_path";

  }

  String get baseUrl => _baseUrl;

  Uri getUriUrl( String prefix,{ Map<String, String> params } ) {

    final String finalUrl = "$_path$prefix";

    params = {};

    params['api_key'] = '5b5f0fb6035bfba42ba625bc45be2acd';    

    return Uri.https( _domain, finalUrl, params );
    
  }  

}