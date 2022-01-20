import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'audio_component_game.dart';
import 'speech_analysis.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  AudioComponentGame game = AudioComponentGame(
    viewportResolution: Vector2(
      1024,
      600,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SpeechAnalysis(),
              ),
            )
          ],
        ));
  }
}
