import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointmobile_scanner/pointmobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../../core/_core_exports.dart';
import '../../../_view_exports.dart';

class SelectedItem extends StatefulWidget {
  const SelectedItem({Key? key}) : super(key: key);

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  @override
  void initState() {
    super.initState();
    PointmobileScanner.channel.setMethodCallHandler(_onBarcodeScannerHandler);
    PointmobileScanner.initScanner();
    _count = 0;
  }

  late String barcode;
  Future<void> _onBarcodeScannerHandler(MethodCall call) async {
    try {
      barcode = call.arguments[1].toString();

      Provider.of<DeliverJobViewModel>(context, listen: false)
          .saveItem(barcode);
    } catch (e) {
      ErrorSnackBar().showMessageSnackBar("BARKOD OKUMA SIRASINDA HATA OLUŞTU");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _count = 0;
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
                        PointmobileScanner.channel.setMethodCallHandler(null);
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: context.paddingAllHigh,
                      child: Row(
                        children: [
                          Text(
                            "2/2 Toplu Ürün İşlemleri",
                            style: AppTextStyles.button16Regular
                                .copyWith(color: AppColors.darkGreen),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: context.paddingAllHigh,
                      child: Row(children: [
                        SvgIcons(
                            path: ImageConstants.instance.getBocIcon,
                            size: .15),
                        Expanded(
                          child: Padding(
                            padding: context.paddingHighHorizontal,
                            child: RichText(
                              text: TextSpan(
                                text: 'Lütfen aşağıdaki ürünleri koyduğunuz ',
                                style: AppTextStyles.button16Regular
                                    .copyWith(color: AppColors.appGreen),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Kutunun Barkodunu',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'okutunuz.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SvgIcons(
                      path: ImageConstants.instance.getQrImage,
                      size: .6,
                    ),
                    Padding(
                      padding: context.paddingHighHorizontal,
                      child: Row(
                        children: [
                          Text(
                            "Seçili Ürünler",
                            style: AppTextStyles.button16Regular
                                .copyWith(color: AppColors.appGreen),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: context.paddingHighHorizontal,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: deliverJobViewModel.clonTotalItem.length,
                          itemBuilder: (context, index) {
                            deliverJobViewModel
                                    .clonTotalItem[index].cacheIsSelected!
                                ? _count++
                                : null;
                            return deliverJobViewModel
                                    .clonTotalItem[index].cacheIsSelected!
                                ? Text(_count.toString() +
                                    ". " +
                                    deliverJobViewModel
                                        .clonTotalItem[index].name!)
                                : const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ]);
                })
              : Center(
                  child: CircularProgressIndicator(color: context.appGreen),
                ),
        ),
      ),
      onWillPop: () async {
        PointmobileScanner.channel.setMethodCallHandler(null);
        Navigator.pop(context);
        return false;
      },
    );
  }
}
