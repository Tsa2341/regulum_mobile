import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:regulum/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker(
    this.profileImagePath,
    this.setProfileImage, {
    Key? key,
  }) : super(key: key);

  final String? profileImagePath;
  final void Function(String?) setProfileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileImagePath != null
            ? GestureDetector(
                onTap: () {
                  showGeneralDialog(
                    context: context,
                    useRootNavigator: true,
                    pageBuilder: (_, __, ___) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          child: Image.file(
                            File(profileImagePath!),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 85,
                  height: 85,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.file(
                    File(profileImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.green,
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
              ),
        const SizedBox(width: 10),
        FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  "Add a profile picture",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const SizedBox(height: 12),
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    FilePicker.platform.pickFiles(type: FileType.image).then((FilePickerResult? result) {
                      setProfileImage(result!.files.single.path);
                    });
                  },
                  child: Container(
                    width: 155,
                    height: 27,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: RegulumColors.secondaryDark),
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Text(
                              "Click to add an image",
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.download_for_offline_rounded,
                          size: 27,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
