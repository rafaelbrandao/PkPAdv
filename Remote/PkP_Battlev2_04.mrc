alias fightturns {
  var %ID = $1
  .timerEndTurn $+ %ID off
  var %loop = $iif($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ]),4,2)
  var %x = 0 | while (%x < %loop) {
    inc %x
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %x ] ]) == Switch) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %x ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ])
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %x ] ] Switch; $+ $battle.left(%ID,%x).rand }
      else {
        var %team = $battle.player(%ID,%x)
        var %tn = $teamnumber(%ID,%Team,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ])), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ] $gettok(%pk,1-7,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %x ] ])) $+ : $+ $gettok(%pk,9-14,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ]) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %x ] ])) $+ : $+ $gettok(%pk,17-20,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %x ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %x ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %x ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %x ] ]))
        var %tn = $battle.left(%ID,%x).rand, %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ] $gettok(%pk,1,58)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %x ] ] Switch; $+ %tn
      }
    }
    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %x ] ])) { randmove %ID %x }
    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %x ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %x ] ] $battle.target(%ID,%x).rand }
  }
  uset [ [ B. ] $+ [ %ID ] $+ [ .Memory: ] $+ [ * ] ]

  ; Can I run?

  var %w = 1 | while (%w <= %loop) {
    var %m1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ])
    if (%m1 == Run) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %w ] ] Ok
      msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ fugiu da batalha! | msgfight %ID $lb $+ Esta batalha foi encerrada.
      battle.thief %ID $rvs(%w)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%w) ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%w) ] ]) == Wild) { remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $rvs(%w) ] ]) }
      if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
      b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) | uset B. $+ %ID $+ * | return
    }
    inc %w
  }

  ; Checking if the player is trying to throw a ball...
  var %w = 1 | while (%w <= %loop) {
    var %m1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ])
    if ($gettok(%m1,1,59) == Catch) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %w ] ] Ok
      var %ball = $gettok(%m1,2,59), %foe = $iif(%w == 1,2,1), %n1 = %w, %n2 = %foe, %hp.total = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %foe ] ]), %hp.current = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %foe ] ]), %rate = $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),catch), %st = $v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %foe ] ])

      ; That's something strange, really, here. I will resolve it, maybe!
      var %x = $rand(0,25) | if (%x < 10) { var %x = 2 } | elseif (%x < 15) { var %x = 1.9 } | elseif (%x < 20) { var %x = 1.8 } | elseif (%x < 24) { var %x = 1.7 } | else { var %x = 1. $+ $rand(0,6) }
      var %hp.total = $int($calc(%hp.total / 2)), %hp.current = $int($calc(%hp.current / 2)), %rate = $int($calc(%rate / %x))
      ; , %rated = $int($calc((%rated / 4) + 3))

      if (%hp.total > 255) { var %hp.total = $int($calc($int($calc(%hp.total / 2)) / 2)) } | if (%hp.current > 255) { var %hp.current = $int($calc($int($calc(%hp.current / 2)) / 2)) }
      if ($gettok(%st,1,59) == Sleep) { var %cstat = 10 } | elseif (%st == Frozen) { var %cstat = 10 } | elseif (%st == Paralyz) { var %cstat = 5 } | elseif (%st == Poison) { var %cstat = 5 } | elseif (%st == Burn) { var %cstat = 5 } | else { var %cstat = 0 }
      if (%ball == Poke  Ball) { var %rate = %rate }
      if (%ball == Great Ball) { var %rate = $int($calc(%rate * 1.5)) }
      if (%ball == Ultra Ball) { var %rate = $calc(%rate * 2) }
      if (%ball == Flare Ball) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] ]) == Sunny Day) { var %rate = $calc(%rate * 4) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] ]) == Rain Dance) { var %rate = $int($calc(%rate * 0.5)) }
      }
      if (%ball == Damp Ball) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] ]) == Sunny Day) { var %rate = $int($calc(%rate * 0.5)) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] ]) == Rain Dance) { var %rate = $calc(%rate * 4) }
      }
      if (%ball == Fast Ball) {
        var %fastfoes = Magnemite:Grimer:Tangela:Mr.mime:Eevee:Porygon:Dratini:Dragonair:Pineco:Raikou:Suicune:Entei:Latias:Latios
        if ($findtok(%fastfoes,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),0,58)) { var %rate = $calc(%rate * 4) }
      }
      if (%ball == Magma Ball) {
        if (Fire isin $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),type)) { var %rate = $calc(%rate * 8) }
      }
      if (%ball == Aqua Ball) {
        if (Water isin $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),type)) { var %rate = $calc(%rate * 8) }
      }
      if (%ball == Nest Ball) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ]) < 20) { var %rate = $calc(%rate * 3) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ]) < 30) { var %rate = $calc(%rate * 2) }
      }
      if (%ball == Repeat Ball) {
        if ($pokedex($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])) == $true) { var %rate = $calc(%rate * 3) }
      }
      if (%ball == Timer Ball) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %foe ] ]) < 10) { var %rate = %rate }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %foe ] ]) < 20) { var %rate = $calc(%rate * 2) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %foe ] ]) < 30) { var %rate = $calc(%rate * 3) }
        else { var %rate = $calc(%rate * 4) }
      }
      if (%ball == Net Ball) { if (Bug isin $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),type)) || (Water isin $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),type)) { var %rate = $calc(%rate * 3) } }
      if (%ball == Love Ball) {
        var %female = 0, %male = 0
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Female) { var %female = 1 }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ $iif(%n == 1,2,1) ] ]) == Male) { var %male = 1 } | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ $iif(%n == 1,2,1) ] ]) == Female) { var %female = 1 }
        if (%male) && (%female) { var %rate = $calc(%rate * 8) }
      }
      if (%ball == Level Ball) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %w ] ]) >= $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ]) * 4)) { var %rate = $calc(%rate * 8) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %w ] ]) >= $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ]) * 2)) { var %rate = $calc(%rate * 4) }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %w ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ])) { var %rate = $calc(%rate * 2) }
      }
      if (%ball == Dive Ball) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ]) == Underwater) { var %rate = $int($calc(%rate * 3.5)) } }
      if (%ball == Lure Ball) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Rod ] ])) { var %rate = $calc(%rate * 3) } }

      msgfight %ID $bb $+ $+(:player,%w,;) $lb $+ jogou a %ball $+ !
      var %rated = $int($calc(((((%hp.total * 4) - (%hp.current * 2)) * %rate) / %hp.total))), %rated = $int($calc(%rated + %cstat + 1)), %rr = 0
      ; var %rated = $int($calc(((((%hp.total * 4) - (%hp.current * 2)) * ((%rate * 100 / 5 / 100)) / %hp.total + 1)))), %rated = $int($calc(%rated + %cstat + 1))
      ; if (%rated > 255) { var %rated = $int($calc(%rated / 4)) }
      var %rrr = 1 | while (%rrr <= 3) {
        var %rnd = $rand(0,255) | if (%ball == Master Ball) { var %rated = 1, %rnd = 0 }
        if (%rnd < %rated) { var %rr = %rr + 1 } | inc %rrr
      }
      ; if (%rr == 2) { var %rnd = $rand(0,255) | if (%rnd < %rated) { var %rr = 3 } }
      if (%rr == 3) {
        wlog user $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) was caught with %ball $+ .
        msgfight %ID $bb $+ $+(:player,%w,;) $lb $+ capturou $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $+ $lb $+ ! | var %region = $dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),Info,Region)
        if ($teampos($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),Egg)) { remteam $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) Egg | addteam $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) | addteam $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) Egg }
        else { addteam $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) }
        writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) Memory $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),Memory) $+ : $+ %ball
        if (%ball == Friend Ball) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) Loyalty 200 }
        if ($pokedex($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])) == $false) { .echo $pokedex($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])).add }
        var %x = $readini(pkp\status.ini,Active,Legendary) | if ($findtok(%x,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),0,58)) { var %x = $remtok(%x,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),1,58) | if (%x) { writeini pkp\status.ini Active Legendary %x } | else { remini pkp\status.ini Active Legendary } }
        var %x = $readini(pkp\status.ini,%region,Legendary) | if ($findtok(%x,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),0,58)) { var %x = $remtok(%x,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),1,58) | if (%x) { writeini pkp\status.ini %region Legendary %x } | else { remini pkp\status.ini %region Legendary } }
        if ($findtok(Suicune:Entei:Raikou,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),0,58)) {
          var %rr = $readini(pkp\status.ini,%region,Legendary)
          if (!$findtok(%rr,Suicune,0,58)) && (!$findtok(%rr,Entei,0,58)) && (!$findtok(%rr,Raikou,0,58)) {
            if (!$gettok($readini(pkp\status.ini,Legendary,Lugia),2,59)) && (!$gettok($readini(pkp\status.ini,Legendary,Ho-oh),2,59)) { var %rr = $addtok(%rr,Lugia,58), %rr = $addtok(%rr,Ho-oh,58) }
            if (%rr) { writeini pkp\status.ini %region Legendary %rr } | else { remini pkp\status.ini %region Legendary }
          }
        }
        writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini Historico Caught $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $+ ; $+ $gettok($dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),Memory),2,58) $+ ; $+ %ball
        msgfight %ID $lb $+ Esta batalha foi encerrada.
        if ($is_legend($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]))) {
          var %idle = $int($calc( ($egroup($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])).step / 30720) * 60 * 60 * 24 * 28)), %idle = $gettok($duration(%idle),1-2,32)
          msg $+(=,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ])) $ct $+ Parabéns, você conseguiu pegar um lendário! Entretanto, se você se mantiver ausente por mais de $dur(%idle,$ct,$cc).e $+ , $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $ct $+ será redisponibilizado para os demais usuários e você perderá a posse. Fique atento!
          writeini pkp\status.ini Legendary $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $gettok($readini(pkp\status.ini,Legendary,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])),1,59) $+ ; $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ])
        }
        if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
        b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ])
        uset B. $+ %ID $+ *
        return
      }
      else {
        msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $lb $+ escapou da %ball $+ !
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Ball ] ])) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Ball ] ]) - 1)
          if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Ball ] ])) {
            wlog user $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) fled.
            if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %foe ] ]),1,59) == sleep) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $lb $+ acordou! }
            elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %foe ] ]) == frozen) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $lb $+ descongelou! }
            msgfight %ID $bb $+ $+(:player,%foe,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $lb $+ fugiu da batalha! | msgfight %ID $lb $+ Esta batalha foi encerrada.
            battle.thief %ID $rvs(%foe)
            if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
            remini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])
            b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %w ] ]) | uset B. $+ %ID $+ * | return
          }
        }
      }
    }
    inc %w
  }

  ; Beginning of the master loop.
  while (!%master.loop) {
    var %master.loop = 1

    var %temp = $battle.check.switch(%ID)
    if ($iif(%temp,%temp,0) > 0) { return }

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Step ] ])) { goto step $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Step ] ]) }
    ; Generating order by moves...
    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID) }
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),2,59)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ] $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Reaction. ] $+ [ %n ] ]),1,59) }
    }

    var %p = 1

    ; Starting pokémon turn...
    sset [ [ B. ] $+ [ %ID ] $+ [ .Foes ] ] $iif($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ]),$iif($calc($battle.target(%ID,1).left + $battle.team(%ID,1).left) > 2,1,0),0)

    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),%p,58)) {

      var %temp = $battle.check.turn(%ID,%p)
      if (%temp == -1) { var %p = 0 }
      elseif (%temp) { return }

      inc %p
    }
    ; End of pokémon turn loop.

    uset [ [ B. ] $+ [ %ID ] $+ [ .Follow. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .HelpingHand. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Flinch. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .MagicCoat. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Snatch. ] $+ [ * ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Protected. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .TempMove. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Endured. ] $+ [ * ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Foes ] ]

    ; Starting the after-turn effects. Now, changing each-turn things.

    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) != Choice Band) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ] }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Yawn. ] $+ [ %n ] ]) == ON) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .YawnT. ] $+ [ %n ] ]) == ON) { uset [ [ B. ] $+ [ %ID ] $+ [ .YawnT. ] $+ [ %n ] ] }
          else {
            uset [ [ B. ] $+ [ %ID ] $+ [ .Yawn. ] $+ [ %n ] ] | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ] Sleep; $+ $rand(1,7) $+ ;0;1 | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ caiu no sono! | .echo $battle.fail(%ID,%n) }
          }
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Charge. ] $+ [ %n ] ])) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Charged. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Charge. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Charged. ] $+ [ %n ] ] }
          else { sset [ [ B. ] $+ [ %ID ] $+ [ .Charged. ] $+ [ %n ] ] ON }
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]) == Rollout) { sset [ [ B. ] $+ [ %ID ] $+ [ .TRollout. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .TRollout. ] $+ [ %n ] ]) + 1) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .TRollout. ] $+ [ %n ] ]) == 5) { uset [ [ B. ] $+ [ %ID ] $+ [ .TRollout. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]) == IceBall) { sset [ [ B. ] $+ [ %ID ] $+ [ .TIceBall. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .TIceBall. ] $+ [ %n ] ]) + 1) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .TIceBall. ] $+ [ %n ] ]) == 5) { uset [ [ B. ] $+ [ %ID ] $+ [ .TIceBall. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ]) == Bide) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ]) < 2) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está guardando energia! | sset [ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ]) + 1) }
          else { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .BideTurn. ] $+ [ %n ] ] }
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ]) == ON) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .UCont. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .UTCont. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ se acalmou! | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ] }
          else { sset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] Uproar }
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .UCont. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .UTCont. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .UCont. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .UCont. ] $+ [ %n ] ]) + 1) }
        }
        elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ]) == OFF) { uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Uproar. ] $+ [ %n ] ] }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Locked. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Locked. ] $+ [ %n ] ] } | else { uset [ [ B. ] $+ [ %ID ] $+ [ .LockOn. ] $+ [ %n ] ] } }
      }
    }

    ; Checking if have a fainted pokémon...
    var %n = 0 | while (%n < %loop) { inc %n | if ($battlefaint(%ID,%n)) { return } }

    ; Oh god, realize my wish please!
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ])) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ]) + 1)
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ]) == 3) {
          msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .WishPoke ] $+ [ %n ] ]) $lb $+ teve seu desejo realizado! | uset [ [ B. ] $+ [ %ID ] $+ [ .Wish ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .WishPoke ] $+ [ %n ] ]
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ já está com o HP cheio! } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) + $int($calc(($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 2)))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou energia! }
        }
      }
    }

    ; Checking the weather and applying the effects...
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Hail) {
        var %wt = $v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ]), %wt = $calc(%wt + 1)
        if (%wt == $v([ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Weather* ] ] | msgfight %ID $lb $+ O efeito do Hail acabou! | battle.c.weather %ID }
        else {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] %wt

          sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 1
          sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
          :step1
          while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Hail) {
            var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
            if (Ice !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
              sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16)))
              msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi acertado pela chuva de granizo!
              if ($battlefaint(%ID,%n) == $true) { return }
            }
          }
        }
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sandstorm) {
        var %wt = $v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ]), %wt = $calc(%wt + 1)
        if (%wt == $v([ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Weather* ] ] | msgfight %ID $lb $+ O efeito do Sandstorm acabou! | battle.c.weather %ID }
        else {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] %wt
          sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 2
          sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
          :step2
          while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sandstorm) {
            var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
            if (Ground !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (Rock !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && (Steel !isin $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
              sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16)))
              msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi acertado pela tempestade de areia!
              if ($battlefaint(%ID,%n) == $true) { return }
            }
          }
        }
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) {
        var %wt = $v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ]), %wt = $calc(%wt + 1)
        if (%wt == $v([ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Weather* ] ] | msgfight %ID $lb $+ O efeito do Rain Dance acabou! | battle.c.weather %ID }
        else { var %x = 1 | while (%x <= %loop) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %x ] ]) == Rain Dish) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %x ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ])) { msgfight %ID $bb $+ $+(:player,%x,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $lb $+ recuperou energia com $bb $+ Rain Dish $+ $lb $+ ! | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ]) + ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %x ] ]) / 16))) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %x ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %x ] ]) } } | inc %x } }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] %wt
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) {
        var %wt = $v([ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ]), %wt = $calc(%wt + 1)
        if (%wt == $v([ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Weather* ] ] | msgfight %ID $lb $+ O efeito do Sunny Day acabou! | battle.c.weather %ID }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Weather. ] $+ [ Turns ] ] %wt
      }
    }

    ; Your skin... Is it shed?!
    var %n = 0 | while (%n < %loop) {
      inc %n | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Shed Skin) { var %rand = $rand(1,100) | if (%rand <= 30) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se do status effect! | uset [ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ] | var %st = 0 } }
    }

    ; Let's boost its speed!
    var %x = 1 | while (%x <= %loop) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %x ] ]) == Speed Boost) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ])) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .SpeedBoost. ] $+ [ %x ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .SpeedBoost. ] $+ [ %x ] ] }
        elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %x ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %x ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %x ] ]) + 1) | msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $lb $+ aumentou velocidade com Speed Boost! }
      }
      elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .SpeedBoost. ] $+ [ %x ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .SpeedBoost. ] $+ [ %x ] ] }
      inc %x
    }

    ; Oh, Ingrain? Ok, then heal 1/16 HP!
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Ingrain. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        var %rec = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16)), %rec = $iif(%rec,%rec,1) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc(%rec + $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se com Ingrain!
      }
    }

    ; If some of pokémon have leftovers, heal 1/16 HP!
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Leftovers) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        var %rec = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16)), %rec = $iif(%rec,%rec,1) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc(%rec + $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) } | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou-se com Leftovers!
      }
    }

    ; If any pokémon have some berry, let's do the effect now!
    var %n = 0, %hb = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])) {
        var %hold = $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])
        if ($gettok(%hold,2,32) == Berry) {
          var %x1 = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 2)), %x2 = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 3)), %x3 = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 4)), %x4 = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])
          if (%x4 <= %x3) {
            if (%hold == Liechi Berry) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Ganlon Berry) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Salac Berry) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Petaya Berry) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Apicot Berry) { if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Lansat Berry) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .UpCritical. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .UpCritical. ] $+ [ %n ] ] ON | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) para se apressar! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 } }
            if (%hold == Starf Berry) {
              var %x = $rand(1,5)
              if (%x == 1) {
                if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
              }
              elseif (%x == 2) {
                if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
              }
              elseif (%x == 3) {
                if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
              }
              elseif (%x == 4) {
                if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
              }
              else {
                if ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SDef. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Def. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou defesa! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou velocidade! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
                elseif ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) <= 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.SAtk. ] $+ [ %n ] ]) + 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ usou $v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) e aumentou ataque especial! | uset [ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ] | var %hb = 1 }
              }
            }
          }
        }
        if (%hb) {
          var %hb = 0 | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Rental ] ])) { if (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Hold 0 } }
          var %t = $iif($battle.team(%ID,%n),$battle.side(%n),%n), %t1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ]) | if (%t1) { var %t1 = %t1 $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) %hold } | else { var %t1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) %hold }
          sset [ [ B. ] $+ [ %ID ] $+ [ .Item: ] $+ [ %t ] ] %t1
        }
      }
    }

    ; And if seeded, let's suck it's health!

    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 3
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step3
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
        var %suchhp = $round.up($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) * 0.125)), %nf = $v([ [ B. ] $+ [ %ID ] $+ [ .Seeded. ] $+ [ %n ] ])
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %nf ] ])) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %suchhp)) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 }
          sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %nf ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %nf ] ]) + %suchhp) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %nf ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %nf ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %nf ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %nf ] ]) }
          msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ teve sua energia sugada pelas sementes!
          if ($battlefaint(%ID,%n) == $true) { return }
        }
      }
    }

    ; Decreasing HP in bad conditions...
    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 4
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step4
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %w = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      var %st = $v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %w ] ])
      if (%st == Burn) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) > 0) {
        var %dano = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %w ] ]) / 8)
        sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) - %dano)) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ] 0 }
        msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ se machucou na queimadura!
        if ($battlefaint(%ID,%w) == $true) { return }
      }
      if ($gettok(%st,1,59) == Poison) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) > 0) {
        if ($gettok(%st,2,59)) {
          sset [ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %w ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %w ] ]) + 1)
          var %poison = $v([ [ B. ] $+ [ %ID ] $+ [ .Poison. ] $+ [ %w ] ]), %dano = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %w ] ]) * (%poison * (1 / 16)))
        }
        else { var %dano = $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %w ] ]) / 8) }
        sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ] $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) - %dano)) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %w ] ] 0 }
        msgfight %ID $bb $+ $+(:player,%w,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %w ] ]) $lb $+ se machucou no veneno!
        if ($battlefaint(%ID,%w) == $true) { return }
      }
    }

    ; Turning off some barriers and becoming confused with some continuos moves...
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .TCont. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Cont. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .TCont. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %n ] ]) != ON) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) != Own Tempo) { sset [ [ B. ] $+ [ %ID ] $+ [ .Confuse. ] $+ [ %n ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .ConfuseTurns. ] $+ [ %n ] ] $rand(1,4) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ ficou confuso! | uset [ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %n ] ] } } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ %n ] ]) - 1) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ proteção cancelada! } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ %n ] ]) - 1) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ tela de luz cancelada! } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ %n ] ]) - 1) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ névoa cancelada! } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ %n ] ]) - 1) | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ %n ] ])) { uset [ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ %n ] ] | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ guarda cancelada! } }
    }

    ; If you sleep, you may have nightmares...

    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 5
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step5
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Nightmare. ] $+ [ %n ] ])) && ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ]),1,59) == Sleep) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está sofrendo com os pesadelos! | var %lhp = $round.up($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 4)), %lhp = $iif(%lhp > $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),%lhp) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %lhp) | if ($battlefaint(%ID,%n) == $true) { return } }
    }

    ; Afflict cursed pokémon!
    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 6
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step6
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Cursed. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ é aflingido pela maldição! | var %lhp = $round.up($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 4)), %lhp = $iif(%lhp > $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),%lhp) | sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %lhp) | if ($battlefaint(%ID,%n) == $true) { return } }
    }

    ; Applying damage on continuos moves...
    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 7
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step7
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .VTurn. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .VTurn. ] $+ [ %n ] ]) + 1)
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .VTurn. ] $+ [ %n ] ]) == $v([ [ B. ] $+ [ %ID ] $+ [ .VTurns. ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está livre do $v([ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ]) $+ ! | uset [ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ] }
        else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) / 16))) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi machucado pelo $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Vortex. ] $+ [ %n ] ]),1,58) $+ ! | if ($battlefaint(%ID,%n) == $true) { return } }
      }
    }

    ; And there's a retarded move being effective!
    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 8
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step8
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .DTurn ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .DTurn ] $+ [ %n ] ]) + 1)
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .DTurn ] $+ [ %n ] ]) == 3) {
          var %move = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]),1,58), %power = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]),2,58), %t = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]),3,58), %atkstat = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]),4,58), %acc = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]),5,58) | uset [ [ B. ] $+ [ %ID ] $+ [ .DTurn ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Destiny ] $+ [ %n ] ]
          var %acc = $int($calc(%acc * $istat(%ID,%n,EV))), %rand = $rand(1,100)
          msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recebeu o golpe $bb $+ %move $+ $lb $+ !
          if ($findtok(Fly:Bounce:Dive:Dig,$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %alvo ] ]),0,58)) { var %acc = 0 }
          if (%rand > %acc) { msgfight %ID $lb $+ Mas o golpe falhou! }
          else {
            var %def = $istat(%ID,%n,DEF)
            var %sdef = $istat(%ID,%n,SDEF)
            if (%t == Normal) { var %defstat = %def } | else { var %defstat = %sdef }
            var %rdamage = $int($calc(((2 * $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ $iif(%n == 1,2,1) ] ]) / 5 + 2) * %atkstat * %power / %defstat) / 50 + 2)), %fdamage = $int($calc(%rdamage * $rand(217,255) / 255)), %dano = %fdamage
            if (%dano <= 0) { var %dano = 1 }
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ])) {
              sset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]) - %dano)
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]) <= 0) {
                uset [ [ B. ] $+ [ %ID ] $+ [ .Substitute. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .SubstituteHP. ] $+ [ %n ] ]
                msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ teve seu substituto quebrado!
              }
            }
            else { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) - %dano) | if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 } | if ($battlefaint(%ID,%n) == $true) { return } }
          }
        }
      }
    }

    ; And now, let's sing the death, the Perish Song!
    sset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ] 9
    sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $battle.order(%ID)
    :step9
    while ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)) {
      var %n = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] $deltok($v([ [ B. ] $+ [ %ID ] $+ [ .Order ] ]),1,58)
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ]) - 1) | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ contagem caiu para $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ]) $+ $lb $+ ! | if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Perish. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 | if ($battlefaint(%ID,%n) == $true) { return } } }
    }

    ; Please, get an encore.

    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .EncoreTurn. ] $+ [ %n ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .EncoreTurn. ] $+ [ %n ] ]) + 1)
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .EncoreTurn. ] $+ [ %n ] ]) > $v([ [ B. ] $+ [ %ID ] $+ [ .EncoreTurns. ] $+ [ %n ] ])) {
          uset [ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %n ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Encore*. ] $+ [ %n ] ]
          msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ está livre do Encore!
        }
      }
    }

    ; Should I disable you?
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ])) {
        var %d = $v([ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ]), %x = 0, %y = $gettok(%d,0,58)
        while (%x < %y) {
          inc %x | var %t = $gettok(%d,%x,58), %t2 = $gettok(%t,3,59), %t2 = $calc(%t2 + 1), %t3 = $gettok(%t,1,59)
          if (%t2 == $gettok(%t,2,59)) {
            var %t4 = $remtok(%d,%t,1,58) | if (%t4) { sset [ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ] %t4 | if (%x == 1) && (%y > 1) { var %x = $calc(%x - 1), %y = $calc(%y - 1), %d = %t4 } } | else { uset [ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ] }
            msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ recuperou seu golpe %t3 $+ !
          }
          else { sset [ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ] $reptok(%d,%t,%t3 $+ ; $+ $gettok(%t,2,59) $+ ; $+ %t2,58) }
        }
      }
    }

    var %x = 1 | while (%x <= %loop) { sset [ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %x ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %x ] ]) + 1) | inc %x }

    ; Setting the names...
    ; var %pkname1 = $len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ])), %pkname2 = $len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ]))
    ; if (%pkname1 > %pkname2) { var %pkname2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ]) $+ 15 $+ $str(.,$calc($len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ])) - $len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ])))), %pkname1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ]) }
    ; else { var %pkname1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ]) $+ 15 $+ $str(.,$calc($len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ])) - $len($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ])))), %pkname2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ]) }

    ; Showing the battle status...
    sset [ [ B. ] $+ [ %ID ] $+ [ .View ] ] $battle.show(%ID)
    var %pkname1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ]), %pkname2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ])
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) {
      var %pkname3 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 3 ] ]), %pkname4 = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 4 ] ]), %n = 0
      if ($len(%pkname1) > $len(%pkname3)) { var %ns3 = $calc($len(%pkname1) - $len(%pkname3)), %ns1 = 0 } | elseif ($len(%pkname1) < $len(%pkname3)) { var %ns1 = $calc($len(%pkname3) - $len(%pkname1)), %ns3 = 0 } | else { var %ns1 = 0, %ns3 = 0 }
      if ($len(%pkname2) > $len(%pkname4)) { var %ns4 = $calc($len(%pkname2) - $len(%pkname4)), %ns2 = 0 } | elseif ($len(%pkname2) < $len(%pkname4)) { var %ns2 = $calc($len(%pkname4) - $len(%pkname2)), %ns4 = 0 } | else { var %ns2 = 0, %ns4 = 0 }
      while (%n < 4) {
        inc %n | var %m = $calc(%n + 1)
        var %p = ( $+ $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) / $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) * 100)) $+ $chr(37) $+ ), %x = $bb $+ %pkname [ $+ [ %n ] ] $+ $lb $+ : $str($chr(2) $chr(2),%ns [ $+ [ %n ] ]) $+ $iif(%ns [ $+ [ %n ] ],, $+ $lb $+) $+ HP $+ $chr(91) $+ $barra($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]),10,14) $+ $lb $+ $chr(93) [p $+ $battle.side(%n) $+ $chr(93) ( $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ / $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) $+ ) [/p $+ $battle.side(%n) $+ $chr(93) [p $+ $rvs(%n) $+ $chr(93) %p [/p $+ $rvs(%n) $+ $chr(93) [pw] %p [/pw]
        var %p = ( $+ $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %m ] ]) / $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %m ] ]) * 100)) $+ $chr(37) $+ )
        msgfight %ID %x $chr(47) $bb $+ %pkname [ $+ [ %m ] ] $+ $lb $+ : $str($chr(2) $chr(2),%ns [ $+ [ %m ] ]) $+ $iif(%ns [ $+ [ %m ] ],, $+ $lb $+) $+ HP $+ $chr(91) $+ $barra($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %m ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %m ] ]),10,14) $+ $lb $+ $chr(93) [p $+ $battle.side(%m) $+ $chr(93) ( $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %m ] ]) $+ / $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %m ] ]) $+ ) [/p $+ $battle.side(%m) $+ $chr(93) [p $+ $rvs(%m) $+ $chr(93) %p [/p $+ $rvs(%m) $+ $chr(93) [pw] %p [/pw]
        inc %n
      }
    }
    else {
      if ($len(%pkname1) > $len(%pkname2)) { var %ns2 = $calc($len(%pkname1) - $len(%pkname2)), %ns1 = 0 }
      elseif ($len(%pkname1) < $len(%pkname2)) { var %ns1 = $calc($len(%pkname2) - $len(%pkname1)), %ns2 = 0 }
      else { var %ns1 = 0, %ns2 = 0 }
      var %n = 1, %p = ( $+ $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) / $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) * 100)) $+ $chr(37) $+ ) | msgfight %ID $bb $+ %pkname [ $+ [ %n ] ] $+ $lb $+ : $str($chr(2) $chr(2),%ns [ $+ [ %n ] ]) $+ $iif(%ns [ $+ [ %n ] ],, $+ $lb $+) $+ HP $+ $chr(91) $+ $barra($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]),10,14) $+ $lb $+ $chr(93) [p1] ( $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ / $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) $+ ) [/p1] [p2] %p [/p2] [pw] %p [/pw]
      var %n = 2, %p = ( $+ $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) / $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) * 100)) $+ $chr(37) $+ ) | msgfight %ID $bb $+ %pkname [ $+ [ %n ] ] $+ $lb $+ : $str($chr(2) $chr(2),%ns [ $+ [ %n ] ]) $+ $iif(%ns [ $+ [ %n ] ],, $+ $lb $+) $+ HP $+ $chr(91) $+ $barra($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]),10,14) $+ $lb $+ $chr(93) [p2] ( $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ / $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ]) $+ ) [/p2] [p1] %p [/p1] [pw] %p [/pw]
    }

    ; Ending a turn.

    uset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ * ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Order ] ] | uset [ [ B. ] $+ [ %ID ] $+ [ .Step ] ]
    var %x1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ 1 ] ]), %x2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ 2 ] ])
    uset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ * ] ]

    var %w = 1 | while (%w <= %loop) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %w ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %w ] ]) } | else { uset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %w ] ] } | inc %w }
    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
          if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])) {
            if (!$v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) || ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) == No!) {
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ])) { randmove %ID %n | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } | else { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) != Struggle) { IA %ID %n } | else { randmove %ID %n | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } }
            }
          }
        }
        else { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Struggle | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] %n }
      }
    }

    ; var %w = 0, %r = 0 | while (%w < %loop) {
    ;  inc %w | var %l = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ]), %m = $rmoves(%ID,%w)
    ;  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %w ] ])) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %w ] ])) {
    ;    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Continuos. ] $+ [ %w ] ])) {
    ;      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %w ] ])) { var %l = $iif(%l == Struggle,$v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %w ] ]),%l) | if ($findtok(%m,%l,0,58)) { var %m = $v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %w ] ]) } | else { var %m = Struggle } }
    ;      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %w ] ])) { var %f = $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %w ] ]) | if (%f) { var %m = $remtok(%m,%f,1,58) } }
    ;      if (%m) && ($gettok(%m,0,58) == 1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ] %m }
    ;      elseif (!%m) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %w ] ] Struggle | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %w ] ] $rvs(%w) }
    ;    }
    ;  }
    ; }

    var %n = 0 | while (%n < %loop) {
      inc %n
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) > 0) {
        if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) && ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) == Ok!) {
            if ($battle.player(%ID,%n) == %n) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. }
            elseif ($battle.player(%ID,%n) != %n) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ $battle.side(%n) ] ]) <= 0) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ $battle.side(%n) ] ])) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. } }
          }
        }
        else {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])) { if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } }
          else {
            if ($battle.player(%ID,%n) == %n) { if ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) == Ok!) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. } }
            elseif ($battle.player(%ID,%n) != %n) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ $battle.side(%n) ] ]) <= 0) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ $battle.side(%n) ] ])) { if ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) == Ok!) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. } } }
          }
        }
      }
    }

    var %n = 0, %r = 0 | while (%n < %loop) { inc %n | if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ])) { inc %r } }
    if (%r == %loop) { var %switch = $battle.order(%ID).c | if (%switch) { var %t.switch = %switch } | var %master.loop }
    else { .timerEndTurn $+ %ID 1 60 /battle.turn %ID }

  }
  ; End of the master loop.

}
