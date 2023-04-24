import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  const UserCard({
    super.key,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${userDetails['id'].toString()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Name',
                      text: userDetails['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone',
                      text: userDetails['phone'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Bank',
                      text: userDetails['bank_name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'IFSC',
                      text: userDetails['bank_ifsc'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Account Number',
                text: userDetails['bank_ac_no'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Deposit',
                text: '₹${userDetails['deposit_amount'].toString()}',
              ),
              const Divider(
                height: 30,
              ),
              CustomActionButton(
                iconData: Icons.arrow_outward_outlined,
                label: 'View Proof',
                color: Colors.purple[700]!,
                onPressed: () async {
                  Uri uri = Uri.parse(userDetails['proof_doc_url']);
                  if (await canLaunchUrl(uri)) {
                    launchUrl(uri);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
