import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/weather_state.dart';

class WeatherNotifier extends StateNotifier<WeatherState>{
  WeatherNotifier():super(WeatherState());
  WeatherService _weatherService = WeatherService();

  Future<void> getWeather(String cityName) async {
    // function <-- fetch data
    if(cityName.trim().isEmpty){
      state = state.copyWith(
        errorMessage: "Please enter city Name",
        clearWeather: true
      );
      return;
    }
    
    //state Loading set
    state = state.copyWith(isLoad: true, 
    errorMessage: "", clearWeather: true);

    // Logic to get data from api
    try{
      final weather = await _weatherService.getWeatherData(cityName);
      state = state.copyWith(isLoad:false, errorMessage: "", weather: weather);
    }
    catch(e){
      state = state.copyWith(isLoad:false, errorMessage: e.toString(), clearWeather: true);
    }
  }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => 
WeatherNotifier(),);