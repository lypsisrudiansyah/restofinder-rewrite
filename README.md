# Resto Finder Rewrite

### Apps Feature:

- Get Nearby Restaurant 
- Get Collections
- Get Restaurant By Collection
- Restaurant Details
- Search Restaurant
- Geocoding & GPS System
 

  ### Setup
  1. Anda harus membuat API Key Zoomato pada situs <a href="https://developers.zomato.com/api?lang=id">Zoomato Developer</a>
  2. Masukkan Api Key yang sudah dibuat pada auth utils seperti berikut:
	 **lib/core/utils/auth_utils.dart**
```dart
class AuthUtils {
  static AuthUtils instance = AuthUtils();

  //* Insert with your Zoomato API KEY
  Future getToken() async {
    return "<YOUR ZOOMATO API KEY>";
  }
}
```
  ### Original Resto Finder Project
  by : @yusriltakeuchi(https://github.com/yusriltakeuchi/restofinder)