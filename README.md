🏋️ FitLife Gym Management System
A full-stack Java web application for managing gym member records with secure authentication and real-time database integration. Built with JSP, JDBC, and IBM i (AS/400) to demonstrate enterprise-level web development and legacy system integration.

🔧 Technologies Used
Backend:

Java (JSP & Servlets)
JDBC for database connectivity
Session management for authentication

Database:

IBM i (AS/400)
JT400 JDBC driver

Server:

Apache Tomcat 9.x

Frontend:

HTML5 & CSS3
Responsive design patterns

Development Tools:

NetBeans IDE
Git for version control

✨ Features

🔐 Secure Authentication - Session-based login with validation and timeout protection
👥 Member Management - View and search gym member records in real-time
💾 Database Integration - Direct connection to IBM i (AS/400) using JDBC
♻️ Reusable Components - Modular JSP includes for navigation, headers, and footers
🛡️ Security Features - SQL injection prevention with prepared statements
⚡ Dynamic Content - Real-time data rendering without page refreshes
🎨 Clean UI - Intuitive interface designed for ease of use


🚀 How to Run
Prerequisites

JDK 8 or higher
Apache Tomcat 9.x
NetBeans IDE (or any Java IDE)
IBM i JDBC driver (jt400.jar)
Access to IBM i database

Installation Steps

Clone the repository

bash   git clone https://github.com/YP2032006/fit-life-gym-management.git
   cd fitlife-gym-management

Open in NetBeans

File → Open Project
Select the cloned directory


Add JDBC Driver

Right-click project → Properties → Libraries
Add JAR/Folder → Select jt400.jar


Configure Apache Tomcat

Tools → Servers → Add Server
Select Apache Tomcat and specify installation path
Set HTTP port (default: 8080)


Update Database Configuration

Modify connection settings in your servlet or config file
Important: Do not commit database credentials to Git


Deploy and Run

Right-click project → Clean and Build
Right-click project → Run
Access at http://localhost:8080/FitLife



Default Login (for testing)

Username: admin
Password: admin


⚠️ Change these credentials before production use!

🔒 Security Features

Session Management - Automatic timeout after 30 minutes of inactivity
SQL Injection Prevention - All queries use prepared statements
Input Validation - Server-side validation on all form inputs
Access Control - Login required for all member-facing pages
Credential Protection - Database passwords excluded from repository

💡 What I Learned
Building this project taught me:

Enterprise Java Development - How to structure real-world web applications using JSP and Servlets
Database Connectivity - JDBC connection management, prepared statements, and result set handling
Session Management - Implementing secure authentication flows with session tracking
Legacy Systems - Working with IBM i (AS/400), a mainframe system still widely used in enterprises
MVC Architecture - Separating concerns for cleaner, more maintainable code
Deployment - Configuring and deploying applications to Apache Tomcat
Security Best Practices - Protecting against SQL injection and managing user sessions safely

The biggest challenge was understanding IBM i's unique database structure and ensuring session data didn't leak between users.
🔮 Future Enhancements

 Add member registration and profile editing
 Implement membership expiration tracking and alerts
 Generate PDF reports for member data
 Add advanced search with filters (by membership type, status, etc.)
 Create dashboard with analytics and charts
 Add email notifications for membership renewals
 Implement role-based access control (admin vs. staff)

📌 Notes

Database credentials are stored securely and excluded from this repository
This project was built for educational purposes to demonstrate full-stack development skills
Uses MVC architecture for clean separation of concerns
Compatible with Java 8+ and Tomcat 9.x
Designed with scalability and maintainability in mind

🤝 Contributing
This is an academic project, but suggestions are welcome! If you'd like to contribute:

Fork the repository
Create a feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request

📝 License
This project is open source and available under the MIT License.

👤 Author
Yash Patel
Software Developer Student
Passionate about building full-stack applications and learning enterprise technologies. This project showcases my ability to work with Java, databases, and web development frameworks.

🌐 GitHub: https://github.com/YP2032006
💼 LinkedIn: https://www.linkedin.com/in/yash-patel-b8935132b
📧 Email: yp2032006@gmail.com

🙏 Acknowledgments

Built as a final academic project to demonstrate enterprise Java web development
Thanks to my instructors for guidance on JDBC and session management
Inspired by real-world gym management systems


⭐ If you found this project helpful, please consider giving it a star!
💼 For Recruiters: This project demonstrates my proficiency in Java web development, database integration, security implementation, and working with enterprise systems.
