import 'package:flame/game.dart';

import '../Animations/apple.dart';
import '../Animations/banana.dart';
import '../Animations/orange.dart';

class WordAnimation extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Apple()..position = Vector2(480, 190));
    add(Banana()..position = Vector2(680, 140));
    add(Orange()..position = Vector2(980, 180));
  }
}
