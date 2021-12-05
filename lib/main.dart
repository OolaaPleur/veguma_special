import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';

import 'screens/wheel_list_screen.dart';
import 'models/wheels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      saveLocale: false,
      useOnlyLangCode: true,
      assetLoader: JsonAssetLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Wheels()),
      ],
      child: MaterialApp(
          title: 'Veguma Special',
          localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
                .copyWith(secondary: Colors.purple),
          ),
          routes: {
            '/': (ctx) => const WheelListScreen(),
          },
          supportedLocales: context.supportedLocales,
          locale: context.locale),
    );
  }
}
