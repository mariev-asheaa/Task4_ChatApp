import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constant.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

// Function to generate a random string for the message ID
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

// Firestore collection reference
CollectionReference messages = FirebaseFirestore.instance.collection('messages');

class chatpage extends StatefulWidget {
  const chatpage({super.key});
  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  final List<types.Message> _messages = [];
  late types.User _user;

  @override
  void initState() {
    super.initState();
    _listenToMessages();
  }

  // Listening to messages in Firestore
  void _listenToMessages() {
    messages.orderBy('createdAt').snapshots().listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return types.TextMessage(
          author: types.User(id: data['authorId'] as String), // Use 'authorId' from Firestore
          createdAt: (data['createdAt'] as Timestamp).millisecondsSinceEpoch, // Convert Timestamp to int
          id: doc.id,
          text: data['text'] as String,
        );
      }).toList();

      // Reverse the list to display with the newest messages at the bottom
      setState(() {
        _messages.clear();
        _messages.addAll(messages.reversed.toList());
      });
    });
  }



  // Handling message send
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user, // Use the dynamic _user
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    _sendMessageToFirestore(textMessage);
  }

  // Storing message in Firestore
  void _sendMessageToFirestore(types.TextMessage message) {
    messages.doc(message.id).set({
      'authorId': message.author.id,
      'createdAt': Timestamp.now(), // Use the current timestamp
      'text': message.text,
    });
  }


  // Adding message to the list
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  //to add image
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }
  @override
  Widget build(BuildContext context) {
    // Retrieving the email passed via the route arguments
    final email = ModalRoute.of(context)!.settings.arguments as String;

    // Initialize the user using the passed email
    _user = types.User(id: email); // Set email as the unique identifier

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryLightColor,
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          backgroundColor: purp,
          inputBackgroundColor: kPrimaryLightColor,
        ),
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,

        onAttachmentPressed: _handleImageSelection,
      ),
    );
  }
}
