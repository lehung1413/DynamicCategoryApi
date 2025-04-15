# 🧪 Dynamic Category Management (DCM)

## 📋 Table of Contents
- [Overview](#overview)
- [Setup Instructions](#setup-instructions)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#database-setup)
  - [Run Backend API](#run-backend-api)
  - [Run Frontend](#run-frontend)
- [Access the Application](#access-the-application)
- [Repositories](#repositories)

---

## 📖 Overview
Dynamic Category Management (DCM) is a system designed to manage dynamic categories for grouping online learning sessions. Users can create, edit, and delete categories with flexible filter conditions such as tags, location, and time range. The system also allows users to preview sessions that match the defined filters.

---

## ⚙️ Setup Instructions

### Prerequisites
Before running the project, ensure you have the following installed:
- **Node.js** (v16 or later) and NPM
- **.NET 6 SDK** or later
- **SQL Server** (local or cloud instance)
- **Visual Studio Code** or any IDE for .NET and Vue.js

---

## 📦 Repositories

### Backend API
- **Name**: DynamicCategoryApi
- **GitHub**: [DynamicCategoryApi](https://github.com/lehung1413/DynamicCategoryApi)

### Frontend
- **Name**: dcm-client
- **GitHub**: [dcm-client](https://github.com/lehung1413/DCM.Client)

---

### 📂 Database Setup

1. **Get the SQL Migration Script**:
   Locate the `MigrateDatabase.sql` file in the root folder of the `DynamicCategoryApi` project.

2. **Connect to SQL Server**:
   Use SQL Server Management Studio (SSMS) or any SQL client to connect to your local SQL Server instance:
   - **Server Name**: `(localdb)\MSSQLLocalDB`
   - **Authentication**: Windows Authentication

3. **Execute the SQL Script**:
   Run the SQL script from step 1 to create the `DCM` database and initialize the required tables.

---

### 🔧 Run Backend API

1. **Set the Startup Project**:
   Open the `DynamicCategoryApi` solution and set the `DCM.Api` project as the startup project.

2. **Verify the Connection String**:
   Open the `appsettings.json` file in the `DCM.Api` project and ensure the connection string points to your `DCM` database:
   ```json
   "ConnectionStrings": {
       "DefaultConnection": "Server=(localdb)\\MSSQLLocalDB;Database=DCM;Integrated Security=True;"
   }
   ```

3. **Run the API**:
   Start the `DCM.Api` project. The API documentation (Swagger) should be available at:
   ```
   https://localhost:7269/swagger/index.html
   ```

---

### 🖼️ Run Frontend

1. **Clone and Navigate to the Frontend Project**:
   Clone the `dcm-client` repository and navigate to its folder:
   ```bash
   git clone https://github.com/lehung1413/DCM.Client.git
   cd DCM.Client
   ```

2. **Install Dependencies**:
   Use NPM to install the required packages:
   ```bash
   npm install
   ```

3. **Configure API Base URL**:
   Open the `src/services/api.js` file and update the `baseURL` variable to point to the backend API:
   ```javascript
   const baseURL = "https://localhost:7269/api";
   ```

4. **Run the Frontend**:
   Start the Vue development server:
   ```bash
   npm run dev
   ```

---

## 🌐 Access the Application

Once both the backend and frontend are running, you can access the application at:
- **Frontend**: [http://localhost:3000/categories](http://localhost:3000/categories)
- **Backend API Documentation**: [https://localhost:7269/swagger/index.html](https://localhost:7269/swagger/index.html)
