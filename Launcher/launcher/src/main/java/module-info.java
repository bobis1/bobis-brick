module com.launcher.launcher {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;


    opens com.launcher.launcher to javafx.fxml;
    exports com.launcher.launcher;
}