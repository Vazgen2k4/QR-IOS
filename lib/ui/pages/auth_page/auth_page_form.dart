import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/widgets/custom_input_widget.dart';

class AuthPageForm extends StatelessWidget {
  final List<CustomInputWidget> children;
  const AuthPageForm({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: children.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return children[i];
      },
    );
  }
}
