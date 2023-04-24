import 'package:escooter_admin/blocs/hub/hub_bloc.dart';
import 'package:escooter_admin/ui/widgets/add_edit_hub_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HubCard extends StatelessWidget {
  final Map<String, dynamic> hubDetails;
  final HubBloc hubBloc;
  const HubCard({
    super.key,
    required this.hubDetails,
    required this.hubBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "#${hubDetails['id'].toString()}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                hubDetails['name'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hubDetails['address'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              CustomActionButton(
                iconData: Icons.map_outlined,
                label: 'Map',
                color: Colors.blue,
                onPressed: () async {
                  Uri uri = Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=${hubDetails['latitude']},${hubDetails['longitude']}');

                  await launchUrl(uri);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                iconData: Icons.edit_outlined,
                label: 'Edit',
                color: Colors.pink,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddEditHubDialog(
                      hubDetails: hubDetails,
                      hubBloc: hubBloc,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                iconData: Icons.delete_forever_outlined,
                label: 'Delete',
                color: Colors.red[700]!,
                onPressed: () {
                  hubBloc.add(DeleteHubEvent(
                    id: hubDetails['id'],
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
