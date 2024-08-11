import 'package:flutter/material.dart';

class event_card extends StatelessWidget {
  final bool isPast;
  final child;
  event_card({
    super.key,
    required this.isPast,
    required this.child,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color:isPast? Color.fromRGBO(255, 114, 94,100):Colors.deepOrange.shade100,
        borderRadius: BorderRadius.circular(8),


      ),
      child: Text('Youraa'),

    );
  }
}
