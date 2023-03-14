import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ScooterManagementSection extends StatelessWidget {
  const ScooterManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "SCOOTER MANAGEMENT",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DataTable2(
                columns: [
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "ID",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "Scooter Name",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "Scooter Location",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "Scooter Mileage",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "Scooter Condition",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Align(
                      child: Text(
                        "Batteri",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      "Status",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.S,
                  ),
                ],
                rows: List<DataRow2>.generate(
                  10,
                  (index) => DataRow2(
                    cells: [
                      DataCell(
                        Text("1"),
                      ),
                      DataCell(
                        Text("ather"),
                      ),
                      DataCell(
                        Text("location"),
                      ),
                      DataCell(
                        Text("250"),
                      ),
                      DataCell(
                        Text("good"),
                      ),
                      DataCell(
                        Text("98"),
                      ),
                      DataCell(
                        Text("Active"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
