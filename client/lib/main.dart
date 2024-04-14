import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'flutter_twitch_controller.dart';
import 'flutter_twitch_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitch Player Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Twitch Player Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TwitchController twitchController = TwitchController();
  final List<String> clipIds = <String>[
    "PoliteSteamyHornetCoolStoryBob-W7yd5ysobf9YTW-G",
    "IncredulousAbstemiousFennelImGlitch",
    "SuaveArtisticDogMVGame-W_RxqTitOo5ubomp",
    "MoistRockyMagpieBabyRage-5bnObs-HRq-I2FNX",
  ];
  @override
  Widget build(BuildContext context) {
    twitchController.onEnterFullscreen(() => print("Entered fullscreen"));
    twitchController.onExitFullscreen(() => print("Exited fullscreen"));
    twitchController.onStateChanged((state) => print(state));
    return Scaffold(
        appBar: AppBar(
          actions: [Text('Login')],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: clipIds.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: TwitchPlayerIFrame(
                  autoplay: true,
                  controller: twitchController,
                  clip: clipIds[index],
                ),
              );
            }));
  }
}
