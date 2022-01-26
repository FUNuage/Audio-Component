import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Banana<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  Banana({Vector2? position, Vector2? size, int? priority})
      : super(
          position: position,
          size: size ?? Vector2.all(185),
          priority: 1,
          //  anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'banana.png',
      SpriteAnimationData.sequenced(
          amount: 20,
          textureSize: Vector2.all(185),
          stepTime: 0.2,
          amountPerRow: 5,
          loop: false),
    );
  }
}
