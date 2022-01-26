import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Orange<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  Orange({Vector2? position, Vector2? size, int? priority})
      : super(
          position: position,
          size: size ?? Vector2.all(150),
          priority: 1,
          //  anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'orange.png',
      SpriteAnimationData.sequenced(
          amount: 20,
          textureSize: Vector2(152, 200),
          stepTime: 0.2,
          amountPerRow: 5,
          loop: false),
    );
  }
}
