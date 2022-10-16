import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:provider/provider.dart';

import '../../../_view_exports.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                GeneralAppBar(backArrowButton: () {
                  NavigationService.instance
                      .navigateToPage(path: NavigationConstants.LANDING_PAGE);
                }),
                Expanded(child: landingBody(context))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          NavigationService.instance
              .navigateToPage(path: NavigationConstants.LANDING_PAGE);
          return false;
        });
  }

  Widget landingBody(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenSize().getWidthPercent(0.07),
                top: context.lowMediumValue,
                bottom: context.width * 0.08),
            child: Text(
              Provider.of<DeliverJobViewModel>(context).filterTypeString,
              style: AppTextStyles.button24Regular,
            ),
          ),
        ),
        Expanded(
          child: Consumer<DeliverJobViewModel>(
            builder: (context, deliverJobViewmodel, child) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              deliverJobViewmodel.selectProduct(index);
                            },
                            child: BoxInfIrmationCard(
                                product:
                                    deliverJobViewmodel.filterProduct[index]),
                          ),
                        ],
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: context.lowValue,
                      ),
                  itemCount: deliverJobViewmodel.filterProduct.length);
            },
          ),
        )
      ],
    );
  }
}
