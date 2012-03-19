; Add a egg with //echo $addpoke(Nick,Egg,Poke,Memory,IV,[EggMoves, else 0],[Trait])
alias addpoke {
  if ($dados($1,Info,Nick)) { var %n = $dados($1,Info,Nick) } | else { var %n = $1 }
  if ($basestat($2,Name)) { var %pk = $basestat($2,Name) } | else { var %pk = $2 }

  if ($prop != Wild) {
    if ($teampos(%n,Egg)) { remteam %n Egg | addteam %n %pk | addteam %n Egg }
    else { addteam %n %pk }
  }

  var %gv = $rand(0,255), %needgv = $basestat($iif(%pk == Egg,$3,%pk),GV)
  if (%needgv isnum 1-254) {
    var %female = 0- $+ %needgv
    if (%gv isnum %female) { var %sex = Female } | else { var %sex = Male }
  }
  elseif (%needgv == 0) { var %sex = Male }
  elseif (%needgv == 255) { var %sex = Female }
  else { var %sex = Unknown }

  if ($rluck == Rarissimo) { var %shiny = ON }
  if (%pk == Egg) {
    var %hatch = $calc($egroup($3).step * 10)
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Name %pk
    writeini pkp\cadastros\ $+ %n $+ .ini %pk DNA $basestat($3,name)
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Hatch $iif($dados(%n,Info,Premium),$int($calc(%hatch * 0.75)),%hatch)
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Milhagem 0
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Nature $nature
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Sex %sex
    writeini pkp\cadastros\ $+ %n $+ .ini %pk GV %gv
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Shiny $iif(%Shiny,ON,OFF)
    if ($7) { writeini pkp\cadastros\ $+ %n $+ .ini %pk Trait $7 }
    writeini pkp\cadastros\ $+ %n $+ .ini %pk Memory $4
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVHp $iif($5,$gettok($5,1,58),$rand(0,31))
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVAtk $iif($5,$gettok($5,2,58),$rand(0,31))
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVDef $iif($5,$gettok($5,3,58),$rand(0,31))
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSpd $iif($5,$gettok($5,4,58),$rand(0,31))
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSAtk $iif($5,$gettok($5,5,58),$rand(0,31))
    writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSDef $iif($5,$gettok($5,6,58),$rand(0,31))
    if ($6) {
      writeini pkp\cadastros\ $+ %n $+ .ini %pk Move1 $gettok($6,1,58)
      if ($gettok($6,2,58)) { writeini pkp\cadastros\ $+ %n $+ .ini %pk Move2 $gettok($6,2,58) }
      if ($gettok($6,3,58)) { writeini pkp\cadastros\ $+ %n $+ .ini %pk Move3 $gettok($6,3,58) }
      if ($gettok($6,4,58)) { writeini pkp\cadastros\ $+ %n $+ .ini %pk Move4 $gettok($6,4,58) }
    }
    return
  }
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Name %pk
  writeini pkp\cadastros\ $+ %n $+ .ini %pk ID %n 
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Level $3
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Nature $nature
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Sex %sex
  writeini pkp\cadastros\ $+ %n $+ .ini %pk GV %gv
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Shiny $iif(%Shiny,ON,OFF)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Trait $iif($gettok($basestat(%pk,Trait),0,44) == 2,$gettok($basestat(%pk,Trait),$rand(1,2),44),$basestat(%pk,Trait))
  var %etype = $basestat(%pk,etype) | writeini pkp\cadastros\ $+ %n $+ .ini %pk ExpStat %etype
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Exp $exp(%etype,$3)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Next $exp(%etype,$calc($3 + 1))
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Memory $iif($4-,$4-,$3 $+ : $+ $rini(cadastros,%n,Info,Locate) $+ : $+ Poke  Ball)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Loyalty 70
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Hold 0 
  writeini pkp\cadastros\ $+ %n $+ .ini %pk Ribbon 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVHp $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVAtk $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVDef $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSpd $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSAtk $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk IVSDef $rand(0,31)
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVHP 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVAtk 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVDef 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVSpd 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVSAtk 0
  writeini pkp\cadastros\ $+ %n $+ .ini %pk EVSDef 0
  recalc %n %pk
  applymoves %n %pk $3
}
alias hatch {
  if ($teampos($1,Egg)) {
    tokenize 32 $1 $rini(cadastros,$1,Egg,DNA) 5
    var %n = $basestat($2,name)
    wlog user $1 Egg turned into $iif($rini(cadastros,$1,Egg,Sex) == unknown,%n,$lower($rini(cadastros,$1,Egg,Sex)) %n) $+ !
    remteam $1 Egg | addteam $1 %n
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Name %n
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 ID $1 
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Level $3
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Nature $rini(cadastros,$1,Egg,Nature)
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Sex $rini(cadastros,$1,Egg,Sex)
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 GV $rini(cadastros,$1,Egg,GV)
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Shiny $rini(cadastros,$1,Egg,Shiny)
    if ($rini(cadastros,$1,Egg,Trait)) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Trait $rini(cadastros,$1,Egg,Trait) } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Trait $iif($gettok($basestat($2,Trait),0,44) == 2,$gettok($basestat($2,Trait),$rand(1,2),44),$basestat($2,Trait)) }
    var %etype = $basestat($2,etype) | writeini pkp\cadastros\ $+ $1 $+ .ini $2 ExpStat %etype
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Exp $exp(%etype,$3)
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Next $exp(%etype,$calc($3 + 1))
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Memory $3 $+ : $+ $rini(cadastros,$1,Info,Locate) $+ : $+ Egg
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Loyalty 110
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Hold 0 
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 Ribbon 0
    var %iv = IVHp, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    var %iv = IVAtk, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    var %iv = IVDef, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    var %iv = IVSpd, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    var %iv = IVSAtk, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    var %iv = IVSDef, %x = $rini(cadastros,$1,Egg,%iv) | if (%x != $null) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv %x } | else { writeini pkp\cadastros\ $+ $1 $+ .ini $2 %iv $rand(0,31) }
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVHP 0
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVAtk 0
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVDef 0
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVSpd 0
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVSAtk 0
    writeini pkp\cadastros\ $+ $1 $+ .ini $2 EVSDef 0
    recalc $1 $2
    if ($rini(cadastros,$1,Egg,Move1)) {
      writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move1 $rini(cadastros,$1,Egg,Move1)
      if ($rini(cadastros,$1,Egg,Move2)) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move2 $rini(cadastros,$1,Egg,Move2) }
      if ($rini(cadastros,$1,Egg,Move3)) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move3 $rini(cadastros,$1,Egg,Move3) }
      if ($rini(cadastros,$1,Egg,Move4)) { writeini pkp\cadastros\ $+ $1 $+ .ini $2 Move4 $rini(cadastros,$1,Egg,Move4) }
    }
    else { applymoves $1 $2 $3 }
    remini pkp\cadastros\ $+ $1 $+ .ini Egg
    if ($pokedex($1,$2) == $false) { .echo $pokedex($1,$2).add }
  }
}
alias evolvepoke {
  if ($checkteam($1,$2) == $false) { return }
  var %name = $2, %evolve = $basestat($3,name)

  writeini pkp\cadastros\ $+ $1 $+ .ini Team $teampos($1,%name) %evolve
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Name %evolve
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 ID $rini(cadastros,$1,%name,ID)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Level $rini(cadastros,$1,%name,Level)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Nature $rini(cadastros,$1,%name,Nature)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Sex $rini(cadastros,$1,%name,Sex)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 GV $rini(cadastros,$1,%name,GV)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Shiny $rini(cadastros,$1,%name,Shiny)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Trait $iif($basestat(%name,Trait) == $basestat(%evolve,Trait),$rini(cadastros,$1,%name,Trait),$iif($gettok($basestat(%evolve,Trait),0,44) == 2,$gettok($basestat(%evolve,Trait),$rand(1,2),44),$basestat(%evolve,Trait)))
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 ExpStat $rini(cadastros,$1,%name,ExpStat)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Exp $rini(cadastros,$1,%name,Exp)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Next $rini(cadastros,$1,%name,Next)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Memory $rini(cadastros,$1,%name,Memory)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Loyalty $rini(cadastros,$1,%name,Loyalty)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Hold $rini(cadastros,$1,%name,Hold)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 Ribbon $rini(cadastros,$1,%name,Ribbon)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVHp $rini(cadastros,$1,%name,IVHp)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVAtk $rini(cadastros,$1,%name,IVAtk)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVDef $rini(cadastros,$1,%name,IVDef)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVSpd $rini(cadastros,$1,%name,IVSpd)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVSAtk $rini(cadastros,$1,%name,IVSAtk)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 IVSDef $rini(cadastros,$1,%name,IVSDef)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVHP $rini(cadastros,$1,%name,EVHP)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVAtk $rini(cadastros,$1,%name,EVAtk)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVDef $rini(cadastros,$1,%name,EVDef)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVSpd $rini(cadastros,$1,%name,EVSpd)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVSAtk $rini(cadastros,$1,%name,EVSAtk)
  writeini pkp\cadastros\ $+ $1 $+ .ini $3 EVSDef $rini(cadastros,$1,%name,EVSDef)
  if ($rini(cadastros,$1,%name,Move1)) { writeini pkp\cadastros\ $+ $1 $+ .ini $3 Move1 $rini(cadastros,$1,%name,Move1) }
  if ($rini(cadastros,$1,%name,Move2)) { writeini pkp\cadastros\ $+ $1 $+ .ini $3 Move2 $rini(cadastros,$1,%name,Move2) }
  if ($rini(cadastros,$1,%name,Move3)) { writeini pkp\cadastros\ $+ $1 $+ .ini $3 Move3 $rini(cadastros,$1,%name,Move3) }
  if ($rini(cadastros,$1,%name,Move4)) { writeini pkp\cadastros\ $+ $1 $+ .ini $3 Move4 $rini(cadastros,$1,%name,Move4) }
  if ($rini(cadastros,$1,%name,Learn)) { writeini pkp\cadastros\ $+ $1 $+ .ini $3 Learn $rini(cadastros,$1,%name,Learn) }
  recalc $1 $3 | remini pkp\cadastros\ $+ $1 $+ .ini %name
}
alias ribbon.add {
  var %nick = $1, %poke = $2, %rib = $rini(cadastros,%nick,%poke,Ribbon)
  if (!%rib) { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Ribbon $3- | return }
  else { if ($ribbon(%nick,%poke,$3-)) { return } | writeini pkp\cadastros\ $+ %nick $+ .ini %poke Ribbon %rib $+ : $+ $3- }
}
alias ribbon.rem {
  var %nick = $1, %poke = $2, %rib = $rini(cadastros,%nick,%poke,Ribbon)
  if ($ribbon(%nick,%poke,$3-)) {
    if (%rib == $3-) { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Ribbon 0 | return }
    else { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Ribbon $remtok(%rib,$3-,1,58) }
  }
}
alias ribbon {
  var %n = $1, %pk = $2, %rib = $rini(cadastros,%n,%pk,Ribbon)
  if ($findtok(%rib,$3-,0,58)) { return $true } | else { return $false }
}
alias pokedex {
  var %nick = $1, %poke = $basestat($2,name), %dex = $rini(cadastros,%nick,Info,Pokedex), %num = $basestat(%poke,num), %i = $rini(cadastros,%nick,Pokedex,%num)
  if ($prop == add) {
    if (!$findtok(%i,%poke,0,58)) {
      if (!%i) || (%i == None) { writeini pkp\cadastros\ $+ %nick $+ .ini Info Pokedex $calc(%dex + 1) }
      writeini pkp\cadastros\ $+ %nick $+ .ini Pokedex %num $iif(%i,$+(%i,:,%poke),%poke)
    }
    return
  }
  if (%i) && ($findtok(%i,%poke,0,58)) { return $true }
  else { return $false }
}
alias nature {
  var %n = Hardy Lonely Brave Adamant Naughty Bold Docile Relaxed Impish Lax Timid Hasty Serious Jolly Naive Modest Mild Quiet Bashful Rash Calm Gentle Sassy Careful Quirky
  return $gettok(%n,$rand(1,25),32)
}
alias basestat {
  var %s = $read(pkp\database.txt,s,$1 $+ :), %n = $readn
  if ($2 == Name) { return $gettok($read(pkp\database.txt,%n),1,58) }
  elseif ($2 == Num) { return $gettok(%s,1,172) }
  elseif ($2 == TotalBase) { var %t = $gettok(%s,2,172), %r = 0, %x = 1 | while ($gettok(%t,%x,32) != $null) { var %r = $calc(%r + $gettok(%t,%x,32)) | inc %x } | return %r }
  elseif ($2 == Base) { return $gettok(%s,2,172) }
  elseif ($2 == HP) { return $gettok($gettok(%s,2,172),1,32) }
  elseif ($2 == Atk) { return $gettok($gettok(%s,2,172),2,32) }
  elseif ($2 == Def) { return $gettok($gettok(%s,2,172),3,32) }
  elseif ($2 == Spd) { return $gettok($gettok(%s,2,172),4,32) }
  elseif ($2 == SAtk) { return $gettok($gettok(%s,2,172),5,32) }
  elseif ($2 == SDef) { return $gettok($gettok(%s,2,172),6,32) }
  elseif ($2 == Type) { return $gettok(%s,4,172) }
  elseif ($2 == EType) { return $gettok(%s,5,172) }
  elseif ($2 == GV) { return $gettok(%s,6,172) }
  elseif ($2 == Trait) { return $gettok(%s,7,172) }
  elseif ($2 == BaseEXP) { return $gettok(%s,8,172) }
  elseif ($2 == Catch) { return $gettok(%s,9,172) }
  elseif ($2 == Height) { return $gettok(%s,10,172) }
  elseif ($2 == Weight) { var %t = $gettok(%s,11,172), %t = $calc(%t / 10) | if (!$count(%t,.)) { var %t = %t $+ .0 } | return %t }
  elseif ($left($2,2) == EV) { var %ev = $gettok(%s,3,172), %t = $right($2,$calc($len($2) - 2)), %n = $findtok(HP Atk Def Spd SAtk SDef,%t,1,32) | if (%n) { return $gettok(%ev,%n,32) } | else { return %ev } }
  else { return $gettok($read(pkp\database.txt,%n),1,58) }
  return
}
alias ispar {
  if ($right($1,1) == 0) || ($right($1,1) == 2) || ($right($1,1) == 4) || ($right($1,1) == 6) || ($right($1,1) == 8) { return $true }
  else return $false
}
alias addteam {
  var %x = 1 | while (%x <= 6) {
    var %n = $readini(pkp\cadastros\ $+ $1 $+ .ini,Team,%x)
    if (!%n) {
      writeini pkp\cadastros\ $+ $1 $+ .ini Team %x $2
      return
    }
    inc %x
  }
}
alias checkteam {
  var %x = 1 | while (%x <= 6) {
    var %n = $readini(pkp\cadastros\ $+ $1 $+ .ini,Team,%x)
    if (%n == $2) { return $true }
    inc %x
  }
  return $false
}
alias teampos {
  var %x = 1 | while (%x <= 6) {
    var %n = $readini(pkp\cadastros\ $+ $1 $+ .ini,Team,%x)
    if (%n == $2) { return %x }
    inc %x
  }
  return 0
}
alias remteam {
  var %x = 1 | while (%x <= 6) {
    var %n = $readini(pkp\cadastros\ $+ $1 $+ .ini,Team,%x)
    if (%n == $2) {
      remini pkp\cadastros\ $+ $1 $+ .ini Team %x
      var %y = %x
      :loop
      if ($readini(pkp\cadastros\ $+ $1 $+ .ini,Team,$calc(%y + 1))) {
        writeini pkp\cadastros\ $+ $1 $+ .ini Team %y $readini(pkp\cadastros\ $+ $1 $+ .ini,Team,$calc(%y + 1))
        remini pkp\cadastros\ $+ $1 $+ .ini Team $calc(%y + 1)
        inc %y | goto loop
      }
      return
    }
    inc %x
  }
}

alias getP {
  var %PAtk = 1, %PDef = 1, %PSpd = 1, %PSAtk = 1, %PSDef = 1, %P = $1
  if (%P == Lonely) { var %PAtk = 1.1, %PDef = 0.9 }
  if (%P == Brave) { var %PAtk = 1.1, %PSpd = 0.9 }
  if (%P == Adamant) { var %PAtk = 1.1, %PSAtk = 0.9 }
  if (%P == Naughty) { var %PAtk = 1.1, %PSDef = 0.9 }
  if (%P == Bold) { var %PAtk = 0.9, %PDef = 1.1 }
  if (%P == Relaxed) { var %PDef = 1.1, %PSpd = 0.9 }
  if (%P == Impish) { var %PDef = 1.1, %PSAtk = 0.9 }
  if (%P == Lax) { var %PDef = 1.1, %PSDef = 0.9 }
  if (%P == Timid) { var %PAtk = 0.9, %PSpd = 1.1 }
  if (%P == Hasty) { var %PDef = 0.9, %PSpd = 1.1 }
  if (%P == Jolly) { var %PSpd = 1.1, %PSAtk = 0.9 }
  if (%P == Naive) { var %PSpd = 1.1, %PSDef = 0.9 }
  if (%P == Modest) { var %PAtk = 0.9, %PSAtk = 1.1 }
  if (%P == Mild) { var %PDef = 0.9, %PSAtk = 1.1 }
  if (%P == Quiet) { var %PSpd = 0.9, %PSAtk = 1.1 }
  if (%P == Rash) { var %PSAtk = 1.1, %PSDef = 0.9 }
  if (%P == Calm) { var %PAtk = 0.9, %PSDef = 1.1 }
  if (%P == Gentle) { var %PDef = 0.9, %PSDef = 1.1 }
  if (%P == Sassy) { var %PSpd = 0.9, %PSDef = 1.1 }
  if (%P == Careful) { var %PSAtk = 0.9, %PSDef = 1.1 }
  :end
  if ($2 == Atk) { return %PAtk }
  elseif ($2 == Def) { return %PDef }
  elseif ($2 == Spd) { return %PSpd }
  elseif ($2 == SAtk) { return %PSAtk }
  else { return %PSDef }
}
alias preevolution {
  var %s = $read(pkp\database.txt,s,$1 $+ :)
  return $gettok(%s,14,172)
}
alias recalc {
  var %x = 1, %n = $1, %pk = $2, %lv = $dados(%n,%pk,Level), %nature = $dados(%n,%pk,Nature)
  while ($nstat(%x)) {
    var %st = $upper($nstat(%x))
    if (%st == HP) { var %r = $calcstat($basestat(%pk,%st),$dados(%n,%pk,IV $+ %st),$dados(%n,%pk,EV $+ %st),%lv,$getp(%nature,%st)).hp }
    else { var %r = $calcstat($basestat(%pk,%st),$dados(%n,%pk,IV $+ %st),$dados(%n,%pk,EV $+ %st),%lv,$getp(%nature,%st)) }
    writeini pkp\cadastros\ $+ %n $+ .ini %pk %st %r
    inc %x
  }
}
alias nbot { var %x = 1, %y = $chat(0) | while (%x <= %y) { if ($chat(%x) == $1) { return Ok! } | inc %x } | return No! }
alias rcolor {
  var %c = $remove($1,) | if ($2) { var %c = %c $+ $chr(44) $+ $2 }
  var %c1 = $gettok(%c,2,44), %c2 = $gettok(%c,1,44)
  return  $+ $iif(%c1,%c1,00) $+ , $+ $iif(%c2,%c2,00)
}
alias msg {
  if ($nbot($right($1,$calc($len($1) - 1))) == No!) { if ($left($1,1) != $chr(35)) { return } }
  var %skin = $rini(cadastros,$remove($1,=,$chr(35)),Info,Skin)
  if (!%skin) { var %lb = 1,15, %bb = 10,15, %ct = 1,00, %cc = 10,00, %bf = 14 }
  elseif (%skin == Love) { var %lb = 0,06, %bb = 13,06, %ct = 1,00, %cc = 13,00, %bl = 4, %bf = 14 }
  elseif (%skin == Florest) { var %lb = 0,03, %bb = 9,03, %ct = 1,00, %cc = 3,00, %bf = 15 }
  elseif (%skin == Ocean) { var %lb = 0,02, %bb = 11,02, %ct = 1,00, %cc = 12,00, %bf = 10 }
  elseif (%skin == Dark) { var %lb = 0,01, %bb = 15,01, %ct = 1,00, %cc = 14,00, %bl = 7, %bf = 14 }
  elseif (%skin == Plate) { var %lb = 0,14, %bb = 15,14, %ct = 2,00, %cc = 14,00, %bl = 15, %bf = 10 }
  elseif (%skin == Classical) { var %lb = 1,15, %bb = 7,15, %ct = 1,00, %cc = 7,00, %bl = 1, %bf = 14 }
  elseif (%skin == Ice) { var %lb = 1,10, %bb = 0,10, %ct = 1,00, %cc = 2,00, %bf = 1 }
  elseif (%skin == Thunder) { var %lb = 1,07, %bb = 8,07, %ct = 5,00, %cc = 7,00, %bl = 10, %bf = 15 }
  elseif (%skin == Volcano) { var %lb = 15,05, %bb = 4,05, %ct = 1,00, %cc = 4,00, %bf = 14 }
  elseif (%skin == Santa) { var %lb = 1,04, %bb = 0,04, %ct = 5,00, %cc = 3,00, %bl = 3, %bf = 15 }
  elseif (%skin == Storm) { var %lb = 10,11, %bb = 1,11, %ct = 14,00, %cc = 15,00, %bl = 14, %bf = 15 }
  elseif (%skin == Gold) { var %lb = 7,01, %bb = 8,01, %ct = 7,00, %cc = 14,00, %bl = 15, %bf = 14 }
  elseif (%skin == Star) { var %lb = 0,02, %bb = 8,02, %ct = 10,00, %cc = 12,00, %bl = 10, %bf = 0 }
  elseif (%skin == Land) { var %lb = 7,05, %bb = 0,05, %ct = 5,00, %cc = 14,00, %bl = 3, %bf = 15 }
  elseif (%skin == Solid) { var %lb = 15,14, %bb = 5,14, %ct = 1,00, %cc = 15,00, %bl = 1, %bf = 15 }
  if (!%bf) { var %bf = $chr(3) $+ $gettok(%bb,2,44) } | if (!%bl) { var %bl = $gettok(%bb,1,44) }
  var %msg = $2-, %msg = $replace(%msg,:barra0;,$+ %bf $+ $str($chr(127),10),:barra1;,%bl $+ $str($chr(127),1) $+ %bf $+ $str($chr(127),9),:barra2;,%bl $+ $str($chr(127),2) $+ %bf $+ $str($chr(127),8),:barra3;,%bl $+ $str($chr(127),3) $+ %bf $+ $str($chr(127),7),:barra4;,%bl $+ $str($chr(127),4) $+ %bf $+ $str($chr(127),6),:barra5;,%bl $+ $str($chr(127),5) $+ %bf $+ $str($chr(127),5))
  var %msg = $replace(%msg,:barra6;,%bl $+ $str($chr(127),6) $+ %bf $+ $str($chr(127),4),:barra7;,%bl $+ $str($chr(127),7) $+ %bf $+ $str($chr(127),3),:barra8;,%bl $+ $str($chr(127),8) $+ %bf $+ $str($chr(127),2),:barra9;,%bl $+ $str($chr(127),9) $+ %bf $+ $str($chr(127),1),:barra10;,%bl $+ $str($chr(127),10))

  .msg $1 $replace(%msg,:lb;,%lb,:bb;,%bb,:ct;,%ct,:cc;,%cc,:rct;,$rcolor(%ct),:rcc;,$rcolor(%cc))
}
alias rluck {
  var %l1 = $rand(1,100), %l2 = $rand(1,100), %l3 = $rand(0,25)
  if (%l1 > 20) && (%l2 > 20) { var %luck = Comum }
  else {
    if (%l1 <= 20) { if (%l2 >= 70) { var %luck = Incomum } | else { if ($calc(%l1 + %l2) <= 20) { var %luck = Raro } | else { var %luck = Comum } } }
    if (%l2 <= 20) { if (%l1 >= 70) { var %luck = Incomum } | else { if ($calc(%l2 + %l1) <= 20) { var %luck = Raro } | else { var %luck = Comum } } }
    if (%luck == Raro) { if ($calc((%l1 * %l2) / %l3) == 1) { var %luck = Rarissimo } }
  }
  return %luck
}
alias rmove {
  if ($prop == s) {
    if ($1 == Focus Punch) { return TM01 }
    elseif ($1 == Dragon Claw) { return TM02 }
    elseif ($1 == Water Pulse) { return TM03 }
    elseif ($1 == Calm Mind) { return TM04 }
    elseif ($1 == Roar) { return TM05 }
    elseif ($1 == Toxic) { return TM06 }
    elseif ($1 == Hail) { return TM07 }
    elseif ($1 == Bulk Up) { return TM08 }
    elseif ($1 == Bullet Seed) { return TM09 }
    elseif ($1 == Hidden Power) { return TM10 }
    elseif ($1 == Sunny Day) { return TM11 }
    elseif ($1 == Taunt) { return TM12 }
    elseif ($1 == Ice Beam) { return TM13 }
    elseif ($1 == Blizzard) { return TM14 }
    elseif ($1 == Hyper Beam) { return TM15 }
    elseif ($1 == Light Screen) { return TM16 }
    elseif ($1 == Protect) { return TM17 }
    elseif ($1 == Rain Dance) { return TM18 }
    elseif ($1 == Giga Drain) { return TM19 }
    elseif ($1 == Safeguard) { return TM20 }
    elseif ($1 == Frustration) { return TM21 }
    elseif ($1 == Solarbeam) { return TM22 }
    elseif ($1 == Iron Tail) { return TM23 }
    elseif ($1 == Thunderbolt) { return TM24 }
    elseif ($1 == Thunder) { return TM25 }
    elseif ($1 == Earthquake) { return TM26 }
    elseif ($1 == Return) { return TM27 }
    elseif ($1 == Dig) { return TM28 }
    elseif ($1 == Psychic) { return TM29 }
    elseif ($1 == Shadow Ball) { return TM30 }
    elseif ($1 == Brick Break) { return TM31 }
    elseif ($1 == Double Team) { return TM32 }
    elseif ($1 == Reflect) { return TM33 }
    elseif ($1 == Shock Wave) { return TM34 }
    elseif ($1 == Flamethrower) { return TM35 }
    elseif ($1 == Sludge Bomb) { return TM36 }
    elseif ($1 == Sandstorm) { return TM37 }
    elseif ($1 == Fire Blast) { return TM38 }
    elseif ($1 == Rock Tomb) { return TM39 }
    elseif ($1 == Aerial Ace) { return TM40 }
    elseif ($1 == Torment) { return TM41 }
    elseif ($1 == Facade) { return TM42 }
    elseif ($1 == Secret Power) { return TM43 }
    elseif ($1 == Rest) { return TM44 }
    elseif ($1 == Attract) { return TM45 }
    elseif ($1 == Thief) { return TM46 }
    elseif ($1 == Steel Wing) { return TM47 }
    elseif ($1 == Skill Swap) { return TM48 }
    elseif ($1 == Snatch) { return TM49 }
    elseif ($1 == Overheat) { return TM50 }
    elseif ($1 == Cut) { return HM01 }
    elseif ($1 == Fly) { return HM02 }
    elseif ($1 == Surf) { return HM03 }
    elseif ($1 == Strength) { return HM04 }
    elseif ($1 == Flash) { return HM05 }
    elseif ($1 == Rock Smash) { return HM06 }
    elseif ($1 == Waterfall) { return HM07 }
    elseif ($1 == Dive) { return HM08 }
    elseif ($1 == Double-Edge) { return MT01 }
    elseif ($1 == Mimic) { return MT02 }
    elseif ($1 == Substitute) { return MT03 }
    elseif ($1 == Body Slam) { return MT04 }
    elseif ($1 == Thunder Wave) { return MT05 }
    elseif ($1 == Mega Punch) { return MT06 }
    elseif ($1 == Mega Kick) { return MT07 }
    elseif ($1 == Metronome) { return MT08 }
    elseif ($1 == Swords Dance) { return MT09 }
    elseif ($1 == Dream Eater) { return MT10 }
    elseif ($1 == Seismic Toss) { return MT11 }
    elseif ($1 == Counter) { return MT12 }
    elseif ($1 == Softboiled) { return MT13 }
    elseif ($1 == Rock Slide) { return MT14 }
    elseif ($1 == Explosion) { return MT15 }
    elseif ($1 == Sleep Talk) { return MT16 }
    elseif ($1 == Snore) { return MT17 }
    elseif ($1 == Swagger) { return MT18 }
    elseif ($1 == Endure) { return MT19 }
    elseif ($1 == Psych Up) { return MT20 }
    elseif ($1 == Defense Curl) { return MT21 }
    elseif ($1 == Dynamicpunch) { return MT22 }
    elseif ($1 == Fire Punch) { return MT23 }
    elseif ($1 == Thunderpunch) { return MT24 }
    elseif ($1 == Ice Punch) { return MT25 }
    elseif ($1 == Icy Wind) { return MT26 }
    elseif ($1 == Fury Cutter) { return MT27 }
    elseif ($1 == Rollout) { return MT28 }
    elseif ($1 == Swift) { return MT29 }
    elseif ($1 == Mud-Slap) { return MT30 }
    else { return Level }
  }
  else {
    if ($1 == TM01) { return Focus Punch }
    elseif ($1 == TM02) { return Dragon Claw }
    elseif ($1 == TM03) { return Water Pulse }
    elseif ($1 == TM04) { return Calm Mind }
    elseif ($1 == TM05) { return Roar }
    elseif ($1 == TM06) { return Toxic }
    elseif ($1 == TM07) { return Hail }
    elseif ($1 == TM08) { return Bulk Up }
    elseif ($1 == TM09) { return Bullet Seed }
    elseif ($1 == TM10) { return Hidden Power }
    elseif ($1 == TM11) { return Sunny Day }
    elseif ($1 == TM12) { return Taunt }
    elseif ($1 == TM13) { return Ice Beam }
    elseif ($1 == TM14) { return Blizzard }
    elseif ($1 == TM15) { return Hyper Beam }
    elseif ($1 == TM16) { return Light Screen }
    elseif ($1 == TM17) { return Protect }
    elseif ($1 == TM18) { return Rain Dance }
    elseif ($1 == TM19) { return Giga Drain }
    elseif ($1 == TM20) { return Safeguard }
    elseif ($1 == TM21) { return Frustration }
    elseif ($1 == TM22) { return Solarbeam }
    elseif ($1 == TM23) { return Iron Tail }
    elseif ($1 == TM24) { return Thunderbolt }
    elseif ($1 == TM25) { return Thunder }
    elseif ($1 == TM26) { return Earthquake }
    elseif ($1 == TM27) { return Return }
    elseif ($1 == TM28) { return Dig }
    elseif ($1 == TM29) { return Psychic }
    elseif ($1 == TM30) { return Shadow Ball }
    elseif ($1 == TM31) { return Brick Break }
    elseif ($1 == TM32) { return Double Team }
    elseif ($1 == TM33) { return Reflect }
    elseif ($1 == TM34) { return Shock Wave }
    elseif ($1 == TM35) { return Flamethrower }
    elseif ($1 == TM36) { return Sludge Bomb }
    elseif ($1 == TM37) { return Sandstorm }
    elseif ($1 == TM38) { return Fire Blast }
    elseif ($1 == TM39) { return Rock Tomb }
    elseif ($1 == TM40) { return Aerial Ace }
    elseif ($1 == TM41) { return Torment }
    elseif ($1 == TM42) { return Facade }
    elseif ($1 == TM43) { return Secret Power }
    elseif ($1 == TM44) { return Rest }
    elseif ($1 == TM45) { return Attract }
    elseif ($1 == TM46) { return Thief }
    elseif ($1 == TM47) { return Steel Wing }
    elseif ($1 == TM48) { return Skill Swap }
    elseif ($1 == TM49) { return Snatch }
    elseif ($1 == TM50) { return Overheat }
    elseif ($1 == HM01) { return Cut }
    elseif ($1 == HM02) { return Fly }
    elseif ($1 == HM03) { return Surf }
    elseif ($1 == HM04) { return Strength }
    elseif ($1 == HM05) { return Flash }
    elseif ($1 == HM06) { return Rock Smash }
    elseif ($1 == HM07) { return Waterfall }
    elseif ($1 == HM08) { return Dive }
    elseif ($1 == MT01) { return Double-Edge }
    elseif ($1 == MT02) { return Mimic }
    elseif ($1 == MT03) { return Substitute }
    elseif ($1 == MT04) { return Body Slam }
    elseif ($1 == MT05) { return Thunder Wave }
    elseif ($1 == MT06) { return Mega Punch }
    elseif ($1 == MT07) { return Mega Kick }
    elseif ($1 == MT08) { return Metronome }
    elseif ($1 == MT09) { return Swords Dance }
    elseif ($1 == MT10) { return Dream Eater }
    elseif ($1 == MT11) { return Seismic Toss }
    elseif ($1 == MT12) { return Counter }
    elseif ($1 == MT13) { return Softboiled }
    elseif ($1 == MT14) { return Rock Slide }
    elseif ($1 == MT15) { return Explosion }
    elseif ($1 == MT16) { return Sleep Talk }
    elseif ($1 == MT17) { return Snore }
    elseif ($1 == MT18) { return Swagger }
    elseif ($1 == MT19) { return Endure }
    elseif ($1 == MT20) { return Psych Up }
    elseif ($1 == MT21) { return Defense Curl }
    elseif ($1 == MT22) { return Dynamicpunch }
    elseif ($1 == MT23) { return Fire Punch }
    elseif ($1 == MT24) { return Thunderpunch }
    elseif ($1 == MT25) { return Ice Punch }
    elseif ($1 == MT26) { return Icy Wind }
    elseif ($1 == MT27) { return Fury Cutter }
    elseif ($1 == MT28) { return Rollout }
    elseif ($1 == MT29) { return Swift }
    elseif ($1 == MT30) { return Mud-Slap }
    else { return None }
  }
}
alias mes {
  if ($1 == January) { return Janeiro }
  elseif ($1 == February) { return Fevereiro }
  elseif ($1 == March) { return Março }
  elseif ($1 == April) { return Abril }
  elseif ($1 == May) { return Maio }
  elseif ($1 == June) { return Junho }
  elseif ($1 == July) { return Julho }
  elseif ($1 == August) { return Agosto }
  elseif ($1 == September) { return Setembro }
  elseif ($1 == October) { return Outubro }
  elseif ($1 == November) { return Novembro }
  elseif ($1 == December) { return Dezembro }
  else { return }
}

alias data {
  var %n = $1, %s = $2, %z = $ini(%n,%s,0), %x = 0
  while (%x < %z) {
    inc %x
    if (%r) { var %r = %r $+ $chr(35) $+ $ini(%n,%s,%x) $+ = $+ $readini(%n,%s,$ini(%n,%s,%x)) }
    else { var %r = $ini(%n,%s,%x) $+ = $+ $readini(%n,%s,$ini(%n,%s,%x)) }
  }
  return %r
}

alias dados {
  var %nick = $1, %type = $2, %action = $3, %value = $4
  var %a = $rini(cadastros,%nick,%type,%action)
  if (%type == Time) { return %a }
  if (%type == Info) {
    if (%action == Perfil) {
      if ($prop == on) { writeini pkp\cadastros\ $+ %nick $+ .ini %type %action $puttok(%a,1,%value,58) | return }
      elseif ($prop == off) { writeini pkp\cadastros\ $+ %nick $+ .ini %type %action $puttok(%a,0,%value,58) | return }
      else { return $gettok(%a,%value,58) }
    }
    elseif (%action == Milhagem) { return $int($calc(%a / 600)) }
    elseif (%action == Access) {
      if ($prop == n) { return %a }
      else {
        if (%a == 1) { return Iniciante }
        elseif (%a == 2) { return Experiente }
        elseif (%a == 3) { return Avançado }
        elseif (%a == 4) { return Mestre }
        elseif (%a == 5) { return Moderador }
        else { return ??? }
      }
    }
    elseif (%action == Skin) { if (%a) { return $org(%a) } | else { return Padrão } }
    elseif (%action == Premium) {
      if ($prop == since) { if (%a) { return $gettok(%a,1,59) } | else { return } }
      elseif ($prop == days) { if (%a) { return $gettok(%a,2,59) } | else { return } }
      elseif ($prop == remain) { var %r = $calc($rini(cadastros,%nick,Info,Online) - $gettok(%a,1,59)) | if (%r >= $calc(86400 * $gettok(%a,2,59))) { return 0 } | else { return $calc(86400 * $gettok(%a,2,59) - %r) } }
      else { if (%a) { return ON } | else { return } }
    }
    elseif (%action == Coin) { if (%a) { return %a } | else { return 0 } }
  }
  if (%type == Historico) {
    if (%action == Win) { return $iif(%a,%a,0) }
    elseif (%action == Lose) { return $iif(%a,%a,0) }
    elseif (%action == Battle) { var %r = $calc($rini(cadastros,%nick,%type,Win) + $rini(cadastros,%nick,%type,Lose)) | return $iif(%r,%r,0) }
  }
  if (%type == Score) {
    var %r = $int($calc($rini(cadastros,%nick,Hoenn,Score) + $rini(cadastros,%nick,Kanto,Score) + $rini(cadastros,%nick,Johto,Score) * 1.5))
    return $iif(%r,%r,0)
  }
  if (%action == Badges) {
    if ($prop == n) { return $iif(%a,$gettok(%a,0,58),0) }
  }
  return $iif(%a,%a,0)
}
alias start { if ($dados($1,Info,Region) == $dados($1,Info,Start)) { return $true } | else { return $false } }
alias badge {
  var %n = Hoenn:Kanto:Johto, %x = 1
  while (%x <= $gettok(%n,0,58)) {
    if ($findtok($dados($1,$gettok(%n,%x,58),Badges),$2,0,58)) { return $true }
    inc %x
  }
  return $false
}

alias item.data {
  var %i = $1, %f = pkp\item.txt
  if ($2 == name) { var %x = $read(%f,s,%i $+ :), %x = $readn, %x = $gettok($read(%f,%x),1,58) }
  elseif ($2 == desc) { var %x = $read(%f,s,%i $+ :), %x = $gettok(%x,3,172) }
  elseif ($2 == bag) || ($2 == use) { var %x = $read(%f,s,%i $+ :), %x = $gettok(%x,2,172) | if ($2 == bag) { var %x = $gettok(%x,$gettok(%x,0,58),58) } | else { var %x = $gettok(%x,1,58) } }
  elseif ($2 == price) || ($2 == milha) || ($2 == coin) {
    var %x = $read(%f,s,%i $+ :), %x = $gettok(%x,1,172)
    if (%x) { if ($2 == price) { var %x = $remove($wildtok(%x,¥ $+ *,1,32),¥) } | elseif ($2 == coin) { var %x = $remove($wildtok(%x,¢ $+ *,1,32),¢) } | else { if ($wildtok(%x,¥ $+ *,0,32)) { var %x = $remtok(%x,$wildtok(%x,¥ $+ *,1,32),1,32) } | if ($wildtok(%x,¢ $+ *,0,32)) { var %x = $remtok(%x,$wildtok(%x,¢ $+ *,1,32),1,32) } } }
  }
  return $iif(%x,%x,0)
}
alias ispk {
  if ($read(pkp\moveset.txt,s,$1)) { return $true }
  else { return $false }
}

alias nstat { return $gettok(Hp Atk Def Spd SAtk SDef,$1,32) }
alias mirror {
  var %ID = $1, %team = $2, %hlv = $3, %hpk = $4, %p = $v($+(B.,%ID,.Player.,%team))

  var %x = 1 | if ($prop == 2) { var %hpk = 0: $+ %hpk, %x = 2 }
  while ($gettok(%hpk,%x,58)) {
    var %tpk = $gettok(%hpk,%x,58), %tev = $getmaxevolves(%tpk,%hpk), %r = 0
    if (%tev) {
      while ($gettok(%tev,1,58)) {
        var %tx = $rand(1,$gettok(%tev,0,58)), %t.pk = $gettok(%tev,%tx,58), %tev = $deltok(%tev,%tx,58)
        if ($box.search($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%t.pk)) {
          var %s = $box.search($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%t.pk), %r = $getteam²(%s), %hpk = $puttok(%hpk,%t.pk,%x,58), %tev = 0
          var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $gettok(%s,$calc(15 + %y),59), %ev = $gettok(%s,$calc(21 + %y),59), %nat = $gettok(%s,4,59) | if (%st == HP) { var %v = $calcstat($basestat(%t.pk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%t.pk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
        }
        elseif ($dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%t.pk,Name)) {
          var %s = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]), %r = $getteam(%s,%t.pk), %hpk = $puttok(%hpk,%t.pk,%x,58), %tev = 0
          var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $dados(%s,%t.pk,IV $+ %st), %ev = $dados(%s,%t.pk,EV $+ %st), %nat = $dados(%s,%t.pk,Nature) | if (%st == HP) { var %v = $calcstat($basestat(%t.pk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%t.pk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
        }
      }
      if (!%r) {
        var %r = $getteam(%p,%tpk)
        var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $dados(%p,%tpk,IV $+ %st), %ev = $dados(%p,%tpk,EV $+ %st), %nat = $dados(%p,%tpk,Nature) | if (%st == HP) { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
      }
    }
    else {
      if ($box.search($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%tpk)) {
        var %s = $box.search($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%tpk), %r = $getteam²(%s)
        var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $gettok(%s,$calc(15 + %y),59), %ev = $gettok(%s,$calc(21 + %y),59), %nat = $gettok(%s,4,59) | if (%st == HP) { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
      }
      elseif ($dados($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]),%tpk,Name)) {
        var %s = $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $rvs(%team) ] ]), %r = $getteam(%s,%tpk)
        var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $dados(%s,%tpk,IV $+ %st), %ev = $dados(%s,%tpk,EV $+ %st), %nat = $dados(%s,%tpk,Nature) | if (%st == HP) { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
      }
      else {
        var %r = $getteam(%p,%tpk)
        var %y = 1 | while (%y < 7) { var %st = $nstat(%y), %iv = $dados(%p,%tpk,IV $+ %st), %ev = $dados(%p,%tpk,EV $+ %st), %nat = $dados(%p,%tpk,Nature) | if (%st == HP) { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv).hp } | else { var %v = $calcstat($basestat(%tpk,%st),%iv,%ev,%hlv,$getp(%nat,%st)) } | var %r = $puttok(%r,%v,$calc(8 + %y),58) | inc %y } | var %r = $puttok(%r,%hlv,2,58), %r = $puttok(%r,$gettok(%r,9,58),15,58)
      }
    }
    if (%x == 1) { sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $rvs(%team) ] ] $gettok(%r,1,58) | sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ $rvs(%team) ] ] ON }
    if (%x == 2) && ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) && (!$battle.team(%ID,$rvs(%team))) { sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $battle.team(%ID,$rvs(%team)).num ] ] $gettok(%r,1,58) | sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ $battle.team(%ID,$rvs(%team)).num ] ] ON }

    sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %x ] $+ ] : ] $+ [ $rvs(%team) ] ] %r
    inc %x
  }
}
alias getip {
  var %x = 0, %y = $chat(0)
  if ($prop == r) { while (%x < %y) { inc %x | if ($chat(%x).ip == $1) { return $chat(%x) } } }
  else { while (%x < %y) { inc %x | if ($chat(%x) == $1) { return $chat(%x).ip } } }
}
alias fulldur {
  var %d = $duration($1)
  if (wk isin %d) {
    var %w = $gettok(%d,1,119)
    if (%w > 3) {
      var %d = $deltok(%d,1,32), %m = $int($calc(%w / 4)), %w = $calc(%w % 4)
      if (%w) { var %d = %w $+ wk $+ $iif(%w > 1,s) %d }
      if (%m > 11) {
        var %y = $int($calc(%m / 12)), %m = $calc(%m % 12)
        if (%m) { var %d = %m $+ mth $+ $iif(%m > 1,s) %d }
        var %d = %y $+ yr $+ $iif(%y > 1,s) %d
      }
      else { var %d = %m $+ mth $+ $iif(%m > 1,s) %d }
    }
  }
  return %d
}
alias dur {
  if ($prop == e) { var %d = $1 } | else { var %d = $fulldur($1) }
  var %c1 = $2, %c2 = $3, %r = %c2 $+ $replace(%d,$chr(32),$chr(32) $+ %c2 $+,yr,$chr(32) $+ %c1 $+ ano,mths,$chr(32) $+ %c1 $+ meses,mth,$chr(32) $+ %c1 $+ mês,wk,$chr(32) $+ %c1 $+ semana,day,$chr(32) $+ %c1 $+ dia,hr,$chr(32) $+ %c1 $+ hora,min,$chr(32) $+ %c1 $+ minuto,sec,$chr(32) $+ %c1 $+ segundo)

  var %n = $gettok(%r,0,32), %x = 2
  if (%n > 4) {
    while (%x <= $calc(%n - 4)) { var %r = $puttok(%r,$gettok(%r,%x,32) $+ $chr(44),%x,32) | inc %x | inc %x }
  }
  if (%n > 2) { var %r = $gettok(%r,1- $+ $calc(%n - 2),32) e $gettok(%r,-2-1,32) }
  return %r
}
alias report {
  var %f = pkp\log\report.txt
  if ($exists(%f)) { .run %f | .timerREMREPORT 1 1 .remove %f }
}
alias calctok {
  var %t = $1, %n = $2, %chr = $3, %s = $4

  var %x = 1
  while ($gettok(%n,%x,%chr)) {
    var %temp = $gettok(%n,%x,%chr)
    if (%s == -) { var %y = $findtok(%t,%temp,0,%chr) | while (%y) { var %t = $remtok(%t,%temp,%y,%chr) | dec %y } }
    elseif (%s == +) { var %t = $addtok(%t,%temp,%chr) }
    elseif (%s == *) { var %t = %t $+ $chr(%chr) $+ %temp }
    elseif (%s == /) { var %t = $remtok(%t,%temp,1,%chr) }
    inc %x
  }
  return %t
}
alias randtok {
  var %tokens = $1, %chr = $2
  while ($gettok(%tokens,1,%chr)) {
    var %n = $rand(1,$gettok(%tokens,0,%chr))
    if (%r) { var %r = %r $+ $chr(%chr) $+ $gettok(%tokens,%n,%chr) } | else { var %r = $gettok(%tokens,%n,%chr) }
    var %tokens = $deltok(%tokens,%n,%chr)
  }
  return %r
}
alias separecom {
  var %separe = $2, %chr = $3, %cc = $4, %ct = $5
  var %x = 1 | while ($gettok($1,%x,%chr)) {
    if (%r) { if (%x == $gettok($1,0,%chr)) { var %r = %r %ct $+ %separe %cc $+ $gettok($1,%x,%chr) } | else { var %r = %r $+ %ct $+ $chr(44) %cc $+ $gettok($1,%x,%chr) } } | else { var %r = %cc $+ $gettok($1,%x,%chr) }
    inc %x
  }
  return %r
}
alias gotoplace {
  var %l = $replace($2,$chr(32),_), %d = $3, %r = $dados($1,Info,Region)
  if ($dados($1,Info,Path)) { var %l = %l $+ : $+ $dados($1,Info,Path) }

  var %read = $readini(pkp\region.ini,%r,%l), %part = $gettok(%read,1,172)
  if (%l) && (%r == Hoenn) {
    if (($dados($1,Info,Start) == Johto) && ($dados($1,Quests,League))) || ($dados($1,Johto,League)) {
      if ($2 == $readini(pkp\status.ini,Active,Terra_Cave)) { var %part = $addtok(%part,Terra Cave#,58) }
      if ($2 == $readini(pkp\status.ini,Active,Marine_Cave)) { var %part = $addtok(%part,Marine Cave#,58) }
    }
  }
  if ($2 == Terra Cave) { if ($dados($1,Info,LastLocate)) { var %part = $addtok(%part,$dados($1,Info,LastLocate) $+ $chr(35),58) } | else { var %part = $addtok(%part,Lavaridge Town#,58) } }
  if ($2 == Marine Cave) { if ($dados($1,Info,LastLocate)) { var %part = $addtok(%part,$dados($1,Info,LastLocate) $+ $chr(35),58) } | else { var %part = $addtok(%part,Sootopolis City#,58) } }

  if ($wildtok(%part,%d $+ #*,0,58)) {
    if ($prop == get) { return $wildtok(%part,%d $+ #*,1,58) }
    else { return Ok! }
  }
  var %read = $deltok(%read,1,172)

  while ($gettok(%read,1,172)) {
    var %part = $gettok(%read,1,172), %needed = $gettok(%part,1,58), %part = $deltok(%part,1,58)
    if ($wildtok(%part,%d $+ #*,0,58)) {
      var %y = $gettok(%needed,0,38), %r = 0
      while ($gettok(%needed,1,38)) {
        var %a = $gettok(%needed,1,38)
        if ($left(%a,2) == i@) { if ($item($1,$right(%a,-2)).qnt) { inc %r } }
        elseif ($left(%a,2) == q@) { if ($dados($1,Quests,$right(%a,-2))) { inc %r } }
        else { if ($team.hm($nick,%a) == Ok!) { inc %r } }
        var %needed = $deltok(%needed,1,38)
      }
      if (%y == %r) {
        if ($prop == get) { return $wildtok(%part,%d $+ #*,1,58) }
        else { return Ok! }
      }
    }
    var %read = $deltok(%read,1,172)
  }
}
alias gotowhere {
  var %l = $replace($2,$chr(32),_), %last = $dados($1,Info,LastLocate)
  if ($dados($1,Info,Path)) { var %l = %l $+ : $+ $dados($nick,Info,Path) }

  var %read = $readini(pkp\region.ini,$dados($1,Info,Region),%l), %part = $gettok(%read,1,172)
  if (%l) && ($dados($1,Info,Region) == Hoenn) {
    if (($dados($1,Info,Start) == Johto) && ($dados($1,Quests,League))) || ($dados($1,Johto,League)) {
      if ($2 == $readini(pkp\status.ini,Active,Terra_Cave)) { var %part = $addtok(%part,Terra Cave#,58) }
      if ($2 == $readini(pkp\status.ini,Active,Marine_Cave)) { var %part = $addtok(%part,Marine Cave#,58) }
    }
  }
  if ($2 == Terra Cave) { if ($dados($1,Info,LastLocate)) { var %part = $addtok(%part,$dados($1,Info,LastLocate) $+ #,58) } | else { var %part = $addtok(%part,Lavaridge Town#,58) } }
  if ($2 == Marine Cave) { if ($dados($1,Info,LastLocate)) { var %part = $addtok(%part,$dados($1,Info,LastLocate) $+ #,58) } | else { var %part = $addtok(%part,Sootopolis City#,58) } }

  var %x = 1
  while ($gettok(%part,%x,58)) {
    var %p = $gettok($gettok(%part,%x,58),1,35)
    if (%r) { var %r = %r $+ : $+ %p } | else { var %r = %p }
    inc %x
  }
  if (%last) && ($findtok(%r,%last,0,58)) { if ($gettok(%r,0,58) > 1) { var %r = $remtok(%r,%last,1,58), %r = %r $+ : $+ %last } } | else { var %last = 0 }
  if (%r) { var %res = 1 | msg $+(=,$1) $ct $+ Você poderá deslocar-se às seguintes localizações: | var %e = 1 | while ($gettok(%r,%e,58)) { msg $+(=,$1) $chr(160) $cc $+ $gettok(%r,%e,58) | inc %e } }
  var %read = $deltok(%read,1,172), %r = 0

  var %x = 1
  while ($gettok(%read,%x,172)) {
    var %part = $gettok(%read,%x,172), %needed = $gettok(%part,1,58), %part = $deltok(%part,1,58)
    var %total = $gettok(%needed,0,38), %req = 0, %item = 0, %tech = 0, %z = 1
    while ($gettok(%needed,%z,38)) {
      var %a = $gettok(%needed,%z,38)
      if ($left(%a,2) == i@) { if ($item($1,$right(%a,-2)).qnt) { inc %req | if (%item) { var %item = %item $+ : $+ $right(%a,-2) } | else { var %item = $right(%a,-2) } } }
      elseif ($left(%a,2) == q@) { if ($dados($1,Quests,$right(%a,-2))) { inc %req } }
      else { if ($team.hm($1,%a) == Ok!) { inc %req | if (%tech) { var %tech = %tech $+ : $+ %a } | else { var %tech = %a } } }
      inc %z
    }
    if (%total == %req) {
      var %y = 1, %r = 0
      while ($gettok(%part,%y,58)) {
        var %p = $gettok($gettok(%part,%y,58),1,35)
        if (%r) { var %r = %r $+ : $+ %p } | else { var %r = %p }
        inc %y
      }
      if (%tech) && (%item) { var %needed = $separecom(%tech $+ : $+ %item,e,58,$cc,$ct) }
      elseif (%tech) { var %needed = $separecom(%tech,e,58,$cc,$ct) }
      elseif (%item) { var %needed = $separecom(%item,e,58,$cc,$ct) }
      else { var %needed = 0 }
      if (!%res) { msg $+(=,$1) $ct $+ Você poderá deslocar-se às seguintes localizações: | var %res = 1 }
      var %e = 1 | while ($gettok(%r,%e,58)) {
        if (%needed) { msg $+(=,$1) $chr(160) $cc $+ $arrange($gettok(%r,%e,58),160,20) $ct $+ ( $+ %needed $+ $ct $+ ) }
        else { msg $+(=,$1) $chr(160) $cc $+ $gettok(%r,%e,58) }
        inc %e
      }
    }
    inc %x
  }
  if (%res) { msg $+(=,$1) $ct $+ Fim da exibição de localizações. }
  if (!%res) { msg $+(=,$1) $ct $+ Não há condições em seu time para realizar mudança de localização. }
}

alias c.trans.cad {
  var %nick = $1, %fakenick = $2, %box = $3

  if (!$dados(%nick,Info,Nick)) { .msg =$nick $cc $+ %nick $ct $+ não está cadastro no sistema. | return }
  if (!$dados(%fakenick,Info,Nick)) { .msg =$nick $cc $+ %fakenick $ct $+ não está cadastro no sistema. | return }
  if (%box) {
    var %filebox = pkp\box\ $+ %fakenick $+ \ $+ %box $+ .ini
    if (!$exists(%filebox)) { .msg =$nick $cc $+ %fakenick $ct $+ não possui a box selecionada. | return }
    if ($readini(%filebox,Info,Size) != 30) { .msg =$nick $ct $+ A caixa selecionada não comporta em seu interior $cc $+ 30 $ct $+ pokémon. | return }
    if (!$exists(pkp\box\ $+ %nick $+ \)) { .msg =$nick $cc $+ %nick $ct $+ não possui caixa alguma ou não possui um PC. | return }
    msg =$nick $ct $+ Iniciando transferência... Aguarde. Poderá levar alguns segundos...
    var %newfilebox = pkp\box\ $+ %nick $+ \ $+ $calc($findfile(pkp\box\ $+ %nick $+ \,*.ini,0) + 1) $+ .ini
    writeini %newfilebox Info Size $readini(%filebox,Info,Size)
    writeini %newfilebox Info Link $readini(%filebox,Info,Link)
    while ($ini(%filebox,Box,0)) {
      var %pk = $ini(%filebox,Box,1), %info = $readini(%filebox,Box,%pk)
      if ($gettok(%info,2,59) == %fakenick) { var %info = $puttok(%info,%nick,2,59) }
      if ($gettok(%info,14,59)) && (!$findtok(TM:MT:Instant:Hold:Berry,$item.data($gettok(%info,14,59),bag),0,58)) { var %info = $puttok(%info,0,14,59) }
      if (!$pokedex(%nick,%pk)) { .echo $pokedex(%nick,%pk).add }
      writeini %newfilebox Box %pk %info
      remini %filebox Box %pk
    }
    writeini pkp\cadastros\ $+ %nick $+ .ini PC Points $pc(%nick).points
    writeini pkp\cadastros\ $+ %fakenick $+ .ini PC Points $pc(%fakenick).points
  }
  else { msg =$nick $ct $+ Iniciando transferência... Aguarde. Poderá levar alguns segundos... }
  var %x = Milhagem | writeini pkp\cadastros\ $+ %nick $+ .ini Info %x $calc($readini(pkp\cadastros\ $+ %nick $+ .ini,Info,%x) + $readini(pkp\cadastros\ $+ %fakenick $+ .ini,Info,%x)) | writeini pkp\cadastros\ $+ %fakenick $+ .ini Info %x 0
  var %x = Online | writeini pkp\cadastros\ $+ %nick $+ .ini Info %x $calc($readini(pkp\cadastros\ $+ %nick $+ .ini,Info,%x) + $readini(pkp\cadastros\ $+ %fakenick $+ .ini,Info,%x)) | writeini pkp\cadastros\ $+ %fakenick $+ .ini Info %x 0
  var %x = Coin | writeini pkp\cadastros\ $+ %nick $+ .ini Info %x $calc($readini(pkp\cadastros\ $+ %nick $+ .ini,Info,%x) + $readini(pkp\cadastros\ $+ %fakenick $+ .ini,Info,%x)) | writeini pkp\cadastros\ $+ %fakenick $+ .ini Info %x 0
  var %x = Money | writeini pkp\cadastros\ $+ %nick $+ .ini Info %x $int($calc($readini(pkp\cadastros\ $+ %nick $+ .ini,Info,%x) + ($readini(pkp\cadastros\ $+ %fakenick $+ .ini,Info,%x) / 2))) | writeini pkp\cadastros\ $+ %fakenick $+ .ini Info %x 0
  var %fileitem = pkp\cadastros\ $+ %fakenick $+ .ini
  var %x = 1 | while ($ini(%fileitem,Item,%x)) {
    var %kind = $ini(%fileitem,Item,%x)
    if ($findtok(TM:MT:Instant:Hold:Berry,%kind,0,58)) {
      var %y = 1, %itens = $readini(%fileitem,Item,%kind)
      while ($gettok(%itens,%y,58)) {
        var %item = $gettok(%itens,%y,58), %t = $gettok(%item,0,32), %qnt = $gettok(%item,%t,32), %item = $gettok(%item,1- $+ $calc(%t - 1),32)
        item.add %nick %item $+ : $+ %qnt
        inc %y
      }
    }
    inc %x
  }
  remini %fileitem Item TM | remini %fileitem Item MT | remini %fileitem Item Instant | remini %fileitem Item Hold | remini %fileitem Item Berry
  if ($checknick(%fakenick) == Ok!) { nick.kick PkPAdv %fakenick Seu cadastro foi transferido com sucesso. }
  nick.ban %fakenick
}

alias battle.npc.team {
  var %nick = $1, %npc = $2, %bteam = $3, %control = $4
  var %x = 0 | while (%x < $gettok(%bteam,0,59)) { inc %x | if ($gettok(%bteam,%x,59) !isnum) { var %bteam = $puttok(%bteam,$rini(npc,npc,ID,$gettok(%bteam,%x,59)),%x,59) } }
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
      if (d isin $rini(npc,$int($calc(%bteam / 100)) $+ 00,%bteam,Mode)) {
        if ($rini(cadastros,%nick,Team,2)) && ($rini(cadastros,%nick,Team,2) != Egg) { b.create.fila %nick $rini(cadastros,%nick,Team,1) $rini(cadastros,%nick,Team,2) }
        else { b.create.fila %nick $rini(cadastros,%nick,Team,1) }
      }
      else { b.create.fila %nick $rini(cadastros,%nick,Team,1) }
    }
  }
  if (!%ID) { var %ID = $checknickid(%nick).ID } | var %n = 0
  if ($gettok(%npc,0,59) > 1) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) { var %npc = $gettok(%npc,1,59) }
  var %x = 0 | while (%x < $gettok(%npc,0,59)) {
    inc %x | inc %n
    var %p = $gettok(%bteam,%x,59), %preal = $gettok(%npc,%x,59) | if (!%p) { var %p = $gettok(%bteam,$calc(%x - 1),59) }
    var %file = $int($calc(%p / 100)) $+ 00, %filereal = $int($calc(%preal / 100)) $+ 00, %t = $rini(npc,%file,%p,Team)
    var %cn = $gettok(%control,%x,59) | if (%cn) { if ($checknick(%cn) == Ok!) && ($checknickid(%cn) == No!) { sset [ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ $calc(%x + 1) ] ] %cn } }
    sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] $calc($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) + %t)
    if (p isin $rini(npc,%filereal,%preal,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .PP ] ] ON }
    if (s isin $rini(npc,%filereal,%preal,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Switch ] ] ON }
    if (u isin $rini(npc,%filereal,%preal,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON }
    if (a isin $rini(npc,%filereal,%preal,Mode)) { sset [ [ B. ] $+ [ %ID ] $+ [ .SLPClause ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .FRZClause ] ] ON }
  }
  if ($v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]) > 6) { sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] 6 }
  var %x = 0 | while (%x < $gettok(%npc,0,59)) {
    inc %x | var %preal = $gettok(%npc,%x,59), %filereal = $int($calc(%preal / 100)) $+ 00, %p = $gettok(%bteam,%x,59), %file = $int($calc(%p / 100)) $+ 00, %t = $v([ [ B. ] $+ [ %ID ] $+ [ .Match ] ]), %t = $iif(%n > 1,$int($calc(%t / 2)),%t), %team = $iif(%n > 1,$calc(2 * %x),2), %y = 0
    while (%y < %t) {
      inc %y | var %pk = $rini(npc,%file,%p,%y)
      if (%pk) {
        sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %y ] $+ ] : ] $+ [ %Team ] ] %pk
        if (%n == 1) {
          if (%y == 1) {
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%filereal,%preal,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
            if ($rini(npc,%file,%p,Say)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Say: ] $+ [ %Team ] ] $rini(npc,%file,%p,Say) }
            if ($rini(npc,%filereal,%preal,Outfit)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%filereal,%preal,Outfit) }
          }
          if (%y == 2) && ($v([ [ B. ] $+ [ %ID ] $+ [ .2vs2 ] ])) {
            if ($v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %Team ] ])) { sset [ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ $battle.team(%ID,%Team).num ] ] $v([ [ B. ] $+ [ %ID ] $+ [ .TruePlayer: ] $+ [ %Team ] ]) }
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ $battle.team(%ID,%Team).num ] ] $rini(npc,%filereal,%preal,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ $battle.team(%ID,%Team).num ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ $battle.team(%ID,%Team).num ] ] ON
          }
        }
        else {
          if (%y == 1) {
            sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Team ] ] $rini(npc,%filereal,%preal,Name)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Poke. ] $+ [ %Team ] ] $gettok(%pk,1,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Lvl. ] $+ [ %Team ] ] $gettok(%pk,2,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Gender. ] $+ [ %Team ] ] $gettok(%pk,4,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Shiny. ] $+ [ %Team ] ] $gettok(%pk,5,58)
            sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP: ] $+ [ %Team ] ] ON
            if ($rini(npc,%file,%p,Say)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%file,%p,Say) }
            if ($rini(npc,%filereal,%preal,Outfit)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Team ] ] $rini(npc,%filereal,%preal,Outfit) }
          }
        }
      }
    }
  }

  sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON
  b.start.fight %ID

}

alias copyreg {
  var %o = $1, %d = $2, %par = $3

  if (!$exists(%o)) || (!$exists(%d)) || (!$3) { return }
  if ($ini(%d,%par,0)) { remini %d %par }

  var %x = 1 | while ($ini(%o,%par,%x)) {
    var %n = $ini(%o,%par,%x)
    writeini %d %par %n $readini(%o,%par,%n)
    inc %x
  }
}
