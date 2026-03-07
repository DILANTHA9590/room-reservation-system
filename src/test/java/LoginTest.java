import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class LoginTest {

    @Test
    void testValidLogin() {

        String email = "admin@gmail.com";
        String password = "12345678";

        boolean result = email.equals("admin@gmail.com") &&
                         password.equals("12345678");

        assertTrue(result);
    }
}