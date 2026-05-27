# Assignment VII - Implementation of Security Policies with GPO

## Objective
The objective of this assignment was to manage security policies and restrictions within a Windows Server environment using Group Policy Objects (GPOs)[cite: 67].

## 1. Domain Controller Configuration
A Windows Server Domain Controller was configured using PowerShell automation for the domain corp.local. Active Directory Domain Services (AD-DS) were successfully installed.

## 2. Organizational Units (OUs) & Users
To properly segment access control, two distinct Organizational Units were created:
- **Teachers**: For administrative and faculty staff.
- **Students**: For general student accounts with restricted privileges.
Test users (	eacher_test and student_test) were provisioned in their respective OUs.

## 3. GPO Security Implementations
The following security policies were configured and linked[cite: 70]:
- **Control Panel Restriction**: Applied to the Students OU to prevent unauthorized system modifications.
- **Software Installation Disabled**: Applied to the Students OU to prevent the execution of .msi installers and unapproved software.
- **Strong Password Policy**: Applied at the Domain level (corp.local) to enforce complexity requirements (length, special characters) for all users, including Teachers.

## 4. Verification & Conclusion
User logins were tested for both groups. The student_test account successfully encountered access denied prompts when attempting to open the Control Panel or run installers. The 	eacher_test account was prompted to update their password to meet the new domain complexity requirements. The environment is now secured according to the assignment requirements.
