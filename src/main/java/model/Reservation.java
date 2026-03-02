package model;

import java.time.LocalDate;
import java.util.List;

public class Reservation {

    private int id;
    private String reservationNo;
    private String guestName;
    private String address;
    private String contactNumber;

    private LocalDate checkIn;
    private LocalDate checkOut;

    private String status;

    // 🔗 Relationship
    private RoomType roomType;        // Many reservations → one room type
    private List<Payment> payments;   // One reservation → many payments

    public Reservation() {}

    public Reservation(int id, String reservationNo, String guestName,
                       String address, String contactNumber,
                       LocalDate checkIn, LocalDate checkOut,
                       String status, RoomType roomType) {

        this.id = id;
        this.reservationNo = reservationNo;
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.status = status;
        this.roomType = roomType;
    }

    // Getters & Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReservationNo() { return reservationNo; }
    public void setReservationNo(String reservationNo) { this.reservationNo = reservationNo; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType roomType) { this.roomType = roomType; }

    public List<Payment> getPayments() { return payments; }
    public void setPayments(List<Payment> payments) { this.payments = payments; }
}