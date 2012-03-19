alias battle.check.turn {
  var %ID = $1, %p = $2, %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%p,58), %loop = $iif($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ]),4,2)

  var %check = 1
  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %n ] ])) { var %check }
  else {
    if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]),1,59) == Switch) { var %temp = $battle.check.switch(%ID) | if (%temp) { return %temp } | var %check }
  }

  if (%check) {

    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])) { randmove %ID %n }
    var %counter = $v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ])

    sset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %n ] ] Ok | uset [ [ B. ] $+ [ %ID ] $+ [ .DestinyBond. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Grudge. ] $+ [ %n ] ] | sset [ [ B. ] $+ [ %ID ] $+ [ .Sketch. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) | uset [ [ B. ] $+ [ %ID ] $+ [ .Mimic. ] $+ [ %n ] ]


    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) != Struggle) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %n ] ]) != $v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) {
      msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não pode usar $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) $lb $+ depois de $bb $+ Torment $+ $lb $+ !
      .echo $battle.fail(%ID,%n)
      return
    }
    else { uset [ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %n ] ] }

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Taunt. ] $+ [ %n ] ])) && ($gettok($read(pkp\moveslist.txt,s,$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),7,58)) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não pode usar $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) $lb $+ depois de $bb $+ Taunt $+ $lb $+ ! | return }
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) <= 0) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) == Nothing) { return }

    ; Looking if the pokemon have conditions to attack...

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ %n ] ]) == ON) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuou! | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ] } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ] OFF } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ] } | uset [ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ %n ] ] | return }
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Truant) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Truant. ] $+ [ %n ] ]) == ON) { uset [ [ B. ] $+ [ %ID ] $+ [ .Truant. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não se moveu! | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .FuryCutter. ] $+ [ %n ] ] } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ] OFF } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ] } | return }
      else { sset [ [ B. ] $+ [ %ID ] $+ [ .Truant. ] $+ [ %n ] ] ON }
    }

    var %st = $v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])
    if (%st) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Shed Skin) { var %rand = $rand(1,100) | if (%rand <= 30) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se do status effect! | if (%st == Poison) { uset [ [ B. ] $+ [ %ID ] $+ [ .BadlyPoison. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %n ] ] } | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] | var %st = 0 } }

    if ($gettok(%st,1,59) == Sleep) {
      var %sturns = $calc($gettok(%st,3,59) + 1), %tturns = $gettok(%st,2,59) | sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Sleep; $+ %tturns $+ ; $+ %sturns $+ ; $+ $gettok(%st,4,59)
      if (!%sturns) { var %sturns = 0 }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Early Bird) { var %tturns = $round.up($calc(%tturns / 2)) }
      if ($calc(%sturns - 1) >= %tturns) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ acordou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %n ] ] }
      else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está dormindo! | if (!$findtok(Snore:Sleep Talk,$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]),0,58)) { .echo $battle.fail(%ID,%n) | return } }
    }
    elseif (%st == Paralyz) {
      var %rand = $rand(0,100) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está paralisado!
      if (%rand < 25) { msgfight %ID $lb $+ Não conseguiu se mover! | .echo $battle.fail(%ID,%n) | return }
    }
    elseif (%st == Frozen) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) == Sacred Fire) && (!%thaw) { var %thaw = ok! }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) == Flame Wheel) && (!%thaw) { var %thaw = ok! }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) && (!%thaw) { var %r = $rand(0,255) | if (%r <= 24) { var %thaw = ok! } }
      if (!%thaw) { var %r = $rand(0,255) | if (%r <= 24) { var %thaw = ok! } }
      if (%thaw) { var %thaw = 0 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ descongelou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] }
      else { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está congelado! | .echo $battle.fail(%ID,%n) | return }
    }

    if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %n ] ]),1,58)) {
      var %rand = $rand(1,100) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está apaixonado por $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %n ] ]),2,58) ] ]) $+ !
      if (%rand <= 50) { msgfight %ID $lb $+ Foi imobilizado pelo amor! | .echo $battle.fail(%ID,%n) | return }
    }

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %n ] ])) {
      var %sturns = $v([ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurn. ] $+ [ %n ] ]), %sturns = $calc(%sturns + 1) | sset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurn. ] $+ [ %n ] ] %sturns
      if (%sturns > $v([ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se recuperou da confusao! | uset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurn. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %n ] ] }
      else {
        var %rand = $rand(1,100) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está confuso!
        if (%rand <= 50) {
          var %atk = $istat(%ID,%n,ATK)
          var %def = $istat(%ID,%n,DEF)

          var %rdamage = $int($calc(((2 * $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) / 5 + 2) * %atk * 40 / %def) / 50 + 2)), %fdamage = $int($calc(%rdamage * $rand(217,255) / 255)), %dano = %fdamage
          msgfight %ID $lb $+ Se bateu na confusao!
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ])) {
            sset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]) - %dano)
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]) <= 0) {
              uset [ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]
              msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ teve seu substituto quebrado!
            }
          }
          else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %dano) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } }
          .echo $battle.fail(%ID,%n) | return
        }
      }
    }

    sset [ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])

    if (!$findtok(Transform:Struggle:Mimic:Sketch,$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]),0,58)) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Choice Band) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) } }
    }

    ; Saying the pokémon had used a move...
    var %move = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])

    if (%move != Nothing) {

      if ($findtok(Mimic:Sketch:Mirror Move:Transform:Metronome,%move,0,58)) { uset [ [ B. ] $+ [ %ID ] $+ [ .Sketch. ] $+ [ %n ] ] }

      sset [ [ B. ] $+ [ %ID ] $+ [ .Mimic. ] $+ [ %n ] ] %move
      var %move.say, %nopp

      if (%move == Solarbeam) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | sset [ [ B. ] $+ [ %ID ] $+ [ .SSolarBeam. ] $+ [ %n ] ] ON } | else { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %move.say = 1 } } }
      if (%move == Fly) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Dig) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Dive) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Bounce) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Sky Attack) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Razor Wind) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Skull Bash) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 } | else { var %temppoke = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) | var %move.say = 1 } }
      if (%move == Hyper Beam) || (%move == Hydro Cannon) || (%move == Blast Burn) || (%move == Frenzy Plant) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ não se moveu! | return } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]) == Bide) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ]) == 2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ descarregou a energia! | var %move.say = 1, %nopp = 1 } | else { return } } 

      if ($v([ [ B. ] $+ [ %ID ] $+ [ .SSolarbeam. ] $+ [ %n ] ]) == ON) { uset [ [ B. ] $+ [ %ID ] $+ [ .SSolarbeam. ] $+ [ %n ] ] }
      elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { var %nopp = 1 }

      if (!%move.say) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ ! }

      ; Decreasing move's PP...
      if (!%nopp) {

        if ($checkfoe.left(%ID,%n,Trait.,Pressure)) { var %x = 2 } | else { var %x = 1 }
        var %m = $findtok($gettok($rteam(%ID,%n),17-20,58),%move,1,58)

        if (%m) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .PPDec. ] $+ [ %n ] ] %m
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58), %mpp = $calc(%mpp * 1.6) }
            else { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58), %mpp = $calc(%mpp * 0.6) }
          }
          else {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58) }
            else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])),4,58) / 5)) }
          }
          var %pp = $v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ]), %r = $calc(%pp + %x) | sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %m ] $+ ] . ] $+ [ %n ] ] $iif(%r > %mpp,%mpp,%r)
        }
        else { uset [ [ B. ] $+ [ %ID ] $+ [ .PPDec. ] $+ [ %n ] ] }

      }

      ; Now, let's see about moves that changes its effects according with the battle.
      if (%move == Transform) {
        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]) ] ]) <= 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand }
        var %alvo = $v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]), %alvos = 1, %try = 1

        sset [ [ B. ] $+ [ %ID ] $+ [ .Sex. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Sex. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ] $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]),type)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %alvo ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %alvo ] ])
        var %x = 0 | while (%x < 4) {
          inc %x | if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])),4,58), %mpp = $calc(%mpp + (%mpp * 3 / 5)) | sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ] $calc(%mpp - 5) }
            else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])),4,58) / 5)), %mpp = $calc(%mpp * 3) | sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ] $calc(%mpp - 1) }
          }
          else {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])),4,58) | sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ] $calc(%mpp - 5) }
            else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])),4,58) / 5)) | sset [ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ] $calc(%mpp - 1) }
          }
        }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Transform. ] $+ [ %n ] ] ON
        msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ transformou-se em $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $+ $lb $+ !
        return
      }
      if (%move == Metronome) {
        var %move
        while (!%move) {
          var %move = $read(pkp\moveslist.txt), %move = $remove(%move,$gettok(%move,-1,32))
          if ($findtok(Mirror Move:Transform:Sketch:Sleep Talk:Mimic:Metronome,%move,0,58)) || ($findtok($gettok($rteam(%ID,%n),17-20,58),%move,1,58)) { var %move }
        }
        msgfight %ID $bb $+ $v( [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ 's $v( [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ !
      }
      if (%move == Mirror Move) {
        var %mirror = $v([ [ B. ] $+ [ %ID ] $+ [ .MMove. ] $+ [ %n ] ]), %move = $gettok(%mirror,1,58)
        if (!%mirror) || ($findtok(Mirror Move:Transform:Sketch:Sleep Talk:Mimic:Metronome,%move,0,58)) || ($findtok($gettok($rteam(%ID,%n),17-20,58),%move,0,58)) { var %move }
        else {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $gettok(%mirror,2,58)
          msgfight %ID $bb $+ $v( [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ 's $v( [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ !
        }
      }
      if (%move == Assist) {
        var %x = 0, %assist, %r, %move
        if ($teamleft(%ID,%n) > 1) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Assist. ] $+ [ %n ] ])) { var %r = $v([ [ B. ] $+ [ %ID ] $+ [ .Assist. ] $+ [ %n ] ]) }
          else {
            while (%x < 6) {
              inc %x | var %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %x ] $+ ] : ] $+ [ %n ] ])
              if ($gettok(%pk,1,58) != $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])) {
                var %y = 0 | while (%y < 4) { inc %y | var %assist = $gettok(%pk,$calc(16 + %y),58) | if (!$findtok(Mimic:Mirror Move:Transform:Sketch:Sleep Talk:Metronome,%assist,0,58)) && (!$findtok(%r,%assist,0,58)) && (%assist) { if (%r) { var %r = %r $+ : $+ %assist } | else { var %r = %assist } } }
              }
            }
            sset [ [ B. ] $+ [ %ID ] $+ [ .Assist. ] $+ [ %n ] ] %r
          }
          if (%r) { var %move = $gettok(%r,$rand(1,$gettok(%r,0,58)),58) | msgfight %ID $bb $+ $v( [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ 's $v( [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ ! }
        }
      }
      if (%move == Sleep Talk) {
        var %x, %r, %move
        if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ]),1,59) == Sleep) {
          var %x = $rmoves(%ID,%n), %y = $gettok(%x,0,58), %z = 0
          while (%z < %y) { inc %z | if (!$findtok(Mimic:Mirror Move:Transform:Sketch:Sleep Talk:Metronome:Focus Punch,$gettok(%x,%z,58),0,58)) { if (%r) { var %r = %r $+ : $+ $gettok(%x,%z,58) } | else { var %r = $gettok(%x,%z,58) } } }
          if (%r) { var %move = $gettok(%r,$rand(1,$gettok(%r,0,58)),58) }
          else { var %move = Struggle }
          msgfight %ID $bb $+ $v( [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ 's $v( [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ !
        }
      }
      if (%move == Nature Power) {
        if (%arena == Grama) { var %move = Stun Spore }
        elseif (%arena == Grama Alta) || (%arena == Grama Bem Alta) { var %move = Razor Leaf }
        elseif (%arena == Rocha) { var %move = Rock Slide }
        elseif (%arena == Areia) { var %move = Earthquake }
        elseif (%arena == Oceano) { var %move = Surf }
        elseif (%arena == Lago) { var %move = Bubblebeam }
        elseif (%arena == Submerso) { var %move = Hydro Pump }
        elseif (%arena == Caverna) { var %move = Shadow Ball }
        else { var %move = Swift }
        uset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]
        msgfight %ID $bb $+ $v( [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ 's $v( [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $bb $+ %move $+ $lb $+ !
      }
      if (%move == Follow Me) { if ($battle.team(%ID,%n).left > 1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Follow. ] $+ [ $battle.side(%n) ] ] %n | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está chamando a atenção! | return } | else { var %move } }
      if (%move == Helping Hand) { if ($battle.team(%ID,%n).left > 1) { sset [ [ B. ] $+ [ %ID ] $+ [ .HelpingHand. ] $+ [ $battle.team(%ID,%n).num ] ] ON | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está dando uma força ao seu parceiro! | return } | else { var %move } }
      if (%move == Skull Bash) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ prepara o ataque! } }
      if (%move == Razor Wind) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ criou um redemoinho! | return } }
      if (%move == Fly) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ voou para o alto! | return } }
      if (%move == Bounce) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ voou para o alto! | return } }
      if (%move == Dig) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ cavou um buraco! | return } }
      if (%move == Dive) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ mergulhou! | return } }
      if (%move == Sky Attack) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está guardando energia! | return } }
      if (%move == Solarbeam) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] %move | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está guardando energia! | return } }
      if (%move == Snore) { if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ]),1,59) != Sleep) { var %move } }
      if (%move == Spikes) {
        var %alvo = $battle.target(%ID,%n), %spikes = $v([ [ B. ] $+ [ %ID ] $+ [ .Spikes ] $+ [ $battle.side(%alvo) ] ]), %spikes = $iif(%spikes,%spikes,0)
        if (%spikes < 3) && (%alvo) { sset [ [ B. ] $+ [ %ID ] $+ [ .Spikes ] $+ [ $battle.side(%alvo) ] ] $calc(%spikes + 1) | if ($battle.target(%ID,%n).left > 1) { msgfight %ID $lb $+ Seus adversários foram cercados por espinhos! } | else { msgfight %ID $bb $+ $+(:player,%alvo,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %alvo ] ]) $lb $+ foi cercado por espinhos! } | return }
        else { var %move }
      }

      if (!%move) { .echo $battle.fail(%ID,%n,f) | return }

      ; Checking if the move had missed...
      var %counter = $v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ]), %temp = $battle.attack(%ID,%n,%move)
      if (%counter == $v([ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Counter. ] $+ [ %n ] ] }
      if (%temp) { return %temp }

      ; Battle detail: If the first attacking pokémon got a self-hit and dead, the slower pokémon will no longer attack. Interesting, huh?
      if ($battle.side(%n) == 1) { var %foes = 4:2:3:1 }
      else { var %foes = 3:1:4:2 }

      if ($battlefaints(%ID,%foes)) { return 1 }
      else { var %x = 1, %f = 0 | while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]),%x,58)) { if ($battlefaint(%ID,$gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ]),%x,58))) { inc %f } | inc %x } | if (%f) { return 1 } }

    }
  }

  ; If the pokémon is holding a berry, now let's check if it was actived...
  var %w = 0, %hb = 0 | while (%w < %loop) {
    inc %w

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ])) {
      var %hold = $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ])
      if ($gettok(%hold,2,32) == Berry) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ])) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Frozen) && (%hold == Aspear Berry) {
            msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou do gelo! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Paralyz) && (%hold == Cheri Berry) {
            msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou da paralisia! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
          if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]),1,59) == Sleep) && (%hold == Chesto Berry) {
            msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se acordou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
          if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]),1,59) == Poison) && (%hold == Pecha Berry) {
            msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou do veneno! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Burn) && (%hold == Rawst Berry) {
            msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou da queimadura! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
          if (%hold == Lum Berry) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Frozen) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou do gelo! }
            elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Paralyz) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou da paralisia! }
            elseif ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]),1,59) == Sleep) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se acordou! }
            elseif ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]),1,59) == Poison) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou do veneno! }
            elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ]) == Burn) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se curou da queimadura! }
            uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
          }
        }
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %w ] ])) {
        if (%hold == Persim Berry) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) == Lum Berry) {
          msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se recuperou da confusão! | uset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurn. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1
        }
      }
      if (%hold == Mental Herb) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %w ] ])) { msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e se libertou da atração! | uset [ [ B. ] $+ [ %ID ] $+ [ .Attract. ] $+ [ %w ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1 }
      }
      if (%hold == White Herb) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Acc. ] $+ [ %w ] ] 0 }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %w ] ]) < 0) { var %active = 1 | sset [ [ B. ] $+ [ %ID ] $+ [ .B.Evason. ] $+ [ %w ] ] 0 }
        if (%active) { var %active = 0 | msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ]) e recuperou-se da perda de stats! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %w ] ] | var %hb = 1 }
      }
      if (%hb) {
        var %hb = 0 | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Rental ] ])) { if (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]))) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) Hold 0 } }
        var %t = $iif($battle.team(%ID,%w),$battle.side(%w),%w), %t1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ]) | if (%t1) { var %t1 = %t1 $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) %hold } | else { var %t1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) %hold }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ] %t1
      }
    }
  }
  if ($battlefaint(%ID,%n)) { return 1 }
}

alias battle.turn {
  .timerENDTURN $+ $1 off
  .timerTURN 1 0 /fightturns $1
}
