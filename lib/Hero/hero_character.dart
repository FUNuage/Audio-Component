import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/game.dart';

import 'direction.dart';

class HeroCharacter<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  SpriteAnimation? _standingAnimation;

  HeroCharacter()
      : super(
          position: Vector2(1500, 580),
          size: Vector2(200, 300),
        );

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('big_hero_walk_right.png'),
      srcSize: Vector2(162, 268),
    );

    _walkLeftAnimation = await gameRef.loadSpriteAnimation(
      'big_hero_walk_left.png',
      SpriteAnimationData.sequenced(
          amount: 10,
          textureSize: Vector2(162, 268),
          stepTime: 0.15,
          amountPerRow: 5),
    );

    _walkRightAnimation = await gameRef.loadSpriteAnimation(
      'big_hero_walk_right.png',
      SpriteAnimationData.sequenced(
          amount: 10,
          textureSize: Vector2(162, 268),
          stepTime: 0.15,
          amountPerRow: 5),
    );

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.left:
        animation = _walkLeftAnimation;
        moveLeft(delta);
        break;
      case Direction.right:
        animation = _walkRightAnimation;
        moveRight(delta);
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
      case Direction.up:
        break;
      case Direction.down:
        break;
    }
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }
}
