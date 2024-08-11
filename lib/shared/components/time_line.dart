import 'package:flutter/material.dart';
import 'package:red_spotss/model/report_history.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'event_card.dart';

class TimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;

  TimeLine({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast, required Report report,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          //decorate
          beforeLineStyle: LineStyle(
              color: isPast
                  ? Color.fromRGBO(216, 118, 236, 100)
                  : Colors.deepPurpleAccent.shade100),
          //decorate icon
          indicatorStyle: IndicatorStyle(
              width: 40,
              color: isPast
                  ? Color.fromRGBO(216, 118, 236, 100)
                  : Colors.deepPurple.shade100,
              iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: isPast ? Colors.white : Colors.deepPurple.shade100)),
          //event card

        ));
  }
}
