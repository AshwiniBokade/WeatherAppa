import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{

  //Constant Values
  String baseURL = "https://api.openweathermap.org/data/2.5";
  String appId = "337506e1c9bf752ca55c9ef8889536c0";
  //functions

  Future<WeatherModel?>getWeatherData(String cityName) async
  {
    try{
      String url = "$baseURL/weather?q=$cityName&appid=$appId&units=metric";
      http.Response response = await http.get(Uri.parse(url));

      if(response.statusCode  == 200){
          var jsonData = jsonDecode(response.body);

          return WeatherModel.fromJson(jsonData);
      }
      else{
        throw Exception("Failed to load weather data");
      }
    }
    catch(e){
      throw(Exception("Exception: $e"));
    }
  }
}