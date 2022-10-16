import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/view/deliverjob/viewmodel/_viewmodel_exports.dart';
import 'package:pointmobile_scanner/pointmobile_scanner.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  void initState() {
    super.initState();
    PointmobileScanner.channel.setMethodCallHandler(null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: !Provider.of<DeliverJobViewModel>(context, listen: true).isLoad
              ? Consumer<DeliverJobViewModel>(
                  builder: (context, deliverJobViewModel, child) {
                  return Column(children: [
                    GeneralAppBar(
                      backArrowButton: () {
                        deliverJobViewModel.clearCloneItem();
                        PointmobileScanner.channel.setMethodCallHandler(null);
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstants.LANDING_PAGE);
                      },
                    ),

                    Padding(
                      padding: context.paddingAllHigh,
                      child: Row(
                        children: [
                          Text(
                            "1/2 Toplu Ürün İşlemleri",
                            style: AppTextStyles.button16Regular
                                .copyWith(color: AppColors.darkGreen),
                          ),
                        ],
                      ),
                    ),
                    // selectedItemList(deliverJobViewModel, context),
                    const Divider(),
                    Expanded(
                      child: Padding(
                        padding: context.paddingHighHorizontal,
                        child: itemsList(deliverJobViewModel),
                      ),
                    ),
                    Padding(
                      padding: context.paddingAllMedium,
                      child: StandartButton(
                        btnFunction: () {
                          NavigationService.instance.navigateToPage(
                              path: NavigationConstants.SELECTED_ITEM_VIEW);
                        },
                        bacgraundColor: AppColors.appBlue,
                        buttonText: "Devamet",
                      ),
                    )
                  ]);
                })
              : Center(
                  child: CircularProgressIndicator(color: context.appGreen),
                ),
        ),
      ),
      onWillPop: () async {
        Provider.of<DeliverJobViewModel>(context).clearCloneItem();
        PointmobileScanner.channel.setMethodCallHandler(null);
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.LANDING_PAGE);
        return true;
      },
    );
  }

  Widget itemsList(DeliverJobViewModel deliverJobViewModel) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: deliverJobViewModel.clonTotalItem.length,
      itemBuilder: (context, index) {
        return ProductInformationCard(
          items: deliverJobViewModel.clonTotalItem[index],
          onTapSelectItem: () {
            deliverJobViewModel.selectedItem(index);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: ScreenSize().getWidthPercent(.021),
        );
      },
    );
  }

  Container checkBox(bool check) {
    return Container(
      width: ScreenSize().getWidthPercent(.1),
      height: ScreenSize().getWidthPercent(.1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: check ? AppColors.appGreen : null,
          border: Border.all(
              color: check ? AppColors.appGreen : AppColors.appGrey)),
    );
  }
}
