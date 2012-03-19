alias cmd.Market {
  if ($2 == add) {
    var %t = $iif($rini(cadastros,$nick,Info,Premium),6,3)
    if ($rini(cadastros,$nick,Info,StoreMarket) == %t) { msg =$nick $ct $+ Seu limite de $cc $+ $numero(%t) $ct $+ pokémon em $cc $+ Market $ct $+ foi alcançado. Aguarde até suas transações serem efetuadas, ou remova suas ofertas para liberar espaço. | return }
    var %t = $rini(cadastros,$nick,Time,Market), %d = $gettok(4 2 1 0.5 0.5,$rini(cadastros,$nick,Info,Access),32), %d = $calc(86400 * %d)
    if (%t) {
      var %r = $calc($ctime($date $time) - $ctime(%t))
      if (%r < %d) { msg =$nick $ct $+ Aguarde $dur($gettok($duration($calc(%d - %r)),1,32),$ct,$cc).e $ct $+ para efetuar novas transações no market. | return }
    }
    var %pk = $rini(cadastros,$nick,$3,Name) | if (!%pk) { msg =$nick $ct $+ Você não tem o pokémon selecionado. | return } | if (%pk == Egg) { msg =$nick $ct $+ Você não pode vender $cc $+ Eggs $+ $ct $+ . | return }
    if ($is_legend(%pk)) { msg =$nick $ct $+ Por se tratar de um pokémon $cc $+ lendário $+ $ct $+ , não pode ser trocado. | return }
    if ($dados($nick,%pk,Hold) == Master Ball) { msg =$nick $ct $+ Não é possível vender pokémon que carregam consigo uma $cc $+ Master Ball $+ $ct $+ . | return }
    if ($totalpokes($nick) == 1) { msg =$nick $ct $+ Você não pode ficar sem pokémon no time! | return }
    var %lv = $rini(cadastros,$nick,%pk,Level), %price = $4 | if (%price !isnum) { msg =$nick $ct $+ Você cometeu um erro de sintaxe. Digite " $+ $cc $+ .market $+ $ct $+ " para mais informações. | return } | if (%price < $calc(%lv * 1000)) || (%price > $calc(%lv * 20000)) { msg =$nick $ct $+ Pokémon no level $cc $+ %lv $ct $+ não podem ser vendidos por menos de $cc $+ $chr(36) $+ $getmoney($calc(%lv * 1000)) $ct $+ nem por mais de $cc $+ $chr(36) $+ $getmoney($calc(%lv * 20000)) $+ $ct $+ . | return }
    var %taxa = $int($calc($iif($rini(cadastros,$nick,Info,Premium),0.05,0.1) * %price)) | if ($rini(cadastros,$nick,Info,Money) < %taxa) { msg =$nick $ct $+ Você não tem dinheiro suficiente para completar a transação. | return }
    if ($5) { if ($len($5) < 4) || ($len($5) > 8) { msg =$nick $ct $+ Sua senha não pode ultrapassar $cc $+ oito $ct $+ dígitos, nem ter menos de $cc $+ quatro $ct $+ dígitos. | return } | var %pass = $upper($5) }
    var %nick = $rini(cadastros,$nick,Info,Nick), %line = $getpkline(%nick,%pk), %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $gettok($rini(market,%l,Store,ID),0,58), %pkn = %pk $+ : $+ $rini(cadastros,$nick,%pk,Sex) $+ : $+ $rini(cadastros,$nick,%pk,Level) $+ : $+ $rini(cadastros,$nick,%pk,Shiny)
    while (!%x) { var %ID = $rand(1,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) | if (!$findtok($rini(market,%l,Store,ID),%ID,0,58)) { var %x = 1 } }
    writeini pkp\market\ $+ %l $+ .ini Store ID $iif(%n,$rini(market,%l,Store,ID) $+ : $+ %ID,%ID)
    writeini pkp\market\ $+ %l $+ .ini Store Nick $iif(%n,$rini(market,%l,Store,Nick) $+ : $+ %nick,%nick)
    writeini pkp\market\ $+ %l $+ .ini Store Names $iif(%n,$rini(market,%l,Store,Names) $+ : $+ %pk,%pk)
    writeini pkp\market\ $+ %l $+ .ini %ID Nick %nick | writeini pkp\market\ $+ %l $+ .ini %ID Pokemon %line 
    writeini pkp\market\ $+ %l $+ .ini %ID Price %price | writeini pkp\market\ $+ %l $+ .ini %ID Date $date $time
    writeini pkp\market\ $+ %l $+ .ini %ID Name %pkn
    if (%pass) { writeini pkp\market\ $+ %l $+ .ini %ID Password %pass }
    if ($calc(%y + 1) == 1) { writeini pkp\cadastros\ $+ $nick $+ .ini Time Market $date $time $+ ; $+ $calc(%y + 1) } | else { writeini pkp\cadastros\ $+ $nick $+ .ini Time Market $gettok($rini(cadastros,$nick,Time,Market),1,59) $+ ; $+ $calc(%y + 1) }
    writeini pkp\cadastros\ $+ $nick $+ .ini Info Money $calc($rini(cadastros,$nick,Info,Money) - %taxa)
    writeini pkp\cadastros\ $+ $nick $+ .ini Info StoreMarket $calc($rini(cadastros,$nick,Info,StoreMarket) + 1)
    wlog user $nick Added %pk to $dados($nick,Info,Locate) $+ 's market.
    remteam $nick %pk | remini pkp\cadastros\ $+ $nick $+ .ini %pk | msg =$nick $ct $+ Sua nova oferta foi efetuada. Seu ID é ' $+ $cc $+ %ID $+ $ct $+ '. $iif(%pass,Sua senha é ' $+ $cc $+ %pass $+ $ct $+ '.) | return
  }
  elseif ($2 == rem) {
    var %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $findtok($rini(market,%l,Store,Nick),$nick,0,58), %id = $3
    if (!%n) { msg =$nick $ct $+ Você não criou nenhuma oferta no $cc $+ Market $ct $+ da cidade atual. | return }
    if (!$findtok($rini(market,%l,Store,ID),%ID,0,58)) { msg =$nick $ct $+ A ID selecionada não foi encontrada. Digite ' $+ $cc $+ .market list $nick $+ $ct $+ ' para exibir suas IDs de ofertas. | return }
    if ($rini(market,%l,$3,Nick) != $nick) { msg =$nick $ct $+ Você só pode remover do $cc $+ market $ct $+ IDs criadas por $cc $+ você $+ $ct $+ . | return }
    if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você precisa liberar espaço em seu time. | return }
    if ($rini(cadastros,$nick,$gettok($rini(market,%l,%ID,Name),1,58),Name)) { msg =$nick $ct $+ Você já tem um pokémon com o mesmo nome no time. | return }
    var %nick = $nick | tokenize 59 $rini(market,%l,%ID,Pokemon)
    if ($teampos(%nick,Egg)) { remteam %nick Egg | addteam %nick $1 | addteam %nick Egg } | else { addteam %nick $1 }
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Name $1
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 ID $2
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Level $3
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Nature $4
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Sex $5
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 GV $6
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Shiny $7
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Trait $8
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 ExpStat $9
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Exp $10
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Next $11
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Memory $12
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Loyalty $13
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Hold $14
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Ribbon $15
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVHp $16
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVAtk $17
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVDef $18
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSpd $19
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSAtk $20
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSDef $21
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVHP $22
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVAtk $23
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVDef $24
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSpd $25
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSAtk $26
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSDef $27
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 HP $28
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Atk $29
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Def $30
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Spd $31
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 SAtk $32
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 SDef $33
    if ($34) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Learn $34 }
    if ($35) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move1 $35 }
    if ($36) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move2 $36 }
    if ($37) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move3 $37 }
    if ($38) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move4 $38 }
    if ($gettok($rini(market,%l,Store,ID),0,58) > 1) { var %pos = $findtok($rini(market,%l,Store,ID),%ID,1,58) | writeini pkp\market\ $+ %l $+ .ini Store ID $deltok($rini(market,%l,Store,ID),%pos,58) | writeini pkp\market\ $+ %l $+ .ini Store Nick $deltok($rini(market,%l,Store,Nick),%pos,58) | writeini pkp\market\ $+ %l $+ .ini Store Names $deltok($rini(market,%l,Store,Names),%pos,58) } | else { remini pkp\market\ $+ %l $+ .ini Store }
    writeini pkp\cadastros\ $+ $nick $+ .ini Info StoreMarket $calc($rini(cadastros,$nick,Info,StoreMarket) - 1)
    wlog user $nick Removed $1 from $dados($nick,Info,Locate) $+ 's market.
    remini pkp\market\ $+ %l $+ .ini %ID | msg =$nick $ct $+ Pokémon $rtypename($1,$5,$3,$7) $ct $+ foi removido do $cc $+ Market $+ $ct $+ . | return
  }
  elseif ($2 == buy) {
    var %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $gettok($rini(market,%l,Store,Nick),0,58), %id = $3
    if (!%n) { msg =$nick $ct $+ Não há ofertas no $cc $+ Market $ct $+ da cidade atual. | return }
    if (!$findtok($rini(market,%l,Store,ID),%ID,0,58)) { msg =$nick $ct $+ A ID selecionada não foi encontrada. Digite ' $+ $cc $+ .market list $nick $+ $ct $+ ' para exibir suas IDs de ofertas. | return }
    if ($rini(market,%l,$3,Nick) == $nick) { msg =$nick $ct $+ Você não pode comprar suas próprias ofertas. | return }
    var %pass = $rini(market,%l,%ID,Password) | if (%pass) {
      if (!$4) { msg =$nick $ct $+ Digite ' $+ $cc $+ .market buy %ID <password> $+ $ct $+ ' para efetuar sua transação. | return }
      else {
        if (%pass == $4) { unset %wpass. [ $+ [ $nick ] ] }
        else {
          var %x = %wpass. [ $+ [ $nick ] ] | if ($gettok(%x,1,58) == %ID) { set %wpass. [ $+ [ $nick ] ] %ID $+ : $+ $calc($gettok(%x,2,58) + 1) | if ($gettok(%x,2,58) == 1) { msg =$nick $ct $+ Sua tentativa falhou novamente. Desista de comprar esta oferta de ID $cc $+ %ID $ct $+ ou será banido, se errar novamente. | return } | else { unset %wpass. [ $+ [ $nick ] ] | msg =$nick $ct $+ Você foi banido do bot $cc $+ temporariamente $+ $ct $+ . | nick.ban $nick 2 | return } }
          else { set %wpass. [ $+ [ $nick ] ] %ID $+ : $+ 1 | msg =$nick $ct $+ Você tentou comprar esta oferta com a senha ' $+ $cc $+ $upper($4) $+ $ct $+ ' e estava incorreta. É recomendável que, se ainda quiser comprá-la, não cometa mais erros. Se persistir, será banido automaticamente. | return }
        }
      }
    }
    if ($gettok($rini(market,%l,%ID,Name),14,58) == Master Ball) { msg =$nick $ct $+ Não é possível comprar pokémon que carregam consigo uma $cc $+ Master Ball $+ $ct $+ . | return }
    var %pk = $gettok($rini(market,%l,%ID,Name),1,58) | if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Não foi possível comprar a oferta pois você já tem o pokémon selecionado. | return }
    var %lv = $gettok($rini(market,%l,%ID,Line),3,59), %badges = $dados($nick,$dados($nick,Info,Region),Badges).n, %access = $rini(cadastros,$nick,Info,Access) | if (%access < 4) { var %mlv = $calc((%badges + 2) * 10 + (15 * (%access - 1))) | if (%lv > %ml) && ($gettok($rini(market,%l,%ID,Line),2,59) != $nick) { msg =$nick $ct $+ Você tem $cc $+ %badges $ct $+ $iif(%badges > 1,insígneas,insígnea) $+ . Você pode comprar pokémon de outros treinadores até o level $cc $+ %ml $+ $ct $+ . | return } }
    var %price = $rini(market,%l,%ID,Price), %m = $rini(cadastros,$nick,Info,Money) | if (%m < %price) { msg =$nick $ct $+ Você não tem dinheiro suficiente para comprar. | return }
    if ($rini(cadastros,$nick,$gettok($rini(market,%l,%ID,Line),1,59),Name)) { msg =$nick $ct $+ Você já tem um pokémon com o mesmo nome no time. | return }
    if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você precisa liberar espaço em seu time. | return }
    var %nick = $rini(cadastros,$nick,Info,Nick), %offer = $rini(market,%l,%ID,Nick) | tokenize 59 $rini(market,%l,%ID,Pokemon)
    if ($teampos(%nick,Egg)) { remteam %nick Egg | addteam %nick $1 | addteam %nick Egg } | else { addteam %nick $1 }
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Name $1
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 ID $2
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Level $3
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Nature $4
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Sex $5
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 GV $6
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Shiny $7
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Trait $8
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 ExpStat $9
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Exp $10
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Next $11
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Memory $12
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Loyalty $iif($2 == $nick,$13,70)
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Hold $14
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Ribbon $15
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVHp $16
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVAtk $17
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVDef $18
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSpd $19
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSAtk $20
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 IVSDef $21
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVHP $22
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVAtk $23
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVDef $24
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSpd $25
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSAtk $26
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 EVSDef $27
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 HP $28
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Atk $29
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Def $30
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 Spd $31
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 SAtk $32
    writeini pkp\cadastros\ $+ %nick $+ .ini $1 SDef $33
    if ($34) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Learn $34 }
    if ($35) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move1 $35 }
    if ($36) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move2 $36 }
    if ($37) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move3 $37 }
    if ($38) { writeini pkp\cadastros\ $+ %nick $+ .ini $1 Move4 $38 }
    if ($gettok($rini(market,%l,Store,ID),0,58) > 1) { var %pos = $findtok($rini(market,%l,Store,ID),%ID,1,58) | writeini pkp\market\ $+ %l $+ .ini Store ID $deltok($rini(market,%l,Store,ID),%pos,58) | writeini pkp\market\ $+ %l $+ .ini Store Nick $deltok($rini(market,%l,Store,Nick),%pos,58) | writeini pkp\market\ $+ %l $+ .ini Store Names $deltok($rini(market,%l,Store,Names),%pos,58) } | else { remini pkp\market\ $+ %l $+ .ini Store }
    remini pkp\market\ $+ %l $+ .ini %ID | writeini pkp\cadastros\ $+ $nick $+ .ini Info Money $calc(%m - %price) | writeini pkp\cadastros\ $+ %offer $+ .ini Info Money $calc($rini(cadastros,%offer,Info,Money) + %price) | writeini pkp\cadastros\ $+ %offer $+ .ini Info StoreMarket $calc($rini(cadastros,%offer,Info,StoreMarket) - 1)
    wlog user $nick Pokémon $1 was bought for $chr(36) $+ $getmoney(%price) from %offer $+ .
    wlog user %offer $dados($nick,Info,Nick) bought $1 for $chr(36) $+ $getmoney(%price) $+ .

    var %score = $int($calc(($pontos($nick,$1) / 3) * ($3 * 1000 / %price) * $gettok(2 1.5 1.2 1 1,$rini(cadastros,%offer,Info,Access),32) / $rini(cadastros,$nick,Info,Access))), %max.score = $market.max_score()

    var %m.buy = $dados($nick,Market,Buy), %m.buy = $iif(%m.buy,%m.buy,0), %m.sell = $dados(%offer,Market,Sell), %m.sell = $iif(%m.sell,%m.sell,0)
    if ($rini(cadastros,%offer,Info,Access)) {
      if (%offer == $2) && (!$ribbon($nick,$1,Market Medal)) {
        var %m.score = $dados(%offer,Market,Score), %m.score = $iif(%m.score,%m.score,0)
        if ($calc(%m.score + %score) > %max.score) { var %m.score = $calc(%max.score - %score) }
        elseif (%m.score == %max.score) { var %m.score = %m.score - %score }
        writeini pkp\cadastros\ $+ %offer $+ .ini Market Score $calc(%m.score + %score) | ribbon.add $nick $1 Market Medal
      }
      writeini pkp\cadastros\ $+ %offer $+ .ini Market Sell $calc(%m.sell + 1)
    }
    if ($rini(cadastros,$nick,Info,Access)) {
      if ($nick == $2) && ($ribbon($nick,$1,Market Medal)) {
        var %m.score = $dados($nick,Market,Score), %m.score = $iif(%m.score,%m.score,0)
        if (%m.score == %max.score) { var %score = 0 }
        var %m.score = $calc(%m.score - %score) | if (%m.score < 0) { var %m.score = 0 }
        writeini pkp\cadastros\ $+ $nick $+ .ini Market Score %m.score | ribbon.rem $nick $1 Market Medal
      }
      writeini pkp\cadastros\ $+ $nick $+ .ini Market Buy $calc(%m.buy + 1)
    }
    msg =$nick $ct $+ Pokémon $rtypename($1,$5,$3,$7) $ct $+ foi comprado por $cc $+ $chr(36) $+ $getmoney(%price) $ct $+ de $cc $+ %offer $+ $ct $+ .
    if (!$pokedex($nick,$1)) { echo $pokedex($nick,$1).add }
    if ($checknick(%offer) == Ok!) { msg = [ $+ [ %offer ] ] $ct $+ O pokémon $rtypename($1,$5,$3,$7) $ct $+ (ID: $+ $cc $+ %ID $+ $ct $+ ) foi comprado por $cc $+ %nick $+ $ct $+ . }
    return
  }
  elseif ($2 == list) {
    if ($3) {
      var %nick = $rini(cadastros,$3,Info,Nick) | if (!%nick) { var %nick = $3 }
      var %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $findtok($rini(market,%l,Store,Nick),%nick,0,58) | if (!%n) { msg =$nick Não há ofertas feitas por $cc $+ %nick $+ $ct $+ . | return }
      var %x = 0, %t = $gettok($rini(market,%l,Store,Nick),0,58), %r = 0 | msg =$nick $ct $+ Exibindo ofertas de $cc $+ %nick $+ $ct $+ :
      while (%x < %t) {
        inc %x | var %y = $gettok($rini(market,%l,Store,Nick),%x,58)
        if (%y == %nick) {
          inc %r | var %id = $gettok($rini(market,%l,Store,ID),%x,58)
          msg =$nick $chr(160) $ct $+ Oferta $chr(35) $+ $cc $+ %r $+ $ct $+ :
          msg =$nick $chr(160) $chr(160) $ct $+ Pokémon: $rtypename($gettok($rini(market,%l,%ID,Name),1,58),$gettok($rini(market,%l,%ID,Name),2,58),$gettok($rini(market,%l,%ID,Name),3,58),$gettok($rini(market,%l,%ID,Name),4,58))
          msg =$nick $chr(160) $chr(160) $ct $+ Preço: $cc $+ $chr(36) $+ $getmoney($rini(market,%l,%ID,Price))
          msg =$nick $chr(160) $chr(160) $ct $+ ID: $cc $+ %ID $iif($rini(market,%l,%ID,Password),$ct $+ * Senha)
          if (%r < %n) { msg =$nick $chr(160) }
        }
      }
      msg =$nick $ct $+ Fim da exibição de ofertas. | return
    }
    else {
      var %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $gettok($rini(market,%l,Store,Nick),0,58)
      if (!%n) { msg =$nick $ct $+ Não há nenhuma oferta no $cc $+ Market $+ $ct $+ . | return }
      msg =$nick $ct $+ Exibindo a lista de treinadores com ofertas: | var %x = 0 | while (%x < %n) {
        inc %x | var %y = $gettok($rini(market,%l,Store,Nick),%x,58)
        if (!$findtok(%r,%y,0,58)) { if (%r) { var %r = %r $+ : $+ %y } | else { var %r = %y } | msg =$nick $chr(160) $ct $+ $chr(35) $+ $cc $+ $gettok(%r,0,58) $ct $+ %y ( $+ $cc $+ $numero2($findtok($rini(market,%l,Store,Nick),%y,0,58)) $ct $+ $iif($findtok($rini(market,%l,Store,Nick),%y,0,58) > 1,ofertas,oferta) $+ ) }
      }
      msg =$nick $ct $+ Fim da exibição de treinadores. | return
    }
  }
  elseif ($2 == view) {
    var %l = $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_), %n = $gettok($rini(market,%l,Store,Nick),0,58), %id = $3
    if (!%n) { msg =$nick $ct $+ Não há ofertas no $cc $+ Market $ct $+ da cidade atual. | return }
    if (!$findtok($rini(market,%l,Store,ID),%ID,0,58)) { msg =$nick $ct $+ A ID selecionada não foi encontrada. Digite ' $+ $cc $+ .market list $+ $ct $+ ' para exibir todas as ofertas. | return }
    var %pos = $findtok($rini(market,%l,Store,ID),%ID,1,58)
    tokenize 59 $rini(market,%l,%ID,Pokemon)
    msg =$nick $ct $+ Exibindo oferta $chr(35) $+ $cc $+ %pos $ct $+ ( $+ $cc $+ %ID $+ $ct $+ ):
    msg =$nick $chr(160) $ct $+ Pokémon: $rtypename($1,$5,$3,$7)
    msg =$nick $chr(160) $ct $+ ID: $cc $+ $2
    msg =$nick $chr(160) $ct $+ Stats: HP $cc $+ $28 $ct $+ ATK $cc $+ $29 $ct $+ DEF $cc $+ $30 $ct $+ SPD $cc $+ $31 $ct $+ SATK $cc $+ $32 $ct $+ SDEF $cc $+ $33
    msg =$nick $chr(160) $ct $+ Trait: $cc $+ $8
    msg =$nick $chr(160) $ct $+ Nature: $cc $+ $4
    msg =$nick $chr(160) $ct $+ Item: $cc $+ $iif($14,$14,Nenhum)
    var %rib = $15 | msg =$nick $chr(160) $ct $+ Ribbons: $cc $+ $iif(%rib,$gettok(%rib,0,58),Nenhum)
    var %l = $gettok($13,1,58) | msg =$nick $chr(160) $ct $+ Loyalty: $iif(%l < 50,Não parece que ele gosta de você. Acho que está com raiva.,$iif(%l < 100,Você deveria tratá-lo melhor. Ele não gosta de você.,$iif(%l < 150,Ele é bem fofo.,$iif(%l < 200,Ele é seu amigo. Ele parece feliz.,$iif(%l < 250,Parece que ele realmente confia em você.,Ele está realmente feliz! Ele adora você.)))))
    if ($35) { msg =$nick $chr(160) $ct $+ Move $chr(35) $+ 1 $+ : $+ $cc $iif(!$35,-,$35) }
    if ($36) { msg =$nick $chr(160) $ct $+ Move $chr(35) $+ 2 $+ : $+ $cc $iif(!$36,-,$36) }
    if ($37) { msg =$nick $chr(160) $ct $+ Move $chr(35) $+ 3 $+ : $+ $cc $iif(!$37,-,$37) }
    if ($38) { msg =$nick $chr(160) $ct $+ Move $chr(35) $+ 4 $+ : $+ $cc $iif(!$38,-,$38) }
    msg =$nick $ct $+ Fim da exibição da oferta.
    return
  }
  elseif (!$2) || ($2 == help) {
    msg =$nick $ct $+ Este é o $cc $+ Mercado $ct $+ de $cc $+ $remove($rini(cadastros,$nick,Info,Locate), City, Town,$chr(32)) $+ $ct $+ . Seja bem-vindo, $cc $+ $nick $+ $ct $+ !
    msg =$nick $ct $+ O $cc $+ market $ct $+ serve para você fazer transações comerciais com outros treinadores, vendendo ou comprando pokémon. A seguir, a relação de comandos:
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .market add <pokémon> <preço> (<password>) $+ $ct $+ " para $cc $+ adicionar $ct $+ um pokémon ao $cc $+ market $+ $ct $+ . Será cobrada uma $cc $+ taxa $ct $+ de $cc $+ 10% $ct $+ do valor estabelecido para a venda. Se preferir, adicione um $cc $+ password $ct $+ à sua oferta;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .market buy <ID> (<password>) $+ $ct $+ " para $cc $+ comprar $ct $+ um pokémon do $cc $+ market $+ $ct $+ . Se precisar de $cc $+ senha $+ $ct $+ , digite a senha corretamente;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .market rem <ID> $+ $ct $+ " para $cc $+ remover $ct $+ sua oferta do $cc $+ market $+ $ct $+ ;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .market list (<nick>) $+ $ct $+ " para $cc $+ listar $ct $+ todas as ofertas do $cc $+ market $ct $+ de sua cidade ou ainda apenas as ofertas de um determinado treinador;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .market view <ID> $+ $ct $+ " para $cc $+ visualizar $ct $+ as informações da $cc $+ oferta $ct $+ escolhida;
    msg =$nick $ct $+ Se você é um jogador $cc $+ premium $+ $ct $+ , a $cc $+ taxa $ct $+ cobrada será de apenas 5% e você poderá criar até $cc $+ seis $ct $+ ofertas simultâneas, ao invés de $cc $+ três $ct $+ ofertas para os demais.
  }
  else { msg =$nick $ct $+ Digite ' $+ $cc $+ .Market $+ $ct $+ ' para mais informações. | return }
}

alias market.max_score {
  return $calc(2 * (10 ^ 6))
}
