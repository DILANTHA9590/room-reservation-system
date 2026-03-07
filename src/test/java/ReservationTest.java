import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import model.Reservation;

public class ReservationTest {

    @Test
    void testReservationCreation() {

        Reservation reservation = new Reservation();

        reservation.setGuestName("John Doe");
        reservation.setContactNo("0771234567");

        assertEquals("John Doe", reservation.getGuestName());
        assertEquals("0771234567", reservation.getContactNo());
    }
}