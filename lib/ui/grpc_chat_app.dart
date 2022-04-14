import 'package:grpc_chat_flutter/di/injector.dart';
import 'package:grpc_chat_flutter/ui/pager.dart';
import 'package:grpc_chat_flutter/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class GrpcChatApp extends StatelessWidget {

  const GrpcChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateTitle: (ctx) => "Demo chat gRPC",
      theme: darkTheme,
      darkTheme: darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      initialRoute: "/",
      getPages: Pager(
        injector: Injector.getInstance(),
      ).pages,
    );
  }
}
