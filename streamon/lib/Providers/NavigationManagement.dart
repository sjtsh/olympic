import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class NavigationManagement with DiagnosticableTreeMixin, ChangeNotifier {
  int _index = 1;
  String? playUrl;
  VideoPlayerController? controllerPlaying;
  bool pauseVideo = false;

  int _navigationIndex = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;

  set navigationIndex(int value) {
    _navigationIndex = value;
    notifyListeners();
  }

  pause() {
    if (pauseVideo == false) {
      controllerPlaying?.pause();
      pauseVideo = true;
    } else {
      controllerPlaying?.play();
      pauseVideo = false;
    }
    notifyListeners();
  }
}
