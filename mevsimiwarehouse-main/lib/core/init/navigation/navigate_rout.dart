import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/view/deliverjob/items/view/selected_items.dart';
import '../../../view/_view_exports.dart';
import '../../_core_exports.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.IP_VIEW:
        return normalNavigate(const IpLayerView());
      case NavigationConstants.LOGIN:
        return normalNavigate(const LoginView());
      case NavigationConstants.LANDING_PAGE:
        return normalNavigate(const LandingView());
      case NavigationConstants.PRODUCTS_LIST:
        return normalNavigate(const ProductsListView());
      case NavigationConstants.PRODUCT_DETAIL:
        return normalNavigate(const ProductDetailView());
      case NavigationConstants.REQUEST_PRODUCT_VIEW:
        return normalNavigate(const WaitingProductView());
      case NavigationConstants.ITEMS_VIEW:
        return normalNavigate(const ItemView());
      case NavigationConstants.SELECTED_ITEM_VIEW:
        return normalNavigate(const SelectedItem());

      default:
        return MaterialPageRoute(
          builder: (context) => const IpLayerView(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
