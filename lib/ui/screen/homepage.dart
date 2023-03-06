import 'package:escooter_admin/ui/screen/home_screen_sections/employee_management.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/scooter_management.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/user_management.dart';
import 'package:escooter_admin/ui/screen/hub_management.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 2,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Material(
            color: Color.fromARGB(169, 238, 238, 238),
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
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDrawerButton(
                    iconData: Icons.dashboard_outlined,
                    onPressed: () {
                      tabController.animateTo(0);
                      setState(() {});
                    },
                    isSelected: tabController.index == 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDrawerButton(
                    iconData: Icons.people_outline_rounded,
                    onPressed: () {
                      tabController.animateTo(1);
                      setState(() {});
                    },
                    isSelected: tabController.index == 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDrawerButton(
                    iconData: Icons.badge_outlined,
                    onPressed: () {
                      tabController.animateTo(2);
                      setState(() {});
                    },
                    isSelected: tabController.index == 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDrawerButton(
                    iconData: Icons.hub_outlined,
                    onPressed: () {
                      tabController.animateTo(3);
                      setState(() {});
                    },
                    isSelected: tabController.index == 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDrawerButton(
                    iconData: Icons.electric_moped_outlined,
                    onPressed: () {
                      tabController.animateTo(4);
                      setState(() {});
                    },
                    isSelected: tabController.index == 4,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: Colors.blueGrey,
                ),
                UserManagementSection(),
                EmployeeManagementSection(),
                HubManagementSection(),
                ScooterManagementSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: isSelected ? Colors.green : Colors.black,
      ),
    );
  }
}

class CustomTableHeading extends StatelessWidget {
  final String label;
  const CustomTableHeading({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
