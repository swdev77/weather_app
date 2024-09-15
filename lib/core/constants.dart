class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'be6966e7a6c66fb71664aba6cecbbaad';
  static String currentWeatherByName(String city) => '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}