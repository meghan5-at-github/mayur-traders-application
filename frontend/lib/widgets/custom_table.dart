/*
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomTable<T> extends StatefulWidget {
  final List<DataColumn> columns;
  final List<T> rows;
  final bool hasSearch;
  final List<CustomAction<T>>? actions;
  final bool Function(T, String)? filterFunction;
  final List<DataCell> Function(T) dataCellBuilder;
  final bool searchOnRight; // Add this parameter to choose search field position

  const CustomTable({
    Key? key,
    required this.columns,
    required this.rows,
    required this.dataCellBuilder,
    this.filterFunction,
    this.hasSearch = false,
    this.actions,
    this.searchOnRight = false, // Default to left side
  }) : super(key: key);

  @override
  _CustomTableState<T> createState() => _CustomTableState<T>();
}

class _CustomTableState<T> extends State<CustomTable<T>> {
  List<T> displayedRows = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedRows = widget.rows;
    // searchController.addListener(_filterRows);
  }

  void _filterRows(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedRows = widget.rows;
      });
    } else {
      setState(() {
        displayedRows = widget.rows.where((row) {
          return widget.filterFunction != null
              ? widget.filterFunction!(row, query)
              : true;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hasSearch)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: widget.searchOnRight
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: widget.searchOnRight ? null : 300, // Adjust width as needed
                  child: CustomTextField(
                    label: 'Search',
                    controller: searchController,
                    icon: Icons.search,
                    isRequired: false,
                    onChanged: (query) {
                      _filterRows(query);
                    },
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1), // Border for the table
                ),
                child: DataTable(
                  columns: [
                    ...widget.columns,
                    if (widget.actions != null)
                      const DataColumn(label: Text('Actions')),
                  ],
                  rows: displayedRows.map((row) {
                    final dataCells = widget.dataCellBuilder(row);
                    return DataRow(cells: [
                      ...dataCells,
                      if (widget.actions != null)
                        DataCell(Row(
                          children: widget.actions!.map((action) {
                            return IconButton(
                              icon: Icon(action.icon),
                              onPressed: () => action.onPressed(context, row),
                            );
                          }).toList(),
                        )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAction<T> {
  final IconData icon;
  final void Function(BuildContext context, T row) onPressed;

  CustomAction({
    required this.icon,
    required this.onPressed,
  });
}
*/



import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomTable<T> extends StatefulWidget {
  final List<DataColumn> columns;
  final List<T> rows;
  final bool hasSearch;
  final List<CustomAction<T>>? actions;
  final bool Function(T, String)? filterFunction;
  final List<DataCell> Function(T) dataCellBuilder;
  final bool searchOnRight; // Add this parameter to choose search field position

  const CustomTable({
    Key? key,
    required this.columns,
    required this.rows,
    required this.dataCellBuilder,
    this.filterFunction,
    this.hasSearch = false,
    this.actions,
    this.searchOnRight = false, // Default to left side
  }) : super(key: key);

  @override
  _CustomTableState<T> createState() => _CustomTableState<T>();
}

class _CustomTableState<T> extends State<CustomTable<T>> {
  List<T> displayedRows = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedRows = widget.rows;
    // searchController.addListener(_filterRows);
  }

  void _filterRows(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedRows = widget.rows;
      });
    } else {
      setState(() {
        displayedRows = widget.rows.where((row) {
          return widget.filterFunction != null
              ? widget.filterFunction!(row, query)
              : true;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [
      ...widget.columns.map((column) => DataColumn(
        label: Text(
          (column.label as Text).data ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12, // Adjust font size as needed
          ),
        ),
      )),
      if (widget.actions != null)
        const DataColumn(
          label: Text(
            'Actions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
    ];

    return Column(
      children: [
        if (widget.hasSearch)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: widget.searchOnRight
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: widget.searchOnRight ? null : 300, // Adjust width as needed
                  child: CustomTextField(
                    label: 'Search',
                    controller: searchController,
                    icon: Icons.search,
                    isRequired: false,
                    onChanged: (query) {
                      _filterRows(query);
                    },
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey,
                  width: 1,
                  borderRadius: BorderRadius.zero, // No rounded corners
                ),
                columnWidths: {
                  for (var i = 0; i < columns.length; i++)
                    i: FixedColumnWidth(150), // Adjust width as needed
                },
                children: [
                  TableRow(
                    children: columns.map((column) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1), // Vertical border
                          ),
                        ),
                        child: column.label,
                      );
                    }).toList(),
                  ),
                  ...displayedRows.map((row) {
                    final dataCells = widget.dataCellBuilder(row);
                    return TableRow(
                      children: [
                        ...dataCells.map((cell) => Container(
                          padding: const EdgeInsets.all(8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 150), // Adjust max width as needed
                            child: Text(
                              (cell.child as Text).data ?? '',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12), // Adjust font size as needed
                            ),
                          ),
                        )),
                        if (widget.actions != null)
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: widget.actions!.map((action) {
                                return IconButton(
                                  icon: Icon(action.icon, size: 16), // Adjust icon size as needed
                                  onPressed: () => action.onPressed(context, row),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAction<T> {
  final IconData icon;
  final void Function(BuildContext context, T row) onPressed;

  CustomAction({
    required this.icon,
    required this.onPressed,
  });
}
