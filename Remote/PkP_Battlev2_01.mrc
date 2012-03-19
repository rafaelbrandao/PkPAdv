alias battle.check.switch {
  var %ID = $1, %switch = $battle.order(%ID).c
  if (%switch) { var %t.switch = %switch }

  if (%switch) {
    while ($gettok(%switch,1,58)) {
      var %Player = $gettok(%switch,1,58)

      if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Switch. ] $+ [ %Player ] ])) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ]) > 0) {
          var %temp = 1 | while ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %temp ] ])) {
            if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %temp ] ])) && (%temp != %Player) {
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %temp ] ]) == Pursuit) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %temp ] ]) == %Player) { sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $change.order($battle.order(%ID),%temp).first | return -1 }
            }
            inc %temp
          }
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %Player ] ])) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %Player ] ]) == Natural Cure) { uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %Player ] ] }
          }
          var %team = $battle.player(%ID,%Player), %tn = $teamnumber(%ID,%Team,$v([ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %Player ] ])), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ])
          sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ] $gettok(%pk,1-7,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %Player ] ])) $+ : $+ $gettok(%pk,9-14,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ]) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %Player ] ])) $+ : $+ $gettok(%pk,17-20,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %Player ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %Player ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %Player ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %Player ] ])) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %Player ] ])
        }

        var %team = $battle.player(%ID,%Player), %tn = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %Player ] ]),2,59), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ $iif(%tn,%tn,$battle.left(%ID,%Player).rand) ] $+ ] : ] $+ [ %Team ] ]), %tpk = $v([ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %Player ] ])
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .BatonPass. ] $+ [ %Player ] ])) {
          uset [ [ B. ] $+ [ %ID ] $+ [ .BatonPass. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Disabled. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .PPDec. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %Player ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %Player ] ]
          uset [ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Cursed. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]
        }
        else {
          .echo $foe(%ID,%Player,LockOn.,58,p).del
          .echo $foe(%ID,%Player,Taunt.,58,p).del
          .echo $foe(%ID,%Player,NoEscape.,58,p).del
          .echo $foe(%ID,%Player,Vortex.,58,p).del
          .echo $foe(%ID,%Player,Attract.,58,p).del
          var %p = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]), %x1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%Player) ] ]), %x2 = $v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%Player) ] ]), %x3 = $v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%Player) ] ]), %x4 = $v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%Player) ] ])
          uset [ [ B. ] $+ [ %ID ] $+ [ .*. ] $+ [ %Player ] ]
          sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] %p | if (%x1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%Player) ] ] %x1 } | if (%x2) { sset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%Player) ] ] %x2 } | if (%x3) { sset [ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%Player) ] ] %x3 } | if (%x4) { sset [ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%Player) ] ] %x4 }
        }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Switch. ] $+ [ %Player ] ] 1
        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] $gettok(%pk,1,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] $gettok(%pk,2,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ] $gettok(%pk,4,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ] $gettok(%pk,5,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %Player ] ] $gettok(%pk,6,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Loyalty. ] $+ [ %Player ] ] $gettok(%pk,7,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %Player ] ] $gettok(%pk,8,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %Player ] ] $gettok(%pk,9,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %Player ] ] $gettok(%pk,10,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %Player ] ] $gettok(%pk,11,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %Player ] ] $gettok(%pk,12,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %Player ] ] $gettok(%pk,13,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %Player ] ] $gettok(%pk,14,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ] $gettok(%pk,15,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %Player ] ] $gettok(%pk,16,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %Player ] ] $gettok(%pk,17,58)

        sset [ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %Player ] ] $gettok(%pk,21,58)
        if ($gettok(%pk,18,58)) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %Player ] ] $gettok(%pk,18,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %Player ] ] $gettok(%pk,22,58)
        }
        else { sset [ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %Player ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %Player ] ] 0 }
        if ($gettok(%pk,19,58)) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %Player ] ] $gettok(%pk,19,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %Player ] ] $gettok(%pk,23,58)
        }
        else { sset [ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %Player ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %Player ] ] 0 }
        if ($gettok(%pk,20,58)) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %Player ] ] $gettok(%pk,20,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %Player ] ] $gettok(%pk,24,58)
        }
        else { sset [ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %Player ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %Player ] ] 0 }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %Player ] ] $basestat($gettok(%pk,1,58),Type)
        sset [ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %Player ] ] $gettok(%pk,25,58)
        var %n = %player
        msgfight %ID $bb $+ $+(:player,%n,;) $lb $+ substituiu $bb $+ %tpk $lb $+ por $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ ( $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Female,13F,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Male,12M,N/A)) $+ $lb $+ ) $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %n ] ]) == ON,4+ $+ $lb $+,$+) $+ / $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) $+ $lb $+ !
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %n ] ])) && ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ]),1,59) != Sleep) { uset [ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %n ] ] }
      }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %Player ] ] Nothing | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %Player ] ] %Player

      var %switch = $deltok(%switch,1,58)
    }
    if ($battle.switch(%ID,%t.switch)) {
      if ($battlefaints(%ID)) { return 1 }
      else { var %x = 1 | while ($gettok(%t.switch,%x,58)) { if ($battlefaint(%ID,$gettok(%t.switch,%x,58))) { return 1 } | inc %x } }
    }
  }
}
alias battle.fail {
  var %ID = $1, %n = $2, %t = $3, %alvo = $4, %foe.left = $v([ [ B. ] $+ [ %ID ] $+ [ .Foes ] ])
  uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %n ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ]
  if (%alvo) { uset [ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %alvo ] ] }
  else { uset [ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ] }
  if (%t == f) { msgfight %ID $lb $+ O golpe falhou! }
  if (%t == e) { if (%foe.left) && (%alvo) { msgfight %ID $lb $+ O golpe não teve efeito em $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! } | else { msgfight %ID $lb $+ O golpe não teve efeito! } }
  if (%t == h) { msgfight %ID $lb $+ Mas nada aconteceu! }
}

alias battle.c.weather {
  var %ID = $1, %o = $battle.order(%ID)
  while ($gettok(%o,1,58)) {
    var %n = $gettok(%o,1,58), %o = $deltok(%o,1,58)
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Forecast) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) == Castform) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) != Fire) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] Fire | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se transformou! }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) != Water) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] Water | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se transformou! }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Hail) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) != Ice) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] Ice | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se transformou! }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sandstorm) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) != Normal) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] Normal | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se transformou! }
      if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) != Normal) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] Normal | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se transformou! }
    }
  }
}
