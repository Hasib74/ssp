import 'dart:async';

class ImagePickerController {
  StreamController<String> _imagePickerStreamController =
      StreamController.broadcast();

  Stream get imagePickerStream => _imagePickerStreamController.stream;

  void dispose() {
    _imagePickerStreamController.close();
  }

  //removeImage
  void removeImage() {
    _imagePickerStreamController.sink.add("remove");
  }
}
