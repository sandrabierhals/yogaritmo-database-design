Yogaritmo – Yoga Studio Database Design

This project shows a core business and relational database from scratch based on real-world business requirements. The goal was to model the complete data structure for a yoga studio management system, covering scheduling, reservations, payments, instructors, clients, and feedback.
The focus of this project is database design, normalization, and business logic modeling.

Objectives

Translate business requirements into a relational data model
Design entities, relationships, and constraints
Apply normalization principles
Implement the schema using SQL
Entity-Relationship Modeling (ER)
Primary and Foreign Keys
Triggers and Store procedures
Business rules mapping

Project Structure
yogaritmo/
│
├── database/
│   ├── yogaritmo-esquema-bd.sql
│   └── tp2_ficheiro3.sql
│
├── diagrams/
│   └── core-business.png
│
└── README.md

Database Diagram

Technologies

SQL
PostgreSQL (compatible)
Relational Database Design

How to Run

If you're using PostgreSQL:
psql -U your_user -f yogaritmo-esquema-bd.sql

Or simply import the SQL files into your preferred database manager (pgAdmin, DBeaver, etc.).

Author
Developed by Sandra Bierhals
Backend Developer
