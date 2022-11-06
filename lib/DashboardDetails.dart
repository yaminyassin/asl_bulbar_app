import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class DashboardDetails extends StatefulWidget {
  const DashboardDetails({super.key});

  @override
  State<DashboardDetails> createState() => _DashboardDetailsState();
}

class _DashboardDetailsState extends State<DashboardDetails> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8765'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("titlee caralho"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.settings_ethernet_sharp),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print("ENVIAR MENSAGEM");
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    print('disposed ws connection');
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override

}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
