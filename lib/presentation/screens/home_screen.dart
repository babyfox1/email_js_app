import 'package:email_js_app/core/consts/app_consts.dart';
import 'package:email_js_app/data/model/send_email_model.dart';
import 'package:email_js_app/data/repositories/send_email_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerToName = TextEditingController();
  final TextEditingController controllerFromName = TextEditingController();
  final TextEditingController controllerCopy = TextEditingController();
  final TextEditingController controllerMessage = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send email'),
        backgroundColor: const Color.fromARGB(255, 138, 189, 29),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: controllerToName,
              hintText: 'От кого',
              maxLines: 1,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: controllerFromName,
              hintText: 'Кому',
              maxLines: 1,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: controllerCopy,
              hintText: 'Копия',
              maxLines: 1,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: controllerMessage,
              hintText: 'Сообщение',
              maxLines: 6,
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 186, 229, 126),
                ),
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  await SendEmailRepository().sendEmail(
                      model: SendEmailModel(
                    serviceId: AppConsts.serviceId,
                    templateId: AppConsts.templateId,
                    userId: AppConsts.userId,
                    accessToken: AppConsts.accessToken,
                    templateParams: TemplateParams(
                        toName: controllerToName.text,
                        fromName: controllerFromName.text,
                        message: controllerMessage.text,
                        replyTo: controllerCopy.text),
                  ));
                  isLoading = false;
                  setState(() {});
                },
                child: isLoading ? const CircularProgressIndicator.adaptive() : const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
