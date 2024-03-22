import 'package:intl/intl.dart';
import 'package:todo_list/app/exports.dart';

class AddTask extends StatefulWidget {
  final TaskModel? task;
  const AddTask({super.key, this.task});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _taskName = TextEditingController();
  final _taskDescription = TextEditingController();
  DateTime? _date;

  void _handleAddTask() async {
    try {
      if (widget.task == null) {
        await FirebaseFirestore.instance.collection('tasks').add({
          'name': _taskName.text,
          'description': _taskDescription.text,
          'date': _date!.toIso8601String(),
          'completed': false,
          'admin': Get.find<UserService>().user.value!.id,
          'client': '',
        });
      } else {
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(widget.task!.id)
            .update({
          'name': _taskName.text,
          'description': _taskDescription.text,
          'date': _date!.toIso8601String(),
          'completed': false,
          'admin': widget.task!.admin,
          'client': widget.task!.client,
        });
      }
      Get.back();
    } catch (e) {
      print('error on add task $e');
    }
  }

  @override
  void initState() {
    if (widget.task != null) {
      _taskName.text = widget.task!.name;
      _taskDescription.text = widget.task!.description;
      _date = DateTime.parse(widget.task!.date);
      if (mounted) {
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _taskName,
                    validator: ValidationBuilder().required().build(),
                    autovalidateMode: AutovalidateMode.always,
                    decoration:
                        CommonStyle.inputDecoration(labelText: 'Task title'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final currentDate = DateTime.now();
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: currentDate
                            .subtract(const Duration(days: 365 * 100)),
                        lastDate: currentDate.add(
                          const Duration(days: 356 * 100),
                        ),
                      );
                      if (selectedDate == null) return;

                      _date = selectedDate;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        validator: ValidationBuilder().required().build(),
                        autovalidateMode: AutovalidateMode.always,
                        controller: TextEditingController(
                            text: _date == null
                                ? ''
                                : DateFormat.yMEd().format(_date!)),
                        decoration: CommonStyle.inputDecoration(
                            labelText: 'Select date'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _taskDescription,
              validator: ValidationBuilder().required().build(),
              autovalidateMode: AutovalidateMode.always,
              decoration:
                  CommonStyle.inputDecoration(labelText: 'Task description'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _handleAddTask();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
