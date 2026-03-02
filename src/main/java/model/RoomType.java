package model;

public class RoomType {

    private int id;
    private String name;
    private double ratePerNight;

    public RoomType() {}

    public RoomType(int id, String name, double ratePerNight) {
        this.id = id;
        this.name = name;
        this.ratePerNight = ratePerNight;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getRatePerNight() { return ratePerNight; }
    public void setRatePerNight(double ratePerNight) { this.ratePerNight = ratePerNight; }
}