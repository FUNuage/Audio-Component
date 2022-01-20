import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
  var symbolNames = ['cat', 'dog', 'pig'];

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

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      if (result.finalResult) {
        if (_lastWords == symbolNames[_symbolNumber]) {
          _pronounciationResult = '';
          _nextQuestion();
        } else {
          _pronounciationResult = 'try again';
        }
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _symbolNumber = _symbolNumber + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? ''
                    //? '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    : _speechEnabled
                        ? 'Tap the microphone to start listening...'
                        : 'Speech not available',
                style: const TextStyle(fontSize: 20)),
          ),
        ),
        Expanded(
            child: Container(
                child: Text(
          _pronounciationResult,
          style: const TextStyle(fontSize: 50),
        )))
      ],
    );
  }
}
