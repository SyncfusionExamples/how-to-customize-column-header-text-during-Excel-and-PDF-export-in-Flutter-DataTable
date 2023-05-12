// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

// Local import
import '../helper/save_file_mobile_desktop.dart'
    if (dart.library.html) '../helper/save_file_web.dart' as helper;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
CustomDataGridToExcelConverter excelConverter =
    CustomDataGridToExcelConverter();
CustomDataGridToPdfConverter pdfConverter = CustomDataGridToPdfConverter();

Future<void> exportDataGridToExcel() async {
  final Workbook workbook =
      key.currentState!.exportToExcelWorkbook(converter: excelConverter);
  final List<int> bytes = workbook.saveAsStream();

  await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  workbook.dispose();
}

void exportDataGridToPDF() async {
  PdfDocument document = key.currentState!.exportToPdfDocument(
      fitAllColumnsInOnePage: true, converter: pdfConverter);
  final List<int> bytes = document.saveSync();
  await helper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
  document.dispose();
}

class _MyAppState extends State<MyApp> {
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employeeDataSource = EmployeeDataSource(employees: employees);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter DataGrid'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => exportDataGridToPDF(),
                      child: const Text("Export to PDF")),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => exportDataGridToExcel(),
                      child: const Text("Export to Excel")),
                ),
              ],
            ),
            Expanded(
              child: SfDataGrid(
                key: key,
                source: employeeDataSource,
                columns: getColumns,
                columnWidthMode: ColumnWidthMode.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GridColumn> get getColumns {
    return [
      GridColumn(
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Employee ID'))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Employee Name'))),
      GridColumn(
          columnName: 'designation',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Designation'))),
      GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Salary'))),
      GridColumn(
          columnName: 'city',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('City'))),
      GridColumn(
          columnName: 'country',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Country'))),
      GridColumn(
          columnName: 'phone',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Contact'))),
      GridColumn(
          columnName: 'email',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Email ID'))),
    ];
  }

  List<Employee> employees = [
    Employee(10001, 'James', 'Project Lead', 20000, 'Campinas', 'Brazil',
        '7898782331', 'james@gmail.com'),
    Employee(10002, 'Adams', 'Manager', 30000, 'Alberta', 'Canada',
        '7898782332', 'adams@gmail.com'),
    Employee(10003, 'Lara', 'Developer', 15000, 'Svendborg', 'Denmark',
        '7898782333', 'lara@gmail.com'),
    Employee(10004, 'Michael', 'Designer', 15000, 'Lyon', 'France',
        '7898782334', 'michael@gmail.com'),
    Employee(10005, 'Martin', 'Developer', 15000, 'Berlin', 'Germany',
        '7898782335', 'martin@gmail.com'),
    Employee(10006, 'Newberry', 'Developer', 15000, 'Genoa', 'Italy',
        '7898782336', 'newberry@gmail.com'),
    Employee(10007, 'Balnc', 'Developer', 15000, 'Zapopan', 'Mexico',
        '7898782337', 'balnc@gmail.com'),
    Employee(10008, 'Perry', 'Developer', 15000, 'Stavern', 'Norway',
        '7898782338', 'perry@gmail.com'),
    Employee(10009, 'Gable', 'Developer', 15000, 'Helsinki', 'Finland',
        '7898782339', 'gable@gmail.com'),
    Employee(10010, 'Grimes', 'Developer', 15000, 'Graz', 'Austria',
        '7898782340', 'grimes@gmail.com')
  ];
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.city,
      this.country, this.phone, this.email);
  final int id;
  final String name;
  final String designation;
  final int salary;
  final String city;
  final String country;
  final String phone;
  final String email;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
              DataGridCell<String>(columnName: 'city', value: dataGridRow.city),
              DataGridCell<String>(
                  columnName: 'country', value: dataGridRow.country),
              DataGridCell<String>(
                  columnName: 'phone', value: dataGridRow.phone),
              DataGridCell<String>(
                  columnName: 'email', value: dataGridRow.email),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class CustomDataGridToPdfConverter extends DataGridToPdfConverter {
  @override
  void exportColumnHeader(SfDataGrid dataGrid, GridColumn column,
      String columnName, PdfGrid pdfGrid) {
    var label = columnName;

    // Based on the widget tree structure, you can access the value from the GridColumn.label property.
    //For example, if the label property of the GridColumn contains a Container widget,
    //you need to locate the text widget within it and then retrieve the value stored in its data property

    if (column.label is Container) {
      label = ((column.label as Container).child as Text).data!;
    } else if (column.label is Text) {
      label = (column.label as Text).data!;
    } else if (column.label is Center) {
      label = ((column.label as Center).child as Text).data!;
    }
    super.exportColumnHeader(dataGrid, column, label, pdfGrid);
  }
}

class CustomDataGridToExcelConverter extends DataGridToExcelConverter {
  @override
  void exportColumnHeader(SfDataGrid dataGrid, GridColumn column,
      String columnName, Worksheet worksheet) {
    var label = columnName;
    if (column.label is Container) {
      label = ((column.label as Container).child as Text).data!;
    } else if (column.label is Text) {
      label = (column.label as Text).data!;
    } else if (column.label is Center) {
      label = ((column.label as Center).child as Text).data!;
    }
    super.exportColumnHeader(dataGrid, column, label, worksheet);
  }
}
