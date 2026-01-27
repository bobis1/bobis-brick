package com.launcher.launcher;

import java.io.File;

public class Game {
    private final String name;
    private final File executable;

    public Game(String name, File executable) {
        this.name = name;
        this.executable = executable;
    }

    public String getName() {
        return name;
    }

    public File getExecutable() {
        return executable;
    }
}

