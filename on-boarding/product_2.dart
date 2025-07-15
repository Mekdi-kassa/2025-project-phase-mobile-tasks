import 'dart:io';

class Product {
  String name;
  String description;
  double price;
  int quantity;

  Product(this.name, this.description, this.price, this.quantity);
}

class ProductManager {
  final List<Product> products = [];

  void addProduct() {
    print("\nAdding a new product");
    print("---------------------");

    String name = _getInput("Enter product name: ");
    String description = _getInput("Enter product description: ");
    double price = _getDoubleInput("Enter product price: ");
    int quantity = _getIntInput("Enter product quantity: ");

    products.add(Product(name, description, price, quantity));
    print("\nProduct added successfully!\n");
  }

  void viewAllProducts() {
    if (products.isEmpty) {
      print("\nNo products available.\n");
      return;
    }

    print("\nAll Products");
    print("------------");
    for (int i = 0; i < products.length; i++) {
      print("${i + 1}. ${products[i].name}");
    }
    print("");
  }

  void viewProductDetails() {
    viewAllProducts();
    if (products.isEmpty) return;

    int? index = _getIndexInput("Enter product number to view details: ");
    if (index == null) return;

    Product product = products[index];
    print("\nProduct Details");
    print("--------------");
    print("Name: ${product.name}");
    print("Description: ${product.description}");
    print("Price: \$${product.price}");
    print("Quantity: ${product.quantity}\n");
  }

  void editProduct() {
    viewAllProducts();
    if (products.isEmpty) return;

    int? index = _getIndexInput("Enter product number to edit: ");
    if (index == null) return;

    Product product = products[index];
    print("\nEditing Product: ${product.name}");
    print("--------------------------------");

    String name = _getInput(
      "Enter new name (leave blank to keep current): ",
      currentValue: product.name,
    );
    String description = _getInput(
      "Enter new description (leave blank to keep current): ",
      currentValue: product.description,
    );
    double price = _getDoubleInput(
      "Enter new price (leave blank to keep current): ",
      currentValue: product.price,
    );
    int quantity = _getIntInput(
      "Enter new quantity (leave blank to keep current): ",
      currentValue: product.quantity,
    );

    products[index] = Product(
      name.isEmpty ? product.name : name,
      description.isEmpty ? product.description : description,
      price,
      quantity,
    );

    print("\nProduct updated successfully!\n");
  }

  void deleteProduct() {
    viewAllProducts();
    if (products.isEmpty) return;

    int? index = _getIndexInput("Enter product number to delete: ");
    if (index == null) return;

    String name = products[index].name;
    print("\nAre you sure you want to delete '$name'? (y/n)");
    String confirmation = stdin.readLineSync()?.toLowerCase() ?? 'n';

    if (confirmation == 'y') {
      products.removeAt(index);
      print("\nProduct deleted successfully!\n");
    } else {
      print("\nDeletion cancelled.\n");
    }
  }

  // Helper methods for input handling
  String _getInput(String prompt, {String currentValue = ""}) {
    stdout.write(prompt);
    String input = stdin.readLineSync()?.trim() ?? "";
    return input.isEmpty ? currentValue : input;
  }

  double _getDoubleInput(String prompt, {double currentValue = 0}) {
    while (true) {
      stdout.write(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";
      if (input.isEmpty) return currentValue;
      try {
        return double.parse(input);
      } catch (e) {
        print("Invalid input. Please enter a valid number.");
      }
    }
  }

  int _getIntInput(String prompt, {int currentValue = 0}) {
    while (true) {
      stdout.write(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";
      if (input.isEmpty) return currentValue;
      try {
        return int.parse(input);
      } catch (e) {
        print("Invalid input. Please enter a whole number.");
      }
    }
  }

  int? _getIndexInput(String prompt) {
    while (true) {
      stdout.write(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";
      if (input.isEmpty) return null;
      try {
        int index = int.parse(input) - 1;
        if (index >= 0 && index < products.length) {
          return index;
        }
        print("Invalid product number. Please try again.");
      } catch (e) {
        print("Invalid input. Please enter a valid number.");
      }
    }
  }
}

void main() {
  ProductManager manager = ProductManager();
  bool running = true;

  while (running) {
    print('''
Product Management System
========================
1. Add Product
2. View All Products
3. View Product Details
4. Edit Product
5. Delete Product
6. Exit
''');
    stdout.write('Enter your choice (1-6): ');
    String? choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        manager.addProduct();
        break;
      case '2':
        manager.viewAllProducts();
        break;
      case '3':
        manager.viewProductDetails();
        break;
      case '4':
        manager.editProduct();
        break;
      case '5':
        manager.deleteProduct();
        break;
      case '6':
        running = false;
        print('\nExiting program. Goodbye!\n');
        break;
      default:
        print('\nInvalid choice. Please enter a number between 1-6.\n');
    }
  }
}
