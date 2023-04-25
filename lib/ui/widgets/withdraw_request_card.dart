import 'package:escooter_admin/blocs/withdraw_request/withdraw_request_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class WithdrawRequestCard extends StatelessWidget {
  final Map<String, dynamic> withdrawRequest;
  final WithdrawRequestBloc withdrawRequestBloc;
  const WithdrawRequestCard({
    super.key,
    required this.withdrawRequest,
    required this.withdrawRequestBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#${withdrawRequest['id'].toString()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    withdrawRequest['status'] == 'pending'
                        ? 'Pending'
                        : 'Withdrawed',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
              ),
              Text(
                "#${withdrawRequest['user']['id']}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Name',
                      text: withdrawRequest['user']['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone',
                      text: withdrawRequest['user']['phone'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '₹500',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              withdrawRequest['status'] == 'pending'
                  ? const Divider(
                      height: 30,
                    )
                  : const SizedBox(),
              withdrawRequest['status'] == 'pending'
                  ? CustomActionButton(
                      iconData: Icons.done_all_outlined,
                      label: 'Payment Done',
                      color: Colors.blue[700]!,
                      onPressed: () {
                        withdrawRequestBloc.add(
                          UpdateWithdrawRequestStatusEvent(
                              id: withdrawRequest['id']),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
