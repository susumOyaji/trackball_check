import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyInvoke());
}

class MyInvoke extends StatelessWidget {
  const MyInvoke({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: HomeworkPane(name: 'Homework'),
        ),
      ),
    );
  }
}

class NewHomeworkIntent extends Intent {
  const NewHomeworkIntent({required this.name});

  final String name;
}

class HomeworkPane extends StatefulWidget {
  const HomeworkPane({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _HomeworkPaneState createState() => _HomeworkPaneState();
}

class _HomeworkPaneState extends State<HomeworkPane> {
  final List<String> _homework = <String>[];

  void _createNewHomework(String name) {
    print('Creating new homework $name');
    setState(() {
      _homework.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
            NewHomeworkIntent(name: '${widget.name} ${_homework.length + 1}'),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          NewHomeworkIntent: CallbackAction<NewHomeworkIntent>(
              onInvoke: (NewHomeworkIntent intent) =>
                  _createNewHomework(intent.name)),
        },
        child: Focus(
          autofocus: true,
          child: Column(
            children: <Widget>[
              const Text('List of Homework'),
              ..._homework.map<Widget>((String name) => Text(name)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
