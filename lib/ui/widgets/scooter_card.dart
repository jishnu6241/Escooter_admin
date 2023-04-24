import 'package:escooter_admin/blocs/scooter/scooter_bloc.dart';
import 'package:escooter_admin/ui/widgets/add_edit_scooter_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ScooterCard extends StatelessWidget {
  final Map<String, dynamic> scooterDetails;
  final ScooterBloc scooterBloc;
  const ScooterCard({
    super.key,
    required this.scooterDetails,
    required this.scooterBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#${scooterDetails['id'].toString()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    scooterDetails['status'] == 'ride' ? 'On Ride' : 'On Hold',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                scooterDetails['plate_no'].toString().toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Parked Hub',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                scooterDetails['hub']['name'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              scooterDetails['status'] == 'ride'
                  ? const SizedBox()
                  : CustomActionButton(
                      iconData: Icons.delete_forever_outlined,
                      label: 'Delete',
                      color: Colors.red[700]!,
                      onPressed: () {
                        scooterBloc.add(DeleteScooterEvent(
                          id: scooterDetails['id'],
                        ));
                      },
                    ),
              SizedBox(
                height: scooterDetails['status'] == 'ride' ? 0 : 10,
              ),
              scooterDetails['status'] == 'ride'
                  ? const SizedBox()
                  : CustomActionButton(
                      iconData: Icons.delete_forever_outlined,
                      label: 'Update Hub',
                      color: Colors.purple[700]!,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AddEditScooterDialog(
                            scooterBloc: scooterBloc,
                            scooterDetails: scooterDetails,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
