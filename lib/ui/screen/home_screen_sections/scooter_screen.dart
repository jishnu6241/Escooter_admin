import 'package:escooter_admin/blocs/scooter/scooter_bloc.dart';
import 'package:escooter_admin/ui/widgets/add_edit_scooter_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_button.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:escooter_admin/ui/widgets/custom_search.dart';
import 'package:escooter_admin/ui/widgets/scooter_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScooterScreen extends StatefulWidget {
  const ScooterScreen({super.key});

  @override
  State<ScooterScreen> createState() => _ScooterScreenState();
}

class _ScooterScreenState extends State<ScooterScreen> {
  String status = 'ride';
  ScooterBloc scooterBloc = ScooterBloc();

  String? query;

  void getScooters() {
    scooterBloc.add(
      GetAllScooterEvent(query: query, status: status),
    );
  }

  @override
  void initState() {
    getScooters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScooterBloc>.value(
      value: scooterBloc,
      child: BlocConsumer<ScooterBloc, ScooterState>(
        listener: (context, state) {
          if (state is ScooterFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getScooters();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomSearch(
                          onSearch: (search) {
                            query = search;
                            getScooters();
                          },
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
                              builder: (context) => AddEditScooterDialog(
                                scooterBloc: scooterBloc,
                              ),
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
                    groupValue: status,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    children: {
                      'ride': Text(
                        'On Ride',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      'hold': Text(
                        'On Hold',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    },
                    onValueChanged: (value) {
                      status = value!;
                      getScooters();
                      setState(() {});
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is ScooterSuccessState
                        ? state.scooters.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.scooters.length,
                                    (index) => ScooterCard(
                                      scooterBloc: scooterBloc,
                                      scooterDetails: state.scooters[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No scooters found.'))
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
