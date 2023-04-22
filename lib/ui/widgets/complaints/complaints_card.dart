import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    super.key,
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
                      '#12',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    Text(
                      '19/04/2023',
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
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Divider(
                  height: 30,
                ),
                const LabelWithText(
                  label: 'Plate number',
                  text: 'KL 13 A 1234',
                ),
                const Divider(
                  height: 30,
                ),
                Text(
                  '#11',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: LabelWithText(
                        label: 'Name',
                        text: 'John',
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone',
                        text: '987654321',
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
