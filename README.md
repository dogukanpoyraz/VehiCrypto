# VehiCrypto - Blockchain-Based Vehicle Maintenance Tracking

VehiCrypto is an innovative blockchain-based vehicle maintenance tracking application designed to enhance transparency, security, and efficiency in vehicle service records. This project leverages **blockchain, IPFS, Java, and Flutter** to create a **tamper-proof, decentralized, and user-friendly system** for both vehicle owners and service providers.

## 📸 Screenshots

### Login Page
<p align="center">
  <img src="https://github.com/user-attachments/assets/89b4857f-5d9e-418b-8c33-301d2bb5f6a7" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/749f7b98-8f9f-4e29-bc97-882c18796632" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/1f171f13-25cb-4add-b27a-64b2e2814747" width="22.5%" />
</p>

### Home Page
<p align="center">
  <img src="https://github.com/user-attachments/assets/8e3281fb-fcfb-476b-bcd0-d9da591f2074" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/1e4f07fb-d760-47af-be4f-13c750b3235b" width="22.5%" />
</p>

### Maintenance Form Page
<p align="center">
  <img src="https://github.com/user-attachments/assets/807e11d6-d9b1-42c9-8a1c-c5ffe9276c4c" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/ca09f3c4-e512-4a6a-8f55-02634d6ffb12" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/f40347bd-4d4b-4ea5-986c-322f37c2e80a" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/425cc93f-1a45-414b-ba8d-192d0c545c91" width="22.5%" />
</p>

### Maintenance Records Page
<p align="center">
  <img src="https://github.com/user-attachments/assets/e30be089-6e22-4bce-b760-3c6da5b592e1" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/11bb88da-4c35-4d56-baee-da1711c91db6" width="22.5%" />
  <img src="https://github.com/user-attachments/assets/913fde51-532b-43cd-a18a-f353e23df8bc" width="22.5%" />
</p>




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





