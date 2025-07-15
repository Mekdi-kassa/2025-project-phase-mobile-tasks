# Command-Line eCommerce Manager

![Dart CLI App](https://img.shields.io/badge/Dart-Command%20Line%20App-blue)

A simple command-line eCommerce application built with Dart, demonstrating core OOP principles.

## ✨ Features

- ➕ Add new products
- 👀 View all products
- 🔍 View product details
- ✏️ Edit product information
- ❌ Delete products
- 🔄 Persistent data storage (optional)

## 🧱 Product Structure

```dart
class Product {
  String name;
  String description; 
  double price;
  // Private quantity field with getter/setter
  int _quantity;
  
  Product(this.name, this.description, this.price, this._quantity);
}
