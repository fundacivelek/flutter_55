import 'package:flutter/material.dart';
import 'package:havadurumu/models/weather_model.dart';
import 'package:havadurumu/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: WeatherService().getWeatherData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.hasData) {
              final List<WeatherModel> weathers = snapshot.data as List<WeatherModel>;
              return ListView.builder(
                  itemCount: weathers.length,
                  itemBuilder: (context, index) {
                    final WeatherModel weather = weathers[index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.network(weather.ikon, width: 100),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 25),
                            child: Text(
                              "${weather.gun}\n ${weather.durum.toUpperCase()} ${weather.derece}°",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Min: ${weather.min} °"),
                                  Text("Max: ${weather.max} °"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Gece: ${weather.gece} °"),
                                  Text("Nem: ${weather.nem}"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
            }else {
              return const Center(child: Text("Hava durumu alınırken hata oluştu"));
            }
            
          }
        ),
      ),
    );
  }
}
