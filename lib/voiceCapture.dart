import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceCapture extends StatefulWidget {
  //declare a final void function named onStop that recieves a path to a file
  final void Function(String path) onStop;

  const VoiceCapture({super.key, required this.onStop});

  @override
  _VoiceCaptureState createState() => _VoiceCaptureState();
}

class _VoiceCaptureState extends State<VoiceCapture> {
  var _recordDuration = 0;
  Timer? _timer;
  final _recordController = Record();

  StreamSubscription<RecordState>? _recordSubscription;
  RecordState _recordState = RecordState.stop;

  StreamSubscription<Amplitude>? _amplitudeSubscription;
  Amplitude? _amplitude;

  @override
  void initState() {
    _recordSubscription =
        _recordController.onStateChanged().listen((recordState) {
      setState(() {
        _recordState = recordState;
      });
    });

    _amplitudeSubscription = _recordController
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amplitude) {
      setState(() {
        _amplitude = amplitude;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
