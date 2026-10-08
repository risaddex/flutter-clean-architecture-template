import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean_architecture_template/core/view_model_initializable.dart';
import 'package:flutter_clean_architecture_template/ui/home/home_viewmodel.dart';

class HomeBindings extends StatelessWidget {
  const HomeBindings({
    super.key,
    required this.screenBuilder,
  });

  final WidgetBuilder screenBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel().initialized(),
        ),
      ],
      builder: (_, __) => screenBuilder(context),
    );
  }
}
