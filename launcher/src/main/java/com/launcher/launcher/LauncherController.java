package com.launcher.launcher;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.launcher.launcher.Game;
import javafx.scene.layout.FlowPane;
import javafx.stage.FileChooser;


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
            } catch (Exception e) {
                System.err.println(e);
            }
        } else {
            System.err.println("iconImageView is null - check fx:id in FXML");
        }
    }

    @FXML
    protected void onLaunchButtonClick() throws IOException {
        new ProcessBuilder("./Documents/Tower.sh").start();
    }


    @FXML
    private FlowPane gameList;

    private final List<Game> Game = new ArrayList<>();

    @FXML
    void onAddGame() {
        FileChooser chooser = new FileChooser();
        chooser.setTitle("Select Game Executable");

        File file = chooser.showOpenDialog(null);
        if (file == null) return;

        if (!file.canExecute()) {
            chooser.setTitle("File is not executable");
            return;
        }

        Game game = new Game(file.getName(), file);
        Game.add(game);

        addGameButton(game);
    }

    private void addGameButton(Game game) {
        Button btn = new Button(game.getName());
        btn.getStyleClass().add("game-button");

        btn.setPrefWidth(220);
        btn.setPrefHeight(60);

        btn.setOnAction(e -> launchGame(game));

        gameList.getChildren().add(btn);
    }

    private void launchGame(Game game) {
        new Thread(() -> {
            try {
                new ProcessBuilder(game.getExecutable().getAbsolutePath())
                        .inheritIO()
                        .start();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }).start();
    }
}

