import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/exports.dart';

class TodoListScreen extends StatefulWidget {
  static const routeName = '/todo-list';
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  UserModel? _user;
  bool _isLoading = false;
  List<UserModel> _usersList = [];

  void _getAndSetUser() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }
    _user = await Get.find<UserService>().getUserByid();
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
    print('USER: $_user');
    if (mounted) {
      setState(() {});
    }
  }

  void _getAndSetUsers() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    _usersList = await Get.find<UserService>().getUsersList();

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _getAndSetUser();
    _getAndSetUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          _user?.userName ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.find<UserService>().signOut();
                Get.toNamed(SignInScreen.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('tasks').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final result = snapshot.data!.docs
                      .where(
                        (element) => (element['admin'] == _user!.id ||
                            element['client'] == _user!.id),
                      )
                      .map(
                        (task) => TaskModel.formMap({
                          ...task.data() as Map<String, dynamic>,
                          'id': task.id,
                        }),
                      )
                      .toList();
                  return ListView(
                    children: result.mapIndexed((index, document) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          // direction: DismissDirection.startToEnd,
                          key: Key(document.id),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            color: Colors.green,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              await FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(document.id)
                                  .delete();
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              showAppDialog(
                                title: 'Add Task',
                                AddTask(
                                  task: document,
                                ),
                              );
                              return false;
                            }
                            return null;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  onChanged: (value) {},
                                  value: false,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('EEE, MMM d, y - HH:mm')
                                          .format(
                                              DateTime.parse(document.date)),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${document.name.capitalize}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${document.description.capitalize}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    final pickedOption =
                                        await selectOption<UserModel>(
                                      options: _usersList
                                          .where((element) =>
                                              element.id != _user!.id)
                                          .toList(),
                                      toText: (item) {
                                        return (item as UserModel).email;
                                      },
                                    );

                                    if (pickedOption == null) return;

                                    // print('TASK ID ${document.id}');

                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(document.id)
                                        .update({
                                      'client': pickedOption.id,
                                    });

                                    
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAppDialog(
            title: 'Add Task',
            const AddTask(),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
