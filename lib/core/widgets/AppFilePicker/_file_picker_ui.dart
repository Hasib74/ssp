part of 'app_file_picker.dart';

class _FilePickerUI extends StatefulWidget {
  String? label;
  FileType? fileType;
  double? height;

  _FilePickerUI({super.key, this.label, this.fileType, this.height});

  @override
  State<_FilePickerUI> createState() => _FilePickerUIState();
}

class _FilePickerUIState extends State<_FilePickerUI> {
  File? file;

  BuildContext? con;

  @override
  Widget build(BuildContext context) {
    con = context;
    return Material(
      child: InkWell(
        onTap: () async {
          switch (widget.fileType) {
            case FileType.image:
              File? file = await showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePickerDialog().showDialog(context);
                  });

              if (file != null) {
                setState(() {
                  this.file = file;
                });
              }

              break;
            case FileType.video:
              break;
            case FileType.file:
              break;
            case null:
              break;
          }
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: widget.height ?? 100,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
              ),
            ),
            Positioned(
              left: 50,
              top: 12,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                color: Colors.white,
                child: Text(
                  widget.label ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            Positioned.fill(
              child: file == null
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.file_present_sharp),
                        Text(
                          "${_pickFileType()}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ))
                  : _makeOutputUiBaseOnFileType(),
            ),
          ],
        ),
      ),
    );
  }

  String? _pickFileType() {
    switch (widget.fileType) {
      case FileType.image:
        return "Pick Image";
      case FileType.video:
        return "Pick Video";
      case FileType.file:
        return "Pick File";
      case null:
        return "File";
    }
  }

  _makeOutputUiBaseOnFileType() {
    String? mimeType = lookupMimeType(file!.path);
    print(mimeType);
    if (mimeType!.contains("image")) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13, left: 16),
              child: Image.file(
                file!,
                fit: BoxFit.cover,
                width: 130,
                //  height: 50,
              ),
            ),
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.file_present_sharp),
            Text(
              basename(file!.path),
              style: Theme.of(con!).textTheme.bodyMedium,
            )
          ],
        ),
      );
    }
  }
}
