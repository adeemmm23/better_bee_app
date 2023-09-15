import 'package:better_buzz/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  String? selectedHelp;
  List<String> historyList = [];
  List<String> helpList = [
    'How do I set up the monitoring device for my beehive?',
    'How do I connect the monitoring device to the app?',
    'What data does the monitoring device provide about my beehive?',
    'The mirror refreshes too often',
    'How often does the app update with new hive data?',
    'What should I do if the hive temperature seems too high?',
    'How can I interpret changes in hive noise levels?',
    'Hello world',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      drawer: const CustomDrawer(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
              child: Text('Popular Questions',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('Can I receive notifications for specific hive events'),
              onTap: () {
                context.push('/support/article?articleName=Can I receive notifications for specific hive events&articleContent=No article content yet');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('How do I troubleshoot connectivity issues between the device and app'),
              onTap: () {
                context.push('/support/article?articleName=How do I troubleshoot connectivity issues between the device and app&articleContent=No article content yet');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('How can I track long-term trends in hive data'),
              onTap: () {
                context.push('/support/article?articleName=How can I track long-term trends in hive data&articleContent=No article content yet');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SearchAnchor.bar(
                barBackgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                barElevation: MaterialStateProperty.all(0),
                barHintText: 'Search Help',
                suggestionsBuilder: (context, controller) {
                  if (controller.text.isEmpty) {
                    if (historyList.isNotEmpty) {
                      return getHistoryList(controller);
                    } else {
                      return <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text('No search history.',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                          ),
                        )
                      ];
                    }
                  }
                  return getSuggestions(controller);
                },
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text('Need more help?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Icons.support,
                    size: 22,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Contact us'),
                  subtitle:
                      const Text('Tell us more, and we\'ll help you get there'),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Icons.feedback_rounded,
                    size: 22,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Send Feedback'),
                  subtitle:
                      const Text('Your feedback helps us improve the app'),
                  onTap: ()  {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Iterable<Widget> getHistoryList(SearchController controller) {
    return historyList.map((e) {
      return ListTile(
        leading: const Icon(Icons.history),
        title: Text(e),
        onTap: () {
          controller.closeView(e);
          controller.text = e;
          handleSelection(e);
          context.push('/support/article?articleName=$e&articleContent=No article content yet');
          controller.clear();
        },
      );
    });
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return helpList.where((element) {
      return element.toLowerCase().contains(input.toLowerCase());
    }).map((e) {
      return ListTile(
        leading: const Icon(Icons.chat_bubble_outline_rounded),
        title: Text(e),
        onTap: () {
          controller.closeView(e);
          controller.text = e;
          handleSelection(e);
          context.push('/support/article?articleName=$e&articleContent=No article content yet');
          controller.clear();
        },
      );
    });
  }

  void handleSelection(String? value) {
    setState(() {
      selectedHelp = value;
      if (historyList.length >= 5) {
        historyList.removeLast();
      }
      if (historyList.contains(value)) {
        historyList.remove(value);
      }
      historyList.insert(0, value!);
    });
  }
}
