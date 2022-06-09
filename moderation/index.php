<?php
require 'connection.php';
$data = new stdClass();


if(isset($_GET['guildid'])){
    $guild_id = $_GET['guildid'];
    $sql = "SELECT * FROM `guilds` WHERE guildId = '$guild_id' ";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data->welcomechannel= $row["welcomechannel"];
            $data->defaultrole= $row["defaultrole"];
            $data->guildId= $row["guildId"];
            $data->chatchannelId= $row["chatchannelId"];
            $data->rolenormal= $row["rolenormal"];
            $data->rolemute= $row["rolemute"];
            $data->rulesid= $row["rulesid"];
            $data->prefix= $row["prefix"];
        }
    }else{
        $data->welcomechannel="";
        $data->defaultrole="";
        $data->guildId="";
        $data->chatchannelId="";
        $data->rolenormal="";
        $data->rolemute="";
        $data->rulesid="";
        $data->prefix=".";
    }
    $myJSON = json_encode($data);
    echo $myJSON;
}

else if(isset($_GET['smapid'])){
    $guild_id = $_GET['smapid'];
    $sql = "SELECT * FROM `spam` WHERE guildId = '$guild_id' ";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data->limit= $row["lmt"];
            $data->time= $row["time"];
            $data->guildId= $row["guildId"];
            $data->diff= $row["diff"];

        }
    }else{
        $data->limit="2";
        $data->time="7000";
        $data->guildId="";
        $data->diff="100000";

    }
    $myJSON = json_encode($data);
    echo $myJSON;
}
elseif(isset($_GET['moderation'])){
    $guild_id = $_GET['moderation'];
    $user_id = $_GET['user'];
    $sql = "SELECT * FROM `guilds` WHERE guildId = '$guild_id' ";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data->welcomechannel= $row["welcomechannel"];
            $data->defaultrole= $row["defaultrole"];
            $data->guildId= $row["guildId"];
            $data->chatchannelId= $row["chatchannelId"];
            $data->rolenormal= $row["rolenormal"];
            $data->rolemute= $row["rolemute"];
            $data->rulesid= $row["rulesid"];
            $data->prefix= $row["prefix"];
        }
        $mutelevelsql = "SELECT * FROM `guildmutelevel` WHERE guild = '$guild_id'";
        $mutelevelresult = $con->query($mutelevelsql);
        if ($mutelevelresult->num_rows > 0) {
            while ($mutelevelrow = $mutelevelresult->fetch_assoc()) {
                $mutlvl = $mutelevelrow['lmt'];
                $mutime = $mutelevelrow['time'];

            }
        }else{
            $mutlvl = 1000;
            $mutime = 0;
        }
        $data->mutelevel = $mutlvl;
        $data->mutetimeout = $mutime;
        $checksql = "SELECT * FROM `mute` WHERE user = '$user_id' AND guild = '$guild_id'";
        $checkresult = $con->query($checksql);
        if ($checkresult->num_rows > 0) {
            while ($checkrow = $checkresult->fetch_assoc()) {
                if( $checkrow['count'] < $mutlvl ){
                    $updtestat = "UPDATE `mute` SET count = count+1 WHERE user= '$user_id' AND guild = '$guild_id' ";
                    if ($con->query($updtestat)) {
                        $count = $checkrow['count'];
                        $data->count= $count;
                        $data->action = "mute";
                    }
                }
                else{
                    $data->count= "full";
                    $data->action = "kick";
                }
            }
        }else{
            $data->count=0;
            $inssql = "INSERT INTO `mute`(`guild`, `user`, `count`) VALUES ('$guild_id','$user_id','1')";
            if ($con->query($inssql)) {
                $data->count= 0;
                $data->action = "mute";
             }
        }

    }else{
        $data->welcomechannel="";
        $data->defaultrole="";
        $data->guildId="";
        $data->chatchannelId="";
        $data->rolenormal="";
        $data->rolemute="";
        $data->rulesid="";
        $data->prefix=".";
    }
    $myJSON = json_encode($data);
    echo $myJSON;
}
elseif(isset($_GET['custmcmnd'])){
    $guild_id = $_GET['custmcmnd'];
    $cmnds = [];
    $custcmndsql = "SELECT * FROM `customcmnd` WHERE guild = '$guild_id' ";
    $custcmndresult = $con->query($custcmndsql);
    if ($custcmndresult->num_rows > 0) {
        while ($custcmndrow = $custcmndresult->fetch_assoc()) {
            array_push($cmnds, $custcmndrow);
        }
        $datas = $cmnds;
    }else{
        $datas = new stdClass();
        $datas->cmnd="pong";
        $datas->reply="ping";
    }
    $myJSON = json_encode($datas);
    echo $myJSON;
}
elseif(isset($_GET['userid']) && isset($_GET['guild'])){
    $guild_id = $_GET['guild'];
    $user_id = $_GET['userid'];

    $sql = "SELECT * FROM `userlevel` WHERE guildid = '$guild_id' AND userid = '$user_id' ";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $count = $row['count'];
            $lvl = $count%10;
            if($lvl == 0){
                $nowlvl = $count/10;
                $msgs = 'true';
            }else{
                $nowlvl = 0;
                $msgs = 'false';
            }
            $addcount = "UPDATE `userlevel` SET `count`=count+1 WHERE guildid = '$guild_id' AND userid = '$user_id'";
            if($con->query($addcount)){
                $data->lvln = $nowlvl;
                $data->msg = $msgs;
            }
        }
    }else{

        $span_fill = "INSERT INTO `userlevel`(`guildid`, `userid`, `count`) VALUES ('$guild_id' ,'$user_id','1') ";
        if($con->query($span_fill)){
            $data->lvln = '0';
            $data->msg = 'false';

        }
    }

    $myJSON = json_encode($data);
    echo $myJSON;



}

elseif(isset($_GET['mylevel']) && isset($_GET['guild'])){
    $guild_id = $_GET['guild'];
    $user_id = $_GET['mylevel'];

    $sql = "SELECT * FROM `userlevel` WHERE guildid = '$guild_id' AND userid = '$user_id' ";
    $result = $con->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $count = $row['count'];
            $lvl = round($count/10,0);
            $data->lvln = $lvl;
            $data->msg = 'true';
        }
    }else{
        $data->lvln = '0';
        $data->msg = 'false';
    }
    $myJSON = json_encode($data);
    echo $myJSON;



}elseif(isset($_GET['allcommands'])){
    $prfx = '*';
    $data->prefix= $prfx;
    $data->cmnd = '
            helpbot or '.$prfx.'help //Display all commands
            '.$prfx.'ping //check your ping
            '.$prfx.'weather <location>
            '.$prfx.'stats // status of server
            '.$prfx.'stats <user_id> | '.$prfx.'stats @mention // status of member
            
            Fun Commands
            '.$prfx.'howgay @mention //Gay percentage
            '.$prfx.'howmand @mention //Mad precentage
            '.$prfx.'meme //Memes from reddit
            '.$prfx.'pokemon <pokemon_name> // Pokemon Details
                
            Games 
            '.$prfx.'poll <time> <question> //create yes no poll
            '.$prfx.'rps // Playing Rock Paper Scissors with bot
            '.$prfx.'tictactoe @mention // play tictactoe with player
            
            Music
            '.$prfx.'play //play music or add to quere
            '.$prfx.'skip //skip queue music
            '.$prfx.'stop //stop playing music

            Moderation
            '.$prfx.'kick @mention Reason.. // Kick user from server and sends private message with reason 
            '.$prfx.'ban @mention Reason.. // Ban user from server and send private message with reason 

            Channel
            '.$prfx.'lock //locks chanel
            '.$prfx.'unlock //unlocks Channel
        ';
        $myJSON = json_encode($data);
    echo $myJSON;
}

?>
