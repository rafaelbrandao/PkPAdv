alias unown.code {
  var %n = $1, %x = 1
  while ($dados(%n,Team,%x)) {
    var %u = $dados(%n,Team,%x)
    if ($gettok(%u,1,46) == Unown) { if ($gettok(%u,2,46)) { var %p = $gettok(%u,2,46) } | else { var %p = A } }
    else { var %p = * }
    if (%r) { var %r = %r $+ %p } | else { var %r = %p }
    inc %x
  }
  return $arrange(%r,42,6)
}
alias premio {
  var %f = pkp\status.ini, %g = $readini(%f,Prize,GameType), %t = $readini(%f,Prize,Turn) | inc %t
  writeini %f Prize Turn %t
  if (%g == 3) {
    if (%t > $readini(%f,Prize,Times)) {
      var %s = $readini(%f,Prize,Score), %s = $sorttok(%s,58,r)
      if ($gettok(%s,1,58)) {
        var %hscore = $gettok($gettok(%s,1,58),1,32), %total = $wildtok(%s,%hscore *,0,58), %winner = $gettok($wildtok(%s,%hscore *,$rand(1,%total),58),2,32)
        premio.add %winner | sendamsg $me $cc $+ $dados(%winner,Info,Nick) $ct $+ foi o vencedor da premiação com $cc $+ %hscore $ct $+ pontos! Parabéns!
      }
      premio.clear
    }
  }
  if (%g == 4) { premio.clear }
}
alias premio.clear {
  var %f = pkp\status.ini
  if ($readini(%f,Prize,Active)) && ($readini(%f,Prize,GameType) == 3) {
    var %s = $readini(%f,Prize,Score), %x = 1 | while ($gettok(%s,%x,58)) { remini pkp\cadastros\ $+ $gettok($gettok(%s,%x,58),2,32) $+ .ini Info Lock | inc %x }
  }
  unset %premio.*
  remini %f Prize Active
  remini %f Prize Score
  remini %f Prize Times
  remini %f Prize Range
  remini %f Prize Faces
  remini %f Prize Turn
  .timerPREMIO off
}
alias premio.add {
  var %t = $prize(type), %nick = $dados($1,Info,Nick)
  if (!%nick) { return }
  if (%t == Pokemon) {
    var %pk = $prize, %lv = $iif($prize(par,Level),$prize(par,Level),5), %par = $prize(par), %x = 1
    addpoke %nick %pk %lv
    while ($gettok(%par,%x,172)) { writeini pkp\cadastros\ $+ %nick $+ .ini %pk $gettok(%par,%x,172) $prize(par,$gettok(%par,%x,172)) | inc %x }
    recalc %nick %pk | wlog user %nick Received pokemon %pk from special event.
  }
  elseif (%t == Premium) { premium add %nick $prize | wlog user %nick Received a premium account of $prize days from special event. }
  elseif (%t == Dinheiro) { var %d = $dados(%nick,Info,Money) | writeini pkp\cadastros\ $+ %nick $+ .ini Info Money $calc(%d + $prize) | wlog user %nick Received $chr(36) $+ $getmoney($prize) from special event. }
  elseif (%t == Milhagem) { var %d = $rini(cadastros,%nick,Info,Milhagem) | writeini pkp\cadastros\ $+ %nick $+ .ini Info Milhagem $calc(%d + $calc($prize * 600)) | wlog user %nick Received $prize pokemiles from special event. }
}
alias prize {
  var %f = pkp\status.ini
  if ($1 == type) { return $readini(%f,Prize,Type) }
  elseif ($1 == par) {
    if ($2) {
      var %a = $gettok($readini(%f,Prize,Prize),2,172)
      return $gettok($wildtok(%a,$2 $+ =*,1,59),2,61)
    }
    else {
      var %a = $gettok($readini(%f,Prize,Prize),2,172), %r, %x = 1
      while ($gettok(%a,%x,59)) { if (%r == $null) { var %r = $gettok($gettok(%a,%x,59),1,61) } | else { var %r = %r $+ ¬ $+ $gettok($gettok(%a,%x,59),1,61) } | inc %x }
      if ($2 == $null) { return %r }
      else { return $gettok(%r,0,172) }
    }
  }
  else { return $gettok($readini(%f,Prize,Prize),1,172) }
}
alias status.msg {
  var %n = $dados($1,Info,Nick)
  if (!$dados(%n,Info,Hide)) {
    if ($2 == JOIN) { .sendamsg %n $coloracc(%n) $+ %n $ct $+ entrou no bot. }
    elseif ($2 == PART) { .sendamsg %n $coloracc(%n) $+ %n $ct $+ saiu do bot. }
  }
}
alias else.null { if (!$1-) { return 0 } | else { return $1- } }
alias tmlist { window -ek @Tmlist }
ON *:INPUT:@TMlist: {
  if ($left($1,1) == /) { return }
  if ($2 == -) {
    if (%gettm == ON) {
      if (%tms) { set %tms %tms TM $+ $1 }
      else { set %tms TM $+ $1 }

      if (%gethm == ON) {
        var %tk = $gettok($4-,0,32), %x = 1
        while ($gettok($4-,%x,32)) {
          if ($gettok($4-,%x,32) == -) {
            if (%hms) { set %hms %hms HM $+ $gettok($4-,$calc(%x - 1),32) }
            else { set %hms HM $+ $gettok($4-,$calc(%x - 1),32) }
          }
          inc %x
        }
      }

    }
    else { set %pktemp $3 }
  }
  if (%pktemp) {
    if ($2 == group:) { set %egggroup $remove($3-,$chr(32)) }
    if ($2- == Steps to hatch from egg) { set %steps $1 }
    if ($1 == TMs:) { set %gettm ON } | if ($2 == HMs:) { set %gethm ON }
  }

  if (= isin $1) {
    write egggroup.txt if ( $+ $chr(36) $+ 1 == %pktemp $+ ) $chr(123) var $chr(37) $+ group = $replace(%egggroup,/,$chr(32)) $+ , $chr(37) $+ steps = %steps $chr(125)
    var %r = $sorttok(%tms,32) $sorttok(%hms,32)
    if (%r) { writeini database.ini Techniques %pktemp %r }
    unset %pktemp %egggroup %steps %gettm %gethm %hms %tms
  }

}
alias moveset { window -ek @MoveSet }
ON *:INPUT:@MoveSet: {
  if ($left($1,1) == /) { return }
  if ($1 == .pk) { set %poketemp $2 | unset %movesets | echo Agora é $2 $+ . | return }
  if ($1 == .ok) { write pkp\moveset.txt %poketemp %movesets | echo Agora digite .pk <Poke> para ir pro proximo. | return }
  var %n = 1 | tokenize 32 $1-
  while (%n < $gettok($1-,0,32)) {
    var %x = [ $ [ $+ [ %n ] ] ]
    if ($left(%x,1) == $chr(40)) && ($right(%x,1) == $chr(41)) {
      tokenize 32 $remove($1-,%x) | var %n = 0
    }
    if (%x == -) {
      tokenize 32 $remove($1-,$chr(32) $+ %x) | var %n = 0
    }
    inc %n
  }
  tokenize 32 $remove($1-,$chr(32) $+ Level)
  if (!%movesets) { set %movesets $replace($1-,N/A,1) }
  else { set %movesets %movesets $+ , $replace($1-,N/A,1) }
}
alias check.move {
  var %pk = $1, %lv = $2, %n = 0
  var %moves = $read(pkp\moveset.txt, s, %pk), %x = $gettok(%moves,0,44), %y = 0
  while (%y < %x) {
    inc %y | var %move = $gettok(%moves,%y,44), %learn = $gettok(%move,$gettok(%move,0,32),32), %move = $move($remchar($remove(%move,$chr(32) $+ %learn)))
    if (%move) {
      if (%learn == %lv) && (!$findtok(%r,%move,0,58)) { if (!%r) { var %r = %move } | else { var %r = %r $+ : $+ %move } }
    }
  }
  return %r
}
alias applymoves {
  var %nick = $1, %pk = $2, %lv = $3
  var %moves = $read(pkp\moveset.txt, s, %pk), %x = $gettok(%moves,0,44), %y = 0, %r = 0
  while (%y < %x) {
    inc %y | var %move = $gettok(%moves,%y,44), %learn = $gettok(%move,$gettok(%move,0,32),32), %move = $move($remchar($remove(%move,$chr(32) $+ %learn)))
    if (%learn <= %lv) {
      if (!$findtok(%r,%move,0,58)) { if (%r) { if ($gettok(%r,0,58) < 4) { var %r = %r $+ : $+ %move } | else { var %r = $gettok(%r,2-4,58) $+ : $+ %move } } | else { var %r = %move } }
    }
  }
  if (%r) { var %x = 1 | while ($gettok(%r,%x,58)) { addmove %nick %pk $gettok(%r,%x,58) | inc %x } }
}
alias addmove {
  var %move1 = $rini(cadastros,$1,$2,Move1), %move2 = $rini(cadastros,$1,$2,Move2), %move3 = $rini(cadastros,$1,$2,Move3), %move4 = $rini(cadastros,$1,$2,Move4), %x = 0
  while (%x < 4) { inc %x | var %y = %move [ $+ [ %x ] ] | if (!%y) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ %x ] ] $3- | goto end } }
  remini pkp\cadastros\ $+ $1 $+ .ini $2 Move1 | var %x = 1
  while (%x < 4) {
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ %x ] ] $rini(cadastros,$1,$2,Move [ $+ [ $calc(%x + 1) ] ])
    remini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ $calc(%x + 1) ] ]
    inc %x
  }
  writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ %x ] ] $3-
  :end
}
alias moverem {
  var %move1 = $rini(cadastros,$1,$2,Move1), %move2 = $rini(cadastros,$1,$2,Move2), %move3 = $rini(cadastros,$1,$2,Move3), %move4 = $rini(cadastros,$1,$2,Move4), %x = 0, %t = 0
  while (%x < 4) { inc %x | var %y = %move [ $+ [ %x ] ] | if (%y) { inc %t } | if (%y == $3-) { var %n = %x } }
  if (!%n) { return }
  remini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ %n ] ] | var %x = %n
  while (%x < %t) {
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ %x ] ] $rini(cadastros,$1,$2,Move [ $+ [ $calc(%x + 1) ] ])
    remini pkp\cadastros\ $+ $1 $+ .ini $2 Move [ $+ [ $calc(%x + 1) ] ]
    inc %x
  }
}
alias n.rand {
  return $rand(1,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9)
}
alias clear.useless.cad {
  var %t = 1
  while ($findfile(pkp\cadastros\,*.ini,%t)) {
    var %nick = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini)
    if ($pontuacao(%nick) < 400) {
      echo 4 %nick
      .remove pkp\cadastros\ $+ %nick $+ .ini
      if (%nick) {
        if ($exists(PkP\Box\ $+ %nick $+ \)) { var %d = $findfile(PkP\Box\ $+ %nick $+ \,*.*,0,.remove $1-) | .rmdir PkP\Box\ $+ %nick $+ \ }
      }
    }
    else { echo 2 %nick | inc %t }
  }
}

alias update5.all.info {
  var %tick = $ticks
  echo 2Você inicializou um processo de atualização. Aguarde.
  var %tfiles = $findfile(pkp\cadastros\,*.ini,0), %t = 0
  while (%t < %tfiles) {
    inc %t
    var %nickatual = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini)
    var %balls = $rini(cadastros,%nickatual,Item,Ball)
    var %pkball = $matchtok(%balls,Poké Ball,1,58)
    if (%pkball) {
      var %pos = $findtok(%balls,%pkball,58)
      var %num = $gettok(%pkball,-1,32)
      var %pkball = $puttok(%balls,Poke Ball %num,%pos,58)

      writeini pkp\cadastros\ $+ %nickatual $+ .ini Item Ball %pkball
    }
  }
  echo 2Finalizado.
}

alias update4.all.info {
  var %tick = $ticks
  echo 2Você inicializou um processo de atualização. Aguarde.
  var %tfiles = $findfile(pkp\cadastros\,*.ini,0), %t = 0
  while (%t < %tfiles) {
    inc %t
    var %nickatual = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini)
    var %itens = $rini(cadastros,%nickatual,Info,Item)
    var %x = 1 | while ($gettok(%itens,%x,58)) {
      var %item = $gettok(%itens,%x,58), %n = $gettok(%item,0,32), %i = $gettok(%item,1- $+ $calc(%n - 1),32), %qnt = $gettok(%item,%n,32), %desc = $readini(pkp\database.ini,Item,$replace(%i,$chr(32),_))
      if ($gettok(%desc,2,172)) { var %type = $gettok(%desc,2,172) }
      else { var %type = $gettok(%desc,1,172), %type = $gettok(%type,2,42) }
      if ($dados(%nickatual,Item,%type)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Item %type $dados(%nickatual,Item,%type) $+ : $+ %i %qnt }
      else { writeini pkp\cadastros\ $+ %nickatual $+ .ini Item %type %i %qnt }
      inc %x
    }
    remini pkp\cadastros\ $+ %nickatual $+ .ini Info Item
  }
  echo 2Finalizado.
}
alias update3.all.info {
  var %tick = $ticks
  echo 2Você inicializou um processo de atualização. Aguarde.
  while ($findfile(pkp\box\,*.ini,1)) {
    var %nickatual = $remove($nopath($findfile(pkp\box\,*.ini,1)),.ini)
    if (!$rini(cadastros,%nickatual,Info,Nick)) { goto end }
    mkdir pkp\box\ $+ %nickatual $+ \
    var %n = 1
    while (%n) {
      var %t = $ini(pkp\box\ $+ %nickatual $+ .ini,%n)
      if (%t) {
        if (%t != Stats) {
          var %box = $remove(%t,Box)
          writeini pkp\box\ $+ %nickatual $+ \ $+ %box $+ .ini Info Size $rini(box,%nickatual,Stats,Box $+ %box)
          writeini pkp\box\ $+ %nickatual $+ \ $+ %box $+ .ini Info Link Hoenn
          if ($rini(box,%nickatual,Box $+ %box,Total)) {
            var %y = 1 | while ($ini(pkp\box\ $+ %nickatual $+ .ini,Box $+ %box,%y)) {
              var %p = $ini(pkp\box\ $+ %nickatual $+ .ini,Box $+ %box,%y)
              if (%p != Total) && (%p != Names) { writeini pkp\box\ $+ %nickatual $+ \ $+ %box $+ .ini Box %p $rini(box,%nickatual,Box $+ %box,%p) }
              inc %y
            }
          }
        }
        inc %n
      }
      else { var %n = 0 }
    }
    .remove pkp\box\ $+ %nickatual $+ .ini
  }
  :end
  echo 2Processo finalizado.
}
alias update.all.info {
  var %tick = $ticks
  echo 2Você inicializou um processo de atualização. Aguarde.
  var %tfiles = $findfile(pkp\cadastros\,*.ini,0), %t = 0, %ID = 1000
  while (%t < %tfiles) {
    inc %t
    var %nickatual = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini)
    if ($npc(%nickatual)) {
      while ($rini(npc,npc,%ID,Name)) { inc %ID }
      if ($rini(npc,npc,ID,%nickatual)) { writeini pkp\npc\npc.ini ID %nickatual $rini(npc,npc,ID,%nickatual) $+ : $+ %ID } | else { writeini pkp\npc\npc.ini ID %nickatual %ID }
      writeini pkp\npc\npc.ini %ID Name %nickatual
      if ($readini(pkp\status.ini,Outfit,%nickatual)) { writeini pkp\npc\npc.ini %ID Outfit $base($readini(pkp\status.ini,Outfit,%nickatual),10,10,2) } | else { writeini pkp\npc\npc.ini %ID Outfit 00 }
      var %y = 1 | while ($rini(cadastros,%nickatual,Team,%y)) { inc %y } | var %y = $calc(%y - 1)
      writeini pkp\npc\npc.ini %ID Team %y
      var %x = 0 | while (%x < %y) { inc %x | writeini pkp\npc\npc.ini %ID %x $getteam(%nickatual,$rini(cadastros,%nickatual,Team,%x)) }
      echo 1Processando... 2 $+ %nickatual 1(4x1)
    }
    else {
      if ($readini(pkp\top.ini,Top,%nickatual)) && ($readini(pkp\top.ini,Top,%nickatual) <= 400) { echo 1Processando... 2 $+ %nickatual 1(4x1) }
      else {
        echo 1Processando... 4 $+ %nickatual
        writeini pkp\cadastros\ $+ %nickatual $+ .ini Info Start Hoenn
        writeini pkp\cadastros\ $+ %nickatual $+ .ini Info Region Hoenn
        if ($rini(cadastros,%nickatual,Info,Visited)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Hoenn Visited $rini(cadastros,%nickatual,Info,Visited) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Visited }
        if ($rini(cadastros,%nickatual,Info,Badges)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Hoenn Badges $rini(cadastros,%nickatual,Info,Badges) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Badges }
        if ($rini(cadastros,%nickatual,Info,Score)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Hoenn Score $rini(cadastros,%nickatual,Info,Score) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Score }
        if ($rini(cadastros,%nickatual,Info,Milhagem)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Info Milhagem $calc($rini(cadastros,%nickatual,Info,Milhagem) * 600) }
        var %x = 0, %r = 0 | while (%x < 17) { inc %x | if (%r) { var %r = %r $+ : $+ $iif($rini(cadastros,%nickatual,Perfil,%x) == ON,1,0) } | else { var %r = $iif($rini(cadastros,%nickatual,Perfil,%x) == ON,1,0) } }
        writeini pkp\cadastros\ $+ %nickatual $+ .ini Info Perfil %r $+ :0:0:0:0:0:0:0:0:0:0:0:0:0 | remini pkp\cadastros\ $+ %nickatual $+ .ini Perfil
        writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Register $rini(cadastros,%nickatual,Info,Register) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Register
        remini pkp\cadastros\ $+ %nickatual $+ .ini Info Matt
        if ($rini(cadastros,%nickatual,Info,Report)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Report $rini(cadastros,%nickatual,Info,Report) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Report }
        if ($rini(cadastros,%nickatual,Info,Market)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Market $rini(cadastros,%nickatual,Info,Market) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Market }
        if ($rini(cadastros,%nickatual,Info,Safari)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Safari $rini(cadastros,%nickatual,Info,Safari) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Safari }
        if ($rini(cadastros,%nickatual,Info,Daycare)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Daycare $rini(cadastros,%nickatual,Info,Daycare) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Daycare }
        if ($rini(cadastros,%nickatual,Info,Goto)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Goto $rini(cadastros,%nickatual,Info,Goto) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Goto }
        if ($rini(cadastros,%nickatual,Info,Wild)) { writeini pkp\cadastros\ $+ %nickatual $+ .ini Time Wild $rini(cadastros,%nickatual,Info,Wild) | remini pkp\cadastros\ $+ %nickatual $+ .ini Info Wild }
      }
    }
  }
  echo 4Sistema atualizado com sucesso1! $int($calc(($ticks - %tick)  / 60)) segundos
}
alias update2.all.info {
  var %tick = $ticks
  echo 2Você inicializou um processo de atualização. Aguarde.
  var %tfiles = $findfile(pkp\cadastros\,*.ini,0), %t = 1
  while ($findfile(pkp\cadastros\,*.ini,%t)) {
    var %nickatual = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini)
    if ($npc(%nickatual)) { .remove pkp\cadastros\ $+ %nickatual $+ .ini }
    else { if ($readini(pkp\top.ini,Top,%nickatual)) && ($readini(pkp\top.ini,Top,%nickatual) <= 400) { .remove pkp\cadastros\ $+ %nickatual $+ .ini } | else { inc %t } }
  }
  echo 4Sistema atualizado com sucesso1! $int($calc(($ticks - %tick)  / 3600)) segundos
}

alias r.item {
  var %itens = $rini(cadastros,$1,Info,Item)
  if (%itens) {
    var %x = 0, %y = $gettok(%itens,0,58)
    while (%x < %y) {
      inc %x | if (!$findtok(%rlist,$gettok(%itens,%x,58),0,58)) {
        if (%rlist) { var %rlist = %rlist $+ : $+ $gettok(%itens,%x,58) } | else { var %rlist = $gettok(%itens,%x,58) }
        if (%r) { var %t = $findtok(%itens,$gettok(%itens,%x,58),0,58)), %r = %r $+ : $+ $gettok(%itens,%x,58) %t }
        else { var %t = $findtok(%itens,$gettok(%itens,%x,58),0,58)), %r = $gettok(%itens,%x,58) %t }
      }
    }
    return %r
  }
}

alias rand² {
  :back
  var %1 = $rand(0,1), %2 = $rand(0,50), %3 = $rand(1,5), %4 = $rand(0,32), %5 = $rand(0,64)
  var %r = $int($calc((200 * %1) + (%2 * %3) - (100 * (%1 / 2)) - %4 + %5))
  if (%r > 255) || (%r < 0) { goto back }
  return %r
}
alias corner {
  var %r = 0
  if ($2 == price) {
    if ($findtok(Porygon:Dratini,$1,0,58)) { var %r = 9999 }
    elseif ($findtok(Tauros:Wobbuffet,$1,0,58)) { var %r = 5000 }
    elseif ($findtok(Hitmonchan:Hitmonlee:Hitmontop,$1,0,58)) { var %r = 3600 }
    elseif ($findtok(Vulpix:Mr.mime,$1,0,58)) { var %r = 1800 }
  }
  return %r
}
alias shop {
  if ($1 == Petalburg City) { if ($2 < 4) || (!$2) { return Poke Ball } | else { return Poke Ball:Great Ball:TM28:PC } }
  elseif ($1 == Rustboro City) { if ($2 < 4) || (!$2) { return Poke Ball:Fire Stone } | else { return Poke Ball:Great Ball:Fire Stone:Leaf Stone:Thunderstone:TM39:TM37 } }
  elseif ($1 == Dewford City) { if ($2 < 4) || (!$2) { return Poke Ball:Water Stone } | else { return Poke Ball:Great Ball:Water Stone:TM18:TM39:TM37 } }
  elseif ($1 == Slateport City) { if ($2 < 4) || (!$2) { return Poke Ball:Water Stone:Thunderstone:TM11:TM17:TM18 } | else { return Poke Ball:Great Ball:Water Stone:TM11:TM18:TM39:TM37 } }
  elseif ($1 == Mauville City) { if ($2 < 4) || (!$2) { return Poke Ball:Thunderstone:PC } | else { return Poke Ball:Great Ball:Thunderstone:TM34:PC } }
  elseif ($1 == Verdanturf Town) { if ($2 < 4) || (!$2) { return Poke Ball:Leaf Stone:TM09:PC } | else { return Poke Ball:Great Ball:Leaf Stone:TM09:TM19:PC } }
  elseif ($1 == Lavaridge Town) { if ($2 < 4) || (!$2) { return Poke Ball:Fire Stone:TM11:PC } | else { return Poke Ball:Great Ball:Fire Stone:TM11:TM35:PC } }
  elseif ($1 == Fallarbor Town) { if ($2 < 4) || (!$2) { return Poke Ball:PC } | else { return Poke Ball:Great Ball:TM28:PC } }
  elseif ($1 == Fortree City) { if ($2 < 4) || (!$2) { return Poke Ball:Water Stone:PC } | else { return Poke Ball:Great Ball:Water Stone:Leaf Stone:TM47:PC } }
  elseif ($1 == Lilycove City) { if ($2 < 4) || (!$2) { return Poke Ball:Fire Stone:Water Stone:TM14:TM25:TM38:PC } | else { return Poke Ball:Great Ball:Fire Stone:Water Stone:Leaf Stone:TM14:TM25:TM38:TM22:PC } }
  elseif ($1 == Mossdeep City) { if ($2 < 4) || (!$2) { return Poke Ball:PC } | else { return Poke Ball:Great Ball:PC } }
  elseif ($1 == Sootopolis City) { if ($2 < 4) || (!$2) { return Poke Ball:TM37:PC } | else { return Poke Ball:Great Ball:TM37:PC } }
  elseif ($1 == Pacifidlog Town) { if ($2 < 4) || (!$2) { return Poke Ball:Water Stone } | else { return Poke Ball:Great Ball:Water Stone:PC } }
  elseif ($1 == Evergrande City) { if ($2 < 2) || (!$2) { return Poke Ball:PC } | elseif ($2 < 3) { return Poke Ball:TM21:TM27:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM21:TM27:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM21:TM27:TM15:PC } }
  elseif ($1 == Milhagem) {
    if ($2 < 2) || (!$2) { return Poke Ball:Great Ball:Ultra Ball:Fire Stone:Leaf Stone:Water Stone:Thunderstone:Moon Stone:Sun Stone:TM10:TM21:TM27:PC }
    elseif ($2 < 3) { return Poke Ball:Great Ball:Ultra Ball:Level Ball:Repeat Ball:Friend Ball:Fire Stone:Leaf Stone:Water Stone:Thunderstone:Moon Stone:Sun Stone:King's Rock:Dragon Scale:Leftovers:Metal Coat:Persim Berry:TM10:TM15:TM21:TM23:TM27:TM46:PC }
    elseif ($2 < 4) { return Poke Ball:Great Ball:Ultra Ball:Level Ball:Fast Ball:Repeat Ball:Friend Ball:Nest Ball:Timer Ball:Net Ball:Dive Ball:Lure Ball:Fire Stone:Leaf Stone:Water Stone:Thunderstone:Moon Stone:Sun Stone:King's Rock:Dragon Scale:Leftovers:Shell Bell:Scope Lens:Quick Claw:Starf Berry:Persim Berry:Mental Herb:Metal Coat:TM10:TM13:TM15:TM19:TM21:TM23:TM24:TM27:TM29:TM30:TM35:TM46:PC }
    else {
      var %x1 = Poke Ball:Great Ball:Ultra Ball:Level Ball:Fast Ball:Repeat Ball:Friend Ball:Nest Ball:Timer Ball:Net Ball:Dive Ball:Lure Ball:Flare Ball:Damp Ball:Love Ball:Fire Stone:Leaf Stone:Water Stone:Thunderstone:Moon Stone:Sun Stone:King's Rock:Dragon Scale:Leftovers:Shell Bell:Scope Lens:Quick Claw:Starf Berry:Liechi Berry:Ganlon Berry:Salac Berry:Petaya Berry:Apicot Berry:Lansat Berry:Aspear Berry:Cheri Berry:Chesto Berry:Pecha Berry:Rawst Berry:Persim Berry:Mental Herb
      var %x2 = Black Belt:Blackglasses:Charcoal:Dragon Fang:Hard Stone:Magnet:Metal Coat:Miracle Seed:Mystic Water:Nevermeltice:Poison Barb:Sea Incense:Sharp Beak:Silk Scarf:Silverpowder:Soft Sand:Spell Tag:Twistedspoon:TM01:TM02:TM03:TM04:TM05:TM06:TM07:TM08:TM09:TM10:TM11:TM12:TM13:TM14:TM15:TM16:TM17:TM18:TM19:TM20:TM21:TM22:TM23:TM24:TM25:TM26:TM27:TM28:TM29:TM30:TM31:TM32:TM33:TM34:TM35:TM36:TM37:TM38:TM39:TM40:TM41:TM42:TM43:TM44:TM45:TM46:TM47:TM48:TM49:TM50:PC
      return %x1 $+ : $+ %x2
    }
  }
  elseif ($1 == Game Corner:Celadon City) {
    if ($2 < 2) || (!$2) { return TM13:TM24:TM35:Porygon }
    elseif ($2 isnum 2-3) { return TM13:TM24:TM35:MT06:MT07:MT20:MT21:MT22:Lax Incense:Choice Band:White Herb:Mr.mime:Tauros:Porygon }
    else { return TM13:TM24:TM35:MT06:MT07:MT20:MT21:MT22:MT23:MT24:MT25:MT28:MT30:Lax Incense:Choice Band:White Herb:Mr.mime:Hitmonlee:Hitmonchan:Tauros:Porygon }
  }
  elseif ($1 == Game Corner:Goldenrod City) {
    if ($2 < 2) || (!$2) { return TM13:TM24:TM35:Dratini }
    elseif ($2 isnum 2-3) { return TM13:TM24:TM35:MT08:MT11:MT12:MT13:MT16:Lax Incense:Choice Band:White Herb:Vulpix:Wobbuffet:Dratini }
    else { return TM13:TM24:TM35:MT02:MT08:MT11:MT12:MT13:MT16:MT17:MT18:MT19:MT20:Lax Incense:Choice Band:White Herb:Vulpix:Hitmontop:Wobbuffet:Dratini }
  }
  elseif ($1 == PC) { return Small Box:Normal Box:Great Box:Giant Box }
  elseif ($1 == Viridian City) { if ($2 < 4) || (!$2) { return Poke Ball:PC } | else { return Poke Ball:Great Ball:PC } }
  elseif ($1 == Pewter City) { if ($2 < 4) || (!$2) { return Poke Ball:PC } | else { return Poke Ball:Great Ball:TM39:PC } }
  elseif ($1 == Cerulean City) { if ($2 < 4) || (!$2) { return Poke Ball:PC } | else { return Poke Ball:Great Ball:TM18:PC } }
  elseif ($1 == Vermilion City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:PC } | else { return Poke Ball:Great Ball:TM25:PC } }
  elseif ($1 == Lavender Town) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 3) { return Great Ball:TM10:PC } | else { return Great Ball:TM10:TM32:PC } }
  elseif ($1 == Celadon City) { if ($2 < 3) || (!$2) { return Poke Ball:Fire Stone:Water Stone:Thunderstone:TM16:TM17:TM33:TM43:PC } | elseif ($2 == 2) { return Poke Ball:Fire Stone:Water Stone:Thunderstone:Leaf Stone:TM14:TM16:TM17:TM25:TM33:TM38:TM43:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:Fire Stone:Water Stone:Thunderstone:Leaf Stone:TM09:TM10:TM14:TM16:TM17:TM25:TM33:TM38:TM43:PC } | else { return Poke Ball:Great Ball:Fire Stone:Water Stone:Thunderstone:Leaf Stone:TM09:TM10:TM14:TM16:TM17:TM19:TM20:TM25:TM33:TM38:TM43:PC } }
  elseif ($1 == Saffron City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 2) { return Poke Ball:TM20:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:TM20:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM20:PC } }
  elseif ($1 == Fuchsia City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 2) { return Poke Ball:TM07:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:TM07:PC } | else { return Poke Ball:Great Ball:Ultra Ball:Leaf Stone:TM07:PC } }
  elseif ($1 == Cinnabar Island) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 2) { return Poke Ball:TM11:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:TM11:PC } | else { return Poke Ball:Great Ball:Ultra Ball:Fire Stone:TM11:PC } }
  elseif ($1 == Indigo Plateau) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 2) { return Poke Ball:TM15:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:TM15:PC } | else { return Great Ball:Ultra Ball:TM05:TM15:PC } }
  elseif ($1 == Violet City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:PC } | else { return Poke Ball:Great Ball:TM40:PC } }
  elseif ($1 == Azalea Town) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 == 3) { return Poke Ball:Great Ball:PC } | else { return Poke Ball:Great Ball:Charcoal:PC } }
  elseif ($1 == Goldenrod City) { if ($2 < 2) || (!$2) { return Poke Ball:TM11:TM18:PC } | elseif ($2 < 3) { return Poke Ball:TM11:TM16:TM18:TM33:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM11:TM16:TM17:TM18:TM32:TM33:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM10:TM11:TM16:TM17:TM18:TM20:TM28:TM32:TM33:PC } }
  elseif ($1 == Ecruteak City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM21:TM27:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM21:TM27:TM30:PC } }
  elseif ($1 == Olivine City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM23:PC } }
  elseif ($1 == Cianwood City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM10:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM10:TM31:PC } }
  elseif ($1 == Mahogany Town) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM10:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM07:TM10:PC } }
  elseif ($1 == Blackthorn City) { if ($2 < 3) || (!$2) { return Poke Ball:TM43:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM43:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM43:TM46:PC } }
  elseif ($1 == White City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:PC } | else { return Poke Ball:Great Ball:Ultra Ball:PC } }
  elseif ($1 == Peak Town) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM05:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM05:TM40:PC } }
  elseif ($1 == Sunrise City) { if ($2 < 3) || (!$2) { return Poke Ball:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM09:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM09:TM11:PC } }
  elseif ($1 == Silverst City) { if ($2 < 2) || (!$2) { return Poke Ball:PC } | elseif ($2 < 3) { return Poke Ball:TM15:PC } | elseif ($2 < 4) { return Poke Ball:Great Ball:TM15:TM48:PC } | else { return Poke Ball:Great Ball:Ultra Ball:TM15:TM48:MT29:PC } }
}
alias getnicks {
  var %x = 0, %y = 0
  while (%x < $chan(0)) {
    inc %x
    var %chan = $chan(%x)
    while (%y < $nick(%chan,0)) {
      inc %y
      var %nick = $nick(%chan,%y)
      if ($dados(%nick,Info,Nick)) { var %r = $addtok(%r,$nick(%chan,%y),59) }
    }
    var %y = 0
  }
  var %x = 0
  while (%x < $chat(0)) {
    inc %x
    if ($checknick($chat(%x)) == Ok!) { var %r = $addtok(%r,$chat(%x),59) }
  }
  return %r
}
alias milhagem.add {
  var %x = 0, %nicks = $getnicks, %y = $gettok(%nicks,0,59), %milha = $timer(Milhagem).delay
  while (%x < %y) {
    inc %x
    var %nick = $gettok(%nicks,%x,59)
    if ($dados(%nick,Info,Nick)) && (!$npc(%nick)) {
      var %received = $calc(%milha * $iif($item(%nick,Mach Bike).qnt,2,1) * ($comchan(%nick,0) + $iif($checknick(%nick) == Ok!,1,0)))
      .writeini pkp\cadastros\ $+ %nick $+ .ini Info Milhagem $calc($rini(cadastros,%nick,Info,Milhagem) + %received)
      if ($teampos(%nick,Egg)) {
        var %egg.m = $rini(cadastros,%nick,Egg,Milhagem), %egg.h = $rini(cadastros,%nick,Egg,Hatch)
        if (%egg.m < %egg.h) {
          if ($calc(%egg.m + %received) < %egg.h) { .writeini pkp\cadastros\ $+ %nick $+ .ini Egg Milhagem $calc(%egg.m + %received) }
          else {
            .writeini pkp\cadastros\ $+ %nick $+ .ini Egg Milhagem %egg.h
            if ($checknick(%nick) == Ok!) {
              .msg = [ $+ [ %nick ] ] $cc $+ %nick $+ $ct $+ , Egg(15? $+ $ct $+ )/ $+ $cc $+ ?? $ct $+ está se chocando!
              if ($checkteam(%nick,$rini(cadastros,%nick,Egg,DNA)) == $true) { .msg = [ $+ [ %nick ] ] $ct $+ Não foi possível chocá-lo, pois já $cc $+ existe $ct $+ um pokémon no seu $cc $+ time $ct $+ com o $cc $+ mesmo nome $ct $+ do pokémon que nascerá! }
              else { var %egg.pk = $rini(cadastros,%nick,Egg,DNA) | hatch %nick | .msg = [ $+ [ %nick ] ] $ct $+ Parabéns! $cc $+ Egg $ct $+ se chocou e nasceu $cc $+ %egg.pk $+ $ct $+ ! }
            }
          }
        }
      }
      .writeini pkp\cadastros\ $+ %nick $+ .ini Info Online $calc($rini(cadastros,%nick,Info,Online) + %milha)
      if ($dados(%nick,Info,Premium)) && ($dados(%nick,Info,Premium).remain <= 0) { premium rem %nick }
    }
  }
  var %x = 1 | while ($chat(%x)) { if ($chat(%x).status == active) && ($rini(cadastros,$chat(%x),Info,Access) < 5) { var %n = $calc($ctime($date $time) - $ctime($active($chat(%x)).time)) | if ($active($chat(%x)).time) && (%n >= 600) { nick.kick PkP $chat(%x) Você ficou inativo por mais de 10 minutos. } } | inc %x }
  var %y = $readini(pkp\status.ini,Hoenn,Legendary), %x = $findtok(%y,Groudon,0,58) | if (%x) { var %p = $gettok(Lavaridge Town:Mt Chimney:Desert Underpass:Fallarbor Town:Rustboro City:Fortree City:Mt Chimney:Mauville City:Mt Chimney,$rand(1,32),58) | if (%p) { writeini pkp\status.ini Active Terra_Cave %p } | else { remini pkp\status.ini Active Terra_Cave } } | elseif ($readini(pkp\status.ini,Active,Terra_Cave)) { remini pkp\status.ini Active Terra_Cave }
  var %x = $findtok(%y,Kyogre,0,58) | if (%x) { var %p = $gettok(Mossdeep City:Silver Bay:Shoal Cave:Sootopolis City:Dewford City:Lilycove City:Silver Bay:Oldale Town:Silver Bay,$rand(1,32),58) | if (%p) { writeini pkp\status.ini Active Marine_Cave %p } | else { remini pkp\status.ini Active Marine_Cave } } | elseif ($readini(pkp\status.ini,Active,Marine_Cave)) { remini pkp\status.ini Active Marine_Cave }
  if ($titlebar == :REPORT:) { .titlebar } | elseif ($exists(pkp\log\report.txt)) { .titlebar :REPORT: | .flash /report to read! }

}
alias autojoin {
  .mode $me +p
  ;  .join #Pokemon,#Project
}
alias egroup {
  var %s = $read(pkp\database.txt,s,$1 $+ :)
  if ($prop == step) { return $gettok(%s,13,172) } | else { return $gettok(%s,12,172) }
}
alias evolve {
  var %nick = $1, %poke = $2, %evolve = $3, %lvl = $rini(cadastros,%nick,%poke,Level), %t = $readini(pkp\evolve.ini,Evolve,%poke), %c = 0, %r = 0
  if (%t) {
    var %t = $wildtok(%t,%evolve $+ *,1,59)
    if (%t) {
      var %lv = $gettok(%t,2,58), %stone = $gettok(%t,3,58), %loyal = $gettok(%t,4,58), %hold = $gettok(%t,5,58), %trade = $gettok(%t,6,58), %high = $gettok(%t,7,58), %low = $gettok(%t,8,58), %item = 0
      if (%lv != No) { var %c = $calc(%c + 1) }
      if (%stone != No) { var %c = $calc(%c + 1) }
      if (%loyal != No) { var %c = $calc(%c + 1) }
      if (%hold != No) { var %c = $calc(%c + 1) }
      if (%trade != No) { var %c = $calc(%c + 1) }
      if (%high != No) { var %c = $calc(%c + 1) }

      if (%lv != No) { if (%lvl >= %lv) { var %r = $calc(%r + 1) } }
      if (%stone != No) { if ($item(%nick,%stone).qnt) { var %r = $calc(%r + 1), %item = 1 } }
      if (%loyal != No) { if ($gettok($rini(cadastros,%nick,%poke,Loyalty),1,58) >= %loyal) { var %r = $calc(%r + 1) } }
      if (%hold != No) { if ($rini(cadastros,%nick,%poke,Hold) == %hold) { var %r = $calc(%r + 1), %ghold = 1 } }
      if (%trade != No) { if ($rini(cadastros,%nick,%poke,ID) != $nick) { var %r = $calc(%r + 1) } }
      if (%high != No) { if ($rini(cadastros,%nick,%poke,%high) > $rini(cadastros,%nick,%poke,%low)) { var %r = $calc(%r + 1) } }

      if (%r == %c) { if (%item) { item.rem %nick %stone } | if (%ghold) { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Hold 0 } | return Ok! } | else { return No! }
    }
    else { return No! }
  }
  else { return No! }
}

alias evolution {
  var %t = $readini(pkp\evolve.ini,Evolve,$1)
  var %x = 0, %y = $gettok(%t,0,59)
  while (%x < %y) {
    inc %x
    var %z = $gettok(%t,%x,59)
    if (%r) { if (%x == %y) { var %r = %r $ct $+ ou $cc $+ $gettok(%z,1,58) } | else { var %r = %r $+ $ct $+ $chr(44) $cc $+ $gettok(%z,1,58) } }
    else { var %r = $cc $+ $gettok(%z,1,58) }
  }
  return %r
}

alias code.dex {
  var %t = $len($1), %x = 0
  while (%x < %t) {
    inc %x
    var %l = $right($left($1,%x),1), %l = $base($asc(%l),10,10,3)
    if (%r1 != $null) { var %r1 = %r1 $+ $right($left(%l,1),1) } | else { var %r1 = $right($left(%l,1),1) }
    if (%r2 != $null) { var %r2 = %r2 $+ $right($left(%l,2),1) } | else { var %r2 = $right($left(%l,2),1) }
    if (%r3 != $null) { var %r3 = %r3 $+ $right($left(%l,3),1) } | else { var %r3 = $right($left(%l,3),1) }
  }
  var %r = %r1 $+ %r2 $+ %r3
  return $replace(%r,111,n,0n,r,r1,c,r9,y,11,o,01,a,19,h,09,k,08,j,00,x,05,f,47,p,765,i)
}

alias decode.dex {
  var %name = $replace($1,i,765,p,47,f,05,x,00,j,08,k,09,h,19,a,01,o,11,y,r9,c,r1,r,0n,n,111)
  var %t = $calc($len(%name) / 3), %x = 0
  while (%x < %t) {
    inc %x
    var %y = 0, %n = 0
    while (%y < 3) {
      if (%n != $null) { var %n = %n $+ $right($left(%name,$calc(%x + (%t * %y))),1) } | else { var %n = $right($left(%name,$calc(%x + (%t * %y))),1) }
      inc %y
    }
    if (%r) { var %r = %r $+ $chr(%n) } | else { var %r = $chr(%n) }
  }
  return %r
}

alias nullfill {
  return $1
}

alias clone {
  var %nick = $1, %x = 0, %y = $chat(0) | while (%x < %y) { inc %x | if ($chat(%x) == %nick) { var %ip = $chat(%x).ip } }
  var %x = 0 | while (%x < %y) { inc %x | if ($chat(%x).ip == %ip) && ($chat(%x) != %nick) { return $true } | if ($chat(%x) == %nick) && (%clone) { return $true } | if ($chat(%x) == %nick) { var %clone = 1 } } | return $false
}

alias premium {
  if ($1 == add) {
    if ($dados($2,Info,Premium)) {
      writeini pkp\cadastros\ $+ $2 $+ .ini Info Premium $dados($2,Info,Premium).since $+ ; $+ $calc($3 + $dados($2,Info,Premium).days)
      if ($3) {
        if ($dados($2,Info,Premium).remain <= 0) { msg $+(=,$2) $ct $+ Atenção, $cc $+ $dados($2,Info,Nick) $+ $ct $+ ! Sua conta premiada $cc $+ expirou $+ $ct $+ . | remini pkp\cadastros\ $+ $2 $+ .ini Info Premium | wlog user $2 Premium account was fully removed. }
        else { msg $+(=,$2) $ct $+ Sua conta premiada foi $cc $+ $iif($3 > 0,prolongada,reduzida) $+ $ct $+ . Ainda restam, aproximadamente, $dur($dados($2,Info,Premium).remain,$ct,$cc) $+ $ct $+ . Aproveite! | wlog user $2 Premium account has been changed. }
      }
    }
    else {
      writeini pkp\cadastros\ $+ $2 $+ .ini Info Premium $dados($2,Info,Online) $+ ; $+ $3 | var %r = $remtok($readini(pkp\status.ini,Active,Premium),$1,1,58) | if (%r) { writeini pkp\status.ini Active Premium %r } | else { remini pkp\status.ini Active Premium }
      wlog user $2 Premium account successfully added.
      if ($checknick($2) == Ok!) {
        msg $+(=,$2) $ct $+ Parabéns! A partir deste momento, seu acesso ao $cc $+ $me $ct $+ foi alterado para $cc $+ premiado $+ $ct $+ ! Várias vantagens estão disponíveis para os usuários com contas premiadas, veja-as a seguir:
        msg $+(=,$2) $chr(160) $ct $+ $chr(40) $+ $cc $+ $chr(215) $+ $ct $+ $chr(41) Se ainda estiver começando, poderá escolher mais pokémon iniciais;
        msg $+(=,$2) $chr(160) $ct $+ $chr(40) $+ $cc $+ $chr(215) $+ $ct $+ $chr(41) Apenas os usuários premiados terão mais visitas diárias em batalhas selvagens;
        msg $+(=,$2) $chr(160) $ct $+ $chr(40) $+ $cc $+ $chr(215) $+ $ct $+ $chr(41) Durante uma batalha na $cc $+ Safari Zone $+ $ct $+ , será possível usar mais pokébolas;
        msg $+(=,$2) $chr(160) $ct $+ $chr(40) $+ $cc $+ $chr(215) $+ $ct $+ $chr(41) Poderá armazenar mais pokémon no $cc $+ market $ct $+ ao mesmo tempo;
        msg $+(=,$2) $chr(160) $ct $+ $chr(40) $+ $cc $+ $chr(215) $+ $ct $+ $chr(41) Seus $cc $+ Eggs $ct $+ se chocarão mais rápido que o normal;
        msg $+(=,$2) $ct $+ Aproveite seu período, ainda restam $dur($dados($2,Info,Premium).remain,$ct,$cc) $cc $+ online $ct $+ até esta promoção expirar.
      }
    }
  }
  elseif ($1 == rem) {
    if ($dados($2,Info,Premium)) { msg $+(=,$2) $ct $+ Atenção, $cc $+ $dados($2,Info,Nick) $+ $ct $+ ! Sua conta premiada $cc $+ expirou $+ $ct $+ . | remini pkp\cadastros\ $+ $2 $+ .ini Info Premium | wlog user $2 Premium account was fully removed. }
  }
  else {
    echo Para adicionar uma conta premiada, digite /premium add <Nick> <Dias>. Se uma já existir, será acrescido/decrescido do número de dias.
    echo Para removê-la, digite /premium rem <Nick>.
  }
}
alias link.token {
  var %token = $chr($1), %x = 2
  while ($ [ $+ [ %x ] ] != $null) {
    var %n = $ [ $+ [ %x ] ] | if (!%n) { var %n = 0 }
    if (%res == $null) { var %res = %n }
    else { var %res = %res $+ %token $+ %n }
    inc %x
  }
  return %res
}
alias en { return $else.null($1-) }
alias getpkline {
  var %n = $1, %pk = $2
  if (%pk == Egg) {
    var %line = $link.token(59,$dados(%n,%pk,Name),$dados(%n,%pk,DNA),$dados(%n,%pk,Hatch),$dados(%n,%pk,Milhagem),$dados(%n,%pk,Nature),$dados(%n,%pk,Sex),$dados(%n,%pk,GV),$dados(%n,%pk,Shiny),$dados(%n,%pk,Memory),$dados(%n,%pk,Trait),$dados(%n,%pk,IVHp),$dados(%n,%pk,IVAtk),$dados(%n,%pk,IVDef),$dados(%n,%pk,IVSpd),$dados(%n,%pk,IVSAtk),$dados(%n,%pk,IVSDef),$dados(%n,%pk,Move1),$dados(%n,%pk,Move2),$dados(%n,%pk,Move3),$dados(%n,%pk,Move4))
  }
  else {
    var %line = $link.token(59,$dados(%n,%pk,Name),$dados(%n,%pk,ID),$dados(%n,%pk,Level),$dados(%n,%pk,Nature),$dados(%n,%pk,Sex),$dados(%n,%pk,GV),$dados(%n,%pk,Shiny),$dados(%n,%pk,Trait),$dados(%n,%pk,ExpStat),$dados(%n,%pk,Exp),$dados(%n,%pk,Next),$dados(%n,%pk,Memory),$dados(%n,%pk,Loyalty),$dados(%n,%pk,Hold),$dados(%n,%pk,Ribbon))
    var %line = $link.token(59,%line,$dados(%n,%pk,IVHp),$dados(%n,%pk,IVAtk),$dados(%n,%pk,IVDef),$dados(%n,%pk,IVSpd),$dados(%n,%pk,IVSAtk),$dados(%n,%pk,IVSDef),$dados(%n,%pk,EVHP),$dados(%n,%pk,EVAtk),$dados(%n,%pk,EVDef),$dados(%n,%pk,EVSpd),$dados(%n,%pk,EVSAtk),$dados(%n,%pk,EVSDef),$dados(%n,%pk,HP),$dados(%n,%pk,Atk),$dados(%n,%pk,Def),$dados(%n,%pk,Spd),$dados(%n,%pk,SAtk),$dados(%n,%pk,SDef),$dados(%n,%pk,Learn),$dados(%n,%pk,Move1),$dados(%n,%pk,Move2),$dados(%n,%pk,Move3),$dados(%n,%pk,Move4))
  }
  return %line
}

alias breed {
  tokenize 59 $1-
  var %nick.1 = $1, %pk.1 = $2, %sex.1 = $3, %moveset.1 = $4, %nick.2 = $5, %pk.2 = $6, %sex.2 = $7, %moveset.2 = $8, %male = 0, %female = 0
  if ($breeding(%pk.1,%pk.2) == NO!) {
    if (%nick.1 == %nick.2) { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | return }
    else { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | msg = [ $+ [ %Nick.2 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | return }
  }
  if (%sex.1 == Male) { inc %male } | elseif (%sex.1 == Female) { inc %female }
  if (%sex.2 == Male) { inc %male } | elseif (%sex.2 == Female) { inc %female }
  if (%male > 1) || (%female > 1) {
    if (%nick.1 == %nick.2) { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ não gostam um do outro... | return }
    else { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ são do mesmo sexo... | msg = [ $+ [ %Nick.2 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ não gostam um do outro... | return }
  }
  if (!%male) || (!%female) {
    if (%pk.1 != Ditto) && (%pk.2 != Ditto) {
      if (%nick.1 == %nick.2) { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | return }
      else { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | msg = [ $+ [ %Nick.2 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ preferem brincar um com o outro... | return }
    }
  }
  if (%sex.1 == Male) { var %e = 2 } | elseif (%sex.2 == Male) { var %e = 1 }
  if (!%e) { if (%sex.1 == Female) { var %e = 1 } | elseif (%sex.2 == Female) { var %e = 2 } }
  if (%pk.1 == Ditto) { var %e = 2 } | if (%pk.2 == Ditto) { var %e = 1 }
  if (!%e) {
    if (%nick.1 == %nick.2) { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ não gostam um do outro... | return }
    else { msg = [ $+ [ %Nick.1 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ não gostam um do outro... | msg = [ $+ [ %Nick.2 ] ] $ct $+ Os pokémon $cc $+ %pk.1 $ct $+ e $cc $+ %pk.2 $ct $+ não gostam um do outro... | return }
  }
  var %egg = $preevolution(%pk. [ $+ [ %e ] ]), %d = $iif(%e == 1,2,1)
  if ($findtok(%pk.1 %pk.2,Ditto,0,32)) {
    if (%sex.1 == Male) { var %d = 1 } | elseif (%sex.2 == Male) { var %d = 2 }
    var %e = $iif(%d == 1,2,1)
  }
  if (%egg == Nidoran) { var %rand = $rand(1,2), %egg = Nidoran $+ $iif(%rand == 1,m,f) }
  if (%egg == Plusle) || (%egg == Minun) { var %rand = $rand(1,2), %egg = $iif(%rand == 1,Plusle,Minun) }
  if (%egg == Volbeat) || (%egg == Illumise) { var %rand = $rand(1,2), %egg = $iif(%rand == 1,Volbeat,Illumise) }
  if (%egg == Marill) { if ($rini(cadastros,%nick.1,%pk.1,Hold) == Sea Incense) || ($rini(cadastros,%nick.2,%pk.2,Hold) == Sea Incense) { var %egg = Marill } }
  if (%egg == Wobbuffet) { if ($rini(cadastros,%nick.1,%pk.1,Hold) == Lax Incense) || ($rini(cadastros,%nick.2,%pk.2,Hold) == Lax Incense) { var %egg = Wynaut } }

  var %moves = $read(pkp\moveset.txt, s, %egg), %x = $gettok(%moves,0,44), %y = 0
  while (%y < %x) {
    inc %y | var %move = $gettok(%moves,%y,44), %learn = $gettok(%move,$gettok(%move,0,32),32), %move = $nullfill($remove(%move,$chr(32) $+ %learn))
    if (%learn <= 5) {
      if (!$findtok(%moveset.egg,%move,0,58)) {
        if ($gettok(%moveset.egg,0,58) == 4) { var %moveset.egg = $gettok(%moveset.egg,2-4,58) $+ : $+ %move }
        else { if (%moveset.egg) { var %moveset.egg = %moveset.egg $+ : $+ %move } | else { var %moveset.egg = %move } }
      }
    }
  }
  if (%d) {
    var %x = 0, %y = %moveset. [ $+ [ %d ] ]
    while (%x < 4) {
      inc %x | var %move = $gettok(%y,%x,58)
      if ($rmove(%move).s != Level) && (!$findtok(HM:MT,$left($rmove(%move).s,2),0,58)) {
        if ($findtok($read(pkp\techniques.txt,s,%egg),$rmove(%move).s,0,32)) {
          if (!$findtok(%moveset.egg,%move,0,58)) {
            if ($gettok(%moveset.egg,0,58) == 4) { var %moveset.egg = $gettok(%moveset.egg,2-4,58) $+ : $+ %move }
            else { if (%moveset.egg) { var %moveset.egg = %moveset.egg $+ : $+ %move } | else { var %moveset.egg = %move } }
          }
        }
      }
    }
    var %x = 0, %y = %moveset. [ $+ [ %d ] ]
    while (%x < 4) {
      inc %x | var %move = $gettok(%y,%x,58)
      if ($findtok(%moveset. [ $+ [ %e ] ],%move,0,58)) {
        if ($wildtok($read(pkp\moveset.txt, s, %egg),* $+ %move *,0,44)) {
          if (!$findtok(%moveset.egg,%move,0,58)) {
            if ($gettok(%moveset.egg,0,58) == 4) { var %moveset.egg = $gettok(%moveset.egg,2-4,58) $+ : $+ %move }
            else { if (%moveset.egg) { var %moveset.egg = %moveset.egg $+ : $+ %move } | else { var %moveset.egg = %move } }
          }
        }
      }
    }
    var %x = 0, %y = %moveset. [ $+ [ %d ] ]
    while (%x < 4) {
      inc %x | var %move = $gettok(%y,%x,58)
      if ($read(pkp\eggmoves.txt,s,%egg)) {
        if ($findtok($read(pkp\eggmoves.txt,s,%egg),%move,0,58)) {
          if (!$findtok(%moveset.egg,%move,0,58)) {
            if ($gettok(%moveset.egg,0,58) == 4) { var %moveset.egg = $gettok(%moveset.egg,2-4,58) $+ : $+ %move }
            else { if (%moveset.egg) { var %moveset.egg = %moveset.egg $+ : $+ %move } | else { var %moveset.egg = %move } }
          }
        }
      }
    }
  }
  var %stat = IVHP:IVAtk:IVDef:IVSpd:IVSAtk:IVSDef, %res = IVHP:IVAtk:IVDef:IVSpd:IVSAtk:IVSDef, %x = 0
  while (%x < 3) {
    inc %x | var %y = $gettok(%stat,0,58), %y = $gettok(%stat,$rand(1,%y),58), %stat = $remtok(%stat,%y,1,58)
    if ($1 == $5) { var %iv = $rini(cadastros,$1,$iif($rand(1,2) == 1,$2,$6),%y) } | else { var %iv = $rini(cadastros,$iif(%r == 1,$1,$5),$iif(%r == 1,$2,$6),%y) }
    var %res = $reptok(%res,%y,%iv,58)
  }
  var %x = 0 | while (%x < 6) { inc %x | var %y = $gettok(%res,%x,58) | if (%y !isnum) { var %res = $reptok(%res,%y,$rand(0,31),58) } }
  var %te = $basestat(%egg,Trait), %t.1 = $rini(cadastros,%nick.1,%pk.1,Trait), %t.2 = $rini(cadastros,%nick.2,%pk.2,Trait), %price = $readini(pkp\status.ini,Active,Daycare)
  if (%t.1 == %t.2) { if ($findtok(%te,%t.1,0,44)) { var %trait = %t.1 } }
  .wlog user %nick.1 Obtained an egg breeding %pk.1 and $iif(%nick.1 == %nick.2,%pk.2,%nick.2 $+ 's %pk.2) $+ .
  .echo $addpoke(%nick.1,Egg,%egg,Foi obtido no DayCare Center.,%res,%moveset.egg,$iif(%trait,%trait,0))
  if (%nick.1 == %nick.2) {
    msg = [ $+ [ %nick.1 ] ] $ct $+ Parabéns, $cc $+ %nick.1 $+ $ct $+ ! Você ganhou um $cc $+ Egg $+ $ct $+ ! | writeini pkp\cadastros\ $+ %nick.1 $+ .ini Time Daycare $date $time
    var %p = $int($iif($dados(%nick.1,Info,Premium),$int($calc(%price / 2)),%price))
    writeini pkp\cadastros\ $+ %nick.1 $+ .ini Info Money $calc($rini(cadastros,%nick.1,Info,Money) - %p) | msg $+(=,%nick.1) $ct $+ Você pagou $cc $+ $chr(36) $+ $getmoney(%p) $ct $+ para o $cc $+ DayCare Center $+ $ct $+ .
  }
  else {
    .wlog user %nick.2 Helped %nick.1 obtaining an egg with %pk.2 $+ .
    msg = [ $+ [ %nick.1 ] ] $ct $+ Parabéns, $cc $+ %nick.1 $+ $ct $+ ! Você ganhou um $cc $+ Egg $+ $ct $+ ! | msg = [ $+ [ %nick.2 ] ] $ct $+ Cruzamento efetuado com sucesso. $cc $+ %nick.1 $ct $+ recebeu um $cc $+ Egg $+ $ct $+ ! | writeini pkp\cadastros\ $+ %nick.1 $+ .ini Time Daycare $date $time | writeini pkp\cadastros\ $+ %nick.2 $+ .ini Time Daycare $date $time
    var %price = $int($calc(%price / 2)), %p = $int($iif($dados(%nick.1,Info,Premium),$int($calc(%price / 2)),%price))
    writeini pkp\cadastros\ $+ %nick.1 $+ .ini Info Money $calc($rini(cadastros,%nick.1,Info,Money) - %p) | msg $+(=,%nick.1) $ct $+ Você pagou $cc $+ $chr(36) $+ $getmoney(%p) $ct $+ para o $cc $+ DayCare Center $+ $ct $+ .
    var %p = $int($iif($dados(%nick.2,Info,Premium),$int($calc(%price / 2)),%price))
    writeini pkp\cadastros\ $+ %nick.2 $+ .ini Info Money $calc($rini(cadastros,%nick.2,Info,Money) - %p) | msg $+(=,%nick.2) $ct $+ Você pagou $cc $+ $chr(36) $+ $getmoney(%p) $ct $+ para o $cc $+ DayCare Center $+ $ct $+ .
  }
}

alias breeding {
  var %x = $egroup($1), %y = $egroup($2), %type1.1 = $gettok(%x,1,32), %type1.2 = $gettok(%x,2,32), %type2.1 = $gettok(%y,1,32), %type2.2 = $gettok(%y,2,32)
  if (NoEggs isin %x) || (NoEggs isin %y) { return NO! }
  if (%x == Ditto) && (%y == Ditto) { return NO! }
  if (%x == %y) { return OK! }
  if (%x == Ditto) && (%y != %x) { return OK! }
  if (%y == Ditto) && (%y != %x) { return OK! }
  if (%tipe1.1 == %tipe2.1) { return OK! }
  if (%tipe1.2 == %tipe2.1) && (%type1.2) { return OK! }
  if (%tipe1.1 == %tipe2.2) { return OK! }
  if (%tipe1.2 == %tipe2.2) && (%type1.2) { return OK! }
  return NO!
}


alias team.hm {
  var %x = 0, %region = Hoenn:Kanto:Johto
  while (%x < 6) {
    inc %x
    var %p = $rini(cadastros,$1,Team,%x)
    if (%p) && (%p != Egg) {
      var %y = 0
      while (%y < 4) {
        inc %y | var %m = $rini(cadastros,$1,%p,Move [ $+ [ %y ] ])
        if (%m == $2) && (%m) {
          if (%m == Cut) { var %b = Stone Badge:Cascade Badge, %hm = HM01 }
          elseif (%m == Fly) { var %b = Feather Badge:Thunder Badge, %hm = HM02 }
          elseif (%m == Surf) { var %b = Balance Badge:Soul Badge, %hm = HM03 }
          elseif (%m == Strength) { var %b = Heat Badge:Earth Badge, %hm = HM04 }
          elseif (%m == Flash) { var %b = Knuckle Badge:Marsh Badge, %hm = HM05 }
          elseif (%m == Rock Smash) { var %b = Dynamo Badge:Boulder Badge, %hm = HM06 }
          elseif (%m == Waterfall) { var %b = Rain Badge:Rainbow Badge, %hm = HM07 }
          elseif (%m == Dive) { var %b = Mind Badge:Volcano Badge, %hm = HM08 }
          if (%b) {
            if ($findtok($dados($1,$gettok(%region,1,58),Badges),$gettok(%b,1,58),0,58)) { return Ok! }
            elseif ($findtok($dados($1,$gettok(%region,2,58),Badges),$gettok(%b,2,58),0,58)) { return Ok! }
            else { return No! }
          }
          else { return Ok! }
        }
      }
    }
  }
  return No!
}
;  && ($item($1,%hm).qnt)

alias pc {
  if ($prop == points) {
    var %nick = $1, %r = 0, %x = 1
    while ($findfile(pkp\box\ $+ %nick $+ \,*.ini,%x)) {
      var %y = 1
      while ($ini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%y)) {
        var %pk = $ini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%y)
        tokenize 59 $readini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%pk)
        var %tbase = $basestat(%pk,totalbase), %lv = $3, %totaliv = $calc($16 + $17 + $18 + $19 + $20 + $21), %totalev = $calc($22 + $23 + $24 + $25 + $26 + $27)
        var %exp = $10, %l = $gettok($13,1,58), %l = $iif(%l < 50,1,$iif(%l < 100,1.1,$iif(%l < 150,1.2,$iif(%l < 200,1.3,$iif(%l < 250,1.4,1.5))))), %m = $gettok($12,3,58), %m = $iif(%m == Poke Ball,1,$iif(%m == Great Ball,1.2,$iif(%m == Ultra Ball,1.3,$iif(%m == Master Ball,1.5,1.1)))), %rate = $basestat(%pk,catch), %s = $iif($7 == ON,1.5,1), %rib = $iif($15,$calc(1 + 0.05 * $gettok($15,0,58)),1)
        var %p1 = $int($calc((%tbase * %lv / %m) / 256 * ((256 - %rate) * 100 / 255 / 100))), %p2 = $int($calc( (%exp / (%lv ^ 2)) * ((%totaliv + %lv) / 1.5 + (%totalev * 2 / 64)) + (%tbase / 32))), %p3 = $int($calc(%p2 / 3 * $iif(!%p1,1,%p1) * %l / %m))
        var %r = %r + $int($calc(%p3 * %s * %rib))
        inc %y
      }
      inc %x
    }
    return %r
  }
  elseif ($prop == pks) {
    var %nick = $1, %r = 0, %x = 1
    while ($findfile(pkp\box\ $+ %nick $+ \,*.ini,%x)) {
      var %r = $calc(%r + $ini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,0))
      inc %x
    }
    return %r
  }
}

alias pontuacao {
  var %pontos = $calc($gpoints($1) + $dados($1,PC,Points)), %pk = $calc($totalpokes($1) + $pc($1).pks), %r = $int($calc(%pontos / 32)), %m = $int($calc($rini(cadastros,$1,Info,Money) / 1000)), %o = $calc($rini(cadastros,$1,Info,Online) / 360), %b = $calc(($dados($1,Kanto,Badges).n + $dados($1,Hoenn,Badges).n + $dados($1,Johto,Badges).n) * 60), %s = $calc(($dados($1,Hoenn,Score) + $dados($1,Kanto,Score) + $dados($1,Johto,Score)) * 10), %a = $rini(cadastros,$1,Info,Access)
  var %dex = $rini(cadastros,$1,Info,Pokedex), %ms = $dados($1,Market,Score)
  if (%dex > 350) { var %x = $calc(%dex - 350), %d = $calc(%d + 24000 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 300) { var %x = $calc(%dex - 300), %d = $calc(%d + 12000 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 250) { var %x = $calc(%dex - 250), %d = $calc(%d + 5000 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 200) { var %x = $calc(%dex - 200), %d = $calc(%d + 1000 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 150) { var %x = $calc(%dex - 150), %d = $calc(%d + 500 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 100) { var %x = $calc(%dex - 100), %d = $calc(%d + 300 * %x), %dex = $calc(%dex - %x) }
  if (%dex > 50) { var %x = $calc(%dex - 50), %d = $calc(%d + 100 * %x), %dex = $calc(%dex - %x) }
  if (%dex) { var %x = %dex, %d = $calc(%d + 65 * %x) }
  return $int($calc((50 * 4 ^ %a) + %r + %m + %d + %o + %b + %s + (%pk * 100) + %ms))
}

alias top.add {
  if ($fline(@top,*: $1,0)) { .rline @top $fline(@top,*: $1) $base($pontuacao($1),10,10,10) $+ : $1 | .savebuf @top pkp\top.txt }
  else {
    var %pt = $pontuacao($1)
    if (%pt > $top.pt($top.total)) {
      if ($top.total >= $top.last) { .rline @top 1 $base(%pt,10,10,10) $+ : $1 }
      else { .aline @top $base(%pt,10,10,10) $+ : $1 }
      .savebuf @top pkp\top.txt
    }
  }
}
alias top.rem {
  if ($fline(@top,*: $1,0)) { .dline @top $fline(@top,*: $1) | .savebuf @top pkp\top.txt }
}
alias top.pos {
  if ($1 isnum) { var %line = $calc($top.total - $1 + 1) | return $nullfill($gettok($line(@top,%line),2,58)) }
  else { if ($fline(@top,*: $1,0)) { return $calc($top.total - $fline(@top,*: $1) + 1) } | else { return 0 } }
}
alias top.pt {
  if ($1 isnum) { var %line = $calc($top.total - $1 + 1) | return $base($gettok($line(@top,%line),1,58),10,10,1) }
  else { if ($fline(@top,*: $1,0)) { return $base($gettok($line(@top,$fline(@top,*: $1)),1,58),10,10,1) } | else { return 0 } }
}
alias top.total { var %t = $line(@top,0) | return $iif(%t,%t,0) }
alias top.last { return 50 }
alias top {
  if ($window(@top)) { clear @top }
  else { window -hnls @top }
  var %n = $findfile(pkp\cadastros,*.ini,0), %x = 0
  while (%x < %n) {
    inc %x
    var %f = $findfile(pkp\cadastros,*.ini,%x), %nick = $remove($nopath(%f),.ini)
    if ($rini(cadastros,%nick,Info,Banned)) && (!$gettok($rini(cadastros,%nick,Info,Banned),2,59)) { var %a = 1 }
    if ($npc(%nick)) || ($dados(%nick,Info,Hide)) || (!$nullfill(%nick)) || ($rini(cadastros,%nick,Info,Access) == 5) { var %a = 1 }
    if (%a) { var %a = 0 }
    else {
      var %pt = $pontuacao(%nick)
      ; if (%pt < 400) { .copy pkp\cadastros\ $+ %nick $+ .ini pkp\deleted\ $+ %nick $+ .ini | .remove pkp\cadastros\ $+ %nick $+ .ini }
      if ($top.total == $top.last) { rline @top 1 $base($pontuacao(%nick),10,10,10) $+ : %nick }
      else { aline @top $base($pontuacao(%nick),10,10,10) $+ : %nick }
    }
  }
  .savebuf @top pkp\top.txt
  return
}
alias active {
  var %x = $v(Ativo. $+ $1)
  if (!$prop) { tevent Ativo $1 $2 }
  elseif ($prop == time) { return $tevent(Ativo,$1).time }
}

alias tevent {
  var %x = $v([ [ $1 ] $+ [ . ] $+ [ $2 ] ])
  if (!$prop) {
    if (!$3) { sset [ [ $1 ] $+ [ . ] $+ [ $2 ] ] $date $time | return }
    elseif ($3 == rem) { if (%x) { uset [ [ $1 ] $+ [ . ] $+ [ $2 ] ] } | return }
  }
  elseif ($prop == time) {
    if (%x) { return %x }
    else { return 0 }
  }
}

alias outfit {
  var %ID = $1, %n = $2
  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %n ] ])) { var %outfit = $v([ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %n ] ]) }
  elseif ($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),Info,Outfit)) { var %outfit = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),Info,Outfit) }
  elseif ($gettok($readini(pkp\status.ini,Active,Brain),1,58) == $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) { var %outfit = $brain.outfit() }
  else { var %outfit = 00 }

  return $base(%outfit,10,10,2)
}

alias arena {
  var %l = $1, %type = $2
  if (!$findtok(wild:rod,%type,0,58)) {
    if ($findtok(Fortree City:Viridian City:Azalea Town,%l,0,58)) { var %a = Grama Bem Alta }
    elseif ($findtok(Desert Underpass:Fuchsia City:Olivine City:Cianwood City:Peak Town:Ruins Of Alph,%l,0,58)) { var %a = Areia }
    elseif ($findtok(Lavaridge Town,%l,0,58)) { var %a = Grama }
    elseif ($findtok(Cerulean City:Cinnabar Island:Lavender Town:Ecruteak City:Goldenrod City:Indigo Plateau:Evergrande City:Silverst City:Cycling Road,%l,0,58)) { var %a = Estádio }
    elseif ($findtok(Unknown Dungeon,%l,0,58)) { var %a = Lago:Caverna:Grama:Grama Alta:Areia:Rocha }
    elseif ($findtok(Sunrise City,%l,0,58)) { var %a = Areia:Rocha }
    elseif ($findtok(Peak Town,%l,0,58)) { var %a = Areia:Rocha:Grama }
    elseif ($findtok(White City,%l,0,58)) { var %a = Areia:Grama Alta }
    elseif ($findtok(Victory Road:Mt Mortar:Mt Silver,%l,0,58)) { var %a = Rocha }
    else { var %type = Wild }
  }
  if (!%a) {
    if (%type == wild) {
      if ($findtok(Meteor Falls:Rusturf Tunnel:Evergrande City:Rock Tunnel:Diglett Cave:Victory Road:Unknown Dungeon:Ice Path,%l,0,58)) { var %a = Caverna }
      elseif ($findtok(Mt Chimney:Mt Pyre:Mt Moon:Mt Ember:Terra Cave:Ruins Of Alph,%l,0,58)) { var %a = Rocha }
      elseif ($findtok(Shoal Cave:Seafoam Island:Dark Cave:Fog Cave:Mt Mortar,%l,0,58)) { var %a = Caverna:Lago }
      elseif ($findtok(Fortree City:Ilex Florest,%l,0,58)) { var %a = Grama Bem Alta:Lago:Grama Alta }
      elseif ($findtok(Verdanturf Town:Viridian City:Pewter City,%l,0,58)) { var %a = Grama:Grama Alta }
      elseif ($findtok(Fallarbor Town:Cerulean City:Celadon City:Lake Of Rage,%l,0,58)) { var %a = Grama Alta }
      elseif ($findtok(Lilycove City:Fuchsia City,%l,0,58)) { var %a = Grama Alta:Areia }
      elseif ($findtok(Desert Underpass:Dewford City,%l,0,58)) { var %a = Caverna:Areia }
      elseif ($findtok(Lavaridge Town:Silverst City,%l,0,58)) { var %a = Rocha:Grama }
      elseif ($findtok(Pacifidlog Town:Silver Bay,%l,0,58)) { var %a = Oceano }
      elseif ($findtok(Sky Pillar:Underground Path:Power Plant:Tin Tower,%l,0,58)) { var %a = Estádio }
      elseif ($findtok(Mossdeep City:Cinnabar Island,%l,0,58)) { var %a = Oceano:Areia }
      elseif ($findtok(Sootopolis City:Marine Cave,%l,0,58)) { var %a = Lago }
      elseif ($findtok(Moonlight Woods:White City:Mahogany Town:Lake Of Rage,%l,0,58)) { var %a = Grama Alta:Grama }
      elseif ($findtok(Oldale Town:Littleroot Town,%l,0,58)) { var %a = Grama:Lago }
      elseif ($findtok(Underwater:Water Path:Whirl Edge,%l,0,58)) { var %a = Submerso }
      elseif ($findtok(Whirl Island,%l,0,58)) { var %a = Lago:Areia:Rocha }
      elseif ($findtok(Mt Silver,%l,0,58)) { var %a = Rocha:Lago:Grama Bem Alta:Caverna:Grama Alta }
      elseif ($findtok(Sunrise City:Blackthorn City,%l,0,58)) { var %a = Areia:Rocha }
      else { var %a = Grama }
    }
    else {
      if ($findtok(Dewford City:Slateport City:Mauville City:Fallarbor Town:Lilycove City:Mossdeep City:Vermilion City:Fuchsia City:Seafoam Island:Cinnabar Island:Olivine City:Cianwood City:White City:Peak Town:Sunrise City:Silverst City,%l,0,58)) { var %a = Oceano:Areia }
      elseif ($findtok(Sootopolis City:Evergrande City:Oldale Town:Petalburg City:Rustboro City:Cerulean City:Celadon City:Lake Of Rage:Fog Cave:Dark Cave:Violet City:Cherrygrove City,%l,0,58)) { var %a = Lago }
      else { var %a = Oceano }
    }
  }
  if ($gettok(%a,0,58) > 1) { return $gettok(%a,$rand(1,$gettok(%a,0,58)),58) }
  else { return %a }
}

alias nickscan {
  var %x = 0, %y = $len($1)
  if (%y > 20) { return No! }
  while (%x < %y) {
    inc %x
    var %n = $mid($1,%x,1), %n = $asc(%n)
    if (%n !isnum 48-57) && (%n !isnum 65-90) && (%n !isnum 95) && (%n !isnum 97-122) && (%n !isnum 124) { return No! }
  }
  return Ok!
}

alias ordinal {
  if ($1 == 1) { var %pre = primeir }
  elseif ($1 == 2) { var %pre = segund }
  elseif ($1 == 3) { var %pre = terceir }
  elseif ($1 == 4) { var %pre = quart }
  elseif ($1 == 5) { var %pre = quint }
  elseif ($1 == 6) { var %pre = sext }
  elseif ($1 == 7) { var %pre = sétim }
  elseif ($1 == 8) { var %pre = oitav }
  elseif ($1 == 9) { var %pre = non }
  elseif ($1 == 10) { var %pre = décim }
  else {
    if ($prop == f) { return $1 $+ ª }
    else { return $1 $+ º }
  }
  if ($prop == f) { return %pre $+ a }
  else { return %pre $+ o }
}
alias remtoks {
  var %text = $1, %tok = $2, %chr = $3, %chr² = $iif($4 isnum,$4,%chr), %chr² = $iif(%chr²,%chr²,%chr)
  var %x = 1 | while ($gettok(%tok,%x,%chr²)) { var %text = $remtok(%text,$gettok(%tok,%x,%chr²),1,%chr) | inc %x }
  return %text
}
alias region {
  var %f = pkp\region.ini, %l = $replace($1,$chr(32),_), %x = 1
  while ($ini(%f,%x)) {
    var %r = $ini(%f,%x), %y = 1
    while ($ini(%f,%r,%y)) {
      var %t = $ini(%f,%r,%y)
      if (%l == %t) || (%l $+ : isin %t) { var %res = $iif(%res,%res $+ : $+ %r,%r) }
      inc %y
    }
    inc %x
  }
  return %res
}
alias nickserv {
  if ($1 == identify) { if ($v(Pass. $+ $me)) { return } | sset $+(Pass.,$me) $2 | .timerPASS.CLEAR 1 60 /uset Pass. $+ $me }
  if ($1 == set) && ($2 == password) { if ($v(Pass. $+ $me)) { return } | sset $+(Pass.,$me) $3 | .timerPASS.CLEAR 1 60 /uset Pass. $+ $me }
  nickserv $1-
}
alias pass { if ($readini(pkp\status.ini,Pass,$1)) { return $readini(pkp\status.ini,Pass,$1) } }
alias effect.type {
  var %effect = $gettok($1,1,32)
  if ($findtok(Sleep Burn Frozen Paralyz Poison,%effect,0,32)) { return Primary }
  elseif ($left(%effect,1) isin +-) { return Stat }
  else { return Secondary }
}
alias start.events {
  active $nick | remini pkp\cadastros\ $+ $nick $+ .ini Info Rod | remini pkp\cadastros\ $+ $nick $+ .ini Info Scope
  if ($findtok(%accesslist,$nick,0,58)) { if (%accesslist == $nick) { unset %accesslist } | else { set %accesslist $remtok(%accesslist,$nick,1,58) } }
  if ($findtok(%cadlist,$nick,0,58)) { if (%cadlist == $nick) { unset %cadlist } | else { set %cadlist $remtok(%cadlist,$nick,1,58) } }
  if (!$dados($nick,Info,Perfil,20)) { showmotd $nick } | else { showmotd $nick }
  if ($dados($nick,Market,Score) > $market.max_score) { writeini pkp\cadastros\ $+ $nick $+ .ini Market Score $market.max_score() }
  if (!$totalpokes($nick)) { msg =$nick $cc $+ $nick $+ $ct $+ , está na hora de ganhar seu primeiro pokémon! | msg =$nick $ct $+ Passe no laboratório de $cc $+ $iif($dados($nick,Info,Start) == Hoenn,Littleroot,Pallet) $ct $+ e fale com $cc $+ Prof $iif($dados($nick,Info,Start) == Hoenn,Birch,Oak) $+ $ct $+ . }
  status.msg $nick JOIN
  if ($rini(cadastros,$nick,Info,Access) == 5) { if ($top.pos($nick)) { top.rem $nick } } | else { top.add $dados($nick,Info,Nick) }
  if ($dados($nick,Info,Premium)) {
    if ($dados($nick,Info,Premium).remain <= 0) { premium rem $nick }
    else { msg =$nick $ct $+ Sua conta está $cc $+ premiada $+ $ct $+ . Ainda restam, aproximadamente, $dur($gettok($fulldur($dados($nick,Info,Premium).remain),1,32),$ct,$cc).e $cc $+ online $ct $+ até sua promoção expirar. Aproveite! }
  }
  elseif ($top.pos($nick) == 1) { premium add $nick 7 }
  writeini pkp\cadastros\ $+ $nick $+ .ini Historico Win 0
  writeini pkp\cadastros\ $+ $nick $+ .ini Historico Lose 0
  writeini pkp\cadastros\ $+ $nick $+ .ini Time Online $date $time
  var %x = 0 | while (%x < 6) { inc %x | var %y = $rini(cadastros,$nick,$rini(cadastros,$nick,Team,%x),Learn) | if ($gettok(%y,0,58)) { msg =$nick $ct $+ Seu pokémon $cc $+ $rini(cadastros,$nick,Team,%x) $ct $+ possui $numero($gettok(%y,0,58)) $iif($gettok(%y,0,58) > 1,ataques,ataque) a aprender: $cc $+ $replace($separe(%y),$chr(44),$ct $+ $chr(44) $+ $cc) $+ $ct $+ . } }
  if ($teampos($nick,Egg)) {
    var %egg.m = $rini(cadastros,$nick,Egg,Milhagem), %egg.h = $rini(cadastros,$nick,Egg,Hatch)
    if (%egg.m >= %egg.h) {
      .msg =$nick $cc $+ $nick $+ $ct $+ , Egg(15? $+ $ct $+ )/ $+ $cc $+ ?? $ct $+ está se chocando!
      if ($checkteam($nick,$rini(cadastros,$nick,Egg,DNA)) == $true) { .msg =$nick $ct $+ Não foi possível chocá-lo. Já $cc $+ existe $ct $+ um pokémon no seu $cc $+ time $ct $+ com o $cc $+ mesmo nome $ct $+ do pokémon que nascerá! }
      else { var %egg.pk = $rini(cadastros,$nick,Egg,DNA) | hatch $nick | .msg =$nick $ct $+ Parabéns! $cc $+ Egg $ct $+ se chocou e nasceu $cc $+ %egg.pk $+ $ct $+ ! }
    }
  }
  if ($dados($nick,Info,Notice)) { msg =$nick $ct $+ Atenção, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ : " $+ $dados($nick,Info,Notice) $+ " | remini pkp\cadastros\ $+ $nick $+ .ini Info Notice }
  if ($readini(pkp\status.ini,Prize,Active)) { msg =$nick $ct $+ Atenção! Uma $cc $+ premiação $ct $+ está em andamento! Para participar, leia as instruções digitando ' $+ $cc $+ .Premio $+ $ct $+ '. Boa sorte! }
  .check_legend
}
alias get_idle {
  var %nick = $1
  if ($dados(%nick,Time,Online)) { var %last = $dados(%nick,Time,Online) }
  elseif ($dados(%nick,Time,Goto)) { var %last = $dados(%nick,Time,Goto) }
  elseif ($dados(%nick,Time,Wild)) { var %last = $dados(%nick,Time,Wild) }
  else { var %last = $dados(%nick,Time,Register) }

  if (!%last) { var %last = 01/01/2006 00:00:00 }
  var %last = $ctime(%last), %now = $ctime($date $time)
  return $calc(%now - %last)
}
alias is_legend {
  if ($ini(pkp\status.ini,Legendary,$1)) { return $true }
  else { return $false }
}


; Para buscas apenas no pc, $box.search(<nick>,<pokemon>)
alias get.pkdata {
  var %nick = $1, %pk = $2
  if ($checkteam(%nick,%pk)) { return $getpkline(%nick,%pk) }
  else {
    var %y = 1, %dir = pkp\box\ $+ %nick $+ \
    while ($exists(%dir $+ %y $+ .ini)) {
      var %box.file = %dir $+ %y $+ .ini
      if ($readini(%box.file,Box,%pk)) { return $readini(%box.file,Box,%pk) }
      inc %y
    }
  }
  return $false
}

alias clear_legend {
  var %file = pkp\status.ini, %pk = $1, %region = $gettok($readini(%file,Legendary,%pk),1,59)

  writeini %file Legendary %pk %region $+ ; $+ 0
  if (!$findtok(Lugia Ho-oh,%pk,32)) {
    var %leg = $readini(%file,%region,Legendary)
    if (%leg) { var %leg = $addtok(%leg,%pk,58) }
    else { var %leg = %pk }
    writeini %file %region Legendary %leg
  }
}

alias master.search {
  var %tfiles = $findfile(pkp\cadastros\,*.ini,0), %t = 0
  while (%t < %tfiles) {
    inc %t
    var %nick = $remove($nopath($findfile(pkp\cadastros\,*.ini,%t)),.ini), %pk = $get.pkdata(%nick,$1)
    if (%pk) && ($rini(cadastros,%nick,Info,Access) < 5) { return %nick }
  }

}

alias update5 {
  .echo 4 Atualizando... Aguarde, isso pode demorar.
  var %pk = Regirock | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Regice | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Registeel | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Latias | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Latios | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Kyogre | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Groudon | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Rayquaza | writeini pkp\status.ini Legendary %pk Hoenn; $+ $master.search(%pk)
  var %pk = Articuno | writeini pkp\status.ini Legendary %pk Kanto; $+ $master.search(%pk)
  var %pk = Zapdos | writeini pkp\status.ini Legendary %pk Kanto; $+ $master.search(%pk)
  var %pk = Moltres | writeini pkp\status.ini Legendary %pk Kanto; $+ $master.search(%pk)
  var %pk = Mewtwo | writeini pkp\status.ini Legendary %pk Kanto; $+ $master.search(%pk)
  var %pk = Raikou | writeini pkp\status.ini Legendary %pk Johto; $+ $master.search(%pk)
  var %pk = Entei | writeini pkp\status.ini Legendary %pk Johto; $+ $master.search(%pk)
  var %pk = Suicune | writeini pkp\status.ini Legendary %pk Johto; $+ $master.search(%pk)
  var %pk = Lugia | writeini pkp\status.ini Legendary %pk Johto; $+ $master.search(%pk)
  var %pk = Ho-oh | writeini pkp\status.ini Legendary %pk Johto; $+ $master.search(%pk)
  echo 2 Atualização finalizada. Por favor, cheque o arquivo 1pkp\status.ini 2antes de começar.
}

alias legend_release {
  var %pk = $1, %nick = $2
  if (!%nick) {
    var %nick = $master.search(%pk)
    if (!%nick) {
      return
    }
  }

  if ($checkteam(%nick,%pk)) {
    if ($dados(%nick,%pk,Hold)) { item.add $dados(%nick,pk,Hold) }
    remteam %nick %pk
    remini pkp\cadastros\ $+ %nick $+ .ini %pk
    if ($dados(%nick,Team,1) == Egg) || (!$dados(%nick,Team,1)) {
      addpoke %nick $gettok(Caterpie Wurmple,$rand(1,2),32) 5 5:PkPAdv:Poke  Ball
    }
  }
  else {
    var %y = 1, %z = 0, %dir = pkp\box\ $+ %nick $+ \
    while ($exists(%dir $+ %y $+ .ini)) && (!%z) {
      var %box.file = %dir $+ %y $+ .ini, %data = $readini(%box.file,Box,%pk)
      if (%data) {
        if ($gettok(%data,14,59)) { item.add %nick $gettok(%data,14,59) }
        remini %box.file Box %pk
        var %z = 1
      }
      inc %y
    }
  }
  clear_legend %pk
}

alias check_legend {
  var %x = 1, %file = pkp\status.ini
  while ($ini(%file,Legendary,%x)) {
    var %pk = $ini(%file,Legendary,%x), %opt = $readini(%file,Legendary,%pk), %region = $gettok(%opt,1,59), %nick = $gettok(%opt,2,59)
    if (%nick) {
      var %pk.idle = $int($calc( ($egroup(%pk).step / 30720) * 60 * 60 * 24 * 28 )), %user.idle = $get_idle(%nick)
      ;echo %nick vai perder %pk (idle maximo: %pk.idle $+ ) ja passou %user.idle
      if (%user.idle > %pk.idle) && ($checknick(%nick) == No!) {
        legend_release %pk %nick
      }
    }
    inc %x
  }
}
