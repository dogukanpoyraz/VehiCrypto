# VehiCrypto - Blockchain-Based Vehicle Maintenance Tracking

VehiCrypto is an innovative blockchain-based vehicle maintenance tracking application designed to enhance transparency, security, and efficiency in vehicle service records. This project leverages **blockchain, IPFS, Java, and Flutter** to create a **tamper-proof, decentralized, and user-friendly system** for both vehicle owners and service providers.

## Team Members
| Name - Surname |  Github Account | Department |
| -------------- | --------------- | ---------- |
| Arda YILDIZ      | [29ardayildiz](https://github.com/29ardayildiz) | CENG |
| Çağdaş GÜLEÇ      | [Cagdas-Gulec](https://github.com/Cagdas-Gulec) | CENG |
| Doğukan POYRAZ         | [dogukanpoyraz](https://github.com/dogukanpoyraz)       | CENG |
| Salih Barkın AKKAYA         | [barkin06](https://github.com/barkin06)       | CENG |

## Documents 
- [Project Report](https://github.com/dogukanpoyraz/VehiCrypto/blob/main/Documents/VehiCrypto_Report.pdf)

---

## 🚀 Project Overview

### Problem Statement
Traditional vehicle maintenance tracking relies on **centralized databases and paper-based records**, which are prone to:
- **Data loss and manipulation**
- **Lack of transparency**
- **Disputes between owners and service providers**
- **Difficulties in verifying vehicle maintenance history during resale**

### Our Solution
VehiCrypto provides a **secure, immutable, and verifiable** maintenance record system by:

✅ **Using blockchain to ensure tamper-proof records**  
✅ **Storing maintenance documents on IPFS for cost-efficient decentralized storage**  
✅ **Offering a Flutter-based mobile app for seamless user experience**  
✅ **Providing role-based access for vehicle owners and service providers**  

---

## 🛠️ Technologies Used

### **Frontend**
- **Flutter**: Cross-platform mobile application for Android & iOS
- **Dart**: Programming language for Flutter

### **Backend**
- **Java**: Backend services to handle API requests
- **Spring Boot**: Framework for API and database management
- **REST API**: Communication between frontend and backend

### **Blockchain & Storage**
- **Ethereum (Sepolia Testnet)**: Smart contract deployment
- **Solidity**: Smart contract development
- **IPFS**: Decentralized storage for maintenance documents
- **Web3.js**: Blockchain integration for data retrieval

---

## 📌 Key Features

### 🔑 **User Authentication & Wallet Integration**
- **Secure login & registration**
- **Email verification for account security**
- **Manual wallet integration for blockchain transactions**
- **Future support for gas fee delegation to users**

### 📝 **Vehicle Maintenance Logging**
- **Service providers enter maintenance details via a structured form**
- **Information includes vehicle plate, service date, and replaced parts**
- **Data is stored securely on IPFS, with CID recorded on the blockchain**

### 🔍 **Maintenance History Tracking**
- **Vehicle owners can access their complete maintenance history**
- **Visual indicators (✅ Functional | 🔴 Replaced) for easy record interpretation**
- **Immutable blockchain storage ensures records cannot be altered**

### 🔗 **Decentralized & Secure Data Management**
- **Blockchain records only CID & vehicle plate info to minimize costs**
- **All maintenance reports, images, and invoices are stored on IPFS**
- **Data is retrieved using CID, ensuring integrity & transparency**

---

## 🎯 System Architecture

```plaintext
User ➝ Flutter App ➝ Backend (Java) ➝ Smart Contract (Solidity) ➝ Blockchain (Ethereum) ➝ IPFS Storage





