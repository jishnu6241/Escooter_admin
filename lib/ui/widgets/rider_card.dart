import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RidesCard extends StatelessWidget {
  final Map<String, dynamic> rideDetails;
  const RidesCard({
    super.key,
    required this.rideDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: CustomCard(
        color: Colors.greenAccent[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#${rideDetails['id'].toString()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    rideDetails['status'] == 'complete' ? 'On Hold' : 'On Ride',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Scooter',
                      text: rideDetails['scooter']['plate_no']
                          .toString()
                          .toUpperCase(),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Rider',
                      text: rideDetails['user']['name'],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Start Hub',
                      text: rideDetails['start_hub']['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'End Hub',
                      text: rideDetails['end_hub'] != null
                          ? rideDetails['end_hub']['name']
                          : 'Scooter is on ride',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Start Time',
                      text: DateFormat('dd/MM/yyyy hh:mm a').format(
                        DateTime.parse(rideDetails['start_time']).toLocal(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'End Time',
                        text: rideDetails['end_time'] != null
                            ? DateFormat('dd/MM/yyyy hh:mm a').format(
                                DateTime.parse(rideDetails['end_time']),
                              )
                            : 'Scooter is on ride'),
                  ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Amount',
                      text: rideDetails['status'] == 'active'
                          ? 'Scooter is on ride'
                          : '₹${rideDetails['amount'].toString()}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Payment Status',
                      text: rideDetails['status'] == 'complete'
                          ? 'Paid'
                          : 'Pending',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
