import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:veguma_special/models/createPdf.dart';

import 'package:veguma_special/widgets/new_tire_widget.dart';
import 'package:veguma_special/models/wheels.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('addData')),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CreatePdf>(context, listen: false).createPdfOnPressed(context);
            },
            icon: const Icon(Icons.share),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            int listLength =
                Provider.of<Wheels>(context, listen: false).tires.length;
            Provider.of<Wheels>(context, listen: false).addWheel(
                number: listLength,
                tireSize: tr('tireSize'),
                treadType: tr('treadType'),
                treadWidth: tr('treadWidth'),
                patchNumbers: tr('patchNumbers'),
                interlayer: tr('interlayer'),
                client: '',
                warehouse: tr('warehouse'),
                newTreadType: tr('treadType'),
                newTreadWidth: tr('treadWidth'),
                newTread: false,
                treadDefect: false,
                tireBrand: '',
                tireSizeLength: '',
                treadDate: '',
                mixtureNumber: '',
                hardness: '');
          },
          child: const Icon(Icons.add)),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Wheels>(
                      builder: (ctx, tireData, _) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListView.builder(
                              itemCount: tireData.tires.length,
                              itemBuilder: (_, i) {
                                return Column(
                                  children: [
                                    NewTireWidget(wheel: tireData.tires[i]),
                                    const Divider(),
                                  ],
                                );
                              })),
                    ),
                  ),
      ),
    );
  }
}
