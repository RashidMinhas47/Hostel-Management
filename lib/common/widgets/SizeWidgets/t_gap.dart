import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,this.y,this.x
  });
  final double? x,y;
  // final double? y;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: y,width:x);
  }
}