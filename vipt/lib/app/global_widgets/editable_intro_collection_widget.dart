import 'package:flutter/material.dart';
import 'package:vipt/app/modules/workout_collection/widgets/text_field_widget.dart';

class EditableIntroCollectionWidget extends StatelessWidget {
  final String hintTitle;
  final String? errorText;
  final TextStyle? titleTextStyle;
  final TextEditingController titleTextController;
  final TextEditingController? descriptionTextController;
  const EditableIntroCollectionWidget({
    Key? key,
    required this.titleTextController,
    this.errorText,
    this.descriptionTextController,
    this.hintTitle = 'Enter the training set name',
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: TextFieldWidget(
            textEditingController: titleTextController,
            hint: hintTitle,
            errorText: errorText,
            textStyle: titleTextStyle ?? Theme.of(context).textTheme.headline2,
            underline: descriptionTextController != null ? true : false,
          ),
        ),
        if (descriptionTextController != null)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFieldWidget(
              textEditingController: descriptionTextController!,
              hint: 'Enter a description',
              errorText: errorText,
              textStyle: Theme.of(context).textTheme.subtitle2,
              underline: false,
            ),
          ),
      ],
    );
  }
}
