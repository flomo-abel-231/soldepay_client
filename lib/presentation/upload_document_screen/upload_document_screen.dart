import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:soldepay/services/user_service.dart';
import 'package:soldepay/widgets/custom_button.dart';
import '../../core/app_export.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final storage = const FlutterSecureStorage();

  File? _frontId;
  File? _backId;
  File? _passportPic;

  bool _isLoading = false;

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Allow all file types
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        switch (type) {
          case 'front':
            _frontId = File(result.files.single.path!);
            break;
          case 'back':
            _backId = File(result.files.single.path!);
            break;
          case 'passport':
            _passportPic = File(result.files.single.path!);
            break;
        }
      });
    }
  }

  Future<void> _uploadDocument() async {
    if (_frontId == null || _backId == null || _passportPic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select all files.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await storage.read(key: "token");
      UserService userService = UserService();

      var baseUrl = userService.baseUrl;

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/document/upload"), // Your API URL
      );

      request.headers["Authorization"] = "Bearer $token";

      request.files
          .add(await http.MultipartFile.fromPath("frontId", _frontId!.path));
      request.files
          .add(await http.MultipartFile.fromPath("backId", _backId!.path));
      request.files.add(
          await http.MultipartFile.fromPath("passportPic", _passportPic!.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Documents uploaded successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildUploadField({
    required String label,
    required File? file,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64.h,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: appTheme.whiteCustom),
          borderRadius: BorderRadius.circular(32.h),
        ),
        child: Row(
          children: [
            SizedBox(width: 20.h),
            const Icon(Icons.upload_file, color: Colors.white),
            SizedBox(width: 12.h),
            Expanded(
              child: Text(
                file != null ? file.path.split('/').last : label,
                style: TextStyleHelper.instance.title16Poppins,
              ),
            ),
            SizedBox(width: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme.colorFF0908,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgEllipse78),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Upload Your Documents',
                  style: TextStyleHelper.instance.headline26BoldPoppins,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                _buildUploadField(
                  label: 'Select Front ID File',
                  file: _frontId,
                  onTap: () => _pickFile('front'),
                ),
                _buildUploadField(
                  label: 'Select Back ID File',
                  file: _backId,
                  onTap: () => _pickFile('back'),
                ),
                _buildUploadField(
                  label: 'Select Passport Size Photo',
                  file: _passportPic,
                  onTap: () => _pickFile('passport'),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: _isLoading ? 'Uploading...' : 'Submit Documents',
                  buttonType: CustomButtonType.gradient,
                  width: double.infinity,
                  height: 53.h,
                  borderRadius: 26,
                  fontSize: 16.fSize,
                  fontWeight: FontWeight.w500,
                  onPressed: _isLoading ? null : _uploadDocument,
                ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
