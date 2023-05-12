# How to customize column header text during Excel and PDF export in Flutter DataTable (SfDataGrid)

This article explains how to customize the column header when exporting a DataGrid to an Excel or PDF document.

## STEP 1:
The DataGridToPdfConverter and DataGridToExcelConverter classes provide the functionality to customize the column header while exporting a DataGrid to an Excel or PDF document. This can be achieved by using the exportColumnHeader method according to your requirements. To modify the column name, you can access the actual column header text from the GridColumn.label property and assign it to the corresponding column header while exporting.

```dart
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

```

## STEP 2:
The exportDataGridToExcel and exportDataGridToPDF methods are used to export [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) to Excel and PDF formats, respectively.

```dart
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

```