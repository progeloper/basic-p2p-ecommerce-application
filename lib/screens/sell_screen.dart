import 'dart:typed_data';

import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_widget.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  bool isNameFocused = false;
  bool isDescFocused = false;
  bool isCostFocused = false;
  bool isLoading = false;
  int selected = 4;
  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descController.dispose();
    _costController.dispose();
  }

  void selectImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(child: const Text('Select a photo')),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  image = file;
                });
              },
              child: const Text('Take a photo with the camera'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  image = file;
                });
              },
              child: const Text('Select a photo from your gallery'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User? user = Provider.of<UserProvider>(context).getUser;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: amazonOrangeAccent,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              (image == null)
                                  ? Image.network(
                                      'https://cdn.vectorstock.com/i/preview-1x/50/20/no-photo-or-blank-image-icon-loading-images-vector-37375020.jpg',
                                      height: screenSize.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: screenSize.height / 10,
                                    ),
                              IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // const Padding(
                                //   padding: EdgeInsets.all(8),
                                //   child: Text(
                                //     'Item Details',
                                //     style: TextStyle(
                                //         color: Colors.black,
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 25),
                                //   ),
                                // ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Item Name',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (hasFocus) {
                                    if (hasFocus) {
                                      setState(() {
                                        isNameFocused = true;
                                      });
                                    } else {
                                      setState(() {
                                        isNameFocused = false;
                                      });
                                    }
                                  },
                                  child: TextFieldWidget(
                                    controller: _nameController,
                                    hintText: 'Enter the item name',
                                    isFocused: isNameFocused,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (hasFocus) {
                                    if (hasFocus) {
                                      setState(() {
                                        isDescFocused = true;
                                      });
                                    } else {
                                      setState(() {
                                        isDescFocused = false;
                                      });
                                    }
                                  },
                                  child: TextFieldWidget(
                                    controller: _descController,
                                    hintText: 'Enter a brief description',
                                    isFocused: isDescFocused,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Cost',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (hasFocus) {
                                    if (hasFocus) {
                                      setState(() {
                                        isCostFocused = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCostFocused = false;
                                      });
                                    }
                                  },
                                  child: TextFieldWidget(
                                    controller: _costController,
                                    hintText: 'Enter the price',
                                    isFocused: isCostFocused,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Discount',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                RadioListTile(
                                  activeColor: amazonOrangeAccent,
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  title: const Text('None'),
                                  value: 0,
                                  groupValue: selected,
                                  onChanged: (i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  activeColor: amazonOrangeAccent,
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  title: const Text('70%'),
                                  value: 1,
                                  groupValue: selected,
                                  onChanged: (i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  activeColor: amazonOrangeAccent,
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  title: const Text('60%'),
                                  value: 2,
                                  groupValue: selected,
                                  onChanged: (i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  activeColor: amazonOrangeAccent,
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  title: const Text('50%'),
                                  value: 3,
                                  groupValue: selected,
                                  onChanged: (i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          ReusableButton(
                            callback: () async{
                              String res = 'An error occurred';
                              if(_nameController.text.isNotEmpty&&_costController.text.isNotEmpty&&_descController.text.isNotEmpty&&image!=null){
                                setState(() {
                                  isLoading = true;
                                });
                                try{
                                  res = await FirestoreMethods().uploadProduct(productName: _nameController.text, cost: _costController.text, description: _descController.text, productPhoto: image!, sellerId: user!.uid, sellerName: user.name, discount: selected);
                                }catch(e){
                                  res = e.toString();
                                }
                                setState(() {
                                  isLoading = false;
                                });
                                if(res != 'success'){
                                  showSnackbar(context, 'An error occurred');
                                } else{
                                  showSnackbar(context, 'Your product has been posted');
                                  _descController.clear();
                                  _nameController.clear();
                                  _costController.clear();
                                }
                              }
                            },
                            isLoading: isLoading,
                            color: yellowColor,
                            child: const Text(
                              'Sell',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ReusableButton(
                            callback: () {
                              Navigator.pop(context);
                            },
                            isLoading: false,
                            color: Colors.grey[350]!,
                            child: const Text(
                              'Back',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
