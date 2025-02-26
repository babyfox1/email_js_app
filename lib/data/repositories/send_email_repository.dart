import 'package:dio/dio.dart';
import 'package:email_js_app/core/network/dio_settings.dart';
import 'package:email_js_app/data/model/send_email_model.dart';

class SendEmailRepository {
  final Dio dio = DioSettings().dio;

  Future<void> sendEmail({required SendEmailModel model}) async {
    try {
      await dio.post(
        "https://api.emailjs.com/api/v1.0/email/send",
        data: model.toJson(),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
