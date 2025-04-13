
# 📚 Bookstore Database Management System

## Project Overview
This project implements a comprehensive database management system for a bookstore. The system tracks inventory, customer information, orders, and shipping details through a well-structured relational database.

## Database Schema

### Core Entities
- **Books**: The central inventory items with details including title, publication year, and ISBN
- **Authors**: Information about book writers with biographical details
- **Publishers**: Companies responsible for book production and distribution
- **Customers**: End users who purchase books
- **Orders**: Transaction records between customers and the bookstore

### Relationship Highlights
- Many-to-many relationship between books and authors
- One-to-many relationship between publishers and books
- Multiple address support for customers with status tracking
- Comprehensive order history with status updates

## ER Diagram
```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   Author    │       │ Book_Author │       │    Book     │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ author_id   │◄─────►│ author_id   │◄─────►│ book_id     │
│ name        │       │ book_id     │       │ title       │
│ bio         │       └─────────────┘       │ publisher_id│◄────┐
└─────────────┘                             │ language_id │◄──┐ │
                                            │ pub_year    │   │ │
                                            │ isbn        │   │ │
                                            └─────────────┘   │ │
                                                              │ │
┌─────────────┐                            ┌─────────────┐   │ │
│ Book_Lang   │                            │  Publisher  │   │ │
├─────────────┤                            ├─────────────┤   │ │
│ language_id │◄───────────────────────────│ publisher_id│◄──┘ │
│ lang_name   │                            │ name        │     │
└─────────────┘                            │ address     │◄────┘
                                           └─────────────┘
┌─────────────┐       ┌─────────────┐      ┌─────────────┐
│  Customer   │       │ Cust_Address│      │   Address   │
├─────────────┤       ├─────────────┤      ├─────────────┤
│ customer_id │◄─────►│ customer_id │      │ address_id  │
│ first_name  │       │ address_id  │◄────►│ street_num  │
│ last_name   │       │ status_id   │◄┐    │ street_name │
│ email       │       └─────────────┘ │    │ city        │
│ phone       │                       │    │ state       │
└─────────────┘                       │    │ postal_code │
      ▲                               │    │ country_id  │◄────┐
      │                               │    └─────────────┘     │
      │                               │                        │
┌─────────────┐                       │    ┌─────────────┐     │
│ Cust_Order  │                       │    │ Addr_Status │     │
├─────────────┤                       │    ├─────────────┤     │
│ order_id    │                       └───►│ status_id   │     │
│ customer_id │                            │ status_name │     │
│ order_date  │                            └─────────────┘     │
│ ship_mth_id │◄───┐                                           │
│ address_id  │◄───┼────────────────────────────────────┐     │
│ status_id   │◄┐  │                                     │     │
│ total_amount│  │  │                                     │     │
└─────────────┘  │  │                                     │     │
      ▲          │  │                                     │     │
      │          │  │                                     │     │
      │          │  │                                     │     │
┌─────────────┐  │  │    ┌─────────────┐    ┌─────────────┐    │
│ Order_Line  │  │  │    │ Ship_Method │    │   Country   │    │
├─────────────┤  │  │    ├─────────────┤    ├─────────────┤    │
│ order_id    │  │  └───►│ method_id   │    │ country_id  │◄───┘
│ book_id     │  │       │ method_name │    │ country_name│
│ quantity    │  │       │ cost        │    └─────────────┘
│ price       │  │       └─────────────┘
└─────────────┘  │
                 │
┌─────────────┐  │       ┌─────────────┐
│Order_History│  │       │Order_Status │
├─────────────┤  │       ├─────────────┤
│ history_id  │  │       │ status_id   │
│ order_id    │  │       │ status_name │
│ status_id   │◄─┴──────►└─────────────┘
│ status_date │
│ notes       │
└─────────────┘
```

## Key Features

### Inventory Management
- Complete book metadata including language, publication year, and ISBN
- Multiple author support for co-authored works
- Publisher tracking with contact information

### Customer Management
- Customer profiles with contact details
- Multiple address support (billing, shipping, etc.)
- Address history with status tracking

### Order Processing
- Comprehensive order details
- Multiple items per order with quantity and price tracking
- Order status workflow (pending → processing → shipped → delivered)
- Detailed order history with timestamps and notes

### Security & Access Control
- Role-based access with three user groups:
  - **Admin**: Full system access
  - **Sales Staff**: Customer and order management
  - **Inventory Manager**: Book and author management

## Example Queries

The system supports various business queries, such as:

1. Finding all books by a specific author
2. Tracking order status and history
3. Analyzing sales by various dimensions (time, author, publisher)
4. Managing customer information and purchase history
5. Inventory analysis and management

## Implementation Details

- **Database**: MySQL
- **Relationships**: Enforced with foreign keys
- **Data Integrity**: Constraints on critical fields


## Best Practices Implemented


- Proper foreign key constraints with cascading actions (ON CASCADE)
- Comprehensive indexing strategy
- Role-based access control by Flushing privileges

---

© 2025 Bookstore Database Project
