import 'package:escooter_admin/ui/widgets/add_edit_scooter_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_button.dart';
import 'package:escooter_admin/ui/widgets/custom_search.dart';
import 'package:escooter_admin/ui/widgets/scooter_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScooterScreen extends StatefulWidget {
  const ScooterScreen({super.key});

  @override
  State<ScooterScreen> createState() => _ScooterScreenState();
}

class _ScooterScreenState extends State<ScooterScreen> {
  String? groupValue = 'onRide';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: CustomSearch(
                    onSearch: (search) {},
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Add Scooter',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddEditScooterDialog(),
                      );
                    },
                  ),
                ),
              ],
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
                'onRide': Text(
                  'On Ride',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                'onHalt': Text(
                  'On Halt',
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
                    (index) => const ScooterCard(),
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
