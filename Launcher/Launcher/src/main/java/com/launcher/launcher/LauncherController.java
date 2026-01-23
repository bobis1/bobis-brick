package com.launcher.launcher;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

import java.io.IOException;

public class LauncherController {

    @FXML
    private Label Launch;

    @FXML
    private ImageView IconImage;

    @FXML
    public void initialize() {
        System.out.println("Initialize called");
        System.out.println("iconImageView is: " + IconImage);

        if (IconImage != null) {
            try {
                Image image = new Image(getClass().getResourceAsStream("/images/icon.png"));
                IconImage.setImage(image);
                System.out.println("Image loaded successfully");
            } catch (Exception e) {
                System.err.println("Could not load image: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.err.println("iconImageView is null - check fx:id in FXML");
        }
    }

    @FXML
    protected void onLaunchButtonClick() throws IOException {
        new ProcessBuilder("open", "-a", "Tower").start();
    }
}