import 'package:flutter/material.dart';

class StateEmptyData extends StatelessWidget {
  final GestureTapCallback retry;
  final String message;

  const StateEmptyData({Key key, @required this.retry, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16,),
            Center(child: Text(message)),
            FlatButton(
                child: Text('Retry'),
                onPressed: retry
            )
          ],
        )
    );
  }
}
