import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:vipt/app/core/values/colors.dart';

class MultipleChoiceCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String asset;
  final bool isSelected;
  final Function onSelected;
  final Color? selectedColor;

  const MultipleChoiceCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.asset = '',
    required this.isSelected,
    required this.onSelected,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: isSelected
            ? BorderSide(
                color: selectedColor ?? Theme.of(context).primaryColor,
                width: 1.2,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: () {
          onSelected();
        },
        child: subtitle == 'Body type'
            ? _buildBodyTypeCard(context, asset)
            : subtitle == 'Normal day type'
                ? _buildTypicalDayCard(context, asset)
                : ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: _buildAsset(asset),
                    title: Text(title,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: subtitle == null
                        ? null
                        : Text(subtitle as String,
                            style: Theme.of(context).textTheme.subtitle1),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color:
                                selectedColor ?? Theme.of(context).primaryColor,
                          )
                        : const Icon(
                            Icons.radio_button_unchecked_outlined,
                          ),
                  ),
      ),
    );
  }

  Widget _buildBodyTypeCard(context, asset) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (asset != null) _buildAsset(asset) as Widget,
          const SizedBox(
            width: 24,
          ),
          Text(title, style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }

  Widget _buildTypicalDayCard(context, String? asset) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (asset != null) _buildAsset(asset) as Widget,
          const SizedBox(
            width: 24,
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(title, style: Theme.of(context).textTheme.headline5)),
        ],
      ),
    );
  }

  Widget? _buildAsset(String asset) {
    if (asset.isEmpty) {
      return null;
    } else if (asset.contains('https')) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 74,
          minHeight: 74,
          maxWidth: 80,
          maxHeight: 150,
        ),
        child: Image.network(
          asset,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      );
    } else if (p.extension(asset) == '.svg') {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 74,
          minHeight: 74,
          maxWidth: 80,
          maxHeight: 150,
        ),
        child: SvgPicture.asset(asset),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 74,
          minHeight: 74,
          maxWidth: 80,
          maxHeight: 150,
        ),
        child: Image.asset(
          asset,
        ),
      );
    }
  }
}
