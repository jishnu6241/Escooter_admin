import 'package:escooter_admin/blocs/scooter/scooter_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_button.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/hub_selector.dart';
import 'package:escooter_admin/util/value_validators.dart';
import 'package:flutter/material.dart';

class AddEditScooterDialog extends StatefulWidget {
  final Map<String, dynamic>? scooterDetails;
  final ScooterBloc scooterBloc;
  final String? status;
  const AddEditScooterDialog({
    super.key,
    this.scooterDetails,
    required this.scooterBloc,
    this.status,
  });

  @override
  State<AddEditScooterDialog> createState() => _AddEditScooterDialogState();
}

class _AddEditScooterDialogState extends State<AddEditScooterDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _plateNumberController = TextEditingController();

  int? hubId;
  String? hubName;

  @override
  void initState() {
    if (widget.scooterDetails != null) {
      _plateNumberController.text = widget.scooterDetails!['plate_no'];
      hubId = widget.scooterDetails!['hub']['id'];
      hubName = widget.scooterDetails!['hub']['name'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: widget.scooterDetails != null ? "Update Hub" : "Add Scooter",
      message: widget.scooterDetails != null
          ? "Change the following details and save to apply them"
          : "Enter the following details to add a scooter",
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              widget.scooterDetails != null ? 'Hub' : 'Plate Number',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            widget.scooterDetails != null
                ? const SizedBox()
                : CustomCard(
                    child: TextFormField(
                      readOnly: widget.scooterDetails != null,
                      controller: _plateNumberController,
                      validator: alphaNumericValidator,
                      decoration: const InputDecoration(
                        hintText: 'eg.KL 13 AA 1234',
                      ),
                    ),
                  ),
            widget.scooterDetails != null
                ? const SizedBox()
                : const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
            HubSelector(
              onSelect: (id) {
                hubId = id;
                setState(() {});
              },
              label: hubName ?? 'Select Hub',
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomButton(
              labelColor: Colors.white,
              label: widget.scooterDetails != null ? 'Save' : 'Add',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.scooterDetails != null) {
                    widget.scooterBloc.add(
                      EditScooterEvent(
                        scooterId: widget.scooterDetails!['id'],
                        plateNo: _plateNumberController.text.trim(),
                        parkedHubId: hubId!,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    widget.scooterBloc.add(
                      AddScooterEvent(
                        plateNo: _plateNumberController.text.trim(),
                        parkedHubId: hubId!,
                        status: widget.status,
                      ),
                    );
                    Navigator.pop(context);
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
