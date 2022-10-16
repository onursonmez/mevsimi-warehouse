import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class ItemWidget extends StatelessWidget {
  final String path;
  final Color? shadowColor;
  final String name;
  const ItemWidget(
      {Key? key, required this.path, this.shadowColor, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.width * .2,
          height: context.width * .2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: shadowColor ?? context.appGreen.withOpacity(.7),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 0), // Shadow position
              ),
            ],
            color: context.appGrey,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: context.appBlack, width: context.width * 0.005),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {},
              child: Center(
                child: Image.asset(path, height: context.width * 0.15),
              ),
            ),
          ),
        ),
        Text(
          name,
          style: AppTextStyles.button20Regular,
        )
      ],
    );
  }
}
