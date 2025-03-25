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



# **Setting Up Flutter in GitHub Codespaces & Running a Web App**

This guide walks you through installing Flutter (version 3.29.2) in GitHub Codespaces and running a web app.

## **1. Install Flutter**
```sh
# Remove any existing Flutter installation (if applicable)
sudo rm -rf /opt/flutter  

# Clone the stable branch of Flutter (version 3.29.2)
git clone https://github.com/flutter/flutter.git -b 3.29.2 --depth=1  

# Move Flutter to /opt for global access
sudo mv flutter /opt/  

# Add Flutter to the system PATH
echo 'export PATH="/opt/flutter/bin:$PATH"' >> ~/.bashrc  
source ~/.bashrc  

# Verify Flutter installation
flutter --version  
```

## **2. Install Dependencies**
```sh
# Check required dependencies
flutter doctor  

# Fix common issues (if any)
flutter doctor --fix  

# Enable web support
flutter config --enable-web  

# Ensure the latest stable Flutter version is installed
flutter upgrade  

# Fetch dependencies for the project
flutter pub get  
```

## **3. Run Flutter Web App in Codespaces**
```sh
flutter run -d web-server --web-port=8000  
```

## **4. Forward the Port in Codespaces**
1. Open the **Ports** tab in Codespaces.
2. Click **"Forward a Port"**, enter **8000**, and set visibility to **Public**.

## **5. Open the Web App in Chrome**
Copy the generated Codespaces URL (e.g., `https://your-codespace-id-8000.githubpreview.dev`) and open it in **Chrome**.

---

This ensures a smooth setup and run for Flutter in Codespaces. 🚀  
Let me know if you need any modifications!