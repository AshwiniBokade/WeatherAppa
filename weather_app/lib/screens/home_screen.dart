import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/search_bar_widget.dart';
import 'package:weather_app/widgets/weather_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  final TextEditingController cityEditingController = TextEditingController();

  void fetchWeather() {
    ref.read(weatherProvider.notifier).getWeather(cityEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
          //Loader
           weatherState.isLaoding? SizedBox( 
            height: 700, width: double.infinity,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ) 
          ) 
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search
              SearchBarWidget(
                controller: cityEditingController,
                onSearch: fetchWeather,
              ),

              SizedBox(height: 8,), 
              if(weatherState.weather != null)
                WeatherCard(weather: weatherState.weather!),
                //Text('resp: ${weatherState.weather!.main!.tempMax}', style: TextStyle(color: Colors.black),),
             
            ],
          ),
        ),
      ),
      bottomNavigationBar: weatherState.errorMessage.isEmpty
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    border: Border.all(color: Colors.red.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      weatherState.errorMessage,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
