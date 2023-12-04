import 'package:get/get_navigation/src/routes/get_route.dart';
import '../bluetoothPrintScreen.dart';
import '../view/CashInOutAdd.dart';
import '../view/CashInOutList.dart';
import '../view/DashboardScreen.dart';
import '../view/LoginScreen.dart';
import '../view/printPreview.dart';
import '../view/settlementList.dart';
import '../view/settlementScreen.dart';
import '../view/splashscreen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String splash = "/Splash";
  static const String dashboardScreen = "/DashboardScreen";
  static const String posInvoicePrintPreview = "/PosInvoicePrintPreview";
  static const String bLUEPRINTVIEW = "/bLUEPRINTVIEW";
  static const String addSettlement = "/SettlementScreen";
  static const String settlementList = "/StatementList";
  static const String cashInOutList = "/CashInOutList";
  static const String addCashInOut = "/AddCashInOut";

}

final pages = [
  GetPage(name: AppRoutes.splash, page: () =>  Splash()),
  GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
  GetPage(name: AppRoutes.dashboardScreen, page: () => const DashboardScreen()),
  GetPage(name: AppRoutes.posInvoicePrintPreview, page: () =>  PosInvoicePrintPreview()),
  GetPage(name: AppRoutes.bLUEPRINTVIEW, page: () =>  BLUEPRINTVIEW()),
  GetPage(name: AppRoutes.addSettlement, page: () =>  const SettlementScreen()),
  GetPage(name: AppRoutes.settlementList, page: () =>  const SettlementList()),
  GetPage(name: AppRoutes.addCashInOut, page: () =>  const CashInOutAdd()),
  GetPage(name: AppRoutes.cashInOutList, page: () =>  const CashInOutList()),
];