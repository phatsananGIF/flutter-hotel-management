import 'package:flutter/material.dart';
import 'package:flutter_hotel_management/core/extensions/list_data_extension.dart';

import 'wg_not_found.dart';

class WgListBuilder<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) builder;
  final EdgeInsetsGeometry? padding;

  const WgListBuilder({
    Key? key,
    required this.items,
    required this.builder,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: items.getLengthForList(),
      itemBuilder: (context, index) {
        if (items.isEmpty) {
          return WgNotFound();
        }

        return builder(context, items[index]);
      },
    );
  }
}
