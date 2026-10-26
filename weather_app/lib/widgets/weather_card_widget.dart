
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final main = weather.main;
    final condition = weather.weather?.isNotEmpty == true
        ? weather.weather!.first
        : null;

    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1976D2),
              Color(0xFF64B5F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City and country
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${weather.name ?? 'Unknown city'}, '
                    '${weather.sys?.country ?? ''}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Temperature and condition
            Row(
              children: [
                if (condition?.icon != null)
                  Image.network(
                    'https://openweathermap.org/img/wn/'
                    '${condition!.icon}@2x.png',
                    width: 100,
                    height: 100,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.cloud,
                      size: 72,
                      color: Colors.white,
                    ),
                  )
                else
                  const Icon(
                    Icons.cloud,
                    size: 72,
                    color: Colors.white,
                  ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${main?.temp?.round() ?? '--'}°C',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        condition?.description ?? 'No description',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Feels like '
                        '${main?.feelsLike?.round() ?? '--'}°C',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(color: Colors.white54),
            const SizedBox(height: 16),

            // Min and max temperature
            Row(
              children: [
                Expanded(
                  child: _WeatherDetail(
                    icon: Icons.thermostat,
                    label: 'Min / Max',
                    value: '${main?.tempMin?.round() ?? '--'}° / '
                        '${main?.tempMax?.round() ?? '--'}°C',
                  ),
                ),
                Expanded(
                  child: _WeatherDetail(
                    icon: Icons.water_drop_outlined,
                    label: 'Humidity',
                    value: '${main?.humidity ?? '--'}%',
                  ),
                ),
                Expanded(
                  child: _WeatherDetail(
                    icon: Icons.air,
                    label: 'Wind',
                    value: '${weather.wind?.speed ?? '--'} m/s',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
