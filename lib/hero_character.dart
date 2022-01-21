import 'package:flame/components.dart';
import 'package:flame/game.dart';

class HeroCharacter<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  HeroCharacter({Vector2? position, Vector2? size, int? priority})
      : super(
          position: position,
          size: size ?? Vector2(50, 100),
          priority: priority,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'big_hero_walk.png',
      SpriteAnimationData.sequenced(
          amount: 10,
          textureSize: Vector2(162, 268),
          stepTime: 0.15,
          amountPerRow: 5),
    );
  }
}
