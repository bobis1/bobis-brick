package com.launcher.launcher;

import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.io.IOException;

public class LauncherController {
    @FXML
    private Label launchText;
    @FXML
    protected void onLaunchButtonClick() throws IOException {
        new ProcessBuilder("open", "-a", "Tower").start();

    }
}
