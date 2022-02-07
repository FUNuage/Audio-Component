import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dart:developer';

import '../Hero/hero_character.dart';

class SpeechAnalysis extends StatefulWidget {
  const SpeechAnalysis({Key? key}) : super(key: key);

  @override
  _SpeechAnalysisState createState() => _SpeechAnalysisState();
}

class _SpeechAnalysisState extends State<SpeechAnalysis> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _pronounciationResult = '';
  int _symbolNumber = 0;
  Vector2? position;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      var heroPos = HeroCharacter.currentPosition;
      log('$heroPos');

      _pronounciationResult = result.recognizedWords;

      if (heroPos!.x < 580) {
        if (result.recognizedWords == "Apple" ||
            result.recognizedWords == "apple" ||
            result.recognizedWords == "Apple.") {
          _pronounciationResult = "correct";
        } else {
          _pronounciationResult = "try again";
        }
      } else {
        _pronounciationResult = "try again";
      }

      _lastWords = result.recognizedWords;
      // if (result.finalResult) {
      //   if (_lastWords == 'Apple.') {
      //     _pronounciationResult = 'well done';
      //   } else {
      //     _pronounciationResult = 'try again';
      //   }
      // }
    });
  }

  // void _nextQuestion() {
  //   setState(() {
  //     _symbolNumber = _symbolNumber + 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,

                      // child: Icon(_speechToText.isNotListening
                      //     ? Icons.mic_off
                      //     : Icons.mic),
                      child: Text(_speechToText.isNotListening
                          ? 'press to speak'
                          : 'try again'),
                    ))),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(_speechToText.isListening ? _lastWords : '',
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(_pronounciationResult,
                  style: const TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ));
  }
}
