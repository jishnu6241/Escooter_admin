import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/label_with_text.dart';
import 'package:escooter_admin/util/get_date.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaints;
  const ComplaintCard({
    super.key,
    required this.complaints,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CustomCard(
        color: Colors.red[50],
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${complaints['id'].toString()}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    Text(
                      getDate(DateTime.parse(complaints['created_at'])),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                ),
                Text(
                  complaints['complaint'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Divider(
                  height: 30,
                ),
                LabelWithText(
                  label: 'Plate number',
                  text: complaints['scooter']['plate_no']
                      .toString()
                      .toUpperCase(),
                ),
                const Divider(
                  height: 30,
                ),
                Text(
                  '#${complaints['profile']['id'].toString()}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LabelWithText(
                        label: 'Name',
                        text: complaints['profile']['name'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone',
                        text: complaints['profile']['phone'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
