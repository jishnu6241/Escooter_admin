import 'package:escooter_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:escooter_admin/blocs/ride/ride_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:escooter_admin/ui/widgets/rider_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAndRidesScreen extends StatefulWidget {
  const DashboardAndRidesScreen({super.key});

  @override
  State<DashboardAndRidesScreen> createState() =>
      _DashboardAndRidesScreenState();
}

class _DashboardAndRidesScreenState extends State<DashboardAndRidesScreen> {
  DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  RideBloc ridesBloc = RideBloc();

  String status = 'active';

  void getRequests() {
    ridesBloc.add(RideEvent(status: status));
  }

  @override
  void initState() {
    dashboardCountBloc.add(DashboardCountEvent());
    getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCountBloc>.value(
          value: dashboardCountBloc,
        ),
        BlocProvider<RideBloc>.value(
          value: ridesBloc,
        ),
      ],
      child: BlocConsumer<RideBloc, RideState>(
        listener: (context, state) {
          if (state is RideFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getRequests();
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
                  BlocConsumer<DashboardCountBloc, DashboardCountState>(
                    listener: (context, state) {
                      if (state is DashboardCountFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Failed',
                            message: state.message,
                            primaryButtonLabel: 'Ok',
                            primaryOnPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is DashboardCountSuccessState
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                DashboardCard(
                                  label: 'Total Users',
                                  title: state.dashbordCount['profiles'],
                                  icon: Icons.people_outline,
                                ),
                                DashboardCard(
                                  label: 'Total Scooters',
                                  title: state.dashbordCount['scooters'],
                                  icon: Icons.electric_moped_outlined,
                                ),
                                DashboardCard(
                                  label: 'Total Hubs',
                                  title: state.dashbordCount['hubs'],
                                  icon: Icons.hub_outlined,
                                ),
                              ],
                            )
                          : state is DashboardCountLoadingState
                              ? const Center(
                                  child: CustomProgressIndicator(),
                                )
                              : const SizedBox();
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rides',
                        style: GoogleFonts.notoSans(
                          textStyle:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
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
                          'active': Text(
                            'Active',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          'complete': Text(
                            'Completed',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        },
                        onValueChanged: (value) {
                          status = value!;
                          getRequests();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: state is RideSuccessState
                          ? state.rides.isNotEmpty
                              ? Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.rides.length,
                                    (index) => RidesCard(
                                      rideDetails: state.rides[index],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No rides found'),
                                )
                          : const Center(
                              child: CustomProgressIndicator(),
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
        },
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
