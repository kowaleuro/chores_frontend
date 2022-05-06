class ApiConstants{

  // bazowy URL zmienic w zaleznosci od debugowania na emulatorze androida
  static const String baseUrl = 'http://10.0.2.2:8080';
  //static const String baseUrl = 'http://localhost:8080';

  //authenticate path
  static const String authenticateEndpoint = '/authenticate';

  //login
  static const String loginEndpoint = '/api/v1/user-profile/login';

  //register
  static const String registerEndpoint = '/api/v1/user-profile/register';

  //UserPlaces
  static const String userPlacesEndpoint = '/api/v1/place/usersPlaces';

  //savePlace
  static const String createPlaceEndpoint = '/api/v1/place/save';

  //addChore
  static const String createChoreEndpoint = '/api/v1/place/addChore';

  //getPlaceById
  static const String getPlaceByIdEndpoint = '/api/v1/place';

  static const String joinPlaceEndpoint = '/api/v1/place/subscribeToPlace';
}