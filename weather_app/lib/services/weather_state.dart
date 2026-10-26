import 'package:weather_app/models/weather_model.dart';

class WeatherState {

  final bool isLaoding;
  final String errorMessage;
  final WeatherModel? weather;

  WeatherState({
    this.isLaoding = false,
    this.errorMessage = "",
    this.weather,
  });

  WeatherState copyWith({bool? isLoad, String? errorMessage, WeatherModel? weather, bool clearWeather = false}){
    return WeatherState(isLaoding: isLoad ?? isLaoding, errorMessage: errorMessage ?? this.errorMessage, weather: clearWeather ? null : weather ?? this.weather);
  }
}