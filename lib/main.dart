import 'package:finance_app_fudeo/models/store.dart';
import 'package:finance_app_fudeo/pages/home_page.dart';
import 'package:finance_app_fudeo/repositories/database_repository.dart';
import 'package:finance_app_fudeo/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = "en_EN";
  await initializeDateFormatting("it_IT", null);

  final database = await DatabaseRepository.newConnection();
  GetIt.instance.registerSingleton(database);

  await store.value.initialize();

  runApp(App());
}

class App extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
