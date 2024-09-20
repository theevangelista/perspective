import 'package:perspective/perspective.dart';
import 'package:provider/provider.dart';

/// A provider that creates a [ViewModel] and disposes of it when no longer needed.
class ViewModelProvider extends Provider<ViewModel> {
  ViewModelProvider({super.key, required Create<ViewModel> create, super.lazy})
      : super(
          create: (context) {
            final viewModel = create(context);
            viewModel.onInit();
            return viewModel;
          },
          dispose: (context, value) => value.dispose(),
        );
}

