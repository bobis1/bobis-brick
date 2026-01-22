package com.launcher.launcher;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class Launcher extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Launcher.class.getResource("launcher.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 1200, 1080);
        stage.setScene(scene);
        stage.show();
    }
}
