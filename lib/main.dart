import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() => runApp(PronunciationAssessor());

class PronunciationAssessor extends StatefulWidget {
  @override
  _PronunciationAssessorState createState() => _PronunciationAssessorState();
}

class _PronunciationAssessorState extends State<PronunciationAssessor> {
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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Text(
        "Pronunciation Assessor",
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/' + symbolNames[_symbolNumber] + '.png',
              ),
            ),
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
                child: Text(
              _pronounciationResult,
              style: const TextStyle(fontSize: 50),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    ));
  }
}
