import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import './hero_character.dart';
import 'direction.dart';

class HeroMovement extends SpriteAnimationComponent with HasGameRef {
  late final HeroCharacter hero;

  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;
  static const int speed = 200;
  final Vector2 velocity = Vector2(0, 0);
  var test = Vector2(1, 0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    hero = HeroCharacter(position: size / 2, size: Vector2(200, 300));
    add(hero);
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        // animation = _runUpAnimation;
        moveUp(delta);
        break;
      case Direction.down:
        //   animation = _runDownAnimation;
        moveDown(delta);
        break;
      case Direction.left:
        //   animation = _runLeftAnimation;
        moveLeft(delta);
        break;
      case Direction.right:
        //    animation = _runRightAnimation;
        moveRight(delta);
        break;
      case Direction.none:
        //    animation = _standingAnimation;
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }
}
