import '../exports.dart';

Future<T?> selectOption<T>({
  required List<T> options,
  String Function(dynamic item)? toText,
  final VoidCallback? onRemove,
  String title = "Select option",
}) async {
  final pickedMarketer = await showAppDialog(
    title: title,
    _SelectOption<T>(
      options: options,
      toText: toText ?? (item) => item.toString(),
      onRemove: onRemove,
      title: title,
    ),
  );
  return pickedMarketer;
}

class _SelectOption<K> extends StatefulWidget {
  final List<K> options;
  final String Function(dynamic item) toText;
  final VoidCallback? onRemove;
  final String title;
  _SelectOption({
    required this.options,
    required this.toText,
    this.onRemove,
    required this.title,
  });

  @override
  State<_SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<_SelectOption> {
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List options = widget.options;

    if (_search.text.isNotEmpty) {
      options = widget.options.where((e) {
        final text = widget.toText(e).toLowerCase();
        return text.contains(_search.text.toLowerCase());
      }).toList();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        width: 300.0,
        height: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            TextFormField(
              controller: _search,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search",
                suffixIcon: InkWell(
                    onTap: () {
                      _search.text = "";
                      if (mounted) setState(() {});
                    },
                    child: Icon(Icons.close)),
              ),
              onChanged: (value) {
                if (mounted) setState(() {});
              },
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  "Total Count\t - \t${options.length}",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((e) {
                    final text = widget.toText(e);
                    return InkWell(
                      onTap: () {
                        Get.back(result: e);
                      },
                      child: Card(
                        color: Colors.grey[200],
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                          child: Text(text),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
