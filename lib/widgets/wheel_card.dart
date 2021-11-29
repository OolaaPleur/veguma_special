import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WheelCard extends StatefulWidget {
  final int index;
  final String id;

  WheelCard(this.index, this.id);

  @override
  State<WheelCard> createState() => _WheelCardState();
}

class _WheelCardState extends State<WheelCard> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("TEXT"),
      leading: CircleAvatar(child: Text(widget.index.toString()),),
      trailing: FittedBox(
        child: Row(
          children: [

          ],
        ),
      ),
    );
  }
}
