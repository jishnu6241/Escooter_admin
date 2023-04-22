import 'package:escooter_admin/ui/widgets/custom_search.dart';
import 'package:escooter_admin/ui/widgets/withdraw_request_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawRequestScreen extends StatefulWidget {
  const WithdrawRequestScreen({super.key});

  @override
  State<WithdrawRequestScreen> createState() => _WithdrawRequestScreenState();
}

class _WithdrawRequestScreenState extends State<WithdrawRequestScreen> {
  String? groupValue = 'pending';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomSearch(
              onSearch: (search) {},
            ),
            const Divider(
              height: 20,
            ),
            CupertinoSlidingSegmentedControl(
              backgroundColor: Colors.green[50]!,
              thumbColor: Colors.black,
              groupValue: groupValue,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              children: {
                'pending': Text(
                  'Pending',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                'withdrawed': Text(
                  'Withdrawed',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              },
              onValueChanged: (value) {
                groupValue = value;
                setState(() {});
              },
            ),
            const Divider(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(
                    10,
                    (index) => const WithdrawRequestCard(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
