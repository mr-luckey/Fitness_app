import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/modules/workout_collection/widgets/expandable_widget.dart';

class ProgressInfoWidget extends StatefulWidget {
  final List<bool> completeDays;
  final bool showAction;
  final bool showTitle;
  final String? currentDay;
  final Function? resetPlanFunction;
  const ProgressInfoWidget(
      {Key? key,
      required this.completeDays,
      this.currentDay,
      this.resetPlanFunction,
      this.showAction = true,
      this.showTitle = true})
      : super(key: key);

  @override
  State<ProgressInfoWidget> createState() => _ProgressInfoWidgetState();
}

class _ProgressInfoWidgetState extends State<ProgressInfoWidget> {
  late bool _expand;

  @override
  void initState() {
    _expand = widget.showTitle ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _progressValue = _getProgressValue();
    if (_progressValue.isNaN) {
      _progressValue = 0;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _expand = !_expand;
                });
              },
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Process',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColor.accentTextColor,
                          ),
                    ),
                    Icon(
                        _expand
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColor.accentTextColor),
                  ],
                ),
              ),
            ),
          ),
        ExpandableWidget(
          expand: _expand,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Day ${widget.currentDay}',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),
                          if (widget.showAction)
                            const SizedBox(
                              width: 4,
                            ),
                          if (widget.showAction)
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomConfirmationDialog(
                                        label: 'Automatically record progress',
                                        content:
                                            'The day will automatically be marked as completed when the calories for the day approximately equal the target calories (no more than 100 calories difference).',
                                        labelCancel: 'Close',
                                        textAlign: TextAlign.left,
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        showOkButton: false,
                                        buttonsAlignment: MainAxisAlignment.end,
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset(
                                  SVGAssetString.question,
                                  height: 20,
                                  color: AppColor.textColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (widget.showAction)
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomConfirmationDialog(
                                  label: 'Restart the route?',
                                  content:
                                      'Progress will be reset from the beginning and will not be saved',
                                  labelCancel: 'Cancel',
                                  labelOk: 'Start again',
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  onOk: () async {
                                    Navigator.of(context).pop();
                                    await widget.resetPlanFunction!();
                                  },
                                  buttonsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Text(
                              'Start again',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: AppColor.textColor
                                        .withOpacity(AppColor.subTextOpacity),
                                  ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: (widget.completeDays.length.isNaN ||
                          widget.completeDays.isEmpty)
                      ? 0
                      : 116,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Wrap(
                      spacing: 26.0,
                      runSpacing: 16.0,
                      children: _buildDayIndicatorList(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: _progressValue,
                        minHeight: 8,
                        backgroundColor: AppColor.textFieldUnderlineColor
                            .withOpacity(AppColor.subTextOpacity),
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.lerp(Alignment.topLeft,
                          Alignment.topRight, _progressValue)!,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                            '${(_progressValue * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _getProgressValue() {
    int count = widget.completeDays.length;
    int progress = widget.completeDays.where((element) => element).length;

    return progress.toDouble() / count.toDouble();
  }

  List<Widget> _buildDayIndicatorList(context) {
    List<Widget> results = [];
    for (int i = 0; i < widget.completeDays.length; i++) {
      results.add(
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              widget.completeDays[i]
                  ? SVGAssetString.checkedDay
                  : SVGAssetString.uncheckedDay,
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                '${i + 1}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
            ),
          ],
        ),
      );
    }
    return results;
  }
}
