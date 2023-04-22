import 'package:escooter_admin/ui/screen/home_screen_sections/complaint_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/dashboard_and_rides_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/scooter_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/suggestion_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/user_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/hub_screen.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/withdraw_request_screen.dart';
import 'package:escooter_admin/ui/screen/login.dart';
import 'package:escooter_admin/ui/widgets/change_password_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 7,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.greenAccent,
        ),
        title: Text(
          'E Scooter',
          style: GoogleFonts.sedgwickAveDisplay(
            textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        elevation: 1,
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardAndRidesScreen(),
          HubScreen(),
          ScooterScreen(),
          UserScreen(),
          WithdrawRequestScreen(),
          ComplaintScreen(),
          SuggestionScreen(),
        ],
      ),
      drawer: Material(
        color: Colors.grey[900],
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              children: [
                Text(
                  'MENU',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDrawerButton(
                  iconData: Icons.dashboard_customize_outlined,
                  onPressed: () {
                    tabController.animateTo(0);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 0,
                  label: 'Dashboard & Rides',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  label: 'Hubs',
                  iconData: Icons.hub_outlined,
                  onPressed: () {
                    tabController.animateTo(1);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  label: 'Scooters',
                  iconData: Icons.electric_moped_outlined,
                  onPressed: () {
                    tabController.animateTo(2);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  label: 'Users',
                  iconData: Icons.people_alt_outlined,
                  onPressed: () {
                    tabController.animateTo(3);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  label: 'Withdraw Requests',
                  iconData: Icons.money_outlined,
                  onPressed: () {
                    tabController.animateTo(4);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  iconData: Icons.dangerous_outlined,
                  onPressed: () {
                    tabController.animateTo(5);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 5,
                  label: 'Complaints',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  iconData: Icons.message_outlined,
                  onPressed: () {
                    tabController.animateTo(6);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 6,
                  label: 'Suggestions',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  iconData: Icons.lock_open_outlined,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ChangePasswordDialog(),
                    );
                  },
                  label: 'Change Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDrawerButton(
                  iconData: Icons.logout_outlined,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Logout',
                        message: 'Are you sure that you want to logout ?',
                        primaryButtonLabel: 'Logout',
                        primaryOnPressed: () async {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => true,
                          );
                          await Supabase.instance.client.auth.signOut();
                        },
                        secondaryButtonLabel: 'Cancel',
                        secondaryOnPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                  label: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<CustomDrawerButton> createState() => _CustomDrawerButtonState();
}

class _CustomDrawerButtonState extends State<CustomDrawerButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _hover = true;
      }),
      onExit: (event) => setState(() {
        _hover = false;
      }),
      child: CustomCard(
        color:
            !(widget.isSelected || _hover) ? Colors.black : Colors.greenAccent,
        hoverColor: Colors.greenAccent,
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            children: [
              Icon(
                widget.iconData,
                color:
                    (widget.isSelected || _hover) ? Colors.black : Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: (widget.isSelected || _hover)
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
