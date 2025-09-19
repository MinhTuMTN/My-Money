import 'package:flutter/material.dart';
import 'package:my_money/presentation/features/transaction/view/header.dart';

// 1. TẠO MODEL ĐỂ ĐẢM BẢO TYPE SAFETY
// Thay thế Map bằng một class cụ thể để tránh lỗi gõ sai key và code rõ ràng hơn.
class Category {
  final String categoryName;
  final IconData icon;
  final int value;

  const Category({
    required this.categoryName,
    required this.icon,
    required this.value,
  });
}

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  // 2. DI CHUYỂN DỮ LIỆU TĨNH RA KHỎI HÀM BUILD
  // Dữ liệu này không thay đổi, không cần tạo lại mỗi lần build.
  static const List<Category> _categories = [
    Category(icon: Icons.flight, categoryName: "Du lịch", value: 1),
    Category(
      icon: Icons.emoji_food_beverage,
      categoryName: "Ăn uống",
      value: 2,
    ),
    Category(icon: Icons.local_gas_station, categoryName: "Đi lại", value: 3),
    Category(icon: Icons.shopping_cart, categoryName: "Mua sắm", value: 4),
  ];

  // 3. QUẢN LÝ STATE
  // Sử dụng controller để quản lý và truy cập dữ liệu từ các TextFormField.
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _noteController = TextEditingController();
  Category? _selectedCategory; // Biến lưu category được chọn

  @override
  void dispose() {
    // Luôn dispose các controller khi widget bị hủy để tránh rò rỉ bộ nhớ.
    _amountController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Hàm xử lý logic chọn ngày
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Cập nhật text của controller, giao diện sẽ tự động cập nhật.
      setState(() {
        // Bạn có thể format lại ngày tháng ở đây (ví dụ: dùng package intl)
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  // 4. TÁCH CÁC WIDGET PHỨC TẠP RA THÀNH CÁC HÀM RIÊNG
  // Giúp hàm build chính gọn gàng, dễ đọc hơn.
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.grey.shade100,
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Stack(
            children: [
              Header(
                title: Text(
                  "Add Expense",
                  style: TextStyle(
                    color: colorScheme.onInverseSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height: 250,
              ),
              Positioned(
                top: 125,
                left: 20,
                right: 20,
                child: _buildFormCard(colorScheme), // Gọi hàm xây dựng form
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget chứa toàn bộ form
  Widget _buildFormCard(ColorScheme colorScheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors
            .white, // Nên dùng colorScheme.surfaceVariant để hỗ trợ dark mode
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSectionTitle("CATEGORY"),
            const SizedBox(height: 10),
            _buildCategoryDropdown(),
            const SizedBox(height: 20),

            _buildSectionTitle("AMOUNT"),
            const SizedBox(height: 10),
            _buildAmountField(),
            const SizedBox(height: 20),

            _buildSectionTitle("DATE"),
            const SizedBox(height: 10),
            _buildDateField(),
            const SizedBox(height: 20),

            _buildSectionTitle("NOTE"),
            const SizedBox(height: 10),
            _buildNoteField(),
            const SizedBox(height: 20),

            _buildSaveButton(colorScheme),
          ],
        ),
      ),
    );
  }

  // 5. TÁI SỬ DỤNG STYLE VÀ LOGIC
  // Các hàm nhỏ hơn cho từng phần của form

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<Category>(
      value: _selectedCategory,
      hint: const Text("Select Category"),
      isExpanded: true,
      decoration: _buildInputDecoration(hintText: "Select Category"),
      items: _categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Row(
            children: [
              Icon(category.icon),
              const SizedBox(width: 20),
              Text(category.categoryName),
            ],
          ),
        );
      }).toList(),
      onChanged: (Category? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: _buildInputDecoration(
        hintText: "Amount",
        prefixIcon: Icons.attach_money,
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      readOnly: true, // Không cho người dùng nhập tay
      decoration: _buildInputDecoration(
        hintText: "Date",
        prefixIcon: Icons.calendar_today,
      ),
      onTap: _selectDate, // Gọi hàm xử lý khi nhấn vào
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      decoration: _buildInputDecoration(
        hintText: "Note",
        prefixIcon: Icons.note,
      ),
    );
  }

  Widget _buildSaveButton(ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: colorScheme.surfaceContainer,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          // Xử lý logic lưu dữ liệu
          final amount = _amountController.text;
          final date = _dateController.text;
          final note = _noteController.text;
          final category = _selectedCategory?.categoryName;

          print(
            "Category: $category, Amount: $amount, Date: $date, Note: $note",
          );

          // Thêm validation nếu cần
          if (category != null && amount.isNotEmpty && date.isNotEmpty) {
            // Logic lưu vào database/API
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Expense Saved!")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fill all required fields!")),
            );
          }
        },
        child: Text(
          "Save",
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Hàm helper để tạo InputDecoration, tránh lặp code
  InputDecoration _buildInputDecoration({
    String? hintText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey.shade100, // Màu nền nhẹ
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
