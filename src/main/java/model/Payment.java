package model;

import java.time.LocalDateTime;

public class Payment {

    private int id;
    private double amount;
    private String method;
    private String note;
    private LocalDateTime paidAt;

    // 🔗 Relationship
    private Reservation reservation;

    public Payment() {}

    public Payment(int id, double amount, String method,
                   String note, LocalDateTime paidAt) {

        this.id = id;
        this.amount = amount;
        this.method = method;
        this.note = note;
        this.paidAt = paidAt;
    }

    // Getters & Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public LocalDateTime getPaidAt() { return paidAt; }
    public void setPaidAt(LocalDateTime paidAt) { this.paidAt = paidAt; }

    public Reservation getReservation() { return reservation; }
    public void setReservation(Reservation reservation) { this.reservation = reservation; }
}