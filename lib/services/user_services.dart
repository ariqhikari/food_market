part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> loadUser() async {
    String user = await getUser();

    if (user == null) {
      return ApiReturnValue(message: 'Not have user loaded');
    }

    var data = jsonDecode(user);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/login';

    var response = await client.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);
    saveUser(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File pictureFile, http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/register';

    var response = await client.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': password,
          'password_confirmation': password,
          'address': user.address,
          'phone_number': user.phoneNumber,
          'house_number': user.houseNumber,
          'city': user.city,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);
    saveUser(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    // * Upload Profile Picture
    if (pictureFile != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile);
      if (result.value != null) {
        value = value.copyWith(picturePath: result.value);
      }
    }

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<bool>> signOut({http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/logout';

    var response = await client.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${User.token}'
    });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    removeUser();
    return ApiReturnValue(value: true);
  }

  static Future<ApiReturnValue<User>> updateProfile(User user,
      {File pictureFile, http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/user';

    var response = await client.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${User.token}'
        },
        body: jsonEncode(<String, String>{
          'name': user.name,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);
    saveUser(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    // * Upload Profile Picture
    if (pictureFile != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile);
      if (result.value != null) {
        value = value.copyWith(picturePath: result.value);
      }
    }

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<User>> updateAddress(User user,
      {File pictureFile, http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/user';

    var response = await client.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${User.token}'
        },
        body: jsonEncode(<String, String>{
          'address': user.address,
          'phone_number': user.phoneNumber,
          'house_number': user.houseNumber,
          'city': user.city,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);
    saveUser(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest request}) async {
    String url = baseURL + '/api/user/photo';
    var uri = Uri.parse(url);

    if (request == null) {
      request = http.MultipartRequest('PUT', uri)
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = 'Bearer ${User.token}';
    }

    var multipartFile =
        await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      var data = jsonDecode(responseBody);
      saveUser(responseBody);

      String imagePath = data['data']['user']['profile_photo_url'];

      return ApiReturnValue(value: imagePath);
    } else {
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }
  }
}
