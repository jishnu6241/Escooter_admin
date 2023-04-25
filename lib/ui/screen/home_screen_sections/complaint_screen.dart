import 'package:escooter_admin/blocs/complaints/complaints_bloc.dart';
import 'package:escooter_admin/ui/widgets/complaints/complaints_card.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  ComplaintsBloc complaintsBloc = ComplaintsBloc();

  @override
  void initState() {
    complaintsBloc.add(GetAllComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintsBloc>.value(
      value: complaintsBloc,
      child: BlocConsumer<ComplaintsBloc, ComplaintsState>(
        listener: (context, state) {
          if (state is ComplaintFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  complaintsBloc.add(GetAllComplaintEvent());
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: state is ComplaintSuccessState
                        ? state.complaints.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.complaints.length,
                                    (index) => ComplaintCard(
                                      complaints: state.complaints[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No complaints found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
