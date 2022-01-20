import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class WordAnimation extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final animation = await loadSpriteAnimation(
      'apple.png',
      SpriteAnimationData.sequenced(
          amount: 20,
          textureSize: Vector2.all(140),
          stepTime: 0.1,
          amountPerRow: 4,
          loop: true),
    );

    final spriteSize = Vector2.all(150.0);
    final animationComponent = SpriteAnimationComponent(
      animation: animation,
      size: spriteSize,
    );
    animationComponent.x = size.x / 2 - spriteSize.x;
    animationComponent.y = spriteSize.y;

    add(animationComponent);
  }
}
