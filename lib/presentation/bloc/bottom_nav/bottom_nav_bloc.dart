import 'dart:async';

enum NavBarItem { HOME, FAVORITE, SETTINGS }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController = StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream.asBroadcastStream();

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.FAVORITE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.SETTINGS);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}