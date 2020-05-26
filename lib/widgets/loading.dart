
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapp/shared/global.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          child: Center(
            child: SpinKitChasingDots(
              color: Global.mediumBlue,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
