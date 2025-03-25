# Flutter App Structure 🏗️

This document explains the **directory structure** of the Flutter app and how different parts work together.

## 📂 Project Directory Structure
```yaml
/lib
 ├── main.dart
 ├── /screens
 │    ├── login_screen.dart
 │    ├── home_screen.dart
 │    ├── add_customer_screen.dart
 │    ├── add_vendor_screen.dart
 │    ├── add_raw_material_screen.dart
 │    ├── view_customers_screen.dart
 │    ├── view_vendors_screen.dart
 │    ├── view_raw_materials_screen.dart
 │
 ├── /services
 │    ├── supabase_auth_service.dart        # Handles authentication (login/logout)
 │    ├── supabase_database_service.dart    # Handles database operations (CRUD)
 │
 ├── /widgets
 │    ├── custom_button.dart       # Reusable button widget
 │    ├── custom_textfield.dart    # Reusable text field widget
 │    ├── vendor_dropdown.dart     # Vendor dropdown selector
 │
 ├── /models
 │    ├── customer_model.dart      # Defines the Customer model
 │    ├── vendor_model.dart        # Defines the Vendor model
 │    ├── raw_material_model.dart  # Defines the Raw Material model

```

## 📌 Explanation of Each Folder

### **1️⃣ `/screens/` – UI Screens**
This folder contains **all the pages (screens)** of the app.

| File | Purpose |
|------|---------|
| `login_screen.dart` | Handles login functionality. |
| `home_screen.dart` | Contains **Tabs & Dropdown** for navigation. |
| `add_customer_screen.dart` | Adds a **new customer**. |
| `add_vendor_screen.dart` | Adds a **new vendor**. |
| `add_raw_material_screen.dart` | Adds **raw materials** with a vendor dropdown. |
| `view_customers_screen.dart` | Displays customers with **Edit & Delete**. |
| `view_vendors_screen.dart` | Displays vendors with **Edit & Delete**. |
| `view_raw_materials_screen.dart` | Displays raw materials with **Edit & Delete**. |

📌 **Why?**
- **Separation of concerns** → Each feature has its own screen.
- **Easy to modify & scale** → You can add more screens without modifying everything.

---

### **2️⃣ `/services/` – Business Logic (API, Database)**
This folder contains **all API and database interactions**.

| File | Purpose |
|------|---------|
| `supabase_auth_service.dart` | Handles **login/logout**. |
| `supabase_database_service.dart` | Handles **CRUD operations** for customers, vendors, and raw materials. |

📌 **Why?**
- **Keeps UI screens clean** → No direct API calls in UI files.
- **Easier to update backend** → If you switch from Supabase to Firebase, you only update `supabase_database_service.dart`.

---

### **3️⃣ `/widgets/` – Reusable UI Components**
Contains **custom UI elements** to avoid **code duplication**.

| File | Purpose |
|------|---------|
| `custom_button.dart` | A **reusable button widget**. |
| `custom_textfield.dart` | A **customized text field** used across forms. |
| `vendor_dropdown.dart` | A dropdown to **select vendors** while adding raw materials. |

📌 **Why?**
- **Reusability** → No need to redefine buttons or text fields in every screen.
- **Easier UI modifications** → Change in one place updates all screens.

---

### **4️⃣ `/models/` – Data Models**
Defines **structured data models**.

| File | Purpose |
|------|---------|
| `customer_model.dart` | Defines the **Customer model** (e.g., name, contact_info). |
| `vendor_model.dart` | Defines the **Vendor model** (e.g., name, email). |
| `raw_material_model.dart` | Defines the **Raw Material model** (e.g., name, type, vendor_id). |

📌 **Why?**
- **Strongly typed objects** → Instead of using `Map<String, dynamic>`, we use `Customer(name, contactInfo)`.
- **Easier debugging & API handling**.

---

## 🎯 Why Use This Structure?
✅ **Scalability** → Easily add new screens, APIs, and widgets.  
✅ **Separation of Concerns** → UI (`/screens/`), Logic (`/services/`), and Data (`/models/`) are **independent**.  
✅ **Reusability** → Shared components in `/widgets/` prevent repetitive code.  
✅ **Maintainability** → **Easier debugging & refactoring**.  

---

## 🚀 Future Enhancements
📌 **State Management** → Introduce **`provider` or `riverpod`** for better state handling.  
📌 **Navigation Improvements** → Use **named routes** instead of `Navigator.push()`.  
📌 **Unit Testing** → Add test cases for **services & models**.  

---

## 🎉 Final Thoughts
This structure is **clean, modular, and future-proof**.  
If you ever need to **add more features**, it will be **super easy to manage**! 🚀🔥  

Would you like any modifications or improvements to this? 😊  
