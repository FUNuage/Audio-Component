import 'dart:ui';

import 'package:flame/game.dart';
import 'word_animation.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'background.dart';

class AudioComponentGame extends FlameGame with ScrollDetector, ScaleDetector {
  final Vector2 viewportResolution;

  AudioComponentGame({
    required this.viewportResolution,
  });

  final WordAnimation _wordAnimation = WordAnimation();
  final Background _background = Background();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(viewportResolution);
    camera.setRelativeOffset(Anchor.topLeft);
    camera.speed = 1;

    await add(_background);
    add(_wordAnimation);
  }
}
