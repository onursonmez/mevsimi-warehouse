import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/_core_exports.dart';
import '../../../_view_exports.dart';

class WaitingProductView extends StatelessWidget {
  const WaitingProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: Column(children: [
              GeneralAppBar(
                backArrowButton: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Consumer<DeliverJobViewModel>(
                  builder: (context, deliverJobViewModel, child) =>
                      ListView.builder(
                    itemCount: deliverJobViewModel.lLocaleStackProducts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RequestBoxInfIrmationCard(
                            product:
                                deliverJobViewModel.lLocaleStackProducts[index],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
