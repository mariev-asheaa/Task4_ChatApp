import 'package:flutter/cupertino.dart';

class background extends StatelessWidget {
   background({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
                left: 0,
                width: 200,
                child: Image.asset('assets/images/main_top.png')
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset('assets/images/main_bottom.png')),
            child,
          ],

      ),
    );

  }
}
