import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

// WebSocketChannel _channel = WebSocketChannel.connect(
//   Uri.parse('ws://3bc4-92-172-80-189.ngrok.io'),
// );

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  var channel =
      IOWebSocketChannel.connect(Uri.parse('ws://8a18-92-172-80-189.ngrok.io'));
  //var list = [];
  List<String> myList = [];
  final _productosController = new BehaviorSubject<List<String>>();
  final _controllerste = StreamController<List<String>>.broadcast();

  Stream<List<String>> get productosStream => _productosController.stream;
  List<Map<String, String>> _chatMessages = [];
  get controllerOut => _controllerste.stream.asBroadcastStream();
  get controllerIn => _controllerste.sink;
  final notes = <String>[];
  addNewNote(String note) {
    notes.add(note);
    controllerIn.add(notes);
  }

  bool _running = true;
  void cargarProductos(List<String> producto) async {
    // final productos = await _productosProvider.cargarPetsMiApi(producto);
    _productosController.sink.add(producto);
  }

  // Future<String> getData() async {
  //   await Future.delayed(Duration(seconds: 5)); // Retraso simulado
  //   channel.stream.listen((event) {
  //     //_chatMessages.add({"user_name": "Trump", "message": event});
  //     return event;
  //   }, onDone: () {
  //     print("Task Done1");
  //     //channel.sink.close();
  //   }, onError: (error) {
  //     print("Some Error1");
  //   });
  //   // return "This a test data";
  // }

  Stream<List<Map<String, String>>> _chat() async* {
    var mns;
    await Future<void>.delayed(Duration(seconds: 3));
    // StreamBuilder(
    //   stream: channel.stream,
    //   builder: (context, snapshot) {
    //     mns = snapshot.hasData ? '${snapshot.data}' : '';
    //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
    //   },
    // );
    // Stream<String> stream = new Stream.fromFuture(getData());
    // print("Created the stream");
    channel.stream.asBroadcastStream();
    channel.stream.listen((data) {
      _chatMessages.add({"user_name": "Trump", "message": data});
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
    //  _chatMessages.add({"user_name": "Trump", "message": channel.stream});
    yield _chatMessages;

    // await Future<void>.delayed(Duration(seconds: 3));
    // _chatMessages.add({"user_name": "Biden", "message": "Hi baby"});
    // yield _chatMessages;

    // await Future<void>.delayed(Duration(seconds: 3));
    // _chatMessages.add({
    //   "user_name": "Trump",
    //   "message": "Would you like to have dinner with me?"
    // });
    // yield _chatMessages;

    // await Future<void>.delayed(Duration(seconds: 3));
    // _chatMessages.add({
    //   "user_name": "Biden",
    //   "message": "Great. I am very happy to accompany you."
    // });
    // yield _chatMessages;

    // await Future<void>.delayed(Duration(seconds: 3));
    // _chatMessages
    //     .add({"user_name": "Trump", "message": "Nice. I love you, my honney!"});
    // yield _chatMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
      appBar: AppBar(
        title: Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Stack(
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: StreamBuilder(
                stream: _chat(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, String>>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final chatItem = snapshot.data[index];
                        return ListTile(
                          leading: Text(
                            chatItem["user_name"] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          title: Text(
                            chatItem["message"] ?? '',
                            style: TextStyle(
                                fontSize: 20,
                                color: chatItem['user_name'] == 'Trump'
                                    ? Colors.pink
                                    : Colors.blue),
                          ),
                        );
                      },
                    );
                  }
                  return LinearProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // _channel = WebSocketChannel.connect(
      //   Uri.parse('wss://3bc4-92-172-80-189.ngrok.io'),
      // );
      //setState(() {
      // list.add(_controller.text);
      // });

      channel.sink.add(_controller.text);
      // channel.sink.close();
      // _channel.sink.add(_controller.text);
      //_channel.sink.close(status.goingAway);
      //channel.sink.close(status.goingAway);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
