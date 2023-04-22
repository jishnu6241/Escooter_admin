import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HubCard extends StatelessWidget {
  const HubCard({
    super.key,
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
                  "#11",
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
                'Hub name',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Address line 1, address line 2, city, place, state ,district, pin 670301',
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
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                iconData: Icons.edit_outlined,
                label: 'Edit',
                color: Colors.pink,
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                iconData: Icons.delete_forever_outlined,
                label: 'Delete',
                color: Colors.red[700]!,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
