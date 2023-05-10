import 'package:flutter/material.dart';
import 'package:flutter_hotel_management/core/styles/color.dart';

import '../../../../core/styles/sarabun_font.dart';
import '../../../../core/styles/screen_dimensions.dart';
import '../../../../core/utils/navigator_util.dart';
import '../../customer/customer_screen.dart';

class HomeSummaryCard extends StatelessWidget {
  final int? total;

  const HomeSummaryCard({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushToPage(CustomerScreen());
      },
      child: Container(
        padding: EdgeInsets.all(SCDimens.dimen10),
        decoration: BoxDecoration(
          color: Color(GREEN_GRAY_COLOR),
          borderRadius: BorderRadius.all(
            Radius.circular(SCDimens.dimen10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("จำนวนลูกค้า", style: SBFont.medium18),
            Text("${total ?? 0} คน", style: SBFont.medium18),
          ],
        ),
      ),
    );
  }
}
