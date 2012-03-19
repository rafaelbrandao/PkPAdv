alias sset { hadd var $1 $2- }
alias uset { if (* isin $1) { hdel -w var $1 } | else { hdel var $1 } }
alias usedv { if ($1 isnum) { return $hget(var,$1).item } | else { return $hget(var,0).item } }
alias v { return $hget(var,$1) }
alias pkarena /window -ek @PkmnAdvance
alias cadastro.add {
  writeini pkp\cadastros\ $+ $1 $+ .ini Info Nick $1 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Password $2 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Email $3 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Money 200 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Milhagem 0 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Access 1 | writeini pkp\cadastros\ $+ $1 $+ .ini Info Item 0
  writeini pkp\cadastros\ $+ $1 $+ .ini Info Perfil 1:1:1:0:1:1:1:1:1:1:0:0:1:0:0:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0 | writeini pkp\cadastros\ $+ $1 $+ .ini Hoenn Visited Littleroot Town | writeini pkp\cadastros\ $+ $1 $+ .ini Time Register $date $time | writeini pkp\cadastros\ $+ $1 $+ .ini Pokedex 001 None
}
alias returnpokes {
  var %x = 0, %y = $totalpokes($1), %r = 0
  while (%x < %y) {
    inc %x
    if (%r) {
      var %name = $rini(cadastros,$1,Team,%x)
      if (%name == Egg) { var %r = %r $ct $+ Egg $+ $ct $+ (15? $+ $ct $+ )/ $+ $cc $+ ?? }
      else { var %r = %r $ct $+ $rini(cadastros,$1,%name,Name) $+ $ct $+ ( $+ $iif($rini(cadastros,$1,%name,Sex) == Male,12M,$iif($rini(cadastros,$1,%name,Sex) == Female,13F,14N/A)) $+ $iif($rini(cadastros,$1,%name,Shiny) == ON,04+,$+) $+ $ct $+ )/ $+ $cc $+ $rini(cadastros,$1,%name,Level) }
    }
    else {
      var %name = $rini(cadastros,$1,Team,%x)
      if (%name == Egg) { var %r = $ct $+ Egg $+ $ct $+ (15? $+ $ct $+ )/ $+ $cc $+ ?? }
      else { var %r = $ct $+ $rini(cadastros,$1,%name,Name) $+ $ct $+ ( $+ $iif($rini(cadastros,$1,%name,Sex) == Male,12M,$iif($rini(cadastros,$1,%name,Sex) == Female,13F,14N/A)) $+ $iif($rini(cadastros,$1,%name,Shiny) == ON,04+,$+) $+ $ct $+ )/ $+ $cc $+ $rini(cadastros,$1,%name,Level) }
    }
  }
  return %r
}
alias totalpokes { var %x = 1, %y = 0 | while ($rini(cadastros,$1,Team,%x)) { inc %y | inc %x } | return %y }
alias getmoney {
  var %n = $1, %r = 0
  var %t = $int($calc($1 / 1000000000000)) | if (%t) { var %r = %t }
  var %mmm = $int($calc(($1 - (%t * 1000000000000)) / 1000000000)) | if (%mmm) { if (%r) { var %r = %r $+ , $+ $base(%mmm,10,10,3) } | else { var %r = %mmm } } | elseif (%r) { var %r = %r $+ ,000 }
  var %mm = $int($calc(($1 - (%t * 1000000000000) - (%mmm * 1000000000)) / 1000000)) | if (%mm) { if (%r) { var %r = %r $+ , $+ $base(%mm,10,10,3) } | else { var %r = %mm } } | elseif (%r) { var %r = %r $+ ,000 }
  var %m = $int($calc(($1 - (%t * 1000000000000) - (%mmm * 1000000000) - (%mm * 1000000)) / 1000)) | if (%m) { if (!%r) { var %r = %m } | else { var %r = %r $+ , $+ $base(%m,10,10,3) } } | elseif (%r) { var %r = %r $+ ,000 }
  var %u = $calc($1 - (%t * 1000000000000) - (%mmm * 1000000000) - (%mm * 1000000) - (%m * 1000)) | if (%u) { if (!%r) { var %r = %u } | else { var %r = %r $+ , $+ $base(%u,10,10,3) } } | elseif (%r) { var %r = %r $+ ,000 }
  return $iif(%r,%r,0)
}

alias getitem {
  if ($2) {
    var %itens = $rini(cadastros,$1,Item,$2)
    if ($prop == sort) { var %itens = $sorttok(%itens,58) }
    if (%itens) {
      var %x = 0, %y = $gettok(%itens,0,58)
      while (%x < %y) {
        inc %x
        var %i = $gettok(%itens,%x,58), %t = $gettok(%i,-1,32), %i = $remtok(%i,%t,1,32)
        if ($findtok(HM01:HM02:HM03:HM04:HM05:HM06:HM07:HM08,%i,0,58)) || ($2 == Special) {
          if (%i != PokeDex) {
            if (%r) { var %r = %r - %i }
            else { var %r = $ct $+ %i }
          }
        }
        else {
          if (%r) { var %r = %r - %i $chr(40) $+ × $+ $cc $+ $base(%t,10,10,2) $+ $ct $+ $chr(41) }
          else { var %r = $ct $+ %i $chr(40) $+ × $+ $cc $+ $base(%t,10,10,2) $+ $ct $+ $chr(41) }
        }
      }
      return $iif(%r,%r,Nenhum)
    }
    else { return Nenhum }
  }
  else {
    var %x = 1 | while ($ini(pkp\cadastros\ $+ $1 $+ .ini,Item,%x)) {
      var %n = $ini(pkp\cadastros\ $+ $1 $+ .ini,Item,%x)
      if ($rini(cadastros,$1,Item,%n)) { var %t = $gettok($rini(cadastros,$1,Item,%n),0,58) } | else { var %t = 0 }
      var %n = $item.bag(%n)
      if (%n == Item) { var %n1 = $calc(%n1 + %t) }
      elseif (%n == Ball) { var %n2 = %t }
      elseif (%n == TM Case) { var %n3 = $calc(%n3 + %t) }
      elseif (%n == Special) { var %n4 = %t | if ($wildtok($rini(cadastros,$1,Item,Special),Pokedex *,0,58)) { var %n4 = $calc(%n4 - 1) } }
      elseif (%n == Berry) { var %n5 = %t }
      inc %x
    }
    var %x = 0 | while (%x < 5) {
      inc %x
      if (%n [ $+ [ %x ] ]) {
        if (%x == 1) { var %n = Item } | elseif (%x == 2) { var %n = Ball } | elseif (%x == 3) { var %n = TM Case } | elseif (%x == 4) { var %n = Special } | elseif (%x == 5) { var %n = Berry }
        var %t = %n [ $+ [ %x ] ]
        if (%r) { var %r = %r - %n $chr(40) $+ × $+ $cc $+ $base(%t,10,10,2) $+ $ct $+ $chr(41) }
        else { var %r = $ct $+ %n $chr(40) $+ × $+ $cc $+ $base(%t,10,10,2) $+ $ct $+ $chr(41) }
      }
    }
  }
  if (%r) { return %r }
  else { return Nenhum }
}
alias item.bag {
  var %n = $1
  if ($prop == s) {
    if (%n == Item) { return Instant:Hold }
    elseif (%n == TM Case) { return TM:MT:HM }
    elseif (%n == Ball) || (%n == Special) || (%n == Berry) { return $org(%n) }
    return $false
  }
  else {
    if ($findtok(Instant:Hold,%n,0,58)) { return Item }
    elseif ($findtok(TM:MT:HM,%n,0,58)) { return TM Case }
    elseif (%n == Ball) { return Ball }
    elseif (%n == Special) { return Special }
    elseif (%n == Berry) { return Berry }
  }
}
alias item {
  var %n = $1, %i = $gettok($2,1,58), %qnt = $gettok($2,2,58), %type = $item.data(%i,bag), %qnt = $iif(%qnt,%qnt,1), %qnt = $iif(%qnt > 99,99,%qnt)
  var %itens = $rini(cadastros,%n,Item,%type)
  if ($prop == check) { if ($wildtok(%itens,%i *,0,58)) && (%i) { return Ok! } | return No! }
  if ($prop == qnt) || (!$prop) { if ($wildtok(%itens,%i *,0,58)) { return $gettok($wildtok(%itens,%i *,1,58),-1,32) } | return 0 }
  if ($prop == rem) {
    if ($wildtok(%itens,%i *,0,58)) {
      var %i = $wildtok(%itens,%i *,1,58), %t = $gettok(%i,-1,32), %i = $remtok(%i,%t,1,32)
      var %s = $calc(%t - %qnt)
      if (%s > 0) { var %r = $reptok(%itens,$wildtok(%itens,%i *,1,58),%i %s,58) }
      else { var %r = $remtok(%itens,$wildtok(%itens,%i *,1,58),1,58) }
      writeini pkp\cadastros\ $+ %n $+ .ini Item %type $iif(%r,%r,0)
    }
    return
  }
  if ($prop == add) {
    if (%itens) {
      if ($wildtok(%itens,%i *,0,58)) {
        var %i = $wildtok(%itens,%i *,1,58), %t = $gettok(%i,-1,32), %i = $remtok(%i,%t,1,32)
        var %s = $calc(%t + %qnt) | if (%s > 99) { var %s = 99 }
        var %r = $reptok(%itens,$wildtok(%itens,%i *,1,58),%i %s,58)
      }
      else { var %r = %itens $+ : $+ %i %qnt }
      writeini pkp\cadastros\ $+ %n $+ .ini Item %type $iif(%r,%r,0)
    }
    else { writeini pkp\cadastros\ $+ %n $+ .ini Item %type %i %qnt }
  }
}
alias item.rem { return $item($1,$2-).rem }
alias item.add { var %i = $item.data($2-,name) | return $item($1,$iif(%i,%i,$2-)).add }

alias ct { return :ct; }
alias rct { return :rct; }
alias cc { return :cc; }
alias cc { return :rcc; }
alias b.create {
  var %x = $rand(1000,9999)
  while ($v(B. $+ %x $+ .Player.1)) { var %x = $rand(1000,9999) }

  var %Player = 1, %ID = %x, %nick = $dados($1,Info,Nick)

  sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] $iif(%nick,%nick,$1)
  if ($2) {
    var %x = $rini(cadastros,$1,$2,Name)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] %x
    sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Level)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Shiny)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Sex)

    if (!$3) { return %ID }
    sset [ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ] ON
    var %Player = $battle.team(%ID,%Player).num, %x = $rini(cadastros,$1,$3,Name)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] $iif(%nick,%nick,$1)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] %x
    sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Level)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Shiny)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ] $rini(cadastros,$1,%x,Sex)
  }

  return %ID

}

alias battle.start {
  var %team1 = $1, %team2 = $2, %mode = $3
  if ($gettok(%team1,0,32) > 1) {
    if ($gettok(%team2,0,32) > 1) {
      b.create.fila $gettok(%team1,1,32) $rini(cadastros,$gettok(%team1,1,32),Team,1) | var %ID = $checknickid($gettok(%team1,1,32)).ID
      b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,1)
      b.join %ID $gettok(%team1,2,32) $rini(cadastros,$gettok(%team1,2,32),Team,1)
      b.join %ID $gettok(%team2,2,32) $rini(cadastros,$gettok(%team2,2,32),Team,1)
    }
    else {
      b.create.fila $gettok(%team1,1,32) $rini(cadastros,$gettok(%team1,1,32),Team,1) | var %ID = $checknickid($gettok(%team1,1,32)).ID
      b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,1)
      b.join %ID $gettok(%team1,2,32) $rini(cadastros,$gettok(%team1,2,32),Team,1)
      b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,2)
    }
  }
  else {
    if ($gettok(%team2,0,32) > 1) {
      b.create.fila $gettok(%team1,1,32) $rini(cadastros,$gettok(%team1,1,32),Team,1) $rini(cadastros,$gettok(%team1,1,32),Team,2) | var %ID = $checknickid($gettok(%team1,1,32)).ID
      b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,1)
      b.join %ID $gettok(%team2,2,32) $rini(cadastros,$gettok(%team2,2,32),Team,1)
    }
    else {
      if (d isin %mode) {
        b.create.fila $gettok(%team1,1,32) $rini(cadastros,$gettok(%team1,1,32),Team,1) $rini(cadastros,$gettok(%team1,1,32),Team,2) | var %ID = $checknickid($gettok(%team1,1,32)).ID
        b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,1) $rini(cadastros,$gettok(%team2,1,32),Team,2)
      }
      else {
        b.create.fila $gettok(%team1,1,32) $rini(cadastros,$gettok(%team1,1,32),Team,1) | var %ID = $checknickid($gettok(%team1,1,32)).ID
        b.join %ID $gettok(%team2,1,32) $rini(cadastros,$gettok(%team2,1,32),Team,1)
      }
    }
  }
  if (m isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] $iif($gettok(%mode,2,32),$gettok(%mode,2,32),1) }
  if (p isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .PP ] ] ON }
  if (u isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON }
  if (d isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ] ON }
  if (s isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .Switch ] ] ON }
  if (l isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .Log ] ] ON | if ($isfile(pkp\log\ $+ %ID $+ .txt)) { .remove pkp\log\ $+ %ID $+ .txt } }
  if (c isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ] ON }
  if (a isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .SLPClause ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .FRZClause ] ] ON }
  if (e isin %mode) { sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:1 ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:2 ] ] ON | if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:3 ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:4 ] ] ON } }
  b.start.fight %ID

}

alias battle.npc {
  var %nick = $1, %npc = $2, %control = $3
  var %x = 0 | while (%x < $gettok(%npc,0,59)) { inc %x | if ($gettok(%npc,%x,59) !isnum) { var %npc = $puttok(%npc,$rini(npc,npc,ID,$gettok(%npc,%x,59)),%x,59) } }
  var %x = 0 | while (%x < $gettok(%nick,0,59)) { inc %x | if ($gettok(%nick,%x,59) !isnum) && (!$dados($gettok(%nick,%x,59),Info,Nick)) { var %nick = $puttok(%nick,$rini(npc,npc,ID,$gettok(%nick,%x,59)),%x,59) } }
  if ($abs($calc($gettok(%npc,0,59) - $gettok(%nick,0,59)))) {
    if ($gettok(%nick,0,59) > 1) {
      var %x = 1 | while ($gettok(%nick,%x,59)) {
        var %p = $gettok(%nick,%x,59)
        if (%p isnum) {
          if (%x == 1) { b.create.fila $gettok(%nick,2,59) $rini(cadastros,$gettok(%nick,2,59),Team,1) | var %x = 2  }
          var %file = $int($calc(%p / 100)) $+ 00, %t = $rini(npc,%file,%p,Team), %t = $iif(%t > 3,3,%t), %pk = $rini(npc,%file,%p,1), %team = 3
          if (!%ID) { var %ID = $checknickid($gettok(%nick,2,59)).ID }
          sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%file,%p,Name)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
          sset [ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ] ON
          var %y = 1 | while ($rini(npc,%file,%p,%y)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %y ] $+ ] : ] $+ [ %Team ] ] $rini(npc,%file,%p,%y) | inc %y }
        }
        else { b.create.fila %p $rini(cadastros,%p,Team,1) | var %ID = $checknickid(%p).ID }
        inc %x
      }
    }
    else {
      if ($rini(cadastros,%nick,Team,2)) && ($rini(cadastros,%nick,Team,2) != Egg) { b.create.fila %nick $rini(cadastros,%nick,Team,1) $rini(cadastros,%nick,Team,2) }
      else { var %npc = $gettok(%npc,1,59) | b.create.fila %nick $rini(cadastros,%nick,Team,1) }
    }
  }
  else {
    if ($gettok(%nick,0,59) > 1) {
      var %x = 1 | while ($gettok(%nick,%x,59)) {
        var %p = $gettok(%nick,%x,59)
        if (%p isnum) {
          if (%x == 1) { b.create.fila $gettok(%nick,2,59) $rini(cadastros,$gettok(%nick,2,59),Team,1) | var %x = 2  }
          var %file = $int($calc(%p / 100)) $+ 00, %t = $rini(npc,%file,%p,Team), %t = $iif(%t > 3,3,%t), %pk = $rini(npc,%file,%p,1), %team = 3
          if (!%ID) { var %ID = $checknickid($gettok(%nick,2,59)).ID }
          sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%file,%p,Name)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
          sset [ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ] ON
          var %y = 1 | while ($rini(npc,%file,%p,%y)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %y ] $+ ] : ] $+ [ %Team ] ] $rini(npc,%file,%p,%y) | inc %y }
        }
        else { b.create.fila %p $rini(cadastros,%p,Team,1) | var %ID = $checknickid(%p).ID }
        inc %x
      }
    }
    elseif ($gettok(%npc,0,59) > 1) {
      if ($rini(cadastros,%nick,Team,2)) && ($rini(cadastros,%nick,Team,2) != Egg) { b.create.fila %nick $rini(cadastros,%nick,Team,1) $rini(cadastros,%nick,Team,2) }
      else { b.create.fila %nick $rini(cadastros,%nick,Team,1) }
    }
    else {
      if (d isin $rini(npc,$int($calc(%npc / 100)) $+ 00,%npc,Mode)) {
        if ($rini(cadastros,%nick,Team,2)) && ($rini(cadastros,%nick,Team,2) != Egg) { b.create.fila %nick $rini(cadastros,%nick,Team,1) $rini(cadastros,%nick,Team,2) }
        else { b.create.fila %nick $rini(cadastros,%nick,Team,1) }
      }
      else { b.create.fila %nick $rini(cadastros,%nick,Team,1) }
    }
  }
  if (!%ID) { var %ID = $checknickid(%nick).ID } | var %n = 0
  if ($gettok(%npc,0,59) > 1) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) { var %npc = $gettok(%npc,1,59) }
  var %x = 0 | while (%x < $gettok(%npc,0,59)) {
    inc %x | inc %n | var %p = $gettok(%npc,%x,59), %file = $int($calc(%p / 100)) $+ 00, %t = $rini(npc,%file,%p,Team)
    sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) + %t)
    var %cn = $gettok(%control,%x,59) | if (%cn) { if ($checknick(%cn) == Ok!) && ($checknickid(%cn) == No!) { sset [ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ $calc(%x + 1) ] ] %cn } }
    if (p isin $rini(npc,%file,%p,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .PP ] ] ON }
    if (s isin $rini(npc,%file,%p,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Switch ] ] ON }
    if (u isin $rini(npc,%file,%p,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON }
    if (a isin $rini(npc,%file,%p,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .SLPClause ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .FRZClause ] ] ON }

  }
  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] 6 }
  var %x = 0 | while (%x < $gettok(%npc,0,59)) {
    inc %x | var %p = $gettok(%npc,%x,59), %file = $int($calc(%p / 100)) $+ 00, %t = $v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]), %t = $iif(%n > 1,$int($calc(%t / 2)),%t), %team = $iif(%n > 1,$calc(2 * %x),2), %y = 0
    while (%y < %t) {
      inc %y | var %pk = $rini(npc,%file,%p,%y)
      if (%pk) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %y ] $+ ] : ] $+ [ %Team ] ] %pk
        if (%n == 1) {
          if (%y == 1) {
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%file,%p,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
            if ($rini(npc,%file,%p,Say)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Say: ] $+ [ %Team ] ] $rini(npc,%file,%p,Say) }
            if ($rini(npc,%file,%p,Outfit)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%file,%p,Outfit) }
          }
          if (%y == 2) && ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %Team ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ $battle.team(%ID,%Team).num ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %Team ] ]) }
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,%Team).num ] ] $rini(npc,%file,%p,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ $battle.team(%ID,%Team).num ] ] ON
          }
        }
        else {
          if (%y == 1) {
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%file,%p,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
            if ($rini(npc,%file,%p,Say)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%file,%p,Say) }
            if ($rini(npc,%file,%p,Outfit)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%file,%p,Outfit) }
          }
        }
      }
    }
  }

  sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON
  b.start.fight %ID

}
; %n = $b.join(%ID,%npc).n

alias b.join {
  var %ID = $1, %Player = 1
  while (%Player < 4) {
    inc %Player
    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ])) {
      var %nick = $dados($2,Info,Nick)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] $iif(%nick,%nick,$2)
      var %p = $iif($2 == Wild,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%Player) ] ]),$2)
      if ($3) {
        var %x = $rini(cadastros,%p,$3,Name)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] %x
        sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Level)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Shiny)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Sex)
      }
      if ($4) && ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) {
        var %Player = $battle.team(%ID,%Player).num, %x = $rini(cadastros,%p,$4,Name)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] $iif(%nick,%nick,$2)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] %x
        sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Level)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Shiny)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ] $rini(cadastros,%p,%x,Sex)
      }
      if ($prop == n) { return %Player }
      else { return }
    }
  }
}
alias b.left {
  var %Player = 2, %ID = $1
  if ($2 isnum 2-4) { var %Player = $2 }

  var %x = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ])

  uset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ]
  uset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ]

  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,%Player).num ] ]) == %x) {
    var %Player = $battle.team(%ID,%Player).num
    uset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Player ] ]
    uset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Player ] ]
  }
}
alias b.start.fight {
  var %ID = $1, %Player = 1
  ; [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %n ] $+ ] : ] $+ [ %Player ] ] = Pokémon:Level:Nature:Sex:Shiny:Trait:Loyalty:Hold:HP:ATK:DEF:SPD:SATK:SDEF:HPAtual:Status:Move1:Move2:Move3:Move4:PP1:PP2:PP3:PP4
  var %t = $v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]), %t = $iif(%t,%t,1), %loop = $iif($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ]),4,2)

  :again
  var %p = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ])

  if (%Player == 3) && (%mirror) && (!%cmirror) { var %Player = 1, %cmirror = 1 | goto again }
  if (%Player == 2) && (%mirror) { inc %Player | goto again }
  if (%Player == 1) && (!%mirror) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ])) { inc %Player | goto again }
  if (%p) {
    var %team = $iif($battle.team(%ID,%Player),%Player,$battle.side(%Player))

    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ %Team ] ])) {
      if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ])) {
        var %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ %Team ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ] $gettok(%pk,1,58)
      }
    }
    else {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ])) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) && ($battle.team(%ID,%Player)) { var %r = $int($calc(%t / 2)), %r = $iif(%r,%r,%t) } | else { var %r = %t }
        var %x = 0, %n = 0 | while (%x < %r) {
          inc %x
          if ($rini(cadastros,%p,Team,%x)) && ($rini(cadastros,%p,Team,%x) != Egg) {
            inc %n | var %tpk = $rini(cadastros,%p,Team,%x), %tlv = $dados(%p,%tpk,Level) | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %n ] $+ ] : ] $+ [ %Team ] ] $getteam(%p,%tpk)
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ])) && ($rvs(%team) == 1) && (!%mirror) {
              if (!%hlv) { var %hlv = 0 } | if (%tlv > %hlv) { var %hlv = %tlv } | if (%hpk) { var %hpk = %hpk $+ : $+ %tpk } | else { var %hpk = %tpk }
            }
          }
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ])) && ($rvs(%team) == 1) && (!%mirror) {
          var %mirror = 1 | .echo $mirror(%ID,%team,%hlv,%hpk)
        }
      }
      else {
        var %tpk = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ %Team ] ] $getteam(%p,%tpk)
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ])) && ($rvs(%team) == 1) && (!%mirror) {
          var %hlv = $gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ %Team ] ]),2,58)
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) { var %tlv = $dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,%Player).num ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $battle.team(%ID,%Player).num ] ]),Level) | if (%tlv > %hlv) { var %hlv = %tlv } }
          .echo $mirror(%ID,%Team,%hlv,%tpk)
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) && (!$battle.team(%ID,%Player)) {
          var %tpk = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $battle.team(%ID,%Player).num ] ])
          sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 2 ] $+ ] : ] $+ [ %Team ] ] $getteam(%p,%tpk)
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ])) && ($rvs(%team) == 1) && (!%mirror) {
            .echo $mirror(%ID,%Team,%hlv,%tpk).2
          }
        }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Mirror ] ])) && ($rvs(%team) == 1) { var %mirror = 1 }
      }
    }

    var %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ $teamnumber(%ID,%Player) ] $+ ] : ] $+ [ %Team ] ])
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
    if ($gettok(%pk,19,58)) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %Player ] ] $gettok(%pk,19,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %Player ] ] $gettok(%pk,23,58)
    }
    if ($gettok(%pk,20,58)) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %Player ] ] $gettok(%pk,20,58)
      sset [ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %Player ] ] $gettok(%pk,24,58)
    }
    sset [ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %Player ] ] $basestat($gettok(%pk,1,58),Type)
    sset [ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %Player ] ] $gettok(%pk,25,58)
  }
  if ($gettok($v(B. [ $+ [ %ID ] $+ ] .Say: [ $+ [ %Player ] ]),1,59)) {
    var %x = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]) | if ($gettok(%x,0,95) > 1) { if ($findtok(Magma:Aqua:Rocket,$gettok(%x,2,95),0,58)) { var %x = $cc $+ $gettok(%x,1,95) $ct $+ ( $+ $upper($gettok(%x,2,95)) $+ ) } | else { var %x = $ct $+ $gettok(%x,1,95) $cc $+ $gettok(%x,2,95) } } | else { var %x = $cc $+ %x }
    msg $+(=,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%Player) ] ])) $chr(160) %x $ct $+ - $gettok($v(B. [ $+ [ %ID ] $+ ] .Say: [ $+ [ %Player ] ]),1,59)
  }
  if (%Player == 2) && (%mirror) && (!%cmirror) { var %Player = 1, %cmirror = 1 | goto again }
  if (%Player < %loop) { inc %Player | goto again }
  uset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ * ] ]

  ; if ($checknick($v(B. [ $+ [ %ID ] $+ ] .Player.1)) == Ok!) { msg = [ $+ [ $checknick($v(B. [ $+ [ %ID ] $+ ] .Player.1)) ] ]  }
  if (!$v(B. [ $+ [ %ID ] $+ ] .Wild)) {
    var %x = 0
    while (%x < %loop) {
      inc %x | var %p = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ]), %p2 = $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %x ] ])
      if ($battle.player(%ID,%x) == %x) {
        if ($checknick(%p) == Ok!) && (!$npc(%p)) {
          if ($battle.team(%ID,$rvs(%x))) { msg = [ $+ [ %p ] ] $ct $+ Iniciando batalha contra $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%x) ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$rvs(%x)) $+ ) e $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,$rvs(%x)).num ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$battle.team(%ID,$rvs(%x)).num) $+ ) $+ ... }
          else { msg = [ $+ [ %p ] ] $ct $+ Iniciando batalha contra $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%x) ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$rvs(%x)) $+ ) $+ ... }
        }
        elseif ($npc(%p)) && ($checknick(%p2) == Ok!) {
          if ($battle.team(%ID,$rvs(%x))) { msg = [ $+ [ %p2 ] ] $ct $+ Iniciando batalha contra $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%x) ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$rvs(%x)) $+ ) e $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,$rvs(%x)).num ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$battle.team(%ID,$rvs(%x)).num) $+ ) $+ ... }
          else { msg = [ $+ [ %p2 ] ] $ct $+ Iniciando batalha contra $cc $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%x) ] ]) $ct $+ ( $+ $chr(35) $+ $outfit(%ID,$rvs(%x)) $+ ) $+ ... }
        }
      }
    }
  }
  var %l = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ 1 ] ]),Info,Locate)
  if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .Arena ] ] $arena(%l,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Rod ] ]),rod,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ]),wild,0))) }

  if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) {
    var %x = 0
    while (%x < 2) {
      inc %x
      if ($battle.team(%ID,%x)) {
        if (%x == 1) { var %team1 = $bb $+ $+(:player,%x,;) $+ $lb $+ / $+ $bb $+ $+(:player,$battle.team(%ID,%x).num,;) }
        else { var %team2 = $bb $+ $+(:player,%x,;) $+ $lb $+ / $+ $bb $+ $+(:player,$battle.team(%ID,%x).num,;) }
      }
      else { var %temp = $+(:player,%x,;) | var %team [ $+ [ %x ] ] $bb $+ %temp }
    }
    msgfight %ID $lb $+ Batalha entre %team1 $lb $+ e %team2 $lb $+ - Arena: $v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ])
    var %x = 0 | while (%x < 4) {
      inc %x
      if ($battle.player(%ID,%x) == %x) { var %p [ $+ [ %x ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $+ $lb $+ ( $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Female,13F,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Male,12M,N/A)) $+ $lb $+ ) $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %x ] ]) == ON,4+ $+ $lb $+,$+) $+ / $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %x ] ]) }
      else {
        if (%p [ $+ [ $battle.side(%x) ] ]) { var %p [ $+ [ $battle.side(%x) ] ] %p [ $+ [ $battle.side(%x) ] ] $lb $+ e $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $+ $lb $+ ( $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Female,13F,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Male,12M,N/A)) $+ $lb $+ ) $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %x ] ]) == ON,4+ $+ $lb $+,$+) $+ / $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %x ] ]) }
        else { var %p [ $+ [ $battle.side(%x) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) $+ $lb $+ ( $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Female,13F,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %x ] ]) == Male,12M,N/A)) $+ $lb $+ ) $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %x ] ]) == ON,4+ $+ $lb $+,$+) $+ / $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %x ] ]) }
      }
    }
    var %x = 1, %y = 3:1:4:2 | while ($gettok(%y,%x,58)) { if (%p [ $+ [ $gettok(%y,%x,58) ] ]) { msgfight %ID $bb $+ $+(:player,$gettok(%y,%x,58),;) $lb $+ está usando %p [ $+ [ $gettok(%y,%x,58) ] ] $+ $lb $+ ! } | inc %x }
  }
  else {
    var %sh1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ 1 ] ]), %sh2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ 2 ] ]), %g1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ 1 ] ]), %g2 = $v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ 2 ] ])
    msgfight %ID $lb $+ Batalha entre $bb $+ :player1; $+ $lb $+ ( $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 1 ] ]) $+ $lb $+ $iif(%sh1 == ON,4 $+ $chr(43) $+ $lb $+,$+) $+ $iif(%g1 == Male,/ $+ 12M $+ $lb $+,$iif(%g1 == Female,/ $+ 13F $+ $lb $+,$+)) $+ ) e $bb $+ :player2; $+ $lb $+ ( $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ 2 ] ]) $+ $lb $+ $iif(%sh2 == ON,4 $+ $chr(43) $+ $lb $+ ,$+) $+ $iif(%g2 == Male,/ $+ 12M $+ $lb $+,$iif(%g2 == Female,/ $+ 13F $+ $lb $+,$+)) $+ ) - Arena: $v([ [ B. ] $+ [ %ID ] $+ [ .Arena ] ])
  }

  var %w = 1, %o = $battle.order(%ID)
  while ($gettok(%o,%w,58)) {
    var %n = $gettok(%o,%w,58)
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Air Lock) || ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Cloud Nine) { sset [ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ] ON }
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Damp) { sset [ [ B. ] $+ [ %ID ] $+ [ .Damp ] ] ON }
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Intimidate) {
      var %tt = $battle.target(%ID,%n).both, %x = 1 | while ($gettok(%tt,%x,58)) {
        var %t = $gettok(%tt,%x,58) | inc %x
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %t ] ]) != Clear Body) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %t ] ]) != Hyper Focus) && ($calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %t ] ]) - 1) >= -6) { sset [ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %t ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .B.Atk. ] $+ [ %t ] ]) - 1) | msgfight %ID $bb $+ $+(:player,%t,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %t ] ]) $lb $+ diminuiu ataque com $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) $+ $lb $+ ! }
      }
    }
    inc %w
  }
  var %w = 1
  while ($gettok(%o,%w,58)) {
    var %n = $gettok(%o,%w,58)
    if (!$v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Drought) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Sunny Day | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Drizzle) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Rain Dance | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Sand Stream) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Sandstorm | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999
      }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ]) == Trace) {
        var %a = $battle.target(%ID,%n).rand | msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ copiou a trait $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %a ] ]) de $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %a ] ]) $+ ! | sset [ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %a ] ])
      }
    }
    inc %w
  }
  var %n1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Player.1 ] ])
  if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) && ($dados(%n1,Info,Region) == Hoenn) && ($dados(%n1,Info,Locate)) {
    if (($dados(%n1,Info,Start) == Johto) && ($dados(%n1,Quests,League))) || ($dados(%n1,Johto,League)) {
      if ($dados(%n1,Info,Locate) == $readini(pkp\status.ini,Active,Terra_Cave)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Sunny Day | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999 }
      if ($dados(%n1,Info,Locate) == $readini(pkp\status.ini,Active,Marine_Cave)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] Rain Dance | sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999 }
    }
  }

  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sunny Day) { msgfight %ID $lb $+ A luz do sol agora brilha mais forte! | battle.c.weather %ID }
  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Rain Dance) { msgfight %ID $lb $+ Uma forte chuva acaba de começar! | battle.c.weather %ID }
  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ]) == Sandstorm) { msgfight %ID $lb $+ Uma tempestade de areia foi iniciada! | battle.c.weather %ID }

  if ($window(@PkmnAdvance)) { msgfight %ID $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ 1 ] ]) $+ $lb $+ , escolha seu golpe. $chr(91) $+ $returnmoves(%ID,1) $+ $chr(93) $+ . Você tem 1 minuto. }
  sset [ [ B. ] $+ [ %ID ] $+ [ .View ] ] $battle.show(%ID)

  var %n = 0 | while (%n < %loop) {
    inc %n
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) {
      sset [ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %n ] ] 1
      if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %n ] ] ON
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) && ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) == Ok!) {
          if ($battle.player(%ID,%n) == %n) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. }
        }
        else {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Auto ] ])) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Wild ] ])) { randmove %ID %n | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } | else { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]) != Struggle) { IA %ID %n } | else { randmove %ID %n | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %n ] ] $battle.target(%ID,%n).rand } }
          }
        }
      }
      else {
        if ($battle.player(%ID,%n) == %n) { if ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) == Ok!) { msg = [ $+ [ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) ] ] $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ $lb $+ , escolha o golpe de $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ . $chr(91) $+ $returnmoves(%ID,%n) $+ $chr(93) $+ . Você tem 1 minuto. } }
      }
    }
  }
  .timerEndTurn $+ %ID 1 60 /battle.turn %ID
}
alias msgfight {
  if ($window(@PkmnAdvance)) { echo @PkmnAdvance 1,15 $+ $remove($2-,[p1],[p2]) }
  else {
    if ($v([ [ B. ] $+ [ $1 ] $+ [ .Log ] ]) == ON) {
      var %msg = $2-, %msg = $replace(%msg,:barra0;,$str($chr(160),10),:barra1;,$str($chr(127),1) $+ $str($chr(160),9),:barra2;,$str($chr(127),2) $+ $str($chr(160),8),:barra3;,$str($chr(127),3) $+ $str($chr(160),7),:barra4;,$str($chr(127),4) $+ $str($chr(160),6),:barra5;,$str($chr(127),5) $+ $str($chr(160),5))
      var %msg = $replace(%msg,:barra6;,$str($chr(127),6) $+ $str($chr(160),4),:barra7;,$str($chr(127),7) $+ $str($chr(160),3),:barra8;,$str($chr(127),8) $+ $str($chr(160),2),:barra9;,$str($chr(127),9) $+ $str($chr(160),1),:barra10;,$str($chr(127),10))
      write pkp\log\ $+ $1 $+ .txt $remove(%msg,[p1],[p2],:lb;,:bb;)
    }
    var %msg = $2-, %x = 1
    if ($wildtok($strip(%msg),$chr(91) $+ p $+ *,0,32)) {
      while ($gettok(%msg,%x,32)) {
        var %tmsg = $gettok(%msg,%x,32)
        if ($left($strip(%tmsg),2) == $chr(91) $+ p) {
          var %n = $remove($left($strip(%tmsg),3),$chr(91) $+ p), %y = %x - 1
          while (!%h) {
            inc %y | var %part = $gettok(%msg,%y,32)
            if (%part) { var %took = $iif(%took,%took %part,%part) } | else { var %h = 1 }
            if ($chr(91) $+ /p $+ %n $+ $chr(93) isin %part) {
              var %took = $remove(%took,$chr(91) $+ p $+ %n $+ $chr(93)), %took = $remove(%took,$chr(91) $+ /p $+ %n $+ $chr(93))
              if (%n isnum) { var %m = $battle.side(%n) } | else { var %m = %n }
              var %t = %m [ $+ [ %m ] ]
              if (%t) { var %m [ $+ [ %m ] ] %t %took } | else { var %m [ $+ [ %m ] ] %took }
              var %h = 1, %took = 0
            }
          }
          var %x = %y, %h = 0
        }
        else { var %y = 0 | while (%y < 4) { inc %y | var %t = %m [ $+ [ %y ] ] | if (%t) { var %m [ $+ [ %y ] ] %t %tmsg } | else { var %m [ $+ [ %y ] ] %tmsg } } | if (%mw) { var %mw = %mw %tmsg } | else { var %mw = %tmsg } }
        inc %x
      }
    }
    else { var %y = 0 | while (%y < 4) { inc %y | var %t = %m [ $+ [ %y ] ] | if (%t) { var %m [ $+ [ %y ] ] %t %msg } | else { var %m [ $+ [ %y ] ] %msg } } | if (%mw) { var %mw = %mw %msg } | else { var %mw = %msg } }
    var %x = 0 | while (%x < 4) {
      inc %x
      if ($battle.player($1,%x) == %x) && ($v([ [ B. ] $+ [ $1 ] $+ [ .Player. ] $+ [ %x ] ])) {
        if ($checknick($v(B. [ $+ [ $1 ] $+ ] .Player. [ $+ [ %x ] ])) == Ok!) {
          var %t = %m [ $+ [ $battle.side(%x) ] ], %rmsg = $iif(%t,%t,%mw)
          var %y = 1 | while ($v(B. $+ $1 $+ .Player. $+ %y)) { var %rmsg = $replace(%rmsg,:player $+ %y $+ ;,$v(B. $+ $1 $+ .Player. $+ %y)) | inc %y }
          msg = [ $+ [ $v([ [ B. ] $+ [ $1 ] $+ [ .Player. ] $+ [ %x ] ]) ] ] %rmsg
        }
        if ($checknick($v(B. [ $+ [ $1 ] $+ ] .TruePlayer: [ $+ [ %x ] ])) == Ok!) {
          var %t = %m [ $+ [ $battle.side(%x) ] ], %rmsg = $iif(%t,%t,%mw)
          var %y = 1 | while ($v(B. $+ $1 $+ .Player. $+ %y)) {
            if ($v(B. [ $+ [ $1 ] $+ ] .TruePlayer: [ $+ [ %y ] ])) { var %rmsg = $replace(%rmsg,:player $+ %y $+ ;,$v(B. $+ $1 $+ .TruePlayer: $+ %y)) }
            else { var %rmsg = $replace(%rmsg,:player $+ %y $+ ;,$v(B. $+ $1 $+ .Player. $+ %y)) } | inc %y
          }
          msg = [ $+ [ $v([ [ B. ] $+ [ $1 ] $+ [ .TruePlayer: ] $+ [ %x ] ]) ] ] %rmsg

        }
      }
    }
    if ($v(B. [ $+ [ $1 ] $+ ] .Watching)) {
      var %x = 1, %y = $gettok($v(B. [ $+ [ $1 ] $+ ] .Watching),0,58)
      while (%x <= %y) {
        var %rmsg = %mw
        var %z = 1 | while ($v(B. $+ $1 $+ .Player. $+ %z)) { var %rmsg = $replace(%rmsg,:player $+ %z $+ ;,$v(B. $+ $1 $+ .Player. $+ %z)) | inc %z }
        msg = [ $+ [ $gettok($v(B. [ $+ [ $1 ] $+ ] .Watching),%x,58) ] ] 1,15 $+ %rmsg
        inc %x
      }
    }
  }
}
alias type {
  if ($findtok(Normal Fighting Poison Ground Flying Bug Rock Ghost Steel,$1,0,32)) { return Normal }
  else { return Special }
}

alias rini { return $readini(PkP\ $+ $1 $+ \ $+ $2 $+ .ini,$3,$4) }

alias clearfight { uset [ [ B. ] $+ [ %ID ] $+ [ .*. ] $+ [ %Player ] ] }

alias b.create.fila {
  if ($checknickid($1) == No!) {
    var %x = 1 | while (%x) {
      var %y = $v([ [ F. ] $+ [ %x ] $+ [ .ID ] ])
      if (!%y) {
        sset [ [ F. ] $+ [ %x ] $+ [ .ID ] ] $b.create($1,$2,$3)
        return
      }
      inc %x
    }
  }
}

alias appeared {
  var %x = 1, %n = 2 | while (%x) {
    var %y = $v([ [ F. ] $+ [ %x ] $+ [ .ID ] ])
    if (%y) {
      var %wild = $v([ [ B. ] $+ [ %y ] $+ [ .Player. ] $+ [ %n ] ])
      if (%wild == Wild) { if ($v([ [ B. ] $+ [ %y ] $+ [ .Poke. ] $+ [ %n ] ]) == $1) { return $true } }
    }
    inc %x
    if (!%y) { var %x = 0 }
  }
  return $false
}

alias b.remove.fila {
  var %x = 1, %n = 1 | while (%x) {
    var %y = $v([ [ F. ] $+ [ %x ] $+ [ .ID ] ])
    if ($1 == ID) && ($2) {
      if (%y) {
        if (%y == $2) {
          var %x1 = %x
          uset [ [ F. ] $+ [ %x1 ] $+ [ .ID ] ]
          :loop2
          var %y2 = $v([ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ])
          if (%y2) { sset [ [ F. ] $+ [ %x1 ] $+ [ .ID ] ] $v([ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ]) | uset [ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ] | inc %x1 | goto loop2 }
        }
        inc %x
      }
      else { var %x = 0 }
    }
    else {
      if (%y) {
        if ($v(B. $+ %y $+ .Player.1) == $1) || ($v(B. $+ %y $+ .Player.2) == $1) || ($v(B. $+ %y $+ .Player.3) == $1) || ($v(B. $+ %y $+ .Player.4) == $1) {
          var %x1 = %x
          uset [ [ F. ] $+ [ %x1 ] $+ [ .ID ] ]
          :loop
          var %y2 = $v([ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ])
          if (%y2) { sset [ [ F. ] $+ [ %x1 ] $+ [ .ID ] ] $v([ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ]) | uset [ [ F. ] $+ [ $calc(%x1 + 1) ] $+ [ .ID ] ] | inc %x1 | goto loop }
        }
        inc %x
      }
      else { var %x = 0 }
    }
  }
}

alias b.check.id {
  var %x = 1 | while (%x) {
    var %y = $v([ [ F. ] $+ [ %x ] $+ [ .ID ] ])
    if (!%y) { return No! } | if (%y == $1) { return OK! } | inc %x
  }
}

alias checknickid {
  if (!$1) { return No! }
  var %x = 1 | while (%x) {
    var %y = $v([ [ F. ] $+ [ %x ] $+ [ .ID ] ])
    if (!%y) { return No! }
    var %t = 0 | while (%t < 4) {
      inc %t
      if ($1 == $v([ [ B. ] $+ [ %y ] $+ [ .Player. ] $+ [ %t ] ])) || ($1 == $v([ [ B. ] $+ [ %y ] $+ [ .TruePlayer: ] $+ [ %t ] ])) {
        if ($prop == ID) { return %y }
        if ($prop == hide) {
          if ($1 == $v([ [ B. ] $+ [ %y ] $+ [ .TruePlayer: ] $+ [ %t ] ])) { return 1 }
          else { return 0 }
        }
        return OK!
      }
    }
    inc %x
  }
}
alias getgv {
  var %chance = $1, %gv = $calc(256 * (%chance / 100))
  echo Fêmea(0- $+ $calc(%gv - 1) $+ ) Macho( $+ %gv $+ -256) Gender Value = %gv
}
//echo Hmm.. $calc((132 * (%nUP * (1 / 2))) + (132 * (1 / 2)))
; if (%w == 1) { var %ppp1 = %priority, %spd1 = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .SPD. ] $+ [ %w ] ]) * $statstage($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %w ] ])) * %pcheck)) } | else { var %ppp2 = %priority, %spd2 = $int($calc($v([ [ B. ] $+ [ %ID ] $+ [ .SPD. ] $+ [ %w ] ]) * $statstage($v([ [ B. ] $+ [ %ID ] $+ [ .B.Spd. ] $+ [ %w ] ])) * %pcheck)) }
Alias rmoves {
  var %ID = $1, %n = $2, %x = 0, %r = 0
  while (%x < 4) {
    inc %x | var %y = $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])
    if ($prop != left) {
      if ($wildtok($v([ [ B. ] $+ [ %ID ] $+ [ .Disable. ] $+ [ %n ] ]),%y $+  $+ $chr(59) $+ *,0,58)) { var %y = 0 }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Torment. ] $+ [ %n ] ])) { if (%y == $v([ [ B. ] $+ [ %ID ] $+ [ .Forbidden. ] $+ [ %n ] ])) { var %y = 0 } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Taunt. ] $+ [ %n ] ])) { if ($gettok($read(pkp\moveslist.txt,s,%y),7,58)) { var %y = 0 } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Choice Band) && ($v([ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Choice. ] $+ [ %n ] ]) != %y) { var %y = 0 } }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %n ] ])) { if ($v([ [ B. ] $+ [ %ID ] $+ [ .Encore. ] $+ [ %n ] ]) != %y) { var %y = 0 } }
    }
    if (%y) {
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %y),4,58), %mpp = $calc(%mpp * 1.6) }
        else { var %mpp = $gettok($read(pkp\moveslist.txt, s, %y),4,58), %mpp = $calc(%mpp * 0.6) }
      }
      else {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %y),4,58) }
        else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, %y),4,58) / 5)) }
      }
      var %pp = $v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ]) | if (%pp >= %mpp) { var %y = 0 }
    }
    if (%y) {
      if (%r) { var %r = %r $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ]) }
      else { var %r = $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ]) }
    }
  }
  return %r
}
Alias nmove {
  var %ID = $1, %n = $2, %move = $3
  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %n ] ]) == %move) { return 1 }
  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %n ] ]) == %move) { return 2 }
  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %n ] ]) == %move) { return 3 }
  elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %n ] ]) == %move) { return 4 }
  else { return 0 }
}
Alias bb { return :bb; }
Alias lb { return :lb; }
alias battlefaint {
  var %n = $2, %ID = $1
  if (!$v(B. $+ %ID $+ .Player.1)) { return $true }
  if (%n !isin 1234) { return $false }
  if (!$v(B. $+ %ID $+ .Player. $+ %n)) { return $false }
  :start
  var %hp = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]), %hp2 = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])
  if (%hp > %hp2) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] %hp2 }
  if (%hp < 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 }
  if (%hp > 0) { return $false }
  else {
    var %team = $battle.player(%ID,%n), %tn = $teamnumber(%ID,%team,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %team ] ])
    sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %team ] ] $gettok(%pk,1-7,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,9-14,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,17-20,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %n ] ])) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %n ] ])
    if (!$battle.left(%ID,%n)) && (!$battle.left(%ID,$battle.team(%ID,%n).num)) { winfight %ID $iif($battle.side(%n) == 1,2,1) | return $true }
    elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Lose: ] $+ [ %n ] ])) { return $false }
    else {

      msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi derrotado!
      if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]),1,59) == Switch) { return $false }

      var %base = $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),BaseEXP), %lvl = $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]), %exp = $int($calc((%base * %lvl) / 7)), %wild = $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) == Wild,1,1.5), %foes = $battle.target²(%ID,%n).both
      var %min.exp = $int($calc(%exp * %wild)), %exp = $int($calc(%exp / $gettok(%foes,0,58))), %win.exp = 0

      var %x = 1, %texp = 0
      while ($gettok(%foes,%x,58)) {
        var %foe = $gettok(%foes,%x,58)
        if (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]))) { var %trainerID = $iif($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),ID) == $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),1,1.5) } | else { var %trainerID = 1 }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %foe ] ]) == Lucky Egg) { var %exp.boost = 1.5 } | else { var %exp.boost = 1 }
        var %texp = $calc(%texp + $int($calc(%exp * %trainerID * %wild * %exp.boost)))
        inc %x
      }
      var %win.exp = $calc(%win.exp + %texp), %money = $calc(%money + (%lvl * 10))

      var %win.exp = $int($calc(%win.exp / $gettok(%foes,0,58))), %min.exp = $int($calc(%min.exp / $gettok(%foes,0,58))), %money = $int($calc(%money / $gettok(%foes,0,58)))

      var %z = 1 | while ($gettok(%foes,%z,58)) {
        var %foe = $gettok(%foes,%z,58)

        if (!$v([ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %foe ] ])) {
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %foe ] ]) < 100) { var %loyalty = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),Loyalty) }

          var %l = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),Info,Last), %r = 0
          if (%loyalty != $null) {
            if ($gettok(%l,1,58) == win) {
              if ($gettok(%l,2,58) == $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])) { var %r = 0 } | else { var %r = 1 }
              if ($gettok(%l,3,58) == $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])) { var %r = %r } | else { var %r = %r + 1 }
            }
            else { var %r = 0 }
            if (%r) {
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %foe ] ]) == Soothe Bell) { var %r = %r * 2 }
              var %loyalty = $gettok(%loyalty,1,58) $+ : $+ $calc($gettok(%loyalty,2,58) + %r)
            }
          }
          writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ .ini Info Last win: $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])
          if (%loyalty != $null) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) Loyalty %loyalty | var %loyalty }

          if ($v([ [ B. ] $+ [ %ID ] $+ [ .OutRules. ] $+ [ %foe ] ]) != ON) {

            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %foe ] ]) == Macho Brace) { var %effort = 2 } | else { var %effort = 1 }

            var %te = $totaleffort($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ])), %bev = $basestat($v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),EV)
            if (%te < 510) {
              var %y = 0 | while (%y < %effort) {
                inc %y
                var %x = 0 | while (%x < 6) {
                  inc %x | var %p = $gettok(%bev,%x,32), %stat = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]),$+(EV,$nstat(%x))), %p = $iif($calc(%stat + %p) > 255,$calc(255 - %stat),%p), %p = $iif($calc(%te + %p) > 510,$calc(510 - %te),%p), %r = $calc(%stat + %p), %te = $calc(%te + %p)
                  writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) $+(EV,$nstat(%x)) %r | if (%te == 510) { var %x = 6 }
                }
              }
            }

            writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $+ .ini Info Money $int($calc($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]),Info,Money) + %money))

            addexp $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %foe ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %foe ] ]) %win.exp
            var %thp = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %foe ] ])

            var %player = %foe, %x = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),Level)
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ]) < %x) {
              sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ] %x
              sset [ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),HP)
              sset [ [ B. ] $+ [ %ID ] $+ [ .Loyalty. ] $+ [ %Player ] ] $gettok($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),Loyalty),1,58)
              sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ]) + ($v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %Player ] ]) - %thp))
              if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Transform. ] $+ [ %Player ] ])) {
                sset [ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),Atk)
                sset [ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),Def)
                sset [ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),Spd)
                sset [ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),SAtk)
                sset [ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %Player ] ] $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]),SDef)
              }
              ; Pokémon:Level:Nature:Sex:Shiny:Trait:Loyalty:Hold:HP:ATK:DEF:SPD:SATK:SDEF:HPAtual:Status:Move1:Move2:Move3:Move4:PP1:PP2:PP3:PP4
              var %team = $battle.player(%ID,%Player), %tn = $teamnumber(%ID,%Player), %tt = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] . ] $+ [ %team ] ]), %x = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Atk. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Def. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Spd. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .SAtk. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .SDef. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %Player ] ])
              sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] . ] $+ [ %Team ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Player ] ]) $+ : $+ $gettok(%tt,3-6,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Loyalty. ] $+ [ %Player ] ]) $+ : $+ $gettok(%tt,8,58) $+ : $+ %x $+ : $+ $gettok(%tt,16-25,58)
            }
          }


        }
        inc %z
      }
      if (!$v([ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %n ] ])) {

        var %l = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),Info,Last), %r = 0
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) < 100) {
          var %loyalty = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),Loyalty)
          if ($gettok(%l,1,58) == win) { var %r = 1 }
          else {
            if ($gettok(%l,2,58) == $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])) { var %r = 1 }
            if ($checkfoe(%ID,%n,Player.,$gettok(%l,3,58))) { var %r = %r + 1 } | else { var %r = 0 }
          }
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Soothe Bell) { var %r = $int($calc(%r / 2)) }
          if (%r) { if ($gettok(%loyalty,2,58)) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Loyalty $gettok(%loyalty,1,58) $+ : $+ $calc($gettok(%loyalty,2,58) - %r) } | else { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Loyalty $gettok(%loyalty,1,58) $+ : $+ $calc(0 - %r) } }
        }
        writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini Info Last lose: $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.target(%ID,%n).rand ] ])

        if ($v([ [ B. ] $+ [ %ID ] $+ [ .OutRules. ] $+ [ %n ] ]) != ON) {
          var %trainerID = $iif($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),ID) == $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),1,1.5)
          if ($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ]) == Lucky Egg) { var %exp.boost = 1.5 } | else { var %exp.boost = 1 }
          var %lose.exp = $int($calc(%min.exp * %trainerID * %wild * %exp.boost / 2))
          writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini Info Money $int($calc($rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),Info,Money) + (%money / 2)))
          addexp $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) %lose.exp
        }
      }
      if (!$battle.left(%ID,%n).total) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ])) {
          if (!$checkfoe.left(%ID,%n,Trait.,Cloud Nine,a)) && (!$checkfoe.left(%ID,%n,Trait.,Air Lock,a)) {
            uset [ [ B. ] $+ [ %ID ] $+ [ .NoWeather ] ]
            var %w = 1, %o = $battle.order(%ID)
            while ($gettok(%o,%w,58)) {
              var %m = $gettok(%o,%w,58)
              if ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %m ] ]) > 0) {
                if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %m ] ]) == Drought) { var %changeweather = Sunny Day }
                if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %m ] ]) == Drizzle) { var %changeweather = Rain Dance }
                if ($v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %m ] ]) == Sand Stream) { var %changeweather = Sandstorm }
              }
              inc %w
            }
            if (%changeweather) {
              if (%changeweather != $v([ [ B. ] $+ [ %ID ] $+ [ .Weather ] ])) {
                sset [ [ B. ] $+ [ %ID ] $+ [ .Weather ] ] %changeweather
                if (%changeweather == Sunny Day) { msgfight %ID $lb $+ A luz do sol agora brilha mais forte! }
                elseif (%changeweather == Rain Dance) { msgfight %ID $lb $+ Uma forte chuva acaba de começar! }
                elseif (%changeweather == Sandstorm) { msgfight %ID $lb $+ Uma tempestade de areia foi iniciada! }
              }
              sset [ [ B. ] $+ [ %ID ] $+ [ .WeatherTurns ] ] 999
            }
          }
        }
        sset [ [ B. ] $+ [ %ID ] $+ [ .Lose: ] $+ [ %n ] ] ON | return $false
      }
      if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) && ($checknick($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ])) == Ok!) { var %npc = 0 }
        else { var %npc = 1 }
      }
      else { var %npc = 0 }
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) && (!%npc) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch
        if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { var %player = $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %n ] ]) } | else { var %player = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) }
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) && (!$battle.team(%ID,%n)) {
          var %t = $v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ $battle.team(%ID,%n).num ] ])
          if (%t == Switch) {
            if ($battle.left(%ID,%n).total < 2) && ($battle.wait(%ID).timer) { uset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] | sset [ [ B. ] $+ [ %ID ] $+ [ .Lose: ] $+ [ %n ] ] ON | return $false }
          }
          elseif ($gettok(%t,1,59) == Switch) {
            if ($battle.left(%ID,%n).total < 2) { uset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] | sset [ [ B. ] $+ [ %ID ] $+ [ .Lose: ] $+ [ %n ] ] ON | return $false }
            else { msg = [ $+ [ %player ] ] $bb $+ %player $+ $lb $+ , escolha o pokémon com o comando ' $+ $bb $+ .Trocar $+ $lb $+ '. Você tem 1 minuto. }
          }
          else { msg = [ $+ [ %player ] ] $bb $+ %player $+ $lb $+ , escolha o pokémon com o comando ' $+ $bb $+ .Trocar $+ $lb $+ '. Você tem 1 minuto. }
        }
        else { msg = [ $+ [ %player ] ] $bb $+ %player $+ $lb $+ , escolha o pokémon com o comando ' $+ $bb $+ .Trocar $+ $lb $+ '. Você tem 1 minuto. }
        .timerEndTurn $+ %ID 1 60 /battle.turn %ID
        return $true
      }
      elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) && (%npc) && ($battle.wait(%ID).timer) {
        if (!$IA.switch(%ID,%n)) {
          var %team = $battle.player(%ID,%n), %tn = $battle.left(%ID,%n).next, %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ])
          ; sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ] $gettok(%pk,1-7,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,9-14,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,17-20,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %n ] ])) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HiddenPower. ] $+ [ %n ] ])
          sset [ [ B. ] $+ [ %ID ] $+ [ .TPoke. ] $+ [ %n ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])
          sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ] $gettok(%pk,1,58)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Switch; $+ %tn
        }
        return $true
      }
      else {
        .echo $foe(%ID,%n,Taunt.,58,p).del
        .echo $foe(%ID,%n,NoEscape.,58,p).del
        .echo $foe(%ID,%n,Vortex.,58,p).del
        .echo $foe(%ID,%n,Attract.,58,p).del
        var %player = %n, %team = $battle.player(%ID,%n)

        if (%npc) {
          var %tn = $IA.switch(%ID,%n).n
          if (!%tn) { var %tn = $battle.left(%ID,%n).next }
        }
        else { var %tn = $battle.left(%ID,%n).next }

        var %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %Team ] ]), %tpk = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Player ] ])
        var %x = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]), %x1 = $v([ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%n) ] ]), %x2 = $v([ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%n) ] ]), %x3 = $v([ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%n) ] ]), %x4 = $v([ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%n) ] ])
        uset [ [ B. ] $+ [ %ID ] $+ [ .*. ] $+ [ %n ] ]
        sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] %x | if (%x1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Reflect. ] $+ [ $battle.side(%Player) ] ] %x1 } | if (%x2) { sset [ [ B. ] $+ [ %ID ] $+ [ .LightScreen. ] $+ [ $battle.side(%Player) ] ] %x2 } | if (%x3) { sset [ [ B. ] $+ [ %ID ] $+ [ .Mist. ] $+ [ $battle.side(%Player) ] ] %x3 } | if (%x4) { sset [ [ B. ] $+ [ %ID ] $+ [ .Safeguard. ] $+ [ $battle.side(%Player) ] ] %x4 }
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

        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %Player ] ] Nothing | sset [ [ B. ] $+ [ %ID ] $+ [ .Target. ] $+ [ %Player ] ] %Player

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
        msgfight %ID $bb $+ $+(:player,%n,;) $lb $+ substituiu $bb $+ %tpk $lb $+ por $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ $lb $+ ( $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Female,13F,$iif($v([ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %n ] ]) == Male,12M,N/A)) $+ $lb $+ ) $+ $iif($v([ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %n ] ]) == ON,4+ $+ $lb $+,$+) $+ / $+ $bb $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %n ] ]) $+ $lb $+ !

        sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %Player ] ] Switch; $+ %tn
        sset [ [ B. ] $+ [ %ID ] $+ [ .Switch. ] $+ [ %Player ] ] 1
        sset [ [ B. ] $+ [ %ID ] $+ [ .Turn. ] $+ [ %n ] ] 0
        sset [ [ B. ] $+ [ %ID ] $+ [ .Moved. ] $+ [ %n ] ] Ok
        if ($prop != s) { if ($battle.switch(%ID,%n)) { goto start } }
      }
    }
  }
}

alias battlefaints {
  var %ID = $1
  while (%ID) {
    var %n = 0, %r = 0
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) { var %loop = 4 } | else { var %loop = 2 }
    while (%n < %loop) {
      inc %n
      var %hp = $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]), %hp2 = $v([ [ B. ] $+ [ %ID ] $+ [ .HP. ] $+ [ %n ] ])
      if (%hp > %hp2) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] %hp2 }
      if ($gettok($v([ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ]),1,59) != Switch) {
        if (%hp <= 0) { sset [ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ] 0 | inc %r }
        var %team = $battle.player(%ID,%n), %tn = $teamnumber(%ID,%n,$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])), %pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %team ] ])
        sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %team ] ] $gettok(%pk,1-7,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Hold. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,9-14,58) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %n ] ]) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .Status. ] $+ [ %n ] ])) $+ : $+ $gettok(%pk,17-20,58) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP1. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP2. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP3. ] $+ [ %n ] ])) $+ : $+ $else.null($v([ [ B. ] $+ [ %ID ] $+ [ .PP4. ] $+ [ %n ] ]))
      }
    }
    if (%r <= 1) { return $false }
    if (!$battle.left(%ID,$battle.side(%n))) && (!$battle.left(%ID,$battle.team(%ID,$battle.side(%n)).num)) && (!$battle.left(%ID,$rvs(%n))) && (!$battle.left(%ID,$battle.team(%ID,$rvs(%n)).num)) {
      if ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) || ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,%n).num ] ]))) { winfight %ID $battle.side(%n) | return $true }
      elseif ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%n) ] ]))) || ($npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,$rvs(%n)).num ] ]))) { winfight %ID $iif($battle.side(%n) == 1,2,1) | return $true }
      else {
        var %n = 0 | while (%n < %loop) {
          inc %n
          if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Lose: ] $+ [ %n ] ])) { msgfight %ID $bb $+ $+(:player,%n,;) $+ 's $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $lb $+ foi derrotado! }
          if ($battle.player(%ID,%n) == %n) {
            var %l = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),Info,Last), %loyalty = $rini(cadastros,$v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]),Loyalty), %r = 0
            if ($gettok(%l,1,58) == win) { var %r = 1 }
            else {
              if ($gettok(%l,2,58) == $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ])) { var %r = 1 }
              if ($checkfoe(%ID,%n,Player.,$gettok(%l,3,58))) { var %r = %r + 1 } | else { var %r = 0 }
            }
            writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini Info Last lose: $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) $+ : $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.target(%ID,%n).rand ] ])
            if ($gettok(%loyalty,2,58)) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Loyalty $gettok(%loyalty,1,58) $+ : $+ $calc($gettok(%loyalty,2,58) - %r) }
            else { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %n ] ]) Loyalty $gettok(%loyalty,1,58) $+ : $+ $calc(0 - %r) }
          }
        }
        msgfight %ID $lb $+ Batalha empatada! Sem vencedores definidos...
        msgfight %ID $lb $+ Esta batalha foi concluída.
        battle.thief %ID
        b.remove.fila $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ])
        if ($v(B. [ $+ [ %ID ] $+ ] .Watching)) { var %x = $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),0,58), %y = 0 | while (%y < %x) { inc %y | uset Watch. [ $+ [ $gettok($v(B. [ $+ [ %ID ] $+ ] .Watching),%y,58) ] ] } }
        uset B. $+ %ID $+ *
      }
      return $true
    }
    var %t
    if ($2) { var %t = $2 }
    else { var %n = 0 | while (%n < %loop) { inc %n | var %t = $addtok(%t,%n,58) } }
    var %r = 0
    while ($gettok(%t,1,58)) {
      var %n = $gettok(%t,1,58), %t = $deltok(%t,1,58) | if ($battlefaint(%ID,%n).s) { if (!$v(B. $+ %ID $+ .Player.1)) { return $true } | inc %r }
    }
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Switch ] ])) {
      if (%r) { return $true }
      else { if (!$battle.switch(%ID)) { return $false } }
    }
    else {
      if ($battle.switch(%ID)) { var %start = 1 }
      if (%start) { var %start }
      else { return $false }
    }
  }
}
alias evstage { if ($1 == -6) { return (9 / 3) } | elseif ($1 == -5) { return (8 / 3) } | elseif ($1 == -4) { return (7 / 3) } | elseif ($1 == -3) { return (6 / 3) } | elseif ($1 == -2) { return (5 / 3) } | elseif ($1 == -1) { return (4 / 3) } | elseif ($1 == 1) { return (3 / 4) } | elseif ($1 == 2) { return (3 / 5) } | elseif ($1 == 3) { return (3 / 6) } | elseif ($1 == 4) { return (3 / 7) } | elseif ($1 == 5) { return (3 / 8) } | elseif ($1 == 6) { return (3 / 9) } | else { return 1 } }
alias accstage { if ($1 == -6) { return (3 / 9) } | elseif ($1 == -5) { return (3 / 8) } | elseif ($1 == -4) { return (3 / 7) } | elseif ($1 == -3) { return (3 / 6) } | elseif ($1 == -2) { return (3 / 5) } | elseif ($1 == -1) { return (3 / 4) } | else { return 1 } }
alias statstage { if ($1 == -6) { return (2 / 8) } | elseif ($1 == -5) { return (2 / 7) } | elseif ($1 == -4) { return (2 / 6) } | elseif ($1 == -3) { return (2 / 5) } | elseif ($1 == -2) { return (2 / 4) } | elseif ($1 == -1) { return (2 / 3) } | elseif ($1 == 1) { return 1.5 } | elseif ($1 == 2) { return 2 } | elseif ($1 == 3) { return 2.5 } | elseif ($1 == 4) { return 3 } | elseif ($1 == 5) { return 3.5 } | elseif ($1 == 6) { return 4 } | else { return 1 } }
alias barra {
  var %a = $1, %b = $2, %n = $calc(%b / 10)
  return :barra $+ $int($calc(%a / %b * 10)) $+ ;
  var %n = $calc(%a / %b * 100)
  if ($calc(%n * 10) >= %a) && ($calc(%n * 9) < %a) { var %n = 10 }
  elseif ($calc(%n * 9) >= %a) && ($calc(%n * 8) < %a) { var %n = 9 }
  elseif ($calc(%n * 8) >= %a) && ($calc(%n * 7) < %a) { var %n = 8 }
  elseif ($calc(%n * 7) >= %a) && ($calc(%n * 6) < %a) { var %n = 7 }
  elseif ($calc(%n * 6) >= %a) && ($calc(%n * 5) < %a) { var %n = 6 }
  elseif ($calc(%n * 5) >= %a) && ($calc(%n * 4) < %a) { var %n = 5 }
  elseif ($calc(%n * 4) >= %a) && ($calc(%n * 3) < %a) { var %n = 4 }
  elseif ($calc(%n * 3) >= %a) && ($calc(%n * 2) < %a) { var %n = 3 }
  elseif ($calc(%n * 2) >= %a) && ($calc(%n * 1) < %a) { var %n = 2 }
  elseif ($calc(%n * 1) >= %a) && (%a > 0) { var %n = 1 }
  else { var %n = 0 }
  return :barra $+ %n $+ ;
  ; return  $+ $3 $+ $str($chr(127),%n) $+  $+ $4 $+ $str($chr(127),$calc(10 - %n))
}
alias gbarra {
  var %a = $1, %b = $2, %n = $calc(%b / 20)
  var %n = $int($calc(%a / %b * 100)), %n = $int($calc(%n / 100 * 20))
  if ($3 isnum) { var %c1 =  $+ $3 } | else { var %c1 = $3 } | if ($4 isnum) { var %c2 =  $+ $4 } | else { var %c2 = $4 }
  return %c1 $+ $str($chr(127),%n) $+ %c2 $+ $str($chr(127),$calc(20 - %n))

  if ($calc(%n * 20) >= %a) && ($calc(%n * 19) < %a) { var %n = 20 }
  elseif ($calc(%n * 19) >= %a) && ($calc(%n * 18) < %a) { var %n = 19 }
  elseif ($calc(%n * 18) >= %a) && ($calc(%n * 17) < %a) { var %n = 18 }
  elseif ($calc(%n * 17) >= %a) && ($calc(%n * 16) < %a) { var %n = 17 }
  elseif ($calc(%n * 16) >= %a) && ($calc(%n * 15) < %a) { var %n = 16 }
  elseif ($calc(%n * 15) >= %a) && ($calc(%n * 14) < %a) { var %n = 15 }
  elseif ($calc(%n * 14) >= %a) && ($calc(%n * 13) < %a) { var %n = 14 }
  elseif ($calc(%n * 13) >= %a) && ($calc(%n * 12) < %a) { var %n = 13 }
  elseif ($calc(%n * 12) >= %a) && ($calc(%n * 11) < %a) { var %n = 12 }
  elseif ($calc(%n * 11) >= %a) && ($calc(%n * 10) < %a) { var %n = 11 }
  elseif ($calc(%n * 10) >= %a) && ($calc(%n * 9) < %a) { var %n = 10 }
  elseif ($calc(%n * 9) >= %a) && ($calc(%n * 8) < %a) { var %n = 9 }
  elseif ($calc(%n * 8) >= %a) && ($calc(%n * 7) < %a) { var %n = 8 }
  elseif ($calc(%n * 7) >= %a) && ($calc(%n * 6) < %a) { var %n = 7 }
  elseif ($calc(%n * 6) >= %a) && ($calc(%n * 5) < %a) { var %n = 6 }
  elseif ($calc(%n * 5) >= %a) && ($calc(%n * 4) < %a) { var %n = 5 }
  elseif ($calc(%n * 4) >= %a) && ($calc(%n * 3) < %a) { var %n = 4 }
  elseif ($calc(%n * 3) >= %a) && ($calc(%n * 2) < %a) { var %n = 3 }
  elseif ($calc(%n * 2) >= %a) && ($calc(%n * 1) < %a) { var %n = 2 }
  else { var %n = 1 }
}
alias gbarra2 {
  var %a = $1, %b = $2, %n = $calc(%b / 40)
  var %n = $int($calc(%a / %b * 100)), %n = $int($calc(%n / 100 * 40))
  if ($3 isnum) { var %c1 =  $+ $3 } | else { var %c1 = $3 } | if ($4 isnum) { var %c2 =  $+ $4 } | else { var %c2 = $4 } | if ($5 isnum) { var %c3 =  $+ $5 } | else { var %c3 = $5 }
  if (%n <= 20) { var %r = %c1 $+ $str($chr(127),%n) $+ %c2 $+ $str($chr(127),$calc(20 - %n)) }
  else { var %n = $calc(%n - 20), %r = %c3 $+ $str($chr(127),%n) $+ %c1 $+ $str($chr(127),$calc(20 - %n)) }
  return %r

  if ($calc(%n * 40) >= %a) && ($calc(%n * 39) < %a) { var %n = 40 }
  elseif ($calc(%n * 39) >= %a) && ($calc(%n * 38) < %a) { var %n = 39 }
  elseif ($calc(%n * 38) >= %a) && ($calc(%n * 37) < %a) { var %n = 38 }
  elseif ($calc(%n * 37) >= %a) && ($calc(%n * 36) < %a) { var %n = 37 }
  elseif ($calc(%n * 36) >= %a) && ($calc(%n * 35) < %a) { var %n = 36 }
  elseif ($calc(%n * 35) >= %a) && ($calc(%n * 34) < %a) { var %n = 35 }
  elseif ($calc(%n * 34) >= %a) && ($calc(%n * 33) < %a) { var %n = 34 }
  elseif ($calc(%n * 33) >= %a) && ($calc(%n * 32) < %a) { var %n = 33 }
  elseif ($calc(%n * 32) >= %a) && ($calc(%n * 31) < %a) { var %n = 32 }
  elseif ($calc(%n * 31) >= %a) && ($calc(%n * 30) < %a) { var %n = 31 }
  elseif ($calc(%n * 30) >= %a) && ($calc(%n * 29) < %a) { var %n = 30 }
  elseif ($calc(%n * 29) >= %a) && ($calc(%n * 28) < %a) { var %n = 29 }
  elseif ($calc(%n * 28) >= %a) && ($calc(%n * 27) < %a) { var %n = 28 }
  elseif ($calc(%n * 27) >= %a) && ($calc(%n * 26) < %a) { var %n = 27 }
  elseif ($calc(%n * 26) >= %a) && ($calc(%n * 25) < %a) { var %n = 26 }
  elseif ($calc(%n * 25) >= %a) && ($calc(%n * 24) < %a) { var %n = 25 }
  elseif ($calc(%n * 24) >= %a) && ($calc(%n * 23) < %a) { var %n = 24 }
  elseif ($calc(%n * 23) >= %a) && ($calc(%n * 22) < %a) { var %n = 23 }
  elseif ($calc(%n * 22) >= %a) && ($calc(%n * 21) < %a) { var %n = 22 }
  elseif ($calc(%n * 21) >= %a) && ($calc(%n * 20) < %a) { var %n = 21 }
  elseif ($calc(%n * 20) >= %a) && ($calc(%n * 19) < %a) { var %n = 20 }
  elseif ($calc(%n * 19) >= %a) && ($calc(%n * 18) < %a) { var %n = 19 }
  elseif ($calc(%n * 18) >= %a) && ($calc(%n * 17) < %a) { var %n = 18 }
  elseif ($calc(%n * 17) >= %a) && ($calc(%n * 16) < %a) { var %n = 17 }
  elseif ($calc(%n * 16) >= %a) && ($calc(%n * 15) < %a) { var %n = 16 }
  elseif ($calc(%n * 15) >= %a) && ($calc(%n * 14) < %a) { var %n = 15 }
  elseif ($calc(%n * 14) >= %a) && ($calc(%n * 13) < %a) { var %n = 14 }
  elseif ($calc(%n * 13) >= %a) && ($calc(%n * 12) < %a) { var %n = 13 }
  elseif ($calc(%n * 12) >= %a) && ($calc(%n * 11) < %a) { var %n = 12 }
  elseif ($calc(%n * 11) >= %a) && ($calc(%n * 10) < %a) { var %n = 11 }
  elseif ($calc(%n * 10) >= %a) && ($calc(%n * 9) < %a) { var %n = 10 }
  elseif ($calc(%n * 9) >= %a) && ($calc(%n * 8) < %a) { var %n = 9 }
  elseif ($calc(%n * 8) >= %a) && ($calc(%n * 7) < %a) { var %n = 8 }
  elseif ($calc(%n * 7) >= %a) && ($calc(%n * 6) < %a) { var %n = 7 }
  elseif ($calc(%n * 6) >= %a) && ($calc(%n * 5) < %a) { var %n = 6 }
  elseif ($calc(%n * 5) >= %a) && ($calc(%n * 4) < %a) { var %n = 5 }
  elseif ($calc(%n * 4) >= %a) && ($calc(%n * 3) < %a) { var %n = 4 }
  elseif ($calc(%n * 3) >= %a) && ($calc(%n * 2) < %a) { var %n = 3 }
  elseif ($calc(%n * 2) >= %a) && ($calc(%n * 1) < %a) { var %n = 2 }
  else { var %n = 1 }
}
alias sex { if ($1 == Male) { return $ct $+ ( $+ 12M $+ $ct $+ ) } | elseif ($1 == Female) { return $ct $+ ( $+ 13F $+ $ct $+ ) } | else { return $ct $+ ( $+ 14N/A $+ $ct $+ ) } }
Alias returnmoves {
  var %ID = $1, %n = $2, %r = $rmoves(%ID,%n).left, %r = $iif(%r,%r,Struggle), %x = 0, %y = $gettok(%r,0,58), %res = 0
  if (!$rmoves(%ID,%n)) { return Struggle }
  while (%x < %y) {
    inc %x | var %p = $gettok(%r,%x,58)
    if (%res) {
      if (%x == %y) { var %res = %res e %p }
      else { var %res = %res $+ $chr(44) %p }
    }
    else { var %res = %p }
  }
  return %res
}
alias returnmoves² {
  var %id = $1, %n = $2
  var %x = 0 | while (%x < 4) {
    inc %x
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])) {
      var %y = $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %x ] $+ ] . ] $+ [ %n ] ])
      if ($v([ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ]) == ON) {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %y),4,58), %mpp = $calc(%mpp * 1.6) }
        else { var %mpp = $calc($gettok($read(pkp\moveslist.txt, s, %y),4,58), %mpp = $calc(%mpp * 0.6) }
      }
      else {
        if ($v([ [ B. ] $+ [ %ID ] $+ [ .PP ] ]) == ON) { var %mpp = $gettok($read(pkp\moveslist.txt, s, %y),4,58) }
        else { var %mpp = $int($calc($gettok($read(pkp\moveslist.txt, s, %y),4,58) / 5)) }
      }
      var %pp = $v([ [ B. ] $+ [ %ID ] $+ [ .PP [ $+ [ %x ] $+ ] . ] $+ [ %n ] ]) | if (%pp < %mpp) { var %m [ $+ [ %x ] ] = ok, %t = $calc(%t + 1) }
    }
  }
  if (%t == 1) { var %r = $iif(%m1,$v([ [ B. ] $+ [ %ID ] $+ [ .Move1. ] $+ [ %n ] ]),$iif(%m2,$v([ [ B. ] $+ [ %ID ] $+ [ .Move2. ] $+ [ %n ] ]),$iif(%m3,$v([ [ B. ] $+ [ %ID ] $+ [ .Move3. ] $+ [ %n ] ]),$v([ [ B. ] $+ [ %ID ] $+ [ .Move4. ] $+ [ %n ] ])))) }
  elseif (%t > 1) { 
    var %x = 0 | while (%x < %t) {
      inc %x | if (%m1) { var %mm = 1, %m1 = 0 } | elseif (%m2) { var %mm = 2, %m2 = 0 } | elseif (%m3) { var %mm = 3, %m3 = 0 } | elseif (%m4) { var %mm = 4, %m4 = 0 } | else { goto end }
      if (%x == %t) { var %r = %r e $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %mm ] $+ ] . ] $+ [ %n ] ]) | goto end }
      if (!%r) { var %r = $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %mm ] $+ ] . ] $+ [ %n ] ]) }
      else { var %r = %r $+ $chr(44) $v([ [ B. ] $+ [ %ID ] $+ [ .Move [ $+ [ %mm ] $+ ] . ] $+ [ %n ] ]) }
    }
  }
  else { var %r = Struggle }
  :end
  return %r
}
alias returntargets {
  var %id = $1, %n = $2, %l = 0
  var %x = 0 | while (%x < 4) {
    inc %x
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %x ] ])) && ($v([ [ B. ] $+ [ %ID ] $+ [ .HPAtual. ] $+ [ %x ] ]) > 0) {
      if ($battle.side(%x) != $battle.side(%n)) {
        inc %l
        var %num = %x
        if (%r) { var %r = %r e $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) }
        else { var %r = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %x ] ]) }
      }
    }
  }
  if ($prop == left) { return %l }
  if ($prop == num) { return %num }
  return %r
}
alias totaleffort { return $calc($rini(cadastros,$1,$2,EVHp) + $rini(cadastros,$1,$2,EVAtk) + $rini(cadastros,$1,$2,EVDef) + $rini(cadastros,$1,$2,EVSpd) + $rini(cadastros,$1,$2,EVSAtk) + $rini(cadastros,$1,$2,EVSDef)) }
alias learned {
  if ($rini(cadastros,$1,$2,Move1) == $3-) { return Ok! }
  elseif ($rini(cadastros,$1,$2,Move2) == $3-) { return Ok! }
  elseif ($rini(cadastros,$1,$2,Move3) == $3-) { return Ok! }
  elseif ($rini(cadastros,$1,$2,Move4) == $3-) { return Ok! }
  else { return No! }
}
alias remchar { return $1 }
alias randmove {
  var %ID = $1, %n = $2, %temp = $returnmoves(%ID,%n)
  if (Struggle isin %temp) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Struggle | return }
  var %x = $rmoves(%ID,%n), %y = $gettok(%x,0,58) | if (%x) { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] $gettok(%x,$rand(1,%y),58) } | else { sset [ [ B. ] $+ [ %ID ] $+ [ .Move. ] $+ [ %n ] ] Struggle }
}
alias checknick {
  var %n = 0
  while (%n < $chat(0)) { inc %n | if ($chat(%n) == $1) && ($chat(%n).status == Active) { if ($findtok(%accesslist,$1,0,58)) || ($findtok(%cadlist,$1,0,58)) { return No! } | return Ok! } }
  return No!
}
alias rtypebox {
  if ($1 == 5) { return Link Box }
  elseif ($1 == 30) { return Small Box }
  elseif ($1 == 45) { return Normal Box }
  elseif ($1 == 60) { return Great Box }
  elseif ($1 == 100) { return Giant Box }
  elseif ($1 == 200) { return Rare Box }
  else { return Unknown Box }
}

alias rvs { if ($battle.side($1) == 1) { return 2 } | elseif ($battle.side($1) == 2) { return 1 } }
alias npc {
  if ($rini(npc,npc,ID,$1)) { return Ok }
  if ($findtok(Wild:Brendan:May:Gary:Oak:Birch:Mom:GymLeader:Trainer:Brain,$1,0,58)) { return Ok }
}
alias etype {
  var %type = $1
  if (%type == Normal) { return Rock- Ghost! Steel- }
  elseif (%type == Fire) { return Fire- Water- Grass+ Ice+ Bug+ Rock- Dragon- Steel+ }
  elseif (%type == Water) { return Fire+ Water- Grass- Ground+ Rock+ Dragon- }
  elseif (%type == Grass) { return Fire- Water+ Grass- Poison- Ground+ Flying- Bug- Rock+ Dragon- Steel- }
  elseif (%type == Electric) { return Water+ Grass- Electric- Ground! Flying+ Dragon- }
  elseif (%type == Ice) { return Fire- Water- Grass+ Ice- Ground+ Flying+ Dragon+ Steel- }
  elseif (%type == Fighting) { return Normal+ Ice+ Poison- Flying- Psychic- Bug- Rock+ Ghost! Dark+ Steel+ }
  elseif (%type == Poison) { return Grass+ Poison- Ground- Rock- Ghost- Steel! }
  elseif (%type == Ground) { return Fire+ Grass- Electric+ Poison+ Flying* Bug- Rock+ Steel+ }
  elseif (%type == Flying) { return Grass+ Electric- Fighting+ Bug+ Rock- Steel- }
  elseif (%type == Psychic) { return Fighting+ Poison+ Psychic- Dark! Steel- }
  elseif (%type == Bug) { return Fire- Grass+ Fighting- Poison- Flying- Psychic+ Ghost- Dark+ Steel- }
  elseif (%type == Rock) { return Fire+ Ice+ Fighting- Ground- Flying+ Bug+ Steel- }
  elseif (%type == Ghost) { return Normal! Psychic+ Ghost+ Dark- Steel- }
  elseif (%type == Dragon) { return Dragon+ Steel- }
  elseif (%type == Dark) { return Fighting- Psychic+ Ghost+ Dark- Steel- }
  elseif (%type == Steel) { return Fire- Water- Electric- Ice+ Rock+ Steel- }
  else { return }
}
alias effective {
  var %ID = $1, %type = $2
  if ($prop == n) { var %enemy.type = $3, %trait = $4, %ident = $5 }
  else { var %alvo = $3, %enemy.type = $v([ [ B. ] $+ [ %ID ] $+ [ .Type. ] $+ [ %alvo ] ]), %trait = $v([ [ B. ] $+ [ %ID ] $+ [ .Trait. ] $+ [ %alvo ] ]), %ident = $v([ [ B. ] $+ [ %ID ] $+ [ .Identified. ] $+ [ %alvo ] ]) }
  var %effect = $etype(%type), %e = 1, %x = 1
  while ($gettok(%enemy.type,%x,32)) {
    var %a = $gettok(%enemy.type,%x,32)
    if ($wildtok(%effect,%a $+ *,0,32)) {
      var %r = $remove($wildtok(%effect,%a $+ *,1,32),%a)
      if (%r == +) { var %e = $calc(%e * 2) }
      elseif (%r == -) { var %e = $calc(%e / 2) }
      else {
        if (%ident) { if (%a != Ghost) { var %e = 0 } }
        else { var %e = 0 }
      }
    }
    inc %x
  }
  if (%trait == Levitate) && (%type == Ground) { var %e = 0 }
  return %e
}
