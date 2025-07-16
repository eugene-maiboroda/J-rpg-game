package com.game.mapper;

import com.game.controller.PlayerInfo;
import com.game.entity.Player;
import com.game.entity.Race;
import com.game.entity.Profession;
import java.util.Date;

import static java.util.Objects.isNull;

public class PlayerMapper {

    public static Player fromDto(PlayerInfo info) {
        if (info == null) return null;

        Player player = new Player();
        player.setName(info.name);
        player.setTitle(info.title);
        player.setRace(info.race);
        player.setProfession(info.profession);
        player.setBirthday(new Date(info.birthday));
        player.setBanned(info.banned);
        player.setExperience(info.experience);


        return player;
    }
    public static PlayerInfo toPlayerInfo(Player player) {
        if (isNull(player)) return null;

        PlayerInfo result = new PlayerInfo();
        result.id = player.getId();
        result.name = player.getName();
        result.title = player.getTitle();
        result.race = player.getRace();
        result.profession = player.getProfession();
        result.birthday = player.getBirthday().getTime();
        result.banned = player.getBanned();
        result.experience = player.getExperience();
        result.level = player.getLevel();
        result.untilNextLevel = player.getUntilNextLevel();
        return result;
    }
}