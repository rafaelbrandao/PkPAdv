alias battle.attack {
  var %ID = $1, %n = $2, %move = $3, %p = $findtok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%n,1,58), %1st = $iif(%p == 1,$v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),0)

  if (%move == Explosion) || (%move == Selfdestruct) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Damp ] ])) { var %move } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .OutRules. ] $+ [ %n ] ] ON } }
  if (%move == Magnitude) { var %r = $rand(1,100) | if (%r <= 5) { var %i = 4 } | elseif (%r <= 15) { var %i = 5 } | elseif (%r <= 35) { var %i = 6 } | elseif (%r <= 65) { var %i = 7 } | elseif (%r <= 85) { var %i = 8 } | elseif (%r <= 95) { var %i = 9 } | else { var %i = 10 } }
  var %power = $gettok($read(pkp\moveslist.txt, s, %move),2,58), %type = $gettok($read(pkp\moveslist.txt, s, %move),1,58), %target = $gettok($read(pkp\moveslist.txt, s, %move),5,58), %contact = $gettok($read(pkp\moveslist.txt, s, %move),6,58), %foe.left = $v([ [ B. ] $+ [ %ID ] $+ [ .Foes ] ])

  ; Doing a analyse about the targets, missing no one.
  if (%move == Curse) && (Ghost isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) { var %target = OneEnemy }

  if ($findtok(Self:Team:N/A:Ally,%target,0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %n }
  elseif (%target == BothEnemy) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).both }
  elseif (%target == All) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).all }
  elseif (%target == RandomEnemy) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand }
  else {
    if ($battle.team(%ID,%alvo).left > 1) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Follow. ] $+ [ $rvs(%n) ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Follow. ] $+ [ $rvs(%n) ] ]) }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Lightningrod) && (%type == Electric) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %alvo }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ $battle.team(%ID,%alvo).num ] ]) == Lightningrod) && (%type == Electric) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ $battle.team(%ID,%alvo).num ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.team(%ID,%alvo).num }
    }

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]) ] ]) <= 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } }
    else { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand }
  }

  if (%move == Counter) { if ($type($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),3,59)) == Normal) && ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,58) } | else { var %move } }
  if (%move == Mirror Coat) { if ($type($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),3,59)) == Special) && ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,58) } | else { var %move } }
  if (!%move) { .echo $battle.fail(%ID,%n,f) | return }

  var %alvos = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]),0,58), %try = 1, %miss = 0

  while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]),%try,58)) {

    var %alvo = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]),%try,58)
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > 0) {

      var %acc = $gettok($read(pkp\moveslist.txt, s, %move),3,58), %hit.e, %hit.dmg, %missed
      if (%alvo == %n) { var %acc = N/A }
      if (%alvo != %n) { sset [ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %alvo ] ] %move $+ : $+ %n }

      ; Primary hit loop...
      var %p.hit = 0, %p.hits = 1, %missed, %failed, %changeev = 1
      if (%move == Triple Kick) { var %p.hits = 3 }
      while (%p.hit < %p.hits) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > 0) && (!%failed) {
        inc %p.hit

        ; Some moves have different accuracy according with the battle. Let's take a look...
        if ($findtok($readini(pkp\effectmoves.ini,Distint,Soundmoves),%move,0,58)) { if ($checkfoe.left(%ID,%n,Trait.,Soundproof:Cacophony,p)) { var %x = $checkfoe.left(%ID,%n,Trait.,Soundproof:Cacophony,p).num | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $+ 's $lb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %x ] ]) bloqueou $bb $+ %move $+ $lb $+ ! | var %failed = 1, %acc = N/A } }
        if (%move == Thunder) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) { var %acc = N/A } | elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) { var %acc = 50 } }
        if ($findtok(Protect:Endure:Detect,%move,0,58)) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ])) { var %acc = 100, %acc = $int($calc(%acc / 2 ^ $v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ]))) } }
        if (%move == Skull Bash) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %acc = N/A, %target = Self }
        if (%move == Future Sight) || (%move == Doom Desire) { var %acc = N/A }
        if ($findtok(Fissure:Sheer Cold:Horn Drill,%move,0,58)) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %alvo ] ])) { var %acc = 0 } | else { var %acc = $calc(%acc + (2 * ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) - $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %alvo ] ])))) } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Fly) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Bounce) { if (!$findtok(Gust:Twister:Thunder:Sky Uppercut,%move,0,58)) { if (%target != Team) && (%target != Self) { var %acc = 0 } } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Dig) { if (!$findtok(Fissure:Earthquake:Magnitude,%move,0,58)) { if (%target != Team) && (%target != Self) { var %acc = 0 } } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Dive) { if (!$findtok(Surf:Whirlpool,%move,0,58)) { if (%target != Team) && (%target != Self) { var %acc = 0 } } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Protected. ] $+ [ %alvo ] ]) == ON) { if (%target != Team) && (%target != Self) { if (!$findtok(Future Sight:Doom Desire,%move,0,58)) { var %acc = 0 } } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ]) == %alvo) { var %acc = N/A } | uset [ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Locked. ] $+ [ %n ] ] }
        if (%move == Struggle) { var %acc = N/A }

        if (%acc != N/A) {
          var %acc = $int($calc(%acc * $iif(%changeev,$istat(%ID,%alvo,EV),1) * $istat(%ID,%n,ACC))), %rand = $rand(1,100)
          if (%rand > %acc) {
            inc %miss

            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Protected. ] $+ [ %alvo ] ]) == ON) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ protegeu-se do ataque! }
            elseif ($findtok(Protect:Endure:Detect,%move,0,58)) { msgfight %ID $lb $+ O golpe falhou! }
            elseif (%p.hit == 1) {
              if (%foe.left) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ desviou-se do ataque! }
              else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ errou o ataque! }
            }

            if (%move == Jump Kick) || (%move == Hi Jump Kick) {
              var %e = $effective(%ID,%type,%alvo)
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Levitate) && (%type == Ground) { var %e = 0 }
              var %rdamage = $int($calc(((2 * $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) / 5 + 2) * $istat(%ID,%n,ATK,%type) * %power / $istat(%ID,%alvo,DEF,%type)) / 50 + 2)), %fdamage = $int($calc(%rdamage * %e * $rand(217,255) / 255)), %dano = %fdamage
              var %dano = $int($calc(%dano / 8)), %dano = $iif(%dano,%dano,1)
              sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %dano) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's %temppoke $lb $+ continuou indo e caiu!
              sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %n
            }

            if (%p.hits > 1) && (%p.hit > 1) { msgfight %ID $lb $+ Golpeou $bb $+ $calc(%p.hit - 1) $lb $+ $iif($calc(%p.hit - 1) == 1,vez,vezes) $+ ! | var %p.hits = %p.hit }
            var %missed = 1
          }
        }

        if (!%missed) && (!%failed) {
          if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),1,58)) && (%alvo != %n) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] $puttok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),%move,1,58) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] %move }

          ; Before calc damage, see if the move is a effect move...
          sset [ [ B. ] $+ [ %ID ] $+ [ .LastMove. ] $+ [ %n ] ] %move | sset [ [ B. ] $+ [ %ID ] $+ [ .TempMove. ] $+ [ %n ] ] %move

          ; Secondary hit loop...
          var %s.hit = 0, %s.hits = 1
          if ($findtok(Double Kick:Bonemerang:Twineedle,%move,0,58)) { var %s.hits = 2 }
          if ($findtok(Arm Thrust:Barrage:Bone Rush:Bullet Seed:Comet Punch:Doubleslap:Fury Swipes:Fury Attack:Icicle Spear:Pin Missile:Rock Blast:Spike Cannon,%move,0,58)) {
            var %s.hits = 2, %rand = $rand(1,100)
            if (%rand <= 50) { var %s.hits = 3 }
            elseif (%rand <= 12) { var %s.hits = $rand(4,5) }
            else { var %s.hits = 2 }
          }
          while (%s.hit < %s.hits) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > 0) && (!%missed) && (!%failed) {
            inc %s.hit

            if (%move == Hidden Power) { var %type = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %n ] ]),1,59), %power = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %n ] ]),2,59) }
            if (%move == Brick Break) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%alvo) ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%alvo) ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%alvo) ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%alvo) ] ] | var %broke = 1 } }
            var %e = $effective(%ID,%type,%alvo)
            if (%broke) { var %broke = 0 | if (%e) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ teve sua barreira quebrada! } }
            var %effect = $readini(pkp\effectmoves.ini, Effects, $replace(%move,$chr(32),_))
            if (%move == Skull Bash) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %effect } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move } }
            if (%move == Curse) && (Ghost isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) { var %effect }

            ; Magic Coat would never make me stressed again...
            if (%effect) && ($v([ [ B. ] $+ [ %ID ] $+ [ .MagicCoat. ] $+ [ %alvo ] ]) == ON) && (%target != Team) && (%target != Self) { uset [ [ B. ] $+ [ %ID ] $+ [ .MagicCoat. ] $+ [ %alvo ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ] | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ refletiu $bb $+ %move $+ $lb $+ ! | var %rcoat = %n, %n = %alvo, %alvo = $iif($battle.side(%n) == 1,$iif(%target == BothEnemy,4:2,%rcoat),$iif(%target == BothEnemy,3:1,%rcoat)), %alvos = $gettok(%alvo,0,58), %try = 0, %miss = 0, %missed = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %alvo }
            else {
              if (%effect) {
                if ($effect.type(%effect) == Stat) { var %e = 1 }
                if ($checkfoe.left(%ID,%n,Snatch.,ON)) && (%n == %alvo) { var %n = $checkfoe.left(%ID,%n,Snatch.,ON).num, %alvo = %n, %alvos = 1, %try = 1, %miss = 0 | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Snatch. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ roubou o efeito de $bb $+ %move $+ $lb $+ ! }
                var %z = $gettok(%effect,0,32), %y = 1
                while (%y <= %z) {
                  var %change = $gettok(%effect,%y,32) $gettok(%effect,$calc(%y + 1),32)
                  if (%change == Sleep) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if ($findtok(Insomnia:Vital Spirit,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || ($checkfoe.left(%ID,%n,Uproar.,ON,a)) || ($SLP.clause(%ID,%n)) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Sleep $+ ; $+ $rand(2,7) $+ ;0;1 | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ caiu no sono! }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if (%change == Burn) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if (Fire isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Water Veil) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || (!%e) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) {
                          sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Burn | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ está queimando!
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (Fire !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (!$findtok(Water Veil,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Burn | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi queimado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! }
                        }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if (%change == Frozen) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Magma Armor) || (Ice isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || (!%e) || (!$FRZ.clause(%ID,%n)) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Frozen | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi congelado! }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if (%change == Paralyz) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Limber) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || (!%e) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) {
                          sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi paralisado! Talvez não se mova!
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Limber,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi paralisado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! }
                        }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if ($gettok(%change,1,32) == Poison) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if (Poison isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Immunity) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || (!%e) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) {
                          sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Poison $+ $iif($gettok(%change,2,32) == Badly,;1) | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %alvo ] ] | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi envenenado!
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (Poison !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (!$findtok(Immunity,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Poison | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envenenado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! }
                        }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if (%change == Confuse) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pelo Safeguard! | .echo $battle.fail(%ID,%n,0,%alvo) | var %failed = 1 }
                    if (!%failed) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Own Tempo) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1 }
                      else {
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %alvo ] ]) != ON) { sset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %alvo ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %alvo ] ] $rand(1,4) | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ ficou confuso! }
                        else { .echo $battle.fail(%ID,%n,f,%alvo) } | var %failed = 1
                      }
                    }
                  }

                  if ($gettok(%change,1,32) == +attack) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) + 1) | var %c.attack. [ $+ [ %cstat ] ] $calc(%c.attack. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == +defense) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) + 1) | var %c.defense. [ $+ [ %cstat ] ] $calc(%c.defense. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == +speed) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) + 1) | var %c.speed. [ $+ [ %cstat ] ] $calc(%c.speed. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == +spcattack) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) + 1) | var %c.spcattack. [ $+ [ %cstat ] ] $calc(%c.spcattack. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == +spcdefense) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) + 1) | var %c.spcdefense. [ $+ [ %cstat ] ] $calc(%c.spcdefense. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == +evason) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ]) + 1) | var %c.evason. [ $+ [ %cstat ] ] $calc(%c.evason. [ $+ [ %cstat ] ] + 1) } }
                  if ($gettok(%change,1,32) == -attack) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %cstat ] ]) != Hyper Cutter) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) | var %c.attack. [ $+ [ %cstat ] ] $calc(%c.attack. [ $+ [ %cstat ] ] - 1) } } }
                  if ($gettok(%change,1,32) == -defense) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) - 1) | var %c.defense. [ $+ [ %cstat ] ] $calc(%c.defense. [ $+ [ %cstat ] ] - 1) } }
                  if ($gettok(%change,1,32) == -speed) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) - 1) | var %c.speed. [ $+ [ %cstat ] ] $calc(%c.speed. [ $+ [ %cstat ] ] - 1) } }
                  if ($gettok(%change,1,32) == -spcattack) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) | var %c.spcattack. [ $+ [ %cstat ] ] $calc(%c.spcattack. [ $+ [ %cstat ] ] - 1) } }
                  if ($gettok(%change,1,32) == -spcdefense) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) - 1) | var %c.spcdefense. [ $+ [ %cstat ] ] $calc(%c.spcdefense. [ $+ [ %cstat ] ] - 1) } }
                  if ($gettok(%change,1,32) == -accuracy) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ]) - 1) | var %c.accuracy. [ $+ [ %cstat ] ] $calc(%c.accuracy. [ $+ [ %cstat ] ] - 1) } }
                  if ($gettok(%change,1,32) == -evason) { if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo } | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %cstat ] ]) - 1) | var %c.evason. [ $+ [ %cstat ] ] $calc(%c.evason. [ $+ [ %cstat ] ] - 1) } }

                  var %y = $calc(%y + 2)
                }
                if (%e) && (!%failed) {
                  if (!%c.attack. [ $+ [ %n ] ]) && (!%c.defense. [ $+ [ %n ] ]) && (!%c.speed. [ $+ [ %n ] ]) && (!%c.spcattack. [ $+ [ %n ] ]) && (!%c.spcdefense. [ $+ [ %n ] ]) && (!%c.evason. [ $+ [ %n ] ]) && (!%c.accuracy. [ $+ [ %n ] ]) && (!%c.attack. [ $+ [ %alvo ] ]) && (!%c.defense. [ $+ [ %alvo ] ]) && (!%c.speed. [ $+ [ %alvo ] ]) && (!%c.spcattack. [ $+ [ %alvo ] ]) && (!%c.spcdefense. [ $+ [ %alvo ] ]) && (!%c.evason. [ $+ [ %alvo ] ]) && (!%c.accuracy. [ $+ [ %alvo ] ]) { .echo $battle.fail(%ID,%n,f,%alvo) | var %failed = 1 }
                  else {
                    if (%c.attack. [ $+ [ %n ] ]) { if (%c.attack. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito ataque! } | elseif (%c.attack. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu ataque! } | elseif (%c.attack. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito ataque! } | var %c.attack. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.defense. [ $+ [ %n ] ]) { if (%c.defense. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito defesa! } | elseif (%c.defense. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu defesa! } | elseif (%c.defense. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito defesa! } | var %c.defense. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.speed. [ $+ [ %n ] ]) { if (%c.speed. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito velocidade! } | elseif (%c.speed. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu velocidade! } | elseif (%c.speed. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou velocidade! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito velocidade! } | var %c.speed. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.spcattack. [ $+ [ %n ] ]) { if (%c.spcattack. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito ataque especial! } | elseif (%c.spcattack. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu ataque especial! } | elseif (%c.spcattack. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque especial! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito ataque especial! } | var %c.spcattack. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.spcdefense. [ $+ [ %n ] ]) { if (%c.spcdefense. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito defesa especial! } | elseif (%c.spcdefense. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu defesa especial! } | elseif (%c.spcdefense. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa especial! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito defesa especial! } | var %c.spcdefense. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.accuracy. [ $+ [ %n ] ]) { if (%c.accuracy. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito precisão! } | elseif (%c.accuracy. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu precisão! } | elseif (%c.accuracy. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou precisão! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito precisão! } | var %c.accuracy. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%c.evason. [ $+ [ %n ] ]) { if (%c.evason. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito evasiva! } | elseif (%c.evason. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu evasiva! } | elseif (%c.evason. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou evasiva! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito evasiva! } | var %c.evason. [ $+ [ %n ] ] 0, %e = 1 }
                    if (%alvo != %n) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Clear Body) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == White Smoke) {
                        if (%c.attack. [ $+ [ %alvo ] ] < 0) || (%c.defense. [ $+ [ %alvo ] ] < 0) || (%c.speed. [ $+ [ %alvo ] ] < 0) || (%c.spcattack. [ $+ [ %alvo ] ] < 0) || (%c.spcdefense. [ $+ [ %alvo ] ] < 0) || (%c.accuracy. [ $+ [ %alvo ] ] < 0) || (%c.evason. [ $+ [ %alvo ] ] < 0) { var %e = 0 }
                      }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) && (%move != Tickle) { if (%c.attack. [ $+ [ %alvo ] ] < 0) || (%c.defense. [ $+ [ %alvo ] ] < 0) || (%c.speed. [ $+ [ %alvo ] ] < 0) || (%c.spcattack. [ $+ [ %alvo ] ] < 0) || (%c.spcdefense. [ $+ [ %alvo ] ] < 0) || (%c.accuracy. [ $+ [ %alvo ] ] < 0) || (%c.evason. [ $+ [ %alvo ] ] < 0) { var %e = 0 } }
                      if (%c.accuracy. [ $+ [ %alvo ] ] < 0) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Keen Eye) { var %e = 0 }
                      if (%c.accuracy. [ $+ [ %alvo ] ] < 0) && ($v([ [ B. ] $+ [ %ID ] $+ [ .ProtAcc. ] $+ [ %alvo ] ])) { var %e = 0 }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%alvo) ] ])) { if (%c.attack. [ $+ [ %alvo ] ]) || (%c.defense. [ $+ [ %alvo ] ]) || (%c.speed. [ $+ [ %alvo ] ]) || (%c.spcattack. [ $+ [ %alvo ] ]) || (%c.spcdefense. [ $+ [ %alvo ] ]) || (%c.accuracy. [ $+ [ %alvo ] ]) || (%c.evason. [ $+ [ %alvo ] ]) { var %e = 0 | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi protegido pela névoa! } }
                    }
                    if (%e) {
                      if (%alvo != %n) {
                        if (%c.attack. [ $+ [ %alvo ] ]) { if (%c.attack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque! } | var %c.attack. [ $+ [ %alvo ] ] 0 }
                        if (%c.defense. [ $+ [ %alvo ] ]) { if (%c.defense. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito defesa! } | elseif (%c.defense. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu defesa! } | elseif (%c.defense. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou defesa! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito defesa! } | var %c.defense. [ $+ [ %alvo ] ] 0 }
                        if (%c.speed. [ $+ [ %alvo ] ]) { if (%c.speed. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito velocidade! } | elseif (%c.speed. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu velocidade! } | elseif (%c.speed. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou velocidade! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito velocidade! } | var %c.speed. [ $+ [ %alvo ] ] 0 }
                        if (%c.spcattack. [ $+ [ %alvo ] ]) { if (%c.spcattack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque especial! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque especial! } | var %c.spcattack. [ $+ [ %alvo ] ] 0 }
                        if (%c.spcdefense. [ $+ [ %alvo ] ]) { if (%c.spcdefense. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito defesa especial! } | elseif (%c.spcdefense. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu defesa especial! } | elseif (%c.spcdefense. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou defesa especial! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito defesa especial! } | var %c.spcdefense. [ $+ [ %alvo ] ] 0 }
                        if (%c.accuracy. [ $+ [ %alvo ] ]) { if (%c.accuracy. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito precisão! } | elseif (%c.accuracy. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu precisão! } | elseif (%c.accuracy. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou precisão! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito precisão! } | var %c.accuracy. [ $+ [ %alvo ] ] 0 }
                        if (%c.evason. [ $+ [ %alvo ] ]) { if (%c.evason. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito evasiva! } | elseif (%c.evason. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu evasiva! } | elseif (%c.evason. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou evasiva! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito evasiva! } | var %c.evason. [ $+ [ %alvo ] ] 0 }
                      }
                    }
                    else {
                      if (%c.attack. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %alvo ] ]) + (%c.attack. [ $+ [ %alvo ] ] * -1)) | var %c.attack. [ $+ [ %alvo ] ] 0 }
                      if (%c.defense. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %alvo ] ]) + (%c.defense. [ $+ [ %alvo ] ] * -1)) | var %c.defense. [ $+ [ %alvo ] ] 0 }
                      if (%c.speed. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %alvo ] ]) + (%c.speed. [ $+ [ %alvo ] ] * -1)) | var %c.speed. [ $+ [ %alvo ] ] 0 }
                      if (%c.spcattack. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %alvo ] ]) + (%c.spcattack. [ $+ [ %alvo ] ] * -1)) | var %c.spcattack. [ $+ [ %alvo ] ] 0 }
                      if (%c.spcdefense. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %alvo ] ]) + (%c.spcdefense. [ $+ [ %alvo ] ] * -1)) | var %c.spcdefense. [ $+ [ %alvo ] ] 0 }
                      if (%c.accuracy. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %alvo ] ]) + (%c.accuracy. [ $+ [ %alvo ] ] * -1)) | var %c.accuracy. [ $+ [ %alvo ] ] 0 }
                      if (%c.evason. [ $+ [ %alvo ] ]) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %alvo ] ]) + (%c.evason. [ $+ [ %alvo ] ] * -1)) | var %c.evason. [ $+ [ %alvo ] ] 0 }

                      .echo $battle.fail(%ID,%n,e,%alvo) | var %failed = 1
                    }
                  }
                }
              }

              ; First check of failed moves...
              if (%effect) && (!$readini(pkp\effectmoves.ini,100,$replace(%move,$chr(32),_))) { var %failed = 1 }
              if (!%failed) {
                if (%move == Minimize) { sset [ [ B. ] $+ [ %ID ] $+ [ .Minimized. ] $+ [ %n ] ] ON }
                if (%move == Defense Curl) { sset [ [ B. ] $+ [ %ID ] $+ [ .Defcurled. ] $+ [ %n ] ] ON }
                if (%move == Skull Bash) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] }
                if (%e) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),2,58)) && (%alvo != %n) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] $puttok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),%n,2,58) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] %move $+ : $+ %n } }

                ; Now, see if it's a move with effect distinct...
                if ($findtok(Protect:Endure:Detect,%move,0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ]) + 1) }
                if (%move == Sunny Day) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) || (%move == $v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) { .echo $battle.fail(%ID,%n,f) | var %failed = 1 }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Sunny Day | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] 0
                    msgfight %ID $lb $+ A luz do sol agora brilha mais forte! | battle.c.weather %ID | var %failed = 1
                  }
                }
                if (%move == Rain Dance) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) || (%move == $v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) { .echo $battle.fail(%ID,%n,f) | var %failed = 1 }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Rain Dance | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] 0
                    msgfight %ID $lb $+ Uma forte chuva acaba de começar! | battle.c.weather %ID | var %failed = 1
                  }
                }
                if (%move == Hail) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) || (%move == $v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) { .echo $battle.fail(%ID,%n,f) | var %failed = 1 }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Hail | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] 0
                    msgfight %ID $lb $+ Uma chuva de granizo foi iniciada! | battle.c.weather %ID | var %failed = 1
                  }
                }
                if (%move == Sandstorm) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) || (%move == $v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) { .echo $battle.fail(%ID,%n,f) | var %failed = 1 }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Sandstorm | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] 0
                    msgfight %ID $lb $+ Uma tempestade de areia foi iniciada! | battle.c.weather %ID | var %failed = 1
                  }
                }
                if (%move == Haze) {
                  uset [ [ B. ] $+ [ %ID ] $+ [ .B. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .FocusEnergy. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Identified. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .ProtAcc. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .DefCurled. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Minimized. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Yawn. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Charge. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ * ] ]
                  uset [ [ B. ] $+ [ %ID ] $+ [ .UpCritical. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .NoEscape. ] $+ [ * ] ]
                  var %x = 0 | while (%x < 4) {
                    inc %x
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Transform. ] $+ [ %x ] ])) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ]) == Wild) { var %x1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%x) ] ]) } | else { var %x1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ]) }
                      var %x2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ])
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Sex. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Sex)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Atk)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Def)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Spd)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,SAtk)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,SDef)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Move1)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Move2)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Move3)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %x ] ] $rini(cadastros,%x1,%x2,Move4)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %x ] ] 0
                      sset [ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %x ] ] 0
                      sset [ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %x ] ] 0
                      sset [ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %x ] ] 0
                    }
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %x ] ] $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]),Type)
                  }
                  msgfight %ID $lb $+ Todas as mudanças de stat foram eliminadas!
                  var %failed = 1
                }
                if (%move == Attract) {
                  var %female = 0, %male = 0
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Female) { var %female = 1 }
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %alvo ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %alvo ] ]) == Female) { var %female = 1 }
                  if (!%male) || (!%female) { .echo $battle.fail(%ID,%n,f) }
                  else {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Oblivious) { .echo $battle.fail(%ID,%n,f) }
                    else { sset [ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %alvo ] ] ON $+ : $+ %n | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ ficou apaixonado por $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ ! }
                  }
                  var %failed = 1
                }
                if (%move == Fake Out) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %n ] ]) != 1) { .echo $battle.fail(%ID,%n,f) | var %failed = 1 } }
                if (%move == Triple Kick) { var %power = $calc(10 * (2 ^ (%p.hit - 1))) }
                if (%move == Reflect) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%n) ] ])) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%n) ] ] 5 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envolvido por uma tela protetora! } | var %failed = 1 }
                if (%move == Light Screen) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%n) ] ])) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%n) ] ] 5 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envolvido por uma tela de luz! } | var %failed = 1 }
                if (%move == Mist) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%n) ] ])) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%n) ] ] 5 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envolvido por uma névoa! } | var %failed = 1 }
                if (%move == Rest) {
                  if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ]),1,59) == Sleep) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ já está dormindo! | .echo $battle.fail(%ID,%n) }
                  elseif ($checkfoe.left(%ID,%n,Uproar.,ON,a)) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não conseguiu dormir com o barulho! | .echo $battle.fail(%ID,%n) }
                  elseif ($findtok(Vital Spirit:Insomnia,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não consegue dormir com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! | .echo $battle.fail(%ID,%n) }
                  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ já está com o HP cheio! | .echo $battle.fail(%ID,%n) }
                  else {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .BadlyPoison. ] $+ [ %n ] ] } | sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Sleep;2;0;0 | msgfight %ID $lb $+ Dormiu e recuperou toda sua energia! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])
                  }
                  var %failed = 1
                }
                if (%move == Leech Seed) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  elseif (Grass isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,e,%alvo) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %alvo ] ] %n | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ implantou sementes em $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! }
                  var %failed = 1
                }
                if ($istok($readini(pkp\effectmoves.ini,Distint,RestoreHalf),%move,58) == $true) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + $int($calc(($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 2)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $lb $+ Recuperou metade da energia! }
                  var %failed = 1
                }
                if (%move == Focus Energy) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .FocusEnergy. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .FocusEnergy. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ focalizou sua energia! }
                  var %failed = 1
                }
                if (%move == Yawn) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Yawn. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  elseif ($findtok(Insomnia:Vital Spirit,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) || ($SLP.clause(%ID,%n)) { .echo $battle.fail(%ID,%n,e,%alvo) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Yawn. ] $+ [ %alvo ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .YawnT. ] $+ [ %alvo ] ] ON | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ está sonolento! }
                  var %failed = 1
                }
                if (%move == Bide) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] Bide | sset [ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %n ] ] 0 | var %failed = 1 } }
                if (%move == Destiny Bond) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está tentando levar um oponente junto! }
                  var %failed = 1
                }
                if (%move == Fury Cutter) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .LastMove. ] $+ [ %n ] ]) == Fury Cutter) { var %power = $calc(10 * 2 ^ $v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ]) < 5) { sset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ]) + 1) } } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ] 1 } }
                if (%move == Rollout) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %power = $calc(30 * 2 ^ $v([ [ B. ] $+ [ %ID ] $+ [ .Rollout. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Rollout. ] $+ [ %n ] ]) < 5) { sset [ [ B. ] $+ [ %ID ] $+ [ .Rollout. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Rollout. ] $+ [ %n ] ]) + 1) } } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Rollout. ] $+ [ %n ] ] 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .TRollout. ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Defcurled. ] $+ [ %n ] ]) == ON) { var %power = $calc(%power * 2) } }
                if (%move == Ice Ball) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %power = $calc(30 * 2 ^ $v([ [ B. ] $+ [ %ID ] $+ [ .IceBall. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .IceBall. ] $+ [ %n ] ]) < 5) { sset [ [ B. ] $+ [ %ID ] $+ [ .IceBall. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .IceBall. ] $+ [ %n ] ]) + 1) } } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .IceBall. ] $+ [ %n ] ] 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .TIceBall. ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move } }
                if (%move == Petal Dance) || (%move == Thrash) || (%move == Outrage) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .TCont. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ]) + 1) } }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | sset [ [ B. ] $+ [ %ID ] $+ [ .TCont. ] $+ [ %n ] ] $rand(2,3) | sset [ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ] 1 }
                }
                if (%move == Present) {
                  var %r = $rand(1,10)
                  if (%r <= 2) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) + $int($calc(($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ]) / 4)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ]) } | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ recuperou parte da energia! } | var %failed = 1 }
                  elseif (%r <= 6) { var %power = 40 } | elseif (%r <= 9) { var %power = 80 } | else { var %power = 120 }
                }
                if (%move == Return) { var %power = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .Loyalty. ] $+ [ %n ] ]) / 2.5)) }
                if (%move == Frustration) { var %power = $int($calc((256 - $v([ [ B. ] $+ [ %ID ] $+ [ .Loyalty. ] $+ [ %n ] ])) / 2.5)) }
                if (%move == Safeguard) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%n) ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%n) ] ] 5 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está se protegendo! }
                  var %failed = 1
                }
                if (%move == Flail) || (%move == Reversal) { var %hpat = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]), %hpmax = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) | if (%hpat >= $int($calc(%hpmax * (33 / 48)))) { var %power = 20 } | elseif (%hpat >= $int($calc(%hpmax * (17 / 48)))) { var %power = 40 } | elseif (%hpat >= $int($calc(%hpmax * (10 / 48)))) { var %power = 80 } | elseif (%hpat >= $int($calc(%hpmax * (5 / 48)))) { var %power = 100 } | elseif (%hpat >= $int($calc(%hpmax * (2 / 48)))) { var %power = 150 } | else { var %power = 200 } }
                if (%move == Endeavor) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) >= $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) | var %failed = 1 } }
                if ($findtok(Hyper Beam:Hydro Cannon:Blast Burn:Frenzy Plant,%move,0,58)) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move } }
                if (%move == Dream Eater) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]),1,59) != Sleep) { .echo $battle.fail(%ID,%n,f,%alvo) | var %failed = 1 } }
                if (%move == Morning Sun) || (%move == Moonlight) || (%move == Synthesis) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { if ($findtok(Rain Dance,$v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]),0,58)) { var %we = 4 } | elseif ($findtok(Sunny Day,$v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]),0,58)) { var %we = 1 } | else { var %we = 2 } | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + $int($calc(($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / %we)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $lb $+ Recuperou $iif(%we = 2,metade da,$iif(%we = 4,parte da,toda sua)) energia! }
                  var %failed = 1
                }
                if (%move == Smellingsalt) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]) == Paralyz) && (%e) { var %power = $calc(%power * 2) } }
                if (%move == Foresight) || (%move == Odor Sleuth) {
                  sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %n ] ] 0 | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi identificado! | sset [ [ B. ] $+ [ %ID ] $+ [ .Identified. ] $+ [ %alvo ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .ProtAcc. ] $+ [ %n ] ] ON | var %failed = 1
                }
                if (%move == Weather Ball) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) { var %power = $calc(%power * 2) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) { var %type = Fire } | elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) { var %type = Water } | elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Hail) { var %type = Ice } | else { var %type == Rock } } }
                if (%move == Conversion) {
                  var %cnv = 4 | while (%cnv) { var %mcnv = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %cnv ] $+ ] . ] $+ [ %n ] ])),1,58) | if (%mcnv != $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) { var %cnv.res = $iif(%cnv.res,%cnv.res $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %cnv ] $+ ] . ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %cnv ] $+ ] . ] $+ [ %n ] ])) } | dec %cnv }
                  if ($gettok(%cnv.res,0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] $gettok($read(pkp\moveslist.txt, s, $gettok(%cnv.res,$rand(1,$gettok(%cnv.res,0,58)),58)),1,58) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ mudou para o tipo $bb $+ $organize($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) $+ $lb $+ ! } | else { .echo $battle.fail(%ID,%n,f) } | var %failed = 1
                }
                if (%move == Conversion2) {
                  var %m = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .TempMove. ] $+ [ %alvo ] ])),1,58), %m2 = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .TempMove. ] $+ [ %alvo ] ])),5,58)
                  if ($readini(pkp\effectmoves.ini, Effects, $replace($v([ [ B. ] $+ [ %ID ] $+ [ .TempMove. ] $+ [ %alvo ] ]),$chr(32),_))) || (%m2 == Self) || (%m2 == Team) || (!%m2) { .echo $battle.fail(%ID,%n,f) }
                  else {
                    var %conv2 = $etype(%m), %var = 1 | while ($gettok(%conv2,%var,32)) { var %conv2t = $gettok(%conv2,%var,32) | if (- isin %conv2t) || (! isin %conv2t) { var %conv.res = $iif(%conv.res,%conv.res $remove(%conv2t,-,!), $remove(%conv2t,-)) } | inc %var }
                    var %conv.res = $remove(%conv.res,$v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])), %conv2 = $gettok(%conv.res,0,32)
                    if (!%conv2) { .echo $battle.fail(%ID,%n,f) }
                    else { var %m = $gettok(%conv.res,$rand(1,%conv2),32) | sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] $organize(%m) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ mudou para o tipo $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) $+ $lb $+ ! }
                  }
                  var %failed = 1
                }
                if (%move == Revenge) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59)) { var %power = $calc(%power * 2) } }
                if (%move == Focus Punch) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59)) { msgfight %ID $lb $+ Não conseguiu se concentrar! | var %failed = 1 } }
                if (%move == Stomp) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Minimized. ] $+ [ %alvo ] ]) == ON) { var %power = $calc(%power * 2) } }
                if (%move == Beat Up) { var %power = $calc(10 * $totalpokes($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) }
                if (%move == Wish) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ] 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .WishPoke ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ fez um pedido! } | var %failed = 1 }
                if (%move == Heal Bell) || (%move == Aromatherapy) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se do status effect! | uset [ [ B. ] $+ [ %ID ] $+ [ .BadlyPoison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] }
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 1) { echo $healteam(%ID,%n).stat } | var %failed = 1
                }
                if (%move == Refresh) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se do status effect! | uset [ [ B. ] $+ [ %ID ] $+ [ .BadlyPoison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] } | else { .echo $battle.fail(%ID,%n,f) } | var %failed = 1 }
                if (%move == Mimic) {
                  var %mimic = $v([ [ B. ] $+ [ %ID ] $+ [ .Mimic. ] $+ [ %alvo ] ]), %m = $findtok($gettok($rteam(%ID,%n),17-20,58),%move,1,58)
                  if ($findtok($gettok($rteam(%ID,%n),17-20,58),%mimic,0,58)) || ($findtok(Transform:Metronome:Struggle:Mimic:Sketch:Mirror Move,%mimic,0,58)) || (!%mimic) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] %mimic | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aprendeu o golpe %mimic $+ ! }
                  var %failed = 1
                }
                if (%move == Sketch) {
                  var %mimic = $v([ [ B. ] $+ [ %ID ] $+ [ .Sketch. ] $+ [ %alvo ] ]), %m = $findtok($gettok($rteam(%ID,%n),17-20,58),%move,1,58)
                  if ($findtok($gettok($rteam(%ID,%n),17-20,58),%mimic,0,58)) || (%mimic == Struggle) || (!%mimic) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] %mimic
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) == Wild) { writeini PkP\Cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%n) ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) [ Move [ $+ [ %m ] ] ] %mimic }
                    elseif (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { writeini PkP\Cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) [ Move [ $+ [ %m ] ] ] %mimic }
                    msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ esboçou %mimic $+ !
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 1) {
                      var %tn = $teamnumber(%ID,%n,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %n ] ]) | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %n ] ] $gettok(%pk,1-16,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %n ] ]))
                    }
                  }
                  var %failed = 1
                }
                if (%move == Psych Up) {
                  sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %alvo ] ])) | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %alvo ] ])) | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %alvo ] ])) | sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %alvo ] ]))
                  sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %alvo ] ])) | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %alvo ] ])) | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %n ] ] $iif(!$v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %alvo ] ]),0,$v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %alvo ] ]))
                  msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ copiou as mudanças de stat do oponente! | var %failed = 1
                }
                if (%move == Belly Drum) {
                  var %hhp = $round.up($int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 2))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) <= %hhp) || ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) == 6) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] 6 | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %hhp) | msgfight %ID $lb $+ Perdeu energia e maximizou ataque! } | var %failed = 1
                }
                if (%move == Curse) && (!%effect) {
                  var %hhp = $round.up($int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 2)))
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Cursed. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Cursed. ] $+ [ %alvo ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %hhp) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } | msgfight %ID $lb $+ Perdeu energia e amaldiçoou $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! } | var %failed = 1
                }
                if (%move == Water Spout) || (%move == Eruption) { var %power = $int($calc(((100 * $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) / $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) / 100 * 150)) }
                if (%move == Rage) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %n ] ] ON:0 } }
                if (%move == Pain Split) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) | var %failed = 1 }
                  else { var %e = 1 }
                }
                if (%move == Protect) || (%move == Detect) { if (%p == $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),0,58)) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Protected. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está se protegendo! } | var %failed = 1 }
                if (%move == Lock-On) || (%move == Mind Reader) {
                  sset [ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ] %alvo | sset [ [ B. ] $+ [ %ID ] $+ [ .Locked. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ mirou em $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! | var %failed = 1
                }
                if (%move == Endure) { if (%p == $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),0,58)) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Endured. ] $+ [ %n ] ] ON } | var %failed = 1 }
                if (%move == Magnitude) && (%e) { if (%i == 4) { var %power = 10 } | elseif (%i == 5) { var %power = 30 } | elseif (%i == 6) { var %power = 50 } | elseif (%i == 7) { var %power = 70 } | elseif (%i == 8) { var %power = 90 } | elseif (%i == 9) { var %power = 110 } | else { var %power = 150 } }
                if (%move == Perish Song) {
                  var %ps.v = 0, %ps.r = 0 | while (%ps.v < 4) { inc %ps.v | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %ps.v ] ]) > 0) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %ps.v ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %ps.v ] ]) == Soundproof) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %ps.v ] ]) == Cacophony) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %ps.v ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %ps.v ] ]) $lb $+ bloqueou o golpe com a trait $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %ps.v ] ]) $lb $+ ! } | else { inc %ps.r | sset [ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %ps.v ] ] 4 } } } }
                  if (!%ps.r) { .echo $battle.fail(%ID,%n,f) } | var %failed = 1
                }
                if (%move == Facade) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) { var %power = $calc(%power * 2) }
                if (%move == Skill Swap) { var %tr1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]), %tr2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) | if (%tr1 == Wonder Guard) || (%tr2 == Wonder Guard) { msgfight %ID $lb $+ O golpe falhou! | goto end } | sset [ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ] %tr2 | sset [ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ] %tr1 | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ trocou a trait com $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! | var %failed = 1 }
                if (%move == Role Play) { var %tr = $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) | if (%tr == Wonder Guard) { msgfight %ID $lb $+ O golpe falhou! | goto end } | sset [ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ] %tr | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ copiou a trait do oponente! | var %failed = 1 }
                if (%move == Magic Coat) { if (%p == $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),0,58)) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .MagicCoat. ] $+ [ %n ] ] ON } | var %failed = 1 }
                if (%move == Snatch) { if (%p == $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),0,58)) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Snatch. ] $+ [ %n ] ] ON } | var %failed = 1 }
                if (%move == Gust) || (%move == Twister) || (%move == Thunder) || (%move == Sky Uppercut) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Fly) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Bounce) { var %power = $calc(%power * 2) } }
                if (%move == Surf) || (%move == Whirlpool) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Dive) { var %power = $calc(%power * 2) } }
                if (%move == Earthquake) || (%move == Magnitude) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Dig) { var %power = $calc(%power * 2) } }
                if (%move == Charge) { sset [ [ B. ] $+ [ %ID ] $+ [ .Charge. ] $+ [ %n ] ] ON | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Charged. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Charged. ] $+ [ %n ] ] } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ começou a carregar energia! | var %failed = 1 }
                if (%move == Low Kick) { var %weight = $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]),Weight) | if (%weight <= 10) { var %power = 20 } | elseif (%weight <= 25) { var %power = 40 } | elseif (%weight <= 50) { var %power = 60 } | elseif (%weight <= 100) { var %power = 80 } | elseif (%weight <= 200) { var %power = 100 } | else { var %power = 120 } }
                if (%move == Mud Sport) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .MudSport. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .MudSport. ] $+ [ %n ] ] ON | msgfight %ID $lb $+ Aumentou sua resistência contra $bb $+ Electric $+ $lb $+ ! }
                  var %failed = 1
                }
                if (%move == Water Sport) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .WaterSport. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .WaterSport. ] $+ [ %n ] ] ON | msgfight %ID $lb $+ Aumentou sua resistência contra $bb $+ Fire $+ $lb $+ ! }
                  var %failed = 1
                }
                if (%move == Stockpile) { var %stock = $v([ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ]), %stock = $iif(%stock,%stock,0) | if (%stock < 3) { inc %stock | sset [ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ] %stock | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ armazenou $bb $+ $numero(%stock) $lb $+ $iif(%stock > 1,Stockpiles,Stockpile) $+ ! } | else { .echo $battle.fail(%ID,%n,f) } | var %failed = 1 }
                if (%move == Spit Up) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ])) { var %power = $calc(100 * $v([ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ])) | uset [ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ] } | else { .echo $battle.fail(%ID,%n,f,%alvo) | var %failed = 1 } }
                if (%move == Swallow) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ])) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ já está com o HP cheio! | .echo $battle.fail(%ID,%n) }
                    else {
                      var %stock = $v([ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ]), %sw = $iif(%stock == 1,4,$iif(%stock == 2,2,1)) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / %sw))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) }
                      if (%sw == 1) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou toda a energia! } | else { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou $iif(%sw == 2,metade,parte) da energia! } | uset [ [ B. ] $+ [ %ID ] $+ [ .Stock. ] $+ [ %n ] ]
                    }
                  }
                  else { .echo $battle.fail(%ID,%n,f) }
                  var %failed = 1
                }
                if (%move == Teleport) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ])) {
                    if ($checkfoe.left(%ID,%n,Trait.,Arena Trap)) || ($checkfoe.left(%ID,%n,Trait.,Shadow Tag)) { .echo $battle.fail(%ID,%n,f) }
                    else {
                      msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ desapareceu! | msgfight %ID $lb $+ Esta batalha foi encerrada.
                      battle.thief %ID %n
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%n) ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%n) ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $rvs(%n) ] ]) }
                      if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
                      b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $iif(%w == 1,2,1) ] ]) | uset B. $+ %ID $+ * | return 1
                    }
                  }
                  else { .echo $battle.fail(%ID,%n,f) }
                  var %failed = 1
                }
                if (%move == Roar) || (%move == Whirlwind) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Ingrain. ] $+ [ %alvo ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Suction Cups) { .echo $battle.fail(%ID,%n,e,%alvo) }
                  else {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ])) {
                      msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ espantou seu adversário! | msgfight %ID $lb $+ Esta batalha foi encerrada.
                      battle.thief %ID %n
                      if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%n) ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %alvo ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%alvo) ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) }
                      if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { var %w = $rvs(%n) } | else { var %w = $battle.side(%n) }
                      b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) | uset B. $+ %ID $+ * | return 1
                    }
                    elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 1) && ($battle.left(%ID,%alvo).total) {
                      sset [ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %alvo ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ])
                      ; var %switch = %alvo
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %alvo ] ] Switch; $+ $battle.left(%ID,%alvo).rand
                      var %temp = $battle.check.switch(%ID) | if (%temp) { return %temp }
                    }
                    else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  }
                  var %failed = 1
                }
                if (%move == Encore) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %alvo ] ])) || (!$v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ])) || (!$nmove(%ID,%alvo,$v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ]))) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %alvo ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ])
                    sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %alvo ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ])
                    sset [ [ B. ] $+ [ %ID ] $+ [ .EncoreTurn. ] $+ [ %alvo ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .EncoreTurns. ] $+ [ %alvo ] ] $rand(2,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]),6,3)) | uset [ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ]
                    msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ caiu no %move $+ !
                  }
                  var %failed = 1
                }
                if (%move == Torment) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %alvo ] ] ON | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %alvo ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ] } | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ caiu no %move $+ ! }
                  var %failed = 1
                }
                if (%move == Splash) { .echo $battle.fail(%ID,%n,h) | var %failed = 1 }
                if (%move == Substitute) {
                  var %hhp = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 4))
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) <= %hhp) { msgfight %ID $lb $+ Está muito fraco para criar um substituto! }
                  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ já criou um substituto! }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ] $iif(%hhp,%hhp,1) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %hhp) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ criou um substituto! }
                  var %failed = 1
                }
                if (%move == Baton Pass) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 1) && ($battle.left(%ID,%n).total) {
                    sset [ [ B. ] $+ [ %ID ] $+ [ .BatonPass. ] $+ [ %n ] ] ON
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) && (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch | msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) ] ] $lb $+ Escolha seu pokémon com o comando ' $+ $bb $+ .Trocar $+ $lb $+ '. Você tem 1 minuto. | .timerEndTurn $+ %ID 1 60 /battle.turn %ID | return 1 }
                    elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) && ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) && ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) == Ok!) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch | msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) ] ] $lb $+ Escolha seu pokémon com o comando ' $+ $bb $+ .Trocar $+ $lb $+ '. Você tem 1 minuto. | .timerEndTurn $+ %ID 1 60 /battle.turn %ID | return 1 }
                    else {
                      var %switch = $battle.left(%ID,%n).next
                      if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) {
                        if (!$IA.switch(%ID,%n)) {
                          sset [ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])
                          sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ] $gettok($rteam.n(%ID,%n,%switch),1,58)
                          sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch; $+ %switch
                        }
                      }
                      else {
                        sset [ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])
                        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ] $gettok($rteam.n(%ID,%n,%switch),1,58)
                        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch; $+ %switch
                      }
                      var %temp = $battle.check.switch(%ID) | if (%temp) { return %temp }
                    }
                  }
                  else { .echo $battle.fail(%ID,%n,f) }
                  var %failed = 1
                }
                if (%move == Pursuit) {
                  if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %alvo ] ]),1,59) == Switch) { var %power = $calc(%power * 2) }
                }
                if (%move == Block) || (%move == Mean Look) || (%move == Spider Web) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .NoEscape. ] $+ [ %alvo ] ] %move $+ : $+ %n | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ não pode escapar agora! }
                  else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  var %failed = 1
                }
                if (%move == Nightmare) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else {
                    if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]),1,59) == Sleep) { sset [ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %alvo ] ] ON }
                    else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  }
                  var %failed = 1
                }
                if (%move == Disable) {
                  var %x = $v([ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %alvo ] ])
                  if ($gettok(%x,0,58) > 0) { .echo $battle.fail(%ID,%n,f,%alvo) }
                  else {
                    var %disable = $v([ [ B. ] $+ [ %ID ] $+ [ .Sketch. ] $+ [ %alvo ] ])
                    if (!%disable) || (%disable == Struggle) || ($wildtok(%x,%disable $+ $chr(59) $+ *,0,58)) { .echo $battle.fail(%ID,%n,f,%alvo) }
                    else { if (%x) { sset [ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %alvo ] ] %x $+ : $+ %disable $+ ; $+ $rand(2,5) $+ ;0 } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %alvo ] ] %disable $+ ; $+ $rand(2,5) $+ ;0 } | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's %disable $lb $+ foi desabilitado! }
                  }
                  var %failed = 1
                }
                if (%move == Grudge) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %n ] ])) { msgfight %ID $lb $+ O golpe falhou! | goto end } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ quer deixar o oponente embriagado! } | var %failed = 1 }
                if (%move == Memento) {
                  if ($battle.left(%ID,%n).total <= 1) { var %e = 0 }
                  if (%e) {
                    var %effect = -attack -attack -spcattack -spcattack, %z = $gettok(%effect,0,32), %y = 1
                    while (%y <= %z) {
                      var %change = $gettok(%effect,%y,32)
                      if ($gettok(%change,1,32) == -attack) { if (!$findtok(Hyper Cutter:Clear Body:White Smoke,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%alvo) ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { var %cstat = %alvo | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) | var %c.attack. [ $+ [ %cstat ] ] $calc(%c.attack. [ $+ [ %cstat ] ] - 1) } } }
                      if ($gettok(%change,1,32) == -spcattack) { if (!$findtok(Clear Body:White Smoke,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%alvo) ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { var %cstat = %alvo | if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) | var %c.spcattack. [ $+ [ %cstat ] ] $calc(%c.spcattack. [ $+ [ %cstat ] ] - 1) } } }
                      inc %y
                    }
                    if (!%c.attack. [ $+ [ %alvo ] ]) && (!%c.spcattack. [ $+ [ %alvo ] ]) { .echo $battle.fail(%ID,%n,f,%alvo) }
                    else {
                      if (%c.attack. [ $+ [ %alvo ] ]) { if (%c.attack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque! } | var %c.attack. [ $+ [ %alvo ] ] 0 }
                      if (%c.spcattack. [ $+ [ %alvo ] ]) { if (%c.spcattack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque especial! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque especial! } | var %c.spcattack. [ $+ [ %alvo ] ] 0 }
                      sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0
                    }
                  }
                  else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  var %failed = 1
                }
                if (%move == Taunt) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Taunt. ] $+ [ %alvo ] ])) { msgfight %ID $lb $+ O golpe falhou! } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Taunt. ] $+ [ %alvo ] ] %n | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ é forçado a usar golpes de ataque! } | var %failed = 1 }
                if (%move == Camouflage) {
                  if ($findtok(Grama:Grama Alta:Grama Bem Alta,$v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ]),0,58)) { var %x = Grass }
                  elseif ($findtok(Oceano:Lago:Submerso,$v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ]),0,58)) { var %x = Water }
                  elseif ($findtok(Areia,$v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ]),0,58)) { var %x = Ground }
                  elseif ($findtok(Caverna:Rocha,$v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ]),0,58)) { var %x = Rock }
                  else { var %x = Normal }
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ]) == %x) { .echo $battle.fail(%ID,%n,f) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] %x | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ mudou de tipo para $bb $+ %x $+ $lb $+ ! } | var %failed = 1
                }
                if (%move == Ingrain) {
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Ingrain. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f) }
                  else { sset [ [ B. ] $+ [ %ID ] $+ [ .Ingrain. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ implantou raízes no solo! } | var %failed = 1
                }
                if (%move == Recycle) {
                  var %t = $iif($battle.team(%ID,%n),$battle.side(%n),%n), %t1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ]), %t2 = $wildtok(%t1,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) *,1,58)
                  if (%t2) {
                    var %t1 = $remtok(%t1,%t2,1,58) | if (%t1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ] %t1 } | else { uset [ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ] }
                    var %t2 = $deltok(%t2,1,32) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou o item $bb $+ %t2 $+ $lb $+ !
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Rental ] ])) && (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) && (!$dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),Hold)) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Hold %t2 }
                  }
                  else { .echo $battle.fail(%ID,%n,f) } | var %failed = 1
                }
                if ($findtok(Fissure:Sheer Cold:Horn Drill,%move,0,58)) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Sturdy) { var %e = 0 } | if (%e) { var %e = 1 } }
                if (%move == Spite) {
                  var %omove = $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ]), %m = $findtok($gettok($rteam(%ID,%alvo),17-20,58),%omove,1,58)
                  if (%m) && (%omove) {
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %omove),4,58), %mpp = $calc(%mpp + (%mpp * 3 / 5)) }
                      else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, %omove),4,58) / 5)), %mpp = $calc(%mpp * 3) }
                    }
                    else {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %omove),4,58) }
                      else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, %omove),4,58) / 5)) }
                    }
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %alvo ] ]) < %mpp) {
                      var %t = $rand(1,10), %t1 = $iif($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON,1 2 2 2 3 3 3 4 5 6,1 1 1 1 1 1 2 2 2 3), %t = $gettok(%t1,%t,32), %t1 = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %alvo ] ]) + %t), %t1 = $iif(%t1 > %mpp,%mpp,%t1)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %alvo ] ] %t1 | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ perdeu %t PP com o golpe $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %alvo ] ]) $+ $lb $+ !
                    }
                    else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  }
                  else { .echo $battle.fail(%ID,%n,f,%alvo) }
                  var %failed = 1
                }

                ; Calculing damage and effectiveness...
                if (!%failed) {

                  var %dmg, %chit
                  if ($findtok(Night Shade:Seismic Toss,%move,0,58)) { var %dmg = $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) }
                  elseif (%move == Dragon Rage) { var %dmg = 40 }
                  elseif (%move == Sonicboom) { var %dmg = 20 }
                  elseif ($findtok(Fissure:Sheer Cold:Horn Drill,%move,0,58)) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) { var %dmg = $v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %alvo ] ]) } | else { msgfight %ID $lb $+ É um golpe fatal! | var %dmg = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) } }
                  elseif (%move == Pain Split) { var %avr = $int($calc(($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) / 2)), %dmg = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) - %avr) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $iif(%avr > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]),%avr) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ e $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ dividem as dores entre si! }
                  elseif (%move == Psywave) { var %dmg = $rand(1,$int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) * 1.5))) }
                  elseif ($findtok(Counter:Mirror Coat,%move,0,58)) { var %dmg = $calc($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59) * 2) }
                  elseif (%move == Endeavor) { var %dmg = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) - $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) }
                  elseif (%move == Super Fang) { var %dmg = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) / 2)) | if (!%dmg) { var %dmg = 1 } }
                  elseif (%effect) { var %dmg = 0 }
                  else {
                    if (!$findtok(Battle Armor:Shell Armor,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) {
                      var %a = 0
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .FocusEnergy. ] $+ [ %n ] ])) { var %a = $calc(%a + 1) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Scope Lens) { var %a = $calc(%a + 1) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .UpCritical. ] $+ [ %n ] ])) { var %a = $calc(%a + 1) }
                      if ($findtok($readini(pkp\effectmoves.ini,Distint,HighCritical),%move,0,58)) { var %a = $calc(%a + 2) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Lucky Punch) && ($findtok(Chansey:Blissey,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),0,58)) { var %a = $calc(%a + 2) }
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Stick) && ($findtok(Farfetch'd,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),0,58)) { var %a = $calc(%a + 2) }
                      if (%a > 4) { var %a = 4 } | var %a = $gettok(6 12 25 33 50,$calc(%a + 1),32), %rand = $rand(1,100)
                      if (%rand <= %a) { var %chit = 2 }
                    }
                  }
                  if (%dmg != $null) { var %chit = 0 | if (%e) { var %e = 1 } }

                  if ($type(%type) == Normal) { if (%move == Struggle) { var %type = N/A, %e = 1 } | var %atkstat = $istat(%ID,%n,ATK,%type,%chit), %defstat = $istat(%ID,%alvo,DEF,%type) }
                  else { var %atkstat = $istat(%ID,%n,SATK,%type,%chit), %defstat = $istat(%ID,%alvo,SDEF,%type) }

                  if (%move == Selfdestruct) || (%move == Explosion) { var %defstat = $int($calc(%defstat / 2)) }
                  if (%alvos > 1) && (%target != All) { var %power = $int($calc(%power / 2)) }
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Flash Fire) && (%type == Fire) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Flashed. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Flashed. ] $+ [ %alvo ] ] ON | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou seu poder com $bb $+ Flash Fire $+ $lb $+ ! } | else { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Flash Fire $lb $+ tornou $bb $+ %move $lb $+ inefetivo! } | var %failed = 1 }
                  if (($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Volt Absorb) && (%type == Electric)) || (($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Water Absorb) && (%type == Water)) {
                    msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ absorveu o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ !
                    if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) + ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ]) / 4))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %alvo ] ]) } }
                    var %failed = 1
                  }
                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Wonder Guard) { if (%e < 2) || (%dmg != $null) { if (%move != Struggle) { var %e = 0 } } }
                  if (!%failed) {

                    if (%move == Bide) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ]) == 2) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]) == Bide) {
                        uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ]
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %n ] ])) { .echo $battle.fail(%ID,%n,f,%alvo) | uset [ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %n ] ] | var %failed = 1 }
                        else { var %dmg = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %n ] ]) * 2) | uset [ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %n ] ] }
                      }
                    }

                    if (%move == Future Sight) || (%move == Doom Desire) {
                      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %alvo ] ])) { .echo $battle.fail(%ID,%n,f) }
                      else {
                        var %acc = $gettok($read(pkp\moveslist.txt, s, %move),3,58), %acc = $calc(%acc * $istat(%ID,%n,ACC))
                        sset [ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %alvo ] ] %move $+ : $+ %power $+ : $+ $type(%type) $+ : $+ %atkstat $+ : $+ %acc
                        sset [ [ B. ] $+ [ %ID ] $+ [ .DTurn ] $+ [ %alvo ] ] 0 | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ escolheu $bb $+ %move $lb $+ como seu destino!
                      }
                      var %failed = 1
                    }

                    if (!%failed) {
                      if (%e) {
                        if (!%effect) && (%p.hit == 1) && (%s.hit == 1) && (%foe.left) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi atingido! }
                        if (%i) && (!%intensity) { var %intensity = 1 | msgfight %ID $bb $+ %move $lb $+ teve intensidade $bb $+ %i $+ $lb $+ ! }
                        if (%chit) { var %atkstat = $calc(%atkstat * 2), %chit = 0 | msgfight %ID $lb $+ Foi um acerto crítico! }
                      }
                      var %battleeffect = $calc(10 * %e)
                      if (%power != N/A) {
                        if (%hit.e == $null) || (%hit.e != %e) {
                          if (%e >= 2) { msgfight %ID $lb $+ Foi super-efetivo! }
                          elseif (%e > 0) && (%e < 1) { msgfight %ID $lb $+ Não foi muito efetivo... }
                        }
                      }
                      if (%hit.e != $null) && (%hit.e != %e) { var %hit.dmg }
                      var %hit.e = %e
                      if (!%e) {
                        .echo $battle.fail(%ID,%n,e,%alvo)
                        if (%move == Jump Kick) || (%move == Hi Jump Kick) { var %dano = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %dano) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ continuou indo e caiu! }
                        var %failed = 1
                        sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %n
                      }

                      if (!%failed) {
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) { if (%move == Solarbeam) { var %power = $int($calc(%power / 2)) } }
                        if (%dmg == $null) {
                          var %rdamage = $int($calc(((2 * $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) / 5 + 2) * %atkstat * %power / %defstat) / 50 + 2)), %fdamage = $int($calc(%rdamage * %e * $rand(217,255) / 255)), %dano = %fdamage
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .MudSport. ] $+ [ %alvo ] ]) == ON) && (%type == Electric) { var %dano = $int($calc(%dano / 2)) }
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .WaterSport. ] $+ [ %alvo ] ]) == ON) && (%type == Fire) { var %dano = $int($calc(%dano / 2)) }
                          if (%hit.dmg != $null) { var %dano = %hit.dmg }
                          if (%dano <= 0) { var %dano = 1 }
                        }
                        else { var %dano = $int(%dmg) }
                        if (%hit.dmg == $null) { var %hit.dmg = %dano }

                        if (%move == Uproar) {
                          if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .UTCont. ] $+ [ %n ] ] $rand(2,5) | sset [ [ B. ] $+ [ %ID ] $+ [ .UCont. ] $+ [ %n ] ] 1 | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está fazendo muito barulho! }
                          var %x = 1 | while ($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ])) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %x ] ]),1,59) == Sleep) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %x ] ] | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $lb $+ foi acordado com o barulho! } | inc %x }
                        }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]) == Bide) && (%dano) { sset [ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .BidePower. ] $+ [ %alvo ] ]) + %dano) }
                        if (%type == Fire) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]) == Frozen) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ descongelou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] }
                        if (%move == Tri Attack) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]) == Frozen) { var %r = $rand(1,100) | if (%r <= 33) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ descongelou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] } }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Endured. ] $+ [ %alvo ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) <= %dano) { var %dano = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) - 1) | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aguentou o golpe! } }

                        if ($findtok(Hidden Power:Struggle,%move,0,58)) { var %type = Normal }
                        var %tmove = %move, %tpower = $int($calc($iif(%power == N/A,0,%power) * %e * $iif(%chit,%chit,1))), %tdano = %dano, %ttype = %type
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) {
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ] $calc($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ]),1,59) + %tdano) $+ ; $+ $addtok($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ]),2,59),%n,58) $+ ; $+ $addtok($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ]),3,59),%ttype,32) }
                          else { sset [ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ %alvo ] ] %tdano $+ ; $+ %n $+ ; $+ %ttype }
                        }

                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) {
                          sset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %alvo ] ]) - %dano)
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %alvo ] ]) <= 0) {
                            uset [ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %alvo ] ]
                            msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ teve seu substituto quebrado! | var %subsbroke = 1
                          }
                        }
                        else {
                          if (%move == Rapid Spin) { uset [ [ B. ] $+ [ %ID ] $+ [ .Spikes ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ] }
                          if (%dano > $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) { var %dano = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) }
                          if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),3,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] $puttok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ]),%tpower $+ ; $+ %tdano $+ ; $+ %ttype,3,58) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %alvo ] ] %move $+ : $+ %n $+ : $+ %tpower $+ ; $+ %tdano $+ ; $+ %ttype }
                          sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) - %dano) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) { if (%move == False Swipe) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ] 1 } }
                          if (!$v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ])) {
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %alvo ] ])) && (!$istok($readini(pkp\effectmoves.ini,Distint,Twices),%move,58)) && (!$istok($readini(pkp\effectmoves.ini,Distint,Twice),%move,58)) && (%move != Triple Kick) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 | uset [ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %alvo ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi levado junto com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ ! }
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %alvo ] ])) {
                              var %m = $v([ [ B. ] $+ [ %ID ] $+ [ .PPDec. ] $+ [ %alvo ] ]) | if (%m) {
                                if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
                                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58), %mpp = $calc(%mpp + (%mpp * 3 / 5)) }
                                  else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58) / 5)), %mpp = $calc(%mpp * 3) }
                                }
                                else {
                                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58) }
                                  else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58) / 5)) }
                                }
                                if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ]) != %mpp) {
                                  sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] %mpp | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi embriagado com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ !
                                }
                                uset [ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %alvo ] ]
                              }
                            }
                          }
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %alvo ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .LastMove. ] $+ [ %alvo ] ]) == Rage) { if ($calc($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %alvo ] ]),2,58) + 1) <= 6) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %alvo ] ] ON: $+ $calc($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %alvo ] ]),2,58) + 1) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Twice ] ])) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou a raiva! } } } | else { uset [ [ B. ] $+ [ %ID ] $+ [ .Rage. ] $+ [ %alvo ] ] } }
                          if ($findtok(Absorb:Leech Life:Mega Drain:Giga Drain:Dream Eater,%move,0,58)) {
                            var %suched = $int($calc(%dano / 2)), %suched = $iif(!%suched,1,%suched)
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Liquid Ooze) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ sugou energia de $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ ! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + %suched) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } }
                            else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ perdeu energia ao tentar sugar de $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ ! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %suched) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } }
                          }
                          if (%move == Thief) {
                            if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Sticky Hold) {

                              ; First, check if the user had your item stole and then erase the thief data.
                              var %tn = $teamnumber(%ID,%alvo), %thief = $v([ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ $battle.player(%ID,%alvo) ] ])
                              if (%thief) {
                                if ($gettok(%thief,1,59) == $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ $battle.player(%ID,%alvo) ] ] }
                              }

                              ; The thief data only will be stored if at least one of the players envolved is a NPC. That way, it will be impossible to a player steals another player forever.
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ])) { var %tn = $teamnumber(%ID,%n) | sset [ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ $battle.player(%ID,%n) ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ]) $+ ; $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %alvo ] ]) $+ ; $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) }
                              sset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ]) | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ]
                              msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ roubou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ !
                            }
                          }
                          if (%move == Knock Off) {
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Sticky Hold) {
                              var %tn = $teamnumber(%ID,%alvo), %thief = $v([ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ $battle.player(%ID,%alvo) ] ])
                              if ($gettok(%thief,1,59) == $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ $battle.player(%ID,%alvo) ] ] }
                              msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ derrubou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ]) de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ !
                              uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %alvo ] ]
                            }
                          }
                          if (%move == Fake Out) { if (%p < $findtok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%alvo,1,58)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Inner Focus) { sset [ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ %alvo ] ] ON } }
                        }

                        if ($findtok(Volt Tackle:Double-Edge:Take Down:Submission,%move,0,58)) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) != Rock Head) && (!%subsbroke) { if (%move == Volt Tackle) || (%move == Double-Edge) { var %recoil = 3 } | else { var %recoil = 4 } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se machucou ao recuar! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - $round.up($calc((%dano / %recoil)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } } }
                        if (%move == Struggle) { var %recoil = 4 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se machucou ao recuar! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - $round.up($calc((%dano / %recoil)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } }

                        if (%move == Wrap) || (%move == Bind) || (%move == Fire Spin) || (%move == Clamp) || (%move == Whirlpool) || (%move == Sand Tomb) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %alvo ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %alvo ] ] %move $+ : $+ %n | sset [ [ B. ] $+ [ %ID ] $+ [ .VTurn. ] $+ [ %n ] ] 0 | sset [ [ B. ] $+ [ %ID ] $+ [ .VTurns. ] $+ [ %n ] ] $rand(2,5) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ prendeu o oponente! } }
                        if (%move == Smellingsalt) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ]) == Paralyz) { uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ não está mais paralisado! } }

                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Shell Bell) && (%dano) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) {
                          var %rec = $int($calc(%dano / 8)), %rec = $iif(%rec,%rec,1) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc(%rec + $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > [ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se com Shell Bell!
                        }
                        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) && (!%subsbroke) {
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Color Change) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ]) != %type) { sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ] %type | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ mudou de tipo para %type $+ ! } }
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Cute Charm) && (%contact == Yes) {
                            var %rand = $rand(1,100) | if (%rand <= 30) {
                              var %female = 0, %male = 0
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Female) { var %female = 1 }
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %alvo ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %alvo ] ]) == Female) { var %female = 1 }
                              if (%male) && (%female) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) != Oblivious) { sset [ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %n ] ] ON: $+ %alvo | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ ficou apaixonado por $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ ! } }
                            }
                          }
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Effect Spore) && (%contact == Yes) {
                            var %rand = $rand(1,100) | if (%rand <= 10) {
                              if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) {
                                var %es = Poison:Sleep:Paralyz
                                if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Insomnia) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Vital Spirit) || ($checkfoe.left(%ID,%n,Uproar.,ON,a)) || ($SLP.clause(%ID,%alvo)) { var %es = $remtok(%es,Sleep,1,58) }
                                if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Limber) { var %es = $remtok(%es,Paralyz,0,58) }
                                if (Poison isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Immunity) { var %es = $remtok(%es,Poison,0,58) }

                                var %es = $gettok(%es,$rand(1,$gettok(%es,0,58)),58)
                                if (%es == Sleep) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Sleep; $+ $rand(2,7) $+ ;0;1 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ caiu no sono com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Effect Spore! }
                                elseif (%es == Paralyz) {
                                  sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi paralisado com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Effect Spore!
                                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Limber,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi paralisado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! }
                                }
                                elseif (%es == Poison) {
                                  sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Poison | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envenenado com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Effect Spore!
                                  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Immunity,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Poison | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi envenenado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! }
                                }
                              }
                            }
                          }
                        }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Flame Body) && (%contact == Yes) && (Fire !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Water Veil,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) {
                          var %rand = $rand(1,100) | if (%rand <= 30) {
                            sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Burn | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está queimando com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Flame Body!
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Water Veil,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Burn | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi queimado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! }
                          }
                        }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Poison Point) && (%contact == Yes) && (Poison !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Immunity,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) {
                          var %rand = $rand(1,100) | if (%rand <= 30) {
                            sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Poison | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envenenado com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Poison Point!
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Immunity,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Poison | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi envenenado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ ! }
                          }
                        }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Rough Skin) && (%contact == Yes) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Twice ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se machucou com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Rough Skin! } | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Static) && (%contact == Yes) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Limber,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) {
                          var %rand = $rand(1,100) | if (%rand <= 30) {
                            sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi paralisado com $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ 's Static!
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Limber,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi paralisado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! }
                          }
                        }

                        ; Now, check the secondary effects move:
                        var %rand = $rand(1,100)
                        if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,20,10)) && ($readini(pkp\effectmoves.ini, 10, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 10, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,40,20)) && ($readini(pkp\effectmoves.ini, 20, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 20, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,60,30)) && ($readini(pkp\effectmoves.ini, 30, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 30, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,80,40)) && ($readini(pkp\effectmoves.ini, 40, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 40, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,100,50)) && ($readini(pkp\effectmoves.ini, 50, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 50, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if (%rand <= 100) && ($readini(pkp\effectmoves.ini, 100, $replace(%move,$chr(32),_))) { var %change = $readini(pkp\effectmoves.ini, 100, $replace(%move,$chr(32),_)), %changed = Ok! }
                        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == King's Rock) {
                          if (%dano) && (!%effect) && (%p < $findtok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%alvo,1,58)) && (%changed != Ok!) {
                            if (!$readini(pkp\effectmoves.ini, 40, $replace(%move,$chr(32),_))) && (!$readini(pkp\effectmoves.ini, 50, $replace(%move,$chr(32),_))) {
                              if ($readini(pkp\effectmoves.ini, 10, $replace(%move,$chr(32),_))) { if ($findtok(Signal Beam:Silver Wind:Poison Tail:Steel Wing,%move,0,58)) { var %rand = $rand(1,100) | if (%rand <= 12) { var %change = Flinch, %changed = Ok! } } }
                              elseif ($readini(pkp\effectmoves.ini, 20, $replace(%move,$chr(32),_))) { if ($findtok(Meteor Mash:Twister:Water Pulse,%move,0,58)) { var %rand = $rand(1,100) | if (%rand <= 12) { var %change = Flinch, %changed = Ok! } } }
                              elseif ($readini(pkp\effectmoves.ini, 30, $replace(%move,$chr(32),_))) { if ($findtok(Rolling Kick:Low Kick:Dragonbreath:Bounce:Snore:Muddy Water,%move,0,58)) { var %rand = $rand(1,100) | if (%rand <= 12) { var %change = Flinch, %changed = Ok! } } }
                              else { var %rand = $rand(1,100) | if (%rand <= 12) { var %change = Flinch, %changed = Ok! } }
                            }
                          }
                        }
                        if (%move == Secret Power) {
                          var %rand = $rand(1,100), %arena = $v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ])
                          if (%rand <= $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Serene Grace,60,30)) {
                            var %changed = Ok! | if (%arena == Grama) || (%arena == Grama Alta) { var %change = Poison } | elseif (%arena == Grama Bem Alta) { var %change = Sleep } | elseif (%arena == Oceano) { var %change = -attack target } | elseif (%arena == Lago) { var %change = -speed target } | elseif (%arena == Areia) { var %change = -accuracy } | elseif (%arena == Rocha) { var %change = Confuse } | elseif (%arena == Caverna) { var %change = Flinch } | elseif (%arena == Submerso) { var %change = -defense target } | else { var %change = Paralyze }
                          }
                        }
                        if ($effect.target(%change)) {
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Shield Dust) { var %changed = No! }
                          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %alvo ] ])) || (%subsbroke) { var %changed = No! }
                        }
                        if (%changed == Ok!) {
                          if (%move == Tri Attack) { var %x = $rand(1,3) | if (%x == 1) { var %change = Paralyz } | elseif (%x == 2) { var %change = Burn } | else { var %change = Frozen } }
                          var %changed = No!, %x = 1, %fullchange = %change
                          while ($gettok(%fullchange,%x,32)) {
                            var %change = $gettok(%fullchange,%x,32) $gettok(%fullchange,$calc(%x + 1),32)
                            if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) > 0) {
                              if (%change == Sleep) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Insomnia:Vital Spirit,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) && (!$checkfoe.left(%ID,%alvo,Uproar.,ON,a)) && (!$SLP.clause(%ID,%n)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Sleep; $+ $rand(2,7) $+ ;0;1 | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ caiu no sono! }
                              if (%change == Burn) && (Fire !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && (!$findtok(Water Veil,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]),0,58)) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Burn | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ está queimando!
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Water Veil,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) && (Fire !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Burn | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi queimado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! } }
                              if (%change == Paralyz) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Limber) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi paralisado! Talvez não se mova!
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Limber,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Paralyz | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi paralisado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! } }
                              if (%change == Frozen) && (Ice !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Magma Armor) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) && (!$FRZ.clause(%ID,%n)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Frozen | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi congelado! }
                              if ($gettok(%change,1,32) == Poison) && (Poison !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Immunity) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %alvo ] ] Poison $+ $iif($gettok(%change,2,32) == Badly,;1) | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %alvo ] ] | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi envenenado!
                              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) == Synchronize) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && (!$findtok(Immunity,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]),0,58)) && (Poison !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Poison $+ $iif($gettok(%change,2,32) == Badly,;1) | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi envenenado também com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) $+ $lb $+ ! } }
                              if (%change == Confuse) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %alvo ] ]) != ON) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Own Tempo) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%alvo) ] ]))  { sset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %alvo ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %alvo ] ] $rand(1,4) | msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ ficou confuso! }
                              if (%change == Flinch) && (%p < $findtok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%alvo,1,58)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]) != Inner Focus) { sset [ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ %alvo ] ] ON }
                            }
                            if ($gettok(%change,1,32) == UPAll) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
                              if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque! }
                              if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa! }
                              if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou velocidade! }
                              if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque especial! }
                              if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa especial! }
                            }
                            if ($gettok(%change,2,32) == self) { var %cstat = %n } | else { var %cstat = %alvo }
                            if (+ isin $gettok(%change,1,32)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %cstat ] ]) > 0) {
                              if ($gettok(%change,1,32) == +attack) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) + 1) | var %c.attack. [ $+ [ %cstat ] ] $calc(%c.attack. [ $+ [ %cstat ] ] + 1) } }
                              if ($gettok(%change,1,32) == +defense) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) + 1) | var %c.defense. [ $+ [ %cstat ] ] $calc(%c.defense. [ $+ [ %cstat ] ] + 1) } }
                              if ($gettok(%change,1,32) == +speed) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) + 1) | var %c.speed. [ $+ [ %cstat ] ] $calc(%c.speed. [ $+ [ %cstat ] ] + 1) } }
                              if ($gettok(%change,1,32) == +spcattack) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) + 1) | var %c.spcattack. [ $+ [ %cstat ] ] $calc(%c.spcattack. [ $+ [ %cstat ] ] + 1) } }
                              if ($gettok(%change,1,32) == +spcdefense) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) + 1) | var %c.spcdefense. [ $+ [ %cstat ] ] $calc(%c.spcdefense. [ $+ [ %cstat ] ] + 1) } }
                            } 
                            elseif (- isin $gettok(%change,1,32)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %cstat ] ]) > 0) {
                              var %decrease = 1 | if (%cstat != %n) { if (!$findtok(Clear Body:White Smoke,$v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %cstat ] ]),0,58)) || (!$v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%cstat) ] ])) { var %decrease = 0 } }
                              if (%decrease) {
                                if ($gettok(%change,1,32) == -attack) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %cstat ] ]) != Hyper Cutter) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %cstat ] ]) - 1) | var %c.attack. [ $+ [ %cstat ] ] $calc(%c.attack. [ $+ [ %cstat ] ] - 1) } }
                                if ($gettok(%change,1,32) == -defense) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %cstat ] ]) - 1) | var %c.defense. [ $+ [ %cstat ] ] $calc(%c.defense. [ $+ [ %cstat ] ] - 1) } }
                                if ($gettok(%change,1,32) == -speed) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %cstat ] ]) - 1) | var %c.speed. [ $+ [ %cstat ] ] $calc(%c.speed. [ $+ [ %cstat ] ] - 1) } }
                                if ($gettok(%change,1,32) == -spcattack) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %cstat ] ]) - 1) | var %c.spcattack. [ $+ [ %cstat ] ] $calc(%c.spcattack. [ $+ [ %cstat ] ] - 1) } }
                                if ($gettok(%change,1,32) == -spcdefense) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %cstat ] ]) - 1) | var %c.spcdefense. [ $+ [ %cstat ] ] $calc(%c.spcdefense. [ $+ [ %cstat ] ] - 1) } }
                                if ($gettok(%change,1,32) == -accuracy) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %cstat ] ]) != Keen Eye) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .ProtAcc. ] $+ [ %cstat ] ])) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %cstat ] ]) - 1) | var %c.accuracy. [ $+ [ %cstat ] ] $calc(%c.accuracy. [ $+ [ %cstat ] ] - 1) } }
                              }
                            }
                            var %x = $calc(%x + 2)
                          }
                          if (%c.attack. [ $+ [ %n ] ]) { if (%c.attack. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito ataque! } | elseif (%c.attack. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu ataque! } | elseif (%c.attack. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito ataque! } | var %c.attack. [ $+ [ %n ] ] 0 }
                          if (%c.defense. [ $+ [ %n ] ]) { if (%c.defense. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito defesa! } | elseif (%c.defense. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu defesa! } | elseif (%c.defense. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito defesa! } | var %c.defense. [ $+ [ %n ] ] 0 }
                          if (%c.speed. [ $+ [ %n ] ]) { if (%c.speed. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito velocidade! } | elseif (%c.speed. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu velocidade! } | elseif (%c.speed. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou velocidade! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito velocidade! } | var %c.speed. [ $+ [ %n ] ] 0 }
                          if (%c.spcattack. [ $+ [ %n ] ]) { if (%c.spcattack. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito ataque especial! } | elseif (%c.spcattack. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu ataque especial! } | elseif (%c.spcattack. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou ataque especial! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito ataque especial! } | var %c.spcattack. [ $+ [ %n ] ] 0 }
                          if (%c.spcdefense. [ $+ [ %n ] ]) { if (%c.spcdefense. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito defesa especial! } | elseif (%c.spcdefense. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu defesa especial! } | elseif (%c.spcdefense. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou defesa especial! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito defesa especial! } | var %c.spcdefense. [ $+ [ %n ] ] 0 }
                          if (%c.accuracy. [ $+ [ %n ] ]) { if (%c.accuracy. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito precisão! } | elseif (%c.accuracy. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu precisão! } | elseif (%c.accuracy. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou precisão! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito precisão! } | var %c.accuracy. [ $+ [ %n ] ] 0 }
                          if (%c.evason. [ $+ [ %n ] ]) { if (%c.evason. [ $+ [ %n ] ] == -2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu muito evasiva! } | elseif (%c.evason. [ $+ [ %n ] ] == -1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ diminuiu evasiva! } | elseif (%c.evason. [ $+ [ %n ] ] == 1) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou evasiva! } | else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ aumentou muito evasiva! } | var %c.evason. [ $+ [ %n ] ] 0 }
                          if (%alvo != %n) {
                            if (%c.attack. [ $+ [ %alvo ] ]) { if (%c.attack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque! } | elseif (%c.attack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque! } | var %c.attack. [ $+ [ %alvo ] ] 0 }
                            if (%c.defense. [ $+ [ %alvo ] ]) { if (%c.defense. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito defesa! } | elseif (%c.defense. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu defesa! } | elseif (%c.defense. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou defesa! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito defesa! } | var %c.defense. [ $+ [ %alvo ] ] 0 }
                            if (%c.speed. [ $+ [ %alvo ] ]) { if (%c.speed. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito velocidade! } | elseif (%c.speed. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu velocidade! } | elseif (%c.speed. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou velocidade! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito velocidade! } | var %c.speed. [ $+ [ %alvo ] ] 0 }
                            if (%c.spcattack. [ $+ [ %alvo ] ]) { if (%c.spcattack. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu ataque especial! } | elseif (%c.spcattack. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou ataque especial! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito ataque especial! } }
                            if (%c.spcdefense. [ $+ [ %alvo ] ]) { if (%c.spcdefense. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito defesa especial! } | elseif (%c.spcdefense. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu defesa especial! } | elseif (%c.spcdefense. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou defesa especial! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito defesa especial! } | var %c.spcdefense. [ $+ [ %alvo ] ] 0 }
                            if (%c.accuracy. [ $+ [ %alvo ] ]) { if (%c.accuracy. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito precisão! } | elseif (%c.accuracy. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu precisão! } | elseif (%c.accuracy. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou precisão! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito precisão! } | var %c.accuracy. [ $+ [ %alvo ] ] 0 }
                            if (%c.evason. [ $+ [ %alvo ] ]) { if (%c.evason. [ $+ [ %alvo ] ] == -2) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu muito evasiva! } | elseif (%c.evason. [ $+ [ %alvo ] ] == -1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ diminuiu evasiva! } | elseif (%c.evason. [ $+ [ %alvo ] ] == 1) { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou evasiva! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ aumentou muito evasiva! } | var %c.evason. [ $+ [ %alvo ] ] 0 }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }

          }
          if (!%failed) && (%s.hits > 1) { msgfight %ID $lb $+ Golpeou $bb $+ %s.hit $lb $+ $iif(%s.hit > 1,vezes,vez) $+ ! | var %s.hits = %s.hit }
          elseif (%failed) && (%s.hit > 1) { if ($calc(%s.hit - 1)) { msgfight %ID $lb $+ Golpeou $bb $+ $calc(%s.hit - 1) $lb $+ $iif($calc(%s.hit - 1) > 1,vezes,vez) $+ ! } | var %s.hits = %s.hit }
        }
      }
      if (!%missed) && (!%failed) && (%p.hits > 1) { msgfight %ID $lb $+ Golpeou $bb $+ %p.hit $lb $+ $iif(%p.hit > 1,vezes,vez) $+ ! | var %p.hits = %p.hit }
      elseif (%failed) && (%p.hit > 1) { if ($calc(%p.hit - 1)) { msgfight %ID $lb $+ Golpeou $bb $+ $calc(%p.hit - 1) $lb $+ $iif($calc(%p.hit - 1) > 1,vezes,vez) $+ ! } | var %p.hits = %p.hit }

      if ($v([ [ B. ] $+ [ %ID ] $+ [ .OutRules. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %alvo ] ]) <= 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .OutRules. ] $+ [ %alvo ] ] ON } }

    }

    inc %try
  }

  if (%1st > 0) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) <= 0) { var %x = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),$gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),0,58),58) | sset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %x ] ] Ok } }
}
