-- Create Database (Optional)
CREATE DATABASE IF NOT EXISTS hotel_booking;

USE hotel_booking;

-- Hotel Bookings Table
CREATE TABLE IF NOT EXISTS hotel_bookings (

    id CHAR(36) PRIMARY KEY,

    org_id CHAR(36) NOT NULL,

    hotel_id VARCHAR(100) NOT NULL,

    city VARCHAR(100) NOT NULL,

    checkin_date DATE NOT NULL,

    checkout_date DATE NOT NULL,

    amount DECIMAL(12,2) NOT NULL,

    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

);

-- Booking Events Table
CREATE TABLE IF NOT EXISTS booking_events (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    booking_id CHAR(36) NOT NULL,

    event_type VARCHAR(100) NOT NULL,

    payload JSON,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking
        FOREIGN KEY (booking_id)
        REFERENCES hotel_bookings(id)
        ON DELETE CASCADE

);