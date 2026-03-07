import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import util.DBConnection;
import java.sql.Connection;

public class DBConnectionTest {

    @Test
    void testDatabaseConnection() {

        Connection conn = DBConnection.getConnection();

        assertNotNull(conn);
    }
}