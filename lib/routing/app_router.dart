import 'dart:developer';

import 'package:finance_app_fudeo/models/expense.dart';
import 'package:finance_app_fudeo/pages/edit_expense_page.dart';
import 'package:finance_app_fudeo/pages/home_page.dart';
import 'package:finance_app_fudeo/pages/new_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:finance_app_fudeo/routing/router_constants.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homePageRoute:
        return MaterialPageRoute(builder: (context) => HomePage());
      case newExpensePageRoute:
        return MaterialPageRoute(builder: (context) => NewExpensePage());
      case editExpensePageRoute:
        return MaterialPageRoute(
          builder: (context) =>
              EditExpensePage(routeSettings.arguments as Expense),
        );
      default:
        return MaterialPageRoute(builder: (context) => HomePage());
    }
  }
}
