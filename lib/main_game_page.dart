import 'package:audio_component_v2/Audio%20Component/speech_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'audio_component_game.dart';
import 'Hero/joypad.dart';
import 'Hero/direction.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  AudioComponentGame game = AudioComponentGame(
    viewportResolution: Vector2(
      1900,
      900,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GameWidget(game: game),
      Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SpeechAnalysis(),
          )),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
        ),
      ),
    ]));
  }

  void onJoypadDirectionChanged(Direction direction) {
    game.onJoypadDirectionChanged(direction);
  }
}
