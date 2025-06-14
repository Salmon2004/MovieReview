# MovieReview
Overview of the Project
Introduction
The sudden rise in online media consumption has given birth to an active community of movie enthusiasts who are ready to share their opinions, discover new films, and connect with like-minded fans. As much as this need is present, existing platforms prefer to divide content across multiple sites or fail to provide a complete interactive and personalized experience.
CineLuxe is constructed as a social media-influenced movie website that combines movie reviews, encourages user interaction, and tailors content discovery. Employing the Model-View-Controller (MVC) framework using JSP, Servlets, and MySQL, CineLuxe is programmed to build an active community where movie lovers unite on their passion for cinema through cinematic experiences.

Problem Statement
Today's online age confronts the movie-going audience more actively than ever before in researching and exchanging information about films. The landscape is currently highly fractured, however. There are reviews on a wide variety of sites ranging from social networking platforms, blogs, streaming, to movie databases each performing specialized roles. Sites are generally based on professional critics or have minimum rating systems that largely fail to have user interaction, qualitative comments, and community-based suggestions.

Issues Identified:
Scattered Content: Movie reviews and discussions are dispersed across platforms such as IMDB, Rotten Tomatoes, and various social media channels, making it difficult for users to find consolidated opinions.
Lack of Community Features: Existing review sites emphasize individual critiques but lack robust interaction features like comments, likes, and following mechanisms.
Over-reliance on Critics: Many platforms prioritize professional critics’ reviews, underrepresenting the public’s voice.
Limited User Control: Users have minimal control over their profiles, reviews, and comments, reducing engagement and ownership.



Proposed Solution – CineLuxe:
 
-To address these gaps, CineLuxe is proposed as an all-in-one web-based platform where users can:
Register and manage personal profiles.


Write, edit, and share reviews for any movie.


Browse movie listings with detailed information such as genre, director, and release year.


Rate movies on a scale, with options to comment on other users’ reviews.
The app creates a sense of community because it enables users to engage with likes, comments, and discussion on film reviews transforming passive watching into interactive participation. Each review and comment is traceable to user activity, promoting transparency and accountability.
Technically speaking, the platform was created using the Model-View-Controller (MVC) architecture to facilitate separation and a seamless development process. In the four main modules User Management, Review Management, Commenting System, and Movie Database it will carry out all CRUD functions. Each module will be developed by a specific team member to ensure accountability and modular development.
Finally,  CineLuxe aspires to be a destination website for moviegoers, a place where socializing is abundant, opinions are valued, and finding new films is made easier by others.

Individual Module Assignment
User Management
Assigned to: Afiq

Responsibilities:
User registration and login/logout functionality
Password reset and profile security settings
View other user profile
Role-based  access control (admin/user)
   
CRUD Focus:
Create: Register user
Read: View profile
Update: Edit user information
Delete: Remove account


Review Management
Assigned to: Syafiq
Responsibilities:
Write and post detailed movie reviews
Edit and update reviews
Delete own reviews
Browse reviews by movie or user
View individual review pages with metadata (ratings, timestamps, etc.)

CRUD Focus:
Create: Submit reviews
Read: View movie and user reviews
Update: Edit reviews
Delete: Remove reviews
Movie Database
Assigned to: Ammar

Responsibilities:
Manage movie entries(title, director, genre, release year, etc.)
Add new movie and edit existing movie information
Delete outdated or duplicate entries
View movie listings and individual detail pages
Interface with APIs(e.g., TMDB) for metada enrichment

CRUD Focus:
Create: Add movie entries
Read: Browse/search movie listings
Update: Edit movie details
Delete: Remove movies

Commenting System
Assigned to: Danial

Responsibilities:
Add comments to movie reviews
Like or dislike reviews and comments
Edit and delete own comments
Display comment threads per review
Comment reaction

CRUD Focus:
Create: Post comments
Read: View comment threads
Update: Edit comments
Delete: Remove comments

Steps to run the project locally
1. Clone or Download the Project(in master branch)
2.Open with NetBeans IDE
-Launch NetBeans.
-Go to File > Open Project.
-Browse to the folder you cloned/extracted.
-Select the folder containing nbproject and click Open Project.

3. Set Up Database
-Open phpMyAdmin or MySQL Workbench.
-Create a new database named:
Import the provided .sql file (in db.txt) to set up tables like:
User_
Movie
Review
Comment
Reaction
 
4. Check Database Configuration
Open the file DBUtil.java.

Ensure your MySQL credentials are correct.

5.clean and build and run.
