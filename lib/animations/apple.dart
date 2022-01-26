import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Apple<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  Apple({Vector2? position, Vector2? size, int? priority})
      : super(
          position: position,
          size: size ?? Vector2.all(140),
          priority: 1,
          //  anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'apple.png',
      SpriteAnimationData.sequenced(
          amount: 20,
          textureSize: Vector2(140, 140),
          stepTime: 0.2,
          amountPerRow: 4,
          loop: false),
    );
  }
}
