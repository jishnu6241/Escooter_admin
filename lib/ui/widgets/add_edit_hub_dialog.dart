import 'package:escooter_admin/blocs/hub/hub_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/map_location_selector.dart';
import 'package:escooter_admin/util/value_validators.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEditHubDialog extends StatefulWidget {
  final Map<String, dynamic>? hubDetails;
  final HubBloc hubBloc;
  const AddEditHubDialog({
    super.key,
    this.hubDetails,
    required this.hubBloc,
  });

  @override
  State<AddEditHubDialog> createState() => _AddEditHubDialogState();
}

class _AddEditHubDialogState extends State<AddEditHubDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  LatLng? location;

  @override
  void initState() {
    if (widget.hubDetails != null) {
      _nameController.text = widget.hubDetails!['name'];
      _addressController.text = widget.hubDetails!['address'];
      location = LatLng(
          widget.hubDetails!['latitude'], widget.hubDetails!['longitude']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: widget.hubDetails != null ? "Edit Hub" : "Add Hub",
      message: widget.hubDetails != null
          ? "Change the following details and save to apply them"
          : "Enter the following details to add a hub",
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Hub Name',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _nameController,
                validator: alphaNumericValidator,
                decoration: const InputDecoration(
                  hintText: 'Hub name',
                ),
              ),
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            Text(
              'Address',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _addressController,
                maxLines: 3,
                validator: alphaNumericValidator,
                decoration: const InputDecoration(
                  hintText: 'eg.adress line1, address line 2',
                ),
              ),
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomActionButton(
              color: location != null ? Colors.blue : Colors.grey[600]!,
              iconData: location != null ? Icons.check : Icons.map_outlined,
              onPressed: () async {
                LatLng? selectedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MapLocationSelector(),
                  ),
                );

                if (selectedLocation != null) {
                  location = selectedLocation;
                  setState(() {});
                }
              },
              label: location != null
                  ? '${location!.latitude}, ${location!.longitude}'
                  : 'Add Location',
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomButton(
              labelColor: Colors.white,
              label: widget.hubDetails != null ? 'Save' : 'Add',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.hubDetails != null) {
                    widget.hubBloc.add(
                      EditHubEvent(
                        hubId: widget.hubDetails!['id'],
                        name: _nameController.text.trim(),
                        address: _addressController.text.trim(),
                        latLng: location,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    if (location != null) {
                      widget.hubBloc.add(
                        AddHubEvent(
                          name: _nameController.text.trim(),
                          address: _addressController.text.trim(),
                          latLng: location!,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => const CustomAlertDialog(
                          title: 'Required !',
                          message:
                              'Location is required, please select a location.',
                          primaryButtonLabel: 'Ok',
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
