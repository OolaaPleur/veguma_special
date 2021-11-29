import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veguma_special/widgets/new_tire_widget.dart';
import 'package:veguma_special/widgets/wheel_card.dart';
import 'package:veguma_special/models/wheels.dart';
import 'package:provider/provider.dart';

import '../models/wheels.dart';

class WheelListScreen extends StatefulWidget {
  const WheelListScreen({Key? key}) : super(key: key);

  @override
  _WheelListScreenState createState() => _WheelListScreenState();
}

class _WheelListScreenState extends State<WheelListScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Wheels>(context, listen: false).fetchAndSetProducts();
  }
  void _startTireAdding(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTireWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addData),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed:() => addWheel(),child: const Icon(Icons.add)),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<Wheels>(builder: (ctx, tireData, _) =>
              Padding(padding: EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: tireData.tires.length, itemBuilder: (_, i) {
                        return Column(children: [
                          WheelCard(i, tireData.tires[i].id),
                          Divider(),
                        ],);
                  })),)
          ,
        )
        ,
      )
      ,
    );
  }

  void addWheel() {
    setState(() {

    });
  }
}
