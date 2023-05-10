import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigator_util.dart';

T getBlocProvider<T extends Bloc>() {
  if (NavigatorUtil.navigate.currentState != null) {
    return BlocProvider.of<T>(NavigatorUtil.navigate.currentState!.context);
  } else {
    throw 'can not find current state';
  }
}
