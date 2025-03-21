import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:beFit/generated/l10n.dart';

class SetWeightDialog extends StatelessWidget {
  static const weightRange = 50.0;

  final double userWeight;

  const SetWeightDialog({super.key, required this.userWeight});

  @override
  Widget build(BuildContext context) {
    double selectedWeight = userWeight;
    return AlertDialog(
      title: Text(S.of(context).selectWeightDialogLabel),
      content: Wrap(children: [
        Column(
          children: [
            HorizontalPicker(
                height: 100,
                backgroundColor: Colors.transparent,
                minValue: userWeight - weightRange,
                maxValue: userWeight + weightRange,
                initialPosition: InitialPosition.center,
                divisions: 1000,
                suffix: S.of(context).kgLabel,
                onChanged: (value) {
                  selectedWeight = value;
                })
          ],
        )
      ]),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).dialogCancelLabel)),
        TextButton(
            onPressed: () {
              // TODO validate selected weight
              Navigator.pop(context, selectedWeight);
            },
            child: Text(S.of(context).dialogOKLabel)),
      ],
    );
  }
}
