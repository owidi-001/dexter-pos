import 'dart:convert';
import 'dart:io';

import 'package:dexter/models/products_model.dart';
import 'package:dexter/providers/product_provider.dart';
import 'package:dexter/screens/home/components/product_filter.dart';
import 'package:dexter/theme/theme.dart';
import 'package:dexter/widgets/appButtonWidget.dart';
import 'package:dexter/widgets/form_field_decorator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  // All products
  List<Product> _products = categoryFilter("all");

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshMenu() async {
    List<Product> data = categoryFilter("all");

    setState(() {
      _products = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshMenu(); // loads products when app starts
  }

  // Form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minQuantityController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  // It will also be triggered when you want to update an item or create on
  void _showForm(int? id) async {
    // id == null -> create new item
    // id != null -> update an existing item
    if (id != null) {
      final existingProducts =
          _products.firstWhere((element) => element.id == id);

      _nameController.text = existingProducts.name;
      _priceController.text = "${existingProducts.price}";
      _quantityController.text = "${existingProducts.quantity}";
      _minQuantityController.text = "${existingProducts.minQuantity}";
    } else {
      // Clear the text fields
      _nameController.text = '';
      _priceController.text = '';
      _quantityController.text = '';
      _minQuantityController.text = '';
    }

    // show modalsheet
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: buildInputDecoration("Name", Icons.edit),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nameController,
              decoration: buildInputDecoration("Price", Icons.money),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nameController,
              decoration: buildInputDecoration("Quantity", Icons.numbers),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nameController,
              decoration:
                  buildInputDecoration("minQuantity", Icons.numbers_rounded),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Image from",
                          style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () async {
                          // Pick an image
                          image = await _picker.pickImage(
                              source: ImageSource.camera,
                              // Compress image upload
                              maxHeight: 1024,
                              maxWidth: 1024,
                              imageQuality: 50);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.photo,
                          color: AppTheme.primary,
                        ),
                        label: const Text(
                          "Camera",
                          style: TextStyle(color: AppTheme.primary),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.photo,
                          color: AppTheme.primary,
                        ),
                        label: const Text(
                          "Gallery",
                          style: TextStyle(color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppTheme.primary,
              child: MaterialButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addProduct();
                  } else {
                    await _updateMenu(id);
                  }

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: double.infinity,
                child: Text(
                  id == null ? 'Create New' : 'Update',
                  style: const TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            id == null
                ? Container()
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      AppButtonWidget(
                          title: "Delete", onPressedCallBack: () {}),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Insert a new product to the database
  Future<void> _addProduct() async {
    if (image != null) {
      // convert image to base64
      String imageData = "";

      File imagefile = File(image!.path); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      imageData = base64.encode(imagebytes); //convert bytes to base64 string

      if (kDebugMode) {
        print("The picked image is");
        print(imageData);
      }

      // Create function
      // await SQLHelper.createItem(
      //     _nameController.text, imageData, _descriptionController.text);

      _refreshMenu();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product added successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No image selected!'),
      ));
    }
  }

  // Update an existing journal
  Future<void> _updateMenu(int id) async {
    // Update function
    // await SQLHelper.updateItem(
    //     id, _nameController.text, _descriptionController.text);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Product Updated successfully!'),
    ));
    _refreshMenu();
  }

  // Delete an item
  void _deleteItem(int id) async {
    // Delete function
    // await SQLHelper.deleteItem(id);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a menu!'),
    ));
    _refreshMenu();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    _products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: (() {
                _showForm(null);
              }),
              child: const CircleAvatar(
                  backgroundColor: AppTheme.gradient,
                  child: Icon(
                    CupertinoIcons.add_circled_solid,
                    color: AppTheme.primary,
                  ))),
          const SizedBox(
            width: 18,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _products.isNotEmpty
            ? MasonryView(
                listOfItem: _products,
                numberOfColumn: 2,
                itemBuilder: (item) {
                  // Create food instance from the item indexed
                  // Product product = Product.fromJson(item);

                  return Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.gradient,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        _showForm(item.id);
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            // child: item.image.toString().isNotEmpty
                            //     ? Image.memory(
                            //         const Base64Decoder().convert(item.image),
                            //       )
                            //     : Container(
                            //         decoration: BoxDecoration(
                            //             color: AppTheme.primary,
                            //             borderRadius:
                            //                 BorderRadius.circular(12)),
                            //       ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(item.image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text("You don't have any item saved"),
                    TextButton(
                        onPressed: (() => _showForm(null)),
                        child: const Text(
                          "Add product",
                          style: TextStyle(color: AppTheme.primary),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
