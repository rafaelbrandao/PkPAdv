alias cmd.cidade {
  var %l = $dados($nick,Info,Locate), %region = $dados($nick,Info,Region)
  if ($2) {
    if ($2 == Lab) {
      var %pf = $gettok(Oak Birch Elm,$findtok(Pallet Town:Littleroot Town:New Bark Town,%l,1,58),32), %dex = $dados($nick,Info,Pokedex), %n = $int($calc(%dex / 100)), %left = $calc($iif(!$dados($nick,Quests,$+(%pf,$calc(%n + 1))),(%n + 1),(%n + 2)) * 100 - %dex)
      if ($calc(%dex + %left) > 386) { var %left = $calc(386 - %dex) }
      if (%l == Cinnabar Island) { msg =$nick $ct $+ Você entrou no laboratório. Você pode ver o cientista $cc $+ Phil $+ $ct $+ . | return }
      if (!$findtok(Pallet Town:Littleroot Town:New Bark Town,%l,0,58)) { msg =$nick $ct $+ Não há laboratórios em $cc $+ %l $+ $ct $+ ... }
      else {
        msg =$nick $ct $+ Bem vindo ao laboratório. $cc $+ Prof %pf $ct $+ aparece.
        if ($dados($nick,Quests,Kurt) == 3) && (!$item($nick,GS Ball).qnt) && (%pf == Oak) {
          item.add $nick GS Ball | msg =$nick $chr(160) $cc $+ Prof Oak $ct $+ - Felizmente pude encontrá-lo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Agora que você pode viajar para $cc $+ Johto $+ $ct $+ , gostaria de pedir um enorme favor: entregue este item ao especialista em pokébolas $cc $+ Kurt $+ $ct $+ . Creio que só ele poderá descobrir alguma coisa a respeito desta $cc $+ GS Ball $+ $ct $+ .
          msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ GS Ball $+ $ct $+ ! | return
        }
        if ($start($nick)) {
          if ($totalpokes($nick)) {
            if ($item($nick,PokeDex).qnt) {
              if ($rini(cadastros,$nick,Quests,%pf)) {
                if (%n) {
                  if (!$dados($nick,Quests,%pf $+ %n)) { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Seu currículo está impressionante mesmo! Olhe, acaba de obter cerca de $cc $+ $calc(%n * 100) $ct $+ espécies diferentes de pokémon! Infelizmente não tenho nada para oferecê-lo, mas conheço alguém que poderia ajudá-lo, e muito. Procure pela $cc $+ Silph Corporation $ct $+ em $cc $+ Kanto $+ $ct $+ , outro continente. Não sei se há barcos disponíveis para esta localidade neste momento... }
                  else { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Meu sonho é que um dia, você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , consiga capturar todos os pokémon do mundo... Bem, sonhar nunca é o bastante, não é mesmo? }
                }
                else { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Será que você realmente completará uma quantidade significante de pokémon em sua pokédex? Bem, estou torcendo por você! }
              }
              else {
                msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Ah! Você recebeu a PokeDex! Hahaha, preciso que me ajude a completá-la. Já estou velho, não posso procurá-los sozinho... Bem, isto o ajudará!
                item.add $nick Great Ball:6 | msg =$nick $ct $+ Você recebeu seis $cc $+ Great Ball $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pf Ok
              }
            }
            else {
              if (%pf == Birch) && (!$dados($nick,Quests,May1)) { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Por que você não procura minha sobrinha chamada $cc $+ May $ct $+ na cidade? Ela começou sua jornada há um dia e deve estar anciosa para uma batalha. Se não souber como procurar pessoas, procure em ' $+ $cc $+ .Cidade $+ $ct $+ ' mais informações. }
              else { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Como está seu pokémon? Não se esqueça de tratá-lo bem, hein! }
            }
          }
          else {
            if ($dados($nick,Info,Premium)) { var %choose = Bulbasaur:Chikorita:Treecko:Charmander:Cyndaquil:Torchic:Squirtle:Totodile:Mudkip) }
            if (!%choose) {
              if (%pf == Oak) { var %choose = Bulbasaur:Charmander:Squirtle }
              elseif (%pf == Elm) { var %choose = Chikorita:Cyndaquil:Totodile }
              else { var %choose = Treecko:Torchic:Mudkip }
            }
            msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , seja bem vindo ao laboratório. Se estiver começando sua jornada, então precisará de um pokémon inicial!
            msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Você poderá escolher entre estes $cc $+ $numero($gettok(%choose,0,58)) $ct $+ pokémon: $separecom(%choose,ou,58,$cc,$ct) $+ $ct $+ .
            if (%pf == Oak) {
              msg =$nick $chr(160) $cc $+ ??? $ct $+ - Espere um pouco! Eu cheguei primeiro, eu devo fazer minha escolha, não?!
              msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - Acalme-se, $cc $+ Gary $+ $ct $+ . E então, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ? Qual você vai escolher?
            }
            else { msg =$nick $chr(160) $cc $+ Prof %pf $ct $+ - E então, qual será a sua escolha? }
            msg =$nick $ct $+ Agora, digite o nome do pokémon que você deseja escolher para começar. | set %choose. [ $+ [ $nick ] ] %choose | return
          }
        }
        else {
          if (%pf == Oak) {
            msg =$nick $chr(160) $cc $+ Prof Oak $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Então você começou sua jornada em $dados($nick,Info,Start) $+ ? É uma região fabulosa, sem dúvida.
            msg =$nick $chr(160) $cc $+ Prof Oak $ct $+ - Você já está participando da liga pokémon de $cc $+ Kanto $+ $ct $+ ? Bem, aqui, em Pallet Town, é onde treinadores iniciam suas jornadas em direção à liga.
          }
          if (%pf == Elm) {
            if ($start($nick)) { if ($rini(cadastros,$nick,Quests,League)) { var %league = 1 } }
            else { if ($rini(cadastros,$nick,%region,League)) { var %league = 1 } }
            if (!%league) { msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Você já está participando da liga pokémon de $cc $+ Johto $+ $ct $+ ? Sabia que é esta liga é conhecida como o maior desafio para um treinador pokémon? É difícil mesmo, precisa-se de muita habilidade para vencer a $cc $+ Elite Four $+ $ct $+ ... }
            var %x = $calc($dados($nick,Kanto,Badges).n + $dados($nick,Hoenn,Badges).n + $dados($nick,Johto,Badges).n)
            if (%x >= 16) {
              if (!$dados($nick,Quests,UpdateDex)) {
                msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Olha, você já está pronto para atualizar sua $cc $+ PokeDex $+ $ct $+ . Isto não vai demorar nada... Pronto, aqui está. Agora você já pode obter informações de $cc $+ Egg Moves $ct $+ e $cc $+ Move Tutors $+ $ct $+ . Boa sorte!
                writeini pkp\cadastros\ $+ $nick $+ .ini Quests UpdateDex 1 | return
              }
              if (%x == 24) && (!$dados($nick,Quests,Togepi)) {
                msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Nossa! Você conseguiu adquirir todas as $cc $+ 24 $ct $+ insígneas! Estou muito impressionado. Como forma de motivá-lo, pode ficar com este $cc $+ Egg $+ $ct $+ .
                if ($teampos($nick,Egg)) { msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Que pena! Você já tem um $cc $+ Egg $+ $ct $+ ... }
                else {
                  if ($totalpokes($nick) == 6) { msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Que pena, não há espaço no time para recebê-lo... | return }
                  echo $addpoke($nick,Egg,Togepi,Presente de Prof Elm em New Bark Town,$rand(20,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(15,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31),0,0)
                  msg =$nick $ct $+ Parabéns! Você recebeu um $cc $+ Egg $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Togepi Ok
                }
              }
            }
            if (%league) {
              if ($dados($nick,Quests,MtSlvr)) { msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - $cc $+ Mt Silver $ct $+ é uma área protegida por autoridades, por isso poucos têm acesso a ela. Sei que você não fará mal algum aos pokémon, então não vejo problemas em deixá-lo ter acesso. Pelo contrário, você merece. }
              else {
                msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - Em primeiro lugar, parabéns pela sua entrada no hall da fama! $cc $+ $iif($dados($nick,Info,Start) == Hoenn,Prof Birch,Prof Oak) $ct $+ é um grande amigo e deve estar neste momento comemorando a sua vitória. Existe uma área, aqui em $cc $+ $dados($nick,Info,Region) $+ $ct $+ , onde nenhuma pessoa pode entrar sem autorização. Estou falando do famoso $cc $+ Mt Silver $+ $ct $+ , localizada na ilha prateada.
                msg =$nick $chr(160) $cc $+ Prof Elm $ct $+ - $cc $+ Mt Silver $ct $+ é habitat de muitas espécies de pokémon, algumas quase extintas. Por isso é local de preservação e hoje está protegida por autoridades. Dessa forma, é possível controlar quem tem acesso ao lugar e garantir a segurança dos pokémon. Reconheço o seu talento, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , e por isso o autorizo a visitá-lo!
                msg =$nick $ct $+ Parabéns, você pode visitar $cc $+ Mt Silver $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests MtSlvr Ok
              }
            }
          }
          if (%pf == Birch) { msg =$nick $chr(160) $cc $+ Prof Birch $ct $+ - Bem vindo a Littleroot. Sabe, eu gosto de pesquisar sobre pokémon vivendo em seu habitat. Será que você tem algum raro ai para eu examinar? }
        }
      }
      return
    }
    elseif ($2 == Pillar) {
      if (%l == Ruins Of Alph) {
        if ($dados($nick,Clock,Unown)) {
          var %x = $calc($dados($nick,Info,Online) - $dados($nick,Clock,Unown))
          if (%x < 432000) { msg =$nick $ct $+ Não há mais nada escrito no pilar neste momento... | return }
        }
        var %n = $readini(pkp\status.ini,Active,Unown), %w = ENIGMA *GIFT* **PAST WORDS* WISH** **HOPE *BUILD *QUERY SYMBOL CHAOS* DREAMS
        if (%n > 10) { var %n = 0 } | var %n = $calc(%n + 1), %w = $gettok(%w,%n,32), %x = 1
        while ($mid(%w,%x,1)) { var %u = $mid(%w,%x,1) | if (%r == $null) { var %r = $iif(%u == *,$chr(160),%u) } | else { var %r = %r $iif(%u == *,$chr(160),%u) } | inc %x }
        msg =$nick $ct $+ Você observa agora o pilar da caverna. Está escrito o seguinte: " $+ $cc $+ %r $+ $ct $+ "
        if ($unown.code($nick) == %w) { msg =$nick $ct $+ Terremoto... | premium add $nick 3 | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Unown $dados($nick,Info,Online) | writeini pkp\status.ini Active Unown %n }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Room) {
      if (%l == SS Anne) { msg =$nick $ct $+ Você entrou em uma sala. Você pode ver $cc $+ Sammy $ct $+ e $cc $+ Iris $+ $ct $+ . }
      elseif (%l == SS Tidal) { msg =$nick $ct $+ Você entrou na sala. Você pode ver $separecom(Sidney:Wallace:Phoebe,e,58,$cc,$ct) $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Ship) {
      if (%l == SS Anne) { msg =$nick $ct $+ Você pode ver no navio $cc $+ Evan $ct $+ e $cc $+ Norry $+ $ct $+ . }
      elseif (%l == SS Tidal) { msg =$nick $ct $+ Você pode ver no navio $separecom(Prof Birch:Roxanne:Tate&Liza:Norman:Lore,e,58,$cc,$ct) $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Control) {
      if (%l == SS Anne) { msg =$nick $ct $+ Você entrou na sala de controle. Você pode ver o capitão $cc $+ Jay $+ $ct $+ . }
      elseif (%l == SS Tidal) {
        var %p = Writney:Lance | if ($gettok($dados($nick,Quests,SSTidal),9,58)) && ($dados($nick,Info,Start) != Johto) { var %p = $addtok(%p,Steven,58) }
        msg =$nick $ct $+ Você entrou na sala de controle. Você pode ver o capitão $separecom(%p,e,58,$cc,$ct) $+ $ct $+ .
      }
      elseif (%l == Power Plant) {
        var %x = $readini(pkp\status.ini,%region,Legendary), %pk = Zapdos, %lv = 40
        if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
          if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
          if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
          if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ apareceu!
          .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
        }
        else {
          if ($dados($nick,Quests,PPlant)) { msg =$nick $ct $+ Todos os sistemas estão desligados. }
          else {
            if ($item($nick,Power Key).qnt) {
              msg =$nick $ct $+ Você usou sua $cc $+ Power Key $ct $+ e desligou o gerador...
              msg =$nick $ct $+ Temperatura do ambiente foi normalizada agora. | item.rem $nick Power Key | writeini pkp\cadastros\ $+ $nick $+ .ini Quests PPlant Ok
            }
            else { msg =$nick $ct $+ Para desligar o gerador, é necessário ter a $cc $+ Power Key $+ $ct $+ . }
          }
        }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Tin) {
      if (%l == Ecruteak City) { msg =$nick $ct $+ Bem vindo à $cc $+ Tin Tower $+ $ct $+ . Você pode ver $cc $+ Stan $+ $ct $+ . | if ($dados($nick,Quests,Rocket6) == 2) { msg =$nick $ct $+ Há também membros da equipe $cc $+ Rocket $ct $+ neste lugar. } }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Flower) {
      if (%l == Goldenrod City) { msg =$nick $ct $+ Bem vindo à $cc $+ floricultura $+ $ct $+ . Você pode ver $cc $+ Lisa $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Tower) {
      if (%l == Lavender Town) {
        if ($item($nick,Poké Flute).qnt) || (!$start($nick)) { msg =$nick $ct $+ Este lugar está repleto de lápides de pokémon que morreram... }
        else {
          msg =$nick $ct $+ Membros da equipe $cc $+ Rocket $ct $+ estão na $cc $+ Pokémon Tower $+ $ct $+ ! Deseja batalhar com eles?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar ou ' $+ $cc $+ .nao $+ $ct $+ ' para recusar. | set %confirm. [ $+ [ $nick ] ] FUJ
        }
      }
      elseif (%l == Ecruteak City) {
        msg =$nick $ct $+ Você entrou agora na $cc $+ Burned Tower $+ $ct $+ ...
        if ($badge($nick,Fog Badge)) && (!$start($nick)) && ($dados($nick,Johto,League)) && (!$dados($nick,Quests,BTower)) { msg =$nick $ct $+ Você pode ver alguém analisando os destroços: $cc $+ Morty $+ $ct $+ . }
        elseif ($start($nick)) && (!$dados($nick,Quests,BTower)) { msg =$nick $ct $+ Você pode ver alguém analisando os destroços: $cc $+ Morty $+ $ct $+ . }
        else { msg =$nick $ct $+ Tudo o que se pode ver são apenas ruínas... A impressão é que podem desabar a qualquer momento. }
      }
      elseif (%l == Violet City) {
        if ($start($nick)) && (!$item($nick,HM05).qnt) {
          msg =$nick $ct $+ Você entrou agora na $cc $+ Sprout Tower $+ $ct $+ . Olha! Tem membros da equipe $cc $+ Rocket $ct $+ ameaçando os monges! Deseja batalhar contra eles?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para começar ou ' $+ $cc $+ .nao $+ $ct $+ ' para desistir. | set %confirm. [ $+ [ $nick ] ] RKT:4
        }
        else { msg =$nick $ct $+ Você entrou agora na $cc $+ Sprout Tower $+ $ct $+ . Você pode ver $cc $+ Beck $+ $ct $+ . }
      }
      elseif (%l == Goldenrod City) {
        msg =$nick $ct $+ Você entrou na $cc $+ Radio Tower $+ $ct $+ . Você pode ver $cc $+ Irene $ct $+ e $cc $+ Grace $+ $ct $+ .
        if ($dados($nick,Quests,Rocket5) == No) { msg =$nick $ct $+ Há membros da equipe $cc $+ Rocket $ct $+ neste lugar... }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Farm) {
      if (%l == Olivine City) { msg =$nick $ct $+ Você entrou na fazenda. Você pode ver $cc $+ Nelson $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Light) {
      if (%l == Olivine City) {
        if (!$badge($nick,Mineral Badge)) && ($dados($nick,Quests,Jasmine) != Ok) { var %npc = Jasmine:Greg } | else { var %npc = Greg }
        msg =$nick $ct $+ Você entrou na $cc $+ Lighthouse $+ $ct $+ . Você pode ver $separecom(%npc,e,58,$cc,$ct) $+ $ct $+ .
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Lake) {
      if (%l == Marine Cave) {
        var %x = $readini(pkp\status.ini,%region,Legendary), %pk = Kyogre, %lv = 70
        if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
          msg =$nick $ct $+ É possível ver um enorme lago, e um enorme pokémon em seu interior dormindo...
          if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
          if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
          if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ acordou!
          .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
        }
        else { msg =$nick $ct $+ Não há mais nada nesse lago... }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Volcano) {
      if (%l == Terra Cave) {
        var %x = $readini(pkp\status.ini,%region,Legendary), %pk = Groudon, %lv = 70
        if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
          msg =$nick $ct $+ É possível ver uma enorme cratera, e um enorme pokémon em seu interior dormindo...
          if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
          if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
          if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ acordou!
          .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
        }
        else { msg =$nick $ct $+ Não há mais nada nessa cratera... }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Cave) {
      if ($dados($nick,Quests,Tomb)) {
        if (%l == Dewford City) { var %pk = Regice }
        elseif (%l == Fortree City) { var %pk = Registeel }
        elseif (%l == Desert Underpass) { var %pk = Regirock }
        else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. | return }
        var %x = $readini(pkp\status.ini,%region,Legendary), %lv = 40
        if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
          if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
          if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
          if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ apareceu!
          .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
        }
        else { msg =$nick $ct $+ Não há mais nada nessa caverna... }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Waterfall) {
      if (%l == Seafoam Island) {
        if ($team.hm($nick,Waterfall) == Ok!) {
          msg =$nick $ct $+ Você pode ver uma enorme cachoeira. Seu pokémon usou $cc $+ Waterfall $+ $ct $+ !
          var %x = $readini(pkp\status.ini,%region,Legendary), %pk = Articuno, %lv = 40
          if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
            if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
            if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
            if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ apareceu em meio a névoa!
            .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
            sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
            return
          }
          else { msg =$nick $ct $+ Você subiu a cachoeira e descobriu que não há nada lá, além de uma bela vista. }
        }
        else { msg =$nick $ct $+ Você pode ver uma enorme cachoeira. É muito alta... }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
    }
    elseif ($2 == Shop) { if ($shop(%l)) { msg =$nick $ct $+ Bem vindo à loja de $cc $+ %l $+ $ct $+ ! Para ver os artigos, digite ' $+ $cc $+ .Loja $+ $ct $+ '. } | else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return }
    elseif ($2 == Market) { if ($findtok($readini(pkp\status.ini,$dados($nick,Info,Region),Market),%l,0,58)) { msg =$nick $ct $+ Bem vindo ao market de $cc $+ %l $+ $ct $+ ! Para acessar o market, digite ' $+ $cc $+ .Market $+ $ct $+ '. } | else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return }
    elseif ($2 == Cycles) { if (%l == Mauville City) { msg =$nick $ct $+ Bem vindo a loja de bicicletas. Você pode ver $cc $+ Emma $+ $ct $+ , $cc $+ Maria $ct $+ e $cc $+ Rydel $+ $ct $+ . } | else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return }
    elseif ($2 == Daycare) {
      if (%l == Mauville City) { msg =$nick $ct $+ Bem vindo ao $cc $+ Daycare Center $+ $ct $+ . Você pode ver $cc $+ Ana $+ $ct $+ , $cc $+ Lola $ct $+ e $cc $+ Tob $+ $ct $+ . }
      elseif (%l == Goldenrod City) { msg =$nick $ct $+ Bem vindo ao $cc $+ Daycare Center $+ $ct $+ . Você pode ver $cc $+ Nicole $ct $+ e $cc $+ Mymo $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Haircut) {
      if (%l == Goldenrod City) { msg =$nick $ct $+ Bem vindo ao salão de beleza para pokémon. Você pode ver o cabelereiro $cc $+ Warren $ct $+ e $cc $+ Kaomi $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Institute) { if (%l == Fortree City) { msg =$nick $ct $+ Bem vindo ao $cc $+ Weather Institute $+ $ct $+ . Você pode ver $cc $+ Will $ct $+ e $cc $+ Sandra $+ $ct $+ . } | else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return }
    elseif ($2 == Top) {
      if (%l == Sky Pillar) {
        if ($rini(cadastros,$nick,Quests,Weather)) {
          if ($rini(cadastros,$nick,Quests,Sky2) == Ok) { msg =$nick $ct $+ Não há nada mais no topo do $cc $+ Sky Pillar $+ $ct $+ . }
          else { msg =$nick $ct $+ Pokémon $cc $+ Rayquaza $ct $+ acordou! $cc $+ Rayquaza $ct $+ saiu voando! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Sky2 Ok }
        }
        else {
          var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary)
          if ($findtok(%x,Rayquaza,0,58)) {
            if ($rini(cadastros,$nick,Quests,Rayquaza)) { msg =$nick $ct $+ Não há nada mais no topo do $cc $+ Sky Pillar $+ $ct $+ . }
            else {
              if ($rini(cadastros,$nick,Rayquaza,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Rayquaza $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
              if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Rayquaza $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
              if ($appeared(Rayquaza)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ Rayquaza $ct $+ neste momento! | return }
              writeini pkp\cadastros\ $+ $nick $+ .ini Quests Rayquaza Ok | msg =$nick $ct $+ Pokémon $cc $+ Rayquaza $ct $+ apareceu!
              .echo $addpoke($nick,Rayquaza,70,70: $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | b.join $checknickid($nick).id Wild | sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Rayquaza)
              sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .PPUp ] ] ON | b.start.fight $checknickid($nick).ID
              return
            }
          }
          else { msg =$nick $ct $+ Não há nada mais no topo do $cc $+ Sky Pillar $+ $ct $+ . }
        }
      }
      elseif (%l == Mt Ember) {
        var %x = $readini(pkp\status.ini,%region,Legendary), %pk = Moltres, %lv = 40
        if ($findtok(%x,%pk,0,58)) && (!$dados($nick,Quests,%pk)) {
          if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
          if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
          if ($appeared(%pk)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ %pk $ct $+ neste momento! | return }
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ apareceu em meio às chamas!
          .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
          sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
        }
        else { msg =$nick $ct $+ Não há mais nada no topo do $cc $+ Mt Ember $+ $ct $+ . }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Tent) {
      var %x = $readini(pkp\status.ini,Tent,$replace(%l,$chr(32),_))
      if (%x) {
        msg =$nick $ct $+ Bem vindo a $cc $+ Battle Tent $ct $+ de $cc $+ %l $+ $ct $+ .
        var %rules = $gettok(%x,1,59), %modes = $gettok(%x,2,59)
        msg =$nick $ct $+ Aqui você poderá criar uma batalha pokémon personalizada, ideal para competições realizadas entre jogadores. As regras serão listadas a seguir:
        if ($gettok(%rules,1,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Apenas $cc $+ $numero($gettok(%rules,1,58)) $ct $+ pokémon válidos em seu time; }
        if ($gettok(%rules,2,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Seus leveis devem estar no mínimo em $cc $+ $gettok(%rules,2,58) $+ $ct $+ ; }
        if ($gettok(%rules,3,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) $cc $+ Monotype $ct $+ fará com que os jogadores utilizem pokémon de tipos iguais; }
        if ($gettok(%rules,4,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Apenas pokémon do tipo $cc $+ $gettok(%rules,4,58) $ct $+ são permitidos; }
        if ($gettok(%rules,5,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Pokémon do tipo $cc $+ $gettok(%rules,5,58) $ct $+ não serão permitidos; }
        if ($gettok(%rules,6,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Esta batalha terá no máximo $cc $+ $gettok(%rules,6,58) $ct $+ turnos; }
        if ($gettok(%rules,7,58)) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) Esta batalha durará no máximo $cc $+ $duration($gettok(%rules,7,58)) $+ $ct $+ ; }
        if (p isin %modes) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) $cc $+ PP Normal $ct $+ aplicado nos $cc $+ movesets $ct $+ dos treinadores durante a batalha; }
        if (u isin %modes) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) $cc $+ PP Up $ct $+ aplicado nos $cc $+ movesets $ct $+ dos treinadores durante a batalha; }
        if (s isin %modes) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) $cc $+ Switch $ct $+ habilitado, trocando pokémon com o ' $+ $cc $+ .Trocar $+ $ct $+ '; }
        if (d isin %modes) { msg =$nick $chr(160) $ct $+ ( $+ $cc $+ × $+ $ct $+ ) $cc $+ Double Battle $ct $+ será aplicado, onde cada treinador usará $cc $+ dois $ct $+ pokémon ao mesmo tempo; }
        msg =$nick $ct $+ Deseja criar uma batalha? Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar e ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] TNT: $+ %l | return
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == League) {
      if ($findtok(Evergrande City:Indigo Plateau:Silverst City,%l,0,58)) {
        if ($start($nick)) && (%region == Hoenn) {
          if (!$rini(cadastros,$nick,Quests,Wally)) {
            msg =$nick $chr(160) $cc $+ ??? $ct $+ - Espere um minuto!!! | msg =$nick $ct $+ Treinador $cc $+ Wally $ct $+ aparece. | msg =$nick $chr(160) $cc $+ Wally $ct $+ - Hahaha, $nick $+ ! Achou que fosse quem?! Ei, não precisa ficar nervoso com a liga! Bem, que tal uma batalha? Eu preciso mostrar tudo o que aprendi desde minha saída em Petalburg! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Wally Ok | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Wally $rini(cadastros,$nick,Info,Online)
            battle.npc $nick Wally | sset [ [ B. ] $+ [ $checknickid($nick).id ] $+ [ .Quest ] ] WALLY | return
          }
        }
        msg =$nick $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , seja bem-vindo a liga pokémon de $cc $+ $dados($nick,Info,Region) $+ $ct $+ !
        msg =$nick $ct $+ Você encontra-se com $cc $+ Juiz $+ $ct $+ . Ele veste o uniforme oficial.
        if ($rini(cadastros,$nick,Info,Money) < 30000) { msg =$nick $ct $+ Você não tem $cc $+ dinheiro $ct $+ suficiente para desafiar a liga! | return }
        if (%region == Hoenn) {
          if (!$rini(cadastros,$nick,Quests,Badges)) {
            msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Se deseja prosseguir, preciso verificar antes se você possui todas as oito insígneas.
            if ($dados($nick,$dados($nick,Info,Region),Badges).n == 8) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Parabéns, $nick $+ ! Você já poderá enfrentar a liga pokémon! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Badges Ok }
            else { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Um momento! Você não poderá desafiar a liga ainda. Para isso é necessário que você obtenha as insígneas de Hoenn. | return }
          }
        }
        elseif (%region == Kanto) {
          if (!$item($nick,HM07).qnt) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Não é possível desafiar a liga neste momento. Um dos membros não está presente. | return }
          ; if ($dados($nick,Quests,Lance) == No)  { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Não é possível desafiar a liga neste momento. Um dos membros não está presente. | return }
        }
        else {
          var %x = $calc($dados($nick,Info,Online) - $dados($nick,Clock,League)), %delay = $readini(pkp\status.ini,Active,LeagueDelay) | if (%x < %delay) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Você não pode desafiar a liga ainda. Aguarde $dur($calc(%delay - %x),$ct,$cc) para tentar novamente. | return }
          var %control = $readini(pkp\status.ini,Active,Control) | if ($checknick(%control) != Ok!) || (%confirm. [ $+ [ %control ] ]) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Não é possível desafiar a liga neste momento, porque um dos membros não está presente. Tente outra hora. | return }
          if (%active.league) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Não é possível desafiar a liga neste momento, porque já existe um desafiante nela. Aguarde. | return }
          set %active.league $dados($nick,Info,Nick)
        }
        msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Para conquistar o título de campeão da liga pokémon, você terá que derrotar todos os seguintes treinadores:
        var %x = 0
        while (%x < 5) {
          inc %x
          var %n = $readini(pkp\status.ini,%region,$iif($start($nick),League,League2)), %n = $gettok(%n,%x,58)
          if (%n == Gary) && ($start($nick)) { var %n = Gary $+ $dados($nick,Quests,Gary) }
          if (%n isnum) { var %t = %n } | else { var %t = $rini(npc,npc,ID,%n) }
          var %n = $rini(npc,$int($calc(%t / 100)) $+ 00,%t,Name), %team = $rini(npc,$int($calc(%t / 100)) $+ 00,%t,Team)
          if (!%team) { var %team = 6 }
          if (%x == 5) { msg =$nick $ct $+ Campeão $cc $+ $iif($rini(cadastros,$nick,Quests,League),%n,???) $ct $+ ( $+ $cc $+ $numero(%team) $ct $+ pokémon) }
          else { msg =$nick $ct $+ Elite Four $cc $+ %n $ct $+ ( $+ $cc $+ $numero(%team) $ct $+ pokémon) }
        }
        msg =$nick $ct $+ Aceitar desafio? Digite $cc $+ .sim $ct $+ para iniciar. Caso contrário digite $cc $+ .nao $+ $ct $+ . Será descontado $cc $+ $chr(36) $+ 30,000 $ct $+ ao aceitar o desafio.
        set %confirm. [ $+ [ $nick ] ] LEA | return
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. | return }
    }
    elseif ($2 == Gym) {
      var %mode = $iif($start($nick),Normal,Advanced), %l = $rini(cadastros,$nick,Info,Locate), %gym = $readini(pkp\gym.ini,%mode,$replace(%l,$chr(32),_)))
      if (%gym) {
        if ($start($nick)) {
          if (%l == Sootopolis City) {
            if (!$item($nick,HM07).qnt) {
              if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $ct $+ Existe um aviso na porta do ginásio: ' $+ $cc $+ Fechado temporariamente até o clima melhorar. $+ $ct $+ ' | return }
              elseif (!$rini(cadastros,$nick,Quests,Steven3)) { msg =$nick $ct $+ Existe um aviso na porta do ginásio: ' $+ $cc $+ Fechado temporariamente para reformas. $+ $ct $+ ' | return }
              else { msg =$nick $cc $+ Wallace $ct $+ está em frente ao ginásio. | return }
            }
          }
          if (%l == Saffron City) { if (!$dados($nick,Quests,Rocket3)) { msg =$nick $ct $+ Não é possível entrar no ginásio. Há membros da equipe $cc $+ Rocket $ct $+ em todo lugar! | return } }
          if (%l == Viridian City) { if (!$dados($nick,Quests,Rocket3)) { msg =$nick $ct $+ Não foi possível entrar no ginásio. A porta está trancada! | return } }
        }
        if (%l == Vermilion City) { if ($team.hm($nick,Cut) == No!) { msg =$nick $ct $+ Não dá pra entrar no ginásio. Há um arbusto no caminho. | if ($item($nick,HM01).qnt) { msg =$nick $ct $+ É melhor tentar usar a técnica $cc $+ Cut $+ $ct $+ ... } | return } }
        if (%l == Mahogany Town) { if ($dados($nick,Quests,Rocket5) != Ok) { msg =$nick $ct $+ Há um sujeito muito estranho em frente ao ginásio... | return } }
        msg =$nick $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , seja bem-vindo ao ginásio de $cc $+ %l $+ $ct $+ !
        msg =$nick $ct $+ Você encontra-se com $cc $+ Juiz $+ $ct $+ . Ele veste o uniforme oficial de juiz da liga pokémon de Hoenn.
        if (%l == Olivine City) { if ($dados($nick,Quests,Jasmine) != Ok) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Sinto muito, mas no momento a líder não está no ginásio. Que tal tentar outra hora? | return } }
        var %b = $gettok(%gym,1,172), %badges = $dados($nick,%region,Badges).n, %badges = $iif(!%badges,0,%badges), %badge = $gettok(%gym,2,172), %leader = $gettok($gettok(%gym,4,172),0,58), %leader = $gettok($gettok(%gym,4,172),%leader,58) | if (%leader !isnum) { %leader = $rini(npc,npc,ID,%leader) } | var %leader = $rini(npc,$int($calc(%leader / 100)) $+ 00,%leader,Name)
        if (%b) && (%badges < $calc(%b - 1)) {
          msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Olá! Infelizmente você não poderá lutar contra $cc $+ %leader $ct $+ agora. Ele aceita apenas desafiantes mais experientes. | if (!$gettok($rini(cadastros,$nick,Info,Badges),0,58)) && (%region == Hoenn) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Talvez você deva começar em $cc $+ Rustboro City $+ $ct $+ , com $cc $+ Roxanne $+ $ct $+ . Boa sorte! }
          return
        }
        if ($findtok($dados($nick,%region,Badges),%badge,0,58)) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Olá $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Parabens pela sua vitória contra $cc $+ %leader $+ $ct $+ . Boa sorte! | return }
        if ($rini(cadastros,$nick,Info,Money) < 15000) { msg =$nick $ct $+ Você não tem $cc $+ dinheiro $ct $+ suficiente para desafiar um ginásio! | return }
        if (!$dados($nick,%region,Badges)) && ($start($nick)) { msg =$nick $chr(160) $cc $+ Juiz $ct $+ - Nas lutas de ginásio, você precisará derrotar todos os treinadores e seu líder para adquirir sua insígnea. Não é tão fácil quanto parece! }
        msg =$nick $chr(160) $cc $+ Juiz $ct $+ - A seguir, serão listados os treinadores que você terá que vencer neste ginásio:
        var %o = $gettok(%gym,4,172), %x = 0, %t = $gettok(%o,0,58)
        while (%x < %t) {
          inc %x | var %n = $gettok(%o,%x,58) | if (%n isnum) { var %ID = %n } | else { var %ID = $rini(npc,npc,ID,%n) } | var %name = $rini(npc,$int($calc(%ID / 100)) $+ 00,%ID,Name)
          if (%x == %t) { msg =$nick $ct $+ Leader $cc $+ %name $ct $+ ( $+ $cc $+ $numero($rini(npc,$int($calc(%ID / 100)) $+ 00,%ID,Team)) $ct $+ pokémon) }
          else {
            if ($gettok(%name,0,95) > 1) { var %prefix = $gettok(%name,1,95) } | if (!%prefix) { var %prefix = Trainer }
            msg =$nick $ct $+ %prefix $cc $+ $remove(%name,%prefix $+ _) $ct $+ ( $+ $cc $+ $numero($rini(npc,$int($calc(%ID / 100)) $+ 00,%ID,Team)) $ct $+ pokémon) | var %prefix = 0
          }
        }
        msg =$nick $ct $+ Aceitar desafio? Digite $cc $+ .sim $ct $+ para iniciar a batalha de ginásio. Caso contrário digite $cc $+ .nao $+ $ct $+ . Será descontado $cc $+ $chr(36) $+ 15,000 $ct $+ ao aceitar o desafio.
        set %confirm. [ $+ [ $nick ] ] GYM: $+ $replace($rini(cadastros,$nick,Info,Locate),$chr(32),_) | return
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Museu) {
      if (%l == Slateport City) { msg =$nick $ct $+ Você chegou ao Museu Oceânico. Você pode ver $cc $+ Stern $ct $+ e $cc $+ Ricky $+ $ct $+ . }
      elseif (%l == Pewter City) { msg =$nick $ct $+ Você chegou ao Museu da Ciência. Você pode ver $cc $+ Clara $ct $+ e $cc $+ Ben $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Port) {
      if (%l == Slateport City) { if ($start($nick)) && (!$dados($nick,Quests,League)) { msg =$nick $ct $+ Você chegou ao porto. Você pode ver $cc $+ Writney $ct $+ e $cc $+ Aline $+ $ct $+ . } | else { msg =$nick $ct $+ Você chegou ao porto. Você pode ver $cc $+ Aline $+ $ct $+ . } }
      elseif (%l == Lilycove City) { msg =$nick $ct $+ Você chegou ao porto. Você pode ver $cc $+ Serena $+ $ct $+ . }
      elseif (%l == Vermilion City) { msg =$nick $ct $+ Você chegou ao porto. Você pode ver $cc $+ Cory $+ $ct $+ . }
      elseif (%l == Olivine City) { msg =$nick $ct $+ Você chegou ao porto. Você pode ver $cc $+ Luna $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Devon) {
      if (%l == Rustboro City) { msg =$nick $ct $+ Você chegou a Devon Corporation. Você pode ver $cc $+ Stone $+ $ct $+ , $cc $+ Walter $ct $+ e $cc $+ Shelby $+ $ct $+ . }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Home) {
      if (%l == Mossdeep City) { 
        if ($rini(cadastros,$nick,Quests,Steven3)) { msg =$nick $ct $+ Você entrou na casa, mas não tem ninguém nela. }
        else {
          if ($start($nick)) {
            if ($rini(cadastros,$nick,Quests,Magma3)) { msg =$nick $ct $+ Você entrou na casa. Você pode ver $cc $+ Steven $+ $ct $+ . }
            else { msg =$nick $ct $+ Você entrou na casa, mas não tem ninguém nela. }
          }
          else { msg =$nick $ct $+ Você entrou na casa. Você pode ver $cc $+ Steven $+ $ct $+ . }
        }
        if ($start($nick)) && ($dados($nick,Quests,Gift) == No) { msg =$nick $ct $+ Parece-me que há um $cc $+ presente $ct $+ aqui... }
      }
      elseif (%l == Pacifidlog Town) { if ($start($nick)) { msg =$nick $ct $+ Você entrou na casa. Você pode ver $cc $+ Nicolas $ct $+ e $cc $+ Tucker $+ $ct $+ . } | else { msg =$nick $ct $+ Você entrou na casa. Você pode ver o velho $cc $+ Tucker $+ $ct $+ . } }
      elseif (%l == Lavender Town) {
        if ($start($nick)) {
          if ($item($nick,Poké Flute).qnt) { msg =$nick $ct $+ Você entrou na casa. Você pode ver o senhor $cc $+ Fuji $+ $ct $+ . }
          else { msg =$nick $ct $+ Você entrou na casa, mas não há ninguém nela... }
        }
        else { msg =$nick $ct $+ Você entrou na casa. Você pode ver o senhor $cc $+ Fuji $+ $ct $+ . }
      }
      elseif (%l == Celadon City) { msg =$nick $ct $+ Você entrou na casa. Você pode ver $cc $+ Andrea $ct $+ e $cc $+ Lucas $+ $ct $+ . }
      elseif (%l == Ecruteak City) { msg =$nick $ct $+ Você entrou na casa. Você pode ver $cc $+ Nancy $+ $ct $+ . }
      elseif (%l == Azalea Town) { msg =$nick $ct $+ Você entrou na casa. Você pode ver $iif($item($nick,HM01).qnt,$cc $+ Jonathan $ct $+ e $cc $+ Alex $+ $ct $+ .,$cc $+ Jonathan $+ $ct $+ .) }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Corner) {
      if (%l == Celadon City) {
        msg =$nick $ct $+ Você entrou no $cc $+ Game Corner $+ $ct $+ . Você pode ver $cc $+ Kay $+ $ct $+ , a balconista, $cc $+ Janice $ct $+ e $cc $+ Chad $+ $ct $+ .
        msg =$nick $ct $+ Se quiser jogar em alguma máquina, digite ' $+ $cc $+ .Corner $+ $ct $+ '. É necessário ter um $cc $+ Coin Case $+ $ct $+ .
      }
      elseif (%l == Goldenrod City) {
        msg =$nick $ct $+ Você entrou no $cc $+ Game Corner $+ $ct $+ . Você pode ver $cc $+ Kenny $+ $ct $+ , o balconista, $cc $+ Hector $ct $+ e $cc $+ Foster $+ $ct $+ .
        msg =$nick $ct $+ Se quiser jogar em alguma máquina, digite ' $+ $cc $+ .Corner $+ $ct $+ '. É necessário ter um $cc $+ Coin Case $+ $ct $+ .
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Space) {
      if ($rini(cadastros,$nick,Info,Locate) == Mossdeep City) {
        if ($rini(cadastros,$nick,Quests,Magma3)) || (!$start($nick)) { msg =$nick $ct $+ Bem vindo ao $cc $+ Space Center $+ $ct $+ . Você pode ver $cc $+ Wilton $ct $+ e $cc $+ Dalton $+ $ct $+ . }
        else {
          var %b = $rini(cadastros,$nick,Info,Badges)
          if ($findtok(%b,Mind Badge,0,58)) { msg =$nick $ct $+ Bem vindo ao $cc $+ Space Center $+ $ct $+ . Você pode ver $cc $+ Steven $+ $ct $+ , $cc $+ Wilton $+ $ct $+ , $cc $+ Dalton $ct $+ e alguns membros da Equipe $cc $+ Magma $+ $ct $+ . }
          else { msg =$nick $ct $+ Bem vindo ao $cc $+ Space Center $+ $ct $+ . Você pode ver $cc $+ Steven $+ $ct $+ , $cc $+ Wilton $ct $+ e $cc $+ Dalton $+ $ct $+ . }
        }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. } | return
    }
    elseif ($2 == Safari) {
      if (!$findtok(Lilycove City:Fuchsia City,%l,0,58)) { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. | return }
      if (%stand. [ $+ [ $nick ] ]) { unset %stand. [ $+ [ $nick ] ] }
      var %x = $dados($nick,Time,Safari)
      if (%x) { var %r = $calc($ctime($date $time) - $ctime(%x)) | if (%r >= 14400) { goto safari } | else { msg =$nick $ct $+ Você só pode entrar na $cc $+ Safari Zone $ct $+ apenas $cc $+ uma $ct $+ vez a cada quatro horas. Ainda faltam $dur($calc(14400 - %r),$ct,$cc) para você tentar novamente. | return } }
      else {
        :safari
        if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $ct $+ Existe um aviso na entrada da $cc $+ Safari Zone $+ $ct $+ : ' $+ $cc $+ Fechado até melhorar o tempo. $+ $ct $+ ' | return }
        if (!$3) || (!$basestat($3,etype)) { msg =$nick $ct $+ Para entrar na $cc $+ Safari Zone $+ $ct $+ , é preciso especificar o nome do seu pokémon $cc $+ corretamente $+ $ct $+ . Digite' $+ $cc $+ .cidade safari <seu pokémon> $+ $ct $+ '. | return }
        if (!$checkteam($nick,$3)) { msg =$nick $ct $+ Para entrar na $cc $+ Safari Zone $+ $ct $+ , é preciso especificar o nome do seu pokémon $cc $+ válido $+ $ct $+ . Digite' $+ $cc $+ .cidade safari <seu pokémon> $+ $ct $+ '. | return }
        if ($totalpokes($nick) > 3) { msg =$nick $ct $+ Para entrar na $cc $+ Safari Zone $+ $ct $+ , não é possível ter mais de $cc $+ três $ct $+ pokémon no time. | return }
        if ($3 == Egg) { msg =$nick $ct $+ Para entrar na $cc $+ Safari Zone $+ $ct $+ , é preciso especificar o nome do seu pokémon $cc $+ válido $+ $ct $+ . $cc $+ Egg $ct $+ não é permitido. | return }
        var %m = $rini(cadastros,$nick,Info,Money) | if (%m < 5000) { msg =$nick $ct $+ Para entrar na $cc $+ Safari Zone $+ $ct $+ , é preciso comprar o ingresso por $cc $+ $chr(35) $+ $getmoney(5000) $+ $ct $+ . | return } | writeini pkp\cadastros\ $+ $nick $+ .ini Info Money $calc(%m - 5000)
        battle.wild $nick $dados($nick,$3,Name) qz
        return
      }
    }
    elseif ($2 == Wild) {
      var %x = $gettok($dados($nick,Time,Wild),1,59), %y = $gettok($dados($nick,Time,Wild),2,59), %y = $iif(%y,%y,0), %pr = $dados($nick,Info,Premium)
      if (%x) { if (%y < $iif(%pr,6,3)) { goto wild } | var %r = $calc($ctime($date $time) - $ctime(%x)) | if (%r >= 86400) { goto wild } | else {
          var %x = $rini(cadastros,$nick,Clock,Wild), %o = $rini(cadastros,$nick,Info,Online) | if ($calc(%o - %x) >= $iif(%pr,1800,3600)) { var %clock = 1 | goto wild }
          msg =$nick $ct $+ Você só pode entrar em área de pokémon selvagem até $cc $+ $numero($iif(%pr,6,3)) $ct $+ vezes por dia. Ainda faltam $dur($calc(86400 - %r),$ct,$cc) para você tentar novamente.
          if ($calc(%o - %x)) { msg =$nick $ct $+ Para uma batalha $cc $+ extra $+ $ct $+ , é necessário manter-se $cc $+ online $ct $+ por aproximadamente $dur($calc($iif(%pr,1800,3600) - $calc(%o - %x)),$ct,$cc) $+ . }
          return
        }
      }
      else {
        :wild
        if (!$3) || (!$basestat($3,etype)) { msg =$nick $ct $+ Você utilizou este comando de forma incorreta. Especifique o nome do seu pokémon usando esta sintaxe: ' $+ $cc $+ .Cidade Wild <seu pokémon> $+ $ct $+ '. | return }
        battle.wild $nick $3
        return
      }
    }
    elseif ($2 == Goto) {
      if ($3) {
        var %x = $dados($nick,Time,Goto)
        if (%x) {
          var %r = $calc($ctime($date $time) - $ctime(%x))
          if ($item($nick,Running Shoes).qnt) { if (%r >= 600) { goto city } | else { msg =$nick $ct $+ Você só pode mudar de cidade uma vez a cada $cc $+ 10 $ct $+ minutos. Ainda faltam $dur($calc(600 - %r),$ct,$cc) para você tentar novamente. | return } }
          else { if (%r >= 1200) { goto city } | else { msg =$nick $ct $+ Você só pode mudar de cidade uma vez a cada $cc $+ 20 $ct $+ minutos. Ainda faltam $dur($calc(1200 - %r),$ct,$cc) para você tentar novamente. | return } }
        }
        else {
          :city
          var %d = $org($3-), %l = $rini(cadastros,$nick,Info,Locate)
          var %did = $gotoplace($nick,%l,%d)
          if (%did == ok!) {
            if (!$findtok($dados($nick,$dados($nick,Info,Region),Visited),%d,0,58)) {
              if ($start($nick)) {
                if (%d == Oldale Town) { if ($gpoints($nick) <= 1500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return } | if (!$rini(cadastros,$nick,Quests,May1)) { msg =$nick $ct $+ Talvez eu deva procurar pela sobrinha do $cc $+ Prof Birch $+ $ct $+ , $cc $+ May $+ $ct $+ , pela cidade antes de prosseguir. | return } }
                if (%d == Petalburg City) && ($gpoints($nick) <= 7500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Rustboro City) && ($gpoints($nick) <= 25000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Mauville City) && ($gpoints($nick) <= 190000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Lavaridge Town) && ($gpoints($nick) <= 350000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Fortree City) && ($gpoints($nick) <= 800000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Lilycove City) && (!$rini(cadastros,$nick,Quests,Steven2)) { msg =$nick $ct $+ Você não pôde ir a $cc $+ %d $+ $ct $+ , parece que há algo invisível bloqueando seu caminho! | return }
                if (%d == Silver Bay) && ($rini(cadastros,$nick,Quests,Aqua4) != Ok) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ . Devo procurar as equipe $cc $+ Aqua $ct $+ e $cc $+ Magma $ct $+ antes de prosseguir. | return }
                if (%d == Sky Pillar) { if (!$rini(cadastros,$nick,Quests,Wallace)) { msg =$nick $ct $+ Você não conseguiu entrar no $cc $+ Sky Pillar $+ $ct $+ . A entrada está fechada. | return } }
                if (%d == Viridian City) && ($gpoints($nick) <= 1500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Pewter City) && ($gpoints($nick) <= 7500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Cerulean City) && ($gpoints($nick) <= 25000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Rock Tunnel) && ($gpoints($nick) <= 95000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Celadon City) && ($gpoints($nick) <= 190000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Fuchsia City) && ($gpoints($nick) <= 350000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Cinnabar Island) && ($gpoints($nick) <= 750000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Cherrygrove City) && ($gpoints($nick) <= 1500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Violet City) && ($gpoints($nick) <= 7500) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Azalea Town) && ($gpoints($nick) <= 25000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Olivine City) && ($gpoints($nick) <= 80000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Cianwood City) && ($gpoints($nick) <= 125000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Ice Path) && ($gpoints($nick) <= 350000) { msg =$nick $ct $+ Você ainda não pode ir a $cc $+ %d $+ $ct $+ , pois ainda não possui a quantidade de pontos necessária. | return }
                if (%d == Saffron City) {
                  msg =$nick $ct $+ Você encontra-se com um guarda.
                  if ($dados($nick,Quests,Rocket2)) { msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Então você é membro da Equipe Rocket... Hehehe... O que achou do meu disfarce? Vá, pode passar. Nosso chefe está esperando. }
                  else { msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Err, não pode passar... Não faça perguntas, apenas saia. | return }
                }
                if (%d == Mt Moon) {
                  if ($badge($nick,Boulder Badge)) {
                    if (!$item($nick,PokeDex).qnt) {
                      msg =$nick $chr(160) $cc $+ ??? $ct $+ - Um momento! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , eu sou o assistente do $cc $+ Prof Oak $+ $ct $+ . O mesmo me pediu para entregar-lhe uma invenção que vai revolucionar o mundo: a $cc $+ Pokedex $+ $ct $+ .
                      item.add $nick PokeDex | msg =$nick $ct $+ Parabéns, você ganhou a $cc $+ Pokedex $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - Para utilizá-la, digite, sem as aspas, " $+ $cc $+ .PokeDex <pokémon> $+ $ct $+ ", substituindo <pokémon> pelo nome do pokémon que você já capturou. As informações sobre o mesmo serão exibidas. Brilhante não? Bem, entrega feita. Cuide-se!
                    }
                    writeini pkp\cadastros\ $+ $nick $+ .ini Quests Rocket1 No
                  }
                  else { msg =$nick $ct $+ Você encontra-se com um treinador. | msg =$nick $chr(160) $cc $+ Josh $ct $+ - Ei, treinador! Conhece o ginásio pokémon? Para desafiar um líder de ginásio e tentar ganhar sua insígnea, digite " $+ $cc $+ .cidade gym $+ $ct $+ ", sem as aspas! Lembre-se que você terá que derrotar vários treinadores até conquistar sua insígnea. Trabalhe duro e você verá que $cc $+ Brock $ct $+ não é tão sólido quanto você pensa. | return }
                }
                if (%d == Cerulean City) { if ($dados($nick,Quests,Rocket1) == No) { msg =$nick $ct $+ O que é isto? Membros da equipe $cc $+ Rocket $ct $+ estão impedindo a passagem! E agora? | return } }
                if (%d == Coral Bridge) && (!$dados($nick,Quests,Snorlax)) {
                  if ($item($nick,Poké Flute)) {
                    msg =$nick $ct $+ Você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , começou a tocar a $cc $+ Poké Flute $+ $ct $+ !
                    msg =$nick $ct $+ O pokémon acordou! É um $cc $+ Snorlax $+ $ct $+ !
                    var %x = $rand(1,100), %y = $rand(10,32) | if (%x <= %y) && (!$dados($nick,Snorlax,Name)) {
                      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Snorlax Ok
                      .echo $addpoke($nick,Snorlax,40,40: $+ %d).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).ID | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Snorlax)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
                      return
                    }
                    else { msg =$nick $ct $+ Argh! $cc $+ Snorlax $ct $+ fugiu... }
                  }
                  else { msg =$nick $ct $+ Existe um pokémon dormindo exatamente na passagem... | return }
                }
              }
              if ($findtok(Violet City:Goldenrod City:Ecruteak City,%l,0,58)) && ($findtok(Violet City:Goldenrod City:Ecruteak City,%d,0,58)) {
                if (!$dados($nick,Quests,Sudowoodo)) {
                  if ($item($nick,Wailmer Pail).qnt) {
                    msg =$nick $ct $+ Você usou o $cc $+ Wailmer Pail $+ $ct $+ ...
                    msg =$nick $ct $+ O arbusto começa a se mover! É um $cc $+ Sudowoodo $+ $ct $+ !
                    var %x = $rand(0,2) | if (%x) && (!$dados($nick,Sudowoodo,Name)) && (!$dados($nick,Team,6)) {
                      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Sudowoodo Ok
                      .echo $addpoke($nick,Sudowoodo,30,30: $+ %d).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).ID | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Sudowoodo)
                      sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 5 | b.start.fight %ID | return
                    }
                    else { msg =$nick $ct $+ Droga! $cc $+ Sudowoodo $ct $+ fugiu! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Sudowoodo No }
                  }
                  else { msg =$nick $ct $+ Não foi possível ir a $cc $+ %d $+ $ct $+ . Há um tipo estranho de arbusto no caminho... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Pail Ok | return }
                }
              }
              if (%d == Victory Road) {
                if (%region == Kanto) {
                  msg =$nick $ct $+ Você encontra-se com um guarda.
                  msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Para atravessar até a $cc $+ Victory Road $ct $+ é necessário ter todas as oito insígneas de $cc $+ Kanto $+ $ct $+ .
                  if ($dados($nick,$dados($nick,Info,Region),Badges).n < 8) {
                    msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Não, você não pode passar.
                    if (!$dados($nick,$dados($nick,Info,Region),Badges).n) && ($start($nick)) {
                      if (!$dados($nick,Quests,Gary1)) {
                        msg =$nick $ct $+ Você encontra-se com $cc $+ Gary $+ $ct $+ .
                        msg =$nick $chr(160) $cc $+ Gary $ct $+ - Hahahaha, está perdido é? Você realmente não esperava desafiar a liga pokémon nas condições que você está agora, certo? Ok, então uma batalha!
                        battle.npc $nick 1067 | var %ID = $checknickid($nick).ID | if ($v(B. $+ %ID $+ .2vs2)) { msg =$nick $chr(160) $cc $+ Gary $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , você sabe como batalhar em dupla né? Como não?! Bem, primeiro defina o golpe do pokémon com o comando... bem, você sabe. E depois o alvo, se possível, com o comando " $+ $cc $+ .Alvo <número> $+ $ct $+ ', substituindo $cc $+ <número> $ct $+ pelo número correspondente ao meu pokémon. Pra ver qual é o meu número, tente digitar apenas ' $+ $cc $+ .Alvo $+ $ct $+ '... }
                        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] GARY1
                      }
                    }
                    return
                  }
                  else { msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Parabéns, você está pronto para a liga pokémon. Pode prosseguir. }
                }
                else {
                  msg =$nick $ct $+ Você encontra-se com um guarda.
                  msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Para atravessar até a $cc $+ Victory Road $ct $+ é necessário ter, além de todas as oito insígneas de $cc $+ Johto $+ $ct $+ , as dezesseis insígneas adquiridas em $cc $+ Kanto $ct $+ e $cc $+ Hoenn $+ $ct $+ .
                  var %x = $calc($dados($nick,Kanto,Badges).n + $dados($nick,Hoenn,Badges).n + $dados($nick,Johto,Badges).n)
                  if (%x == 24) { msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Parabéns, você está pronto para a liga pokémon. Pode prosseguir. }
                  else { msg =$nick $chr(160) $cc $+ Guarda $ct $+ - Sinto muito, mas todas as vinte e quatro insígneas são necessárias nesta etapa... | return }
                }
              }
              var %v = $dados($nick,$dados($nick,Info,Region),Visited) | if (%v) { writeini pkp\cadastros\ $+ $nick $+ .ini $dados($nick,Info,Region) Visited %v $+ : $+ %d } | else { writeini pkp\cadastros\ $+ $nick $+ .ini $dados($nick,Info,Region) Visited %d }
            }
            var %d = $gotoplace($nick,%l,%d).get | if ($gettok(%d,2,35)) { writeini pkp\cadastros\ $+ $nick $+ .ini Info Path $gettok(%d,2,35) } | elseif ($dados($nick,Info,Path)) { remini pkp\cadastros\ $+ $nick $+ .ini Info Path }
            var %d = $gettok(%d,1,35)
            msg =$nick $ct $+ Você saiu de $cc $+ $rini(cadastros,$nick,Info,Locate) $+ $ct $+ . Bem vindo à $cc $+ %d $+ $ct $+ .
            wlog user $nick Arrived at %d successfully.
            writeini pkp\cadastros\ $+ $nick $+ .ini Info Locate %d | writeini pkp\cadastros\ $+ $nick $+ .ini Info LastLocate %l | writeini pkp\cadastros\ $+ $nick $+ .ini Time Goto $date $time
            place.events
            return
          }
          else { msg =$nick $ct $+ Não foi possível mudar para a cidade selecionada. Se tiver dúvidas, digite ' $+ $cc $+ .Cidade Goto $+ $ct $+ ' e veja as localizações mais próximas. | return }
        }
      }
      else {
        var %l = $dados($nick,Info,Locate)
        .echo $gotowhere($nick,%l)
      }
      return
    }
    elseif ($2 == Dojo) {
      if (%l == Saffron City) {
        if ($start($nick)) { msg =$nick $ct $+ Você entrou no $cc $+ Fighting Dojo $+ $ct $+ . Você pode ver $cc $+ Koichi $ct $+ e $cc $+ Koji $+ $ct $+ . }
        else { msg =$nick $ct $+ Você entrou no $cc $+ Fighting Dojo $+ $ct $+ . Você pode ver $cc $+ Koichi $+ $ct $+ . }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == Silph) {
      if (%l == Saffron City) {
        if ($start($nick)) {
          if ($dados($nick,Quests,Rocket3)) { msg =$nick $ct $+ Você entrou na $cc $+ Silph Corporation $+ $ct $+ . Você pode ver o presidente $cc $+ Silph $+ $ct $+ . }
          else { msg =$nick $ct $+ Mal posso acreditar no que meus olhos vêem! É a equipe $cc $+ Rocket $+ $ct $+ ! São muitos... }
        }
        else { msg =$nick $ct $+ Você entrou na $cc $+ Silph Corporation $+ $ct $+ . Você pode ver o presidente $cc $+ Silph $+ $ct $+ . }
      }
      else { msg =$nick $ct $+ Esta opção não existe na cidade selecionada. }
      return
    }
    elseif ($2 == P.C) {
      if ($findtok($readini(pkp\status.ini,%region,NoPC),%l,0,58)) { msg =$nick $ct $+ Não há centros pokémon em $cc $+ %l $+ $ct $+ . | return }
      else {
        if (%l == Oldale Town) { if ($start($nick)) { var %npc = Joy:Thomas:Matt } | else { var %npc = Joy:Matt } }
        elseif (%l == Petalburg City) { var %npc = Joy:Derek }
        elseif (%l == Rustboro City) { var %npc = Joy }
        elseif (%l == Dewford City) { var %npc = Joy }
        elseif (%l == Slateport City) { var %npc = Joy:Rose }
        elseif (%l == Mauville City) { var %npc = Joy:Russel:Kessy }
        elseif (%l == Verdanturf Town) { var %npc = Joy:Jay:Isabel:Jerry }
        elseif (%l == Lavaridge Town) { var %npc = Joy:Elliot:Ethan:Isaiah }
        elseif (%l == Fallarbor Town) { var %npc = Joy:Penny:Josh:Lanette }
        elseif (%l == Fortree City) { var %npc = Joy:Tob:Lao }
        elseif (%l == Lilycove City) { var %npc = Joy:Bernie:Robert }
        elseif (%l == Mossdeep City) { var %npc = Joy:Vivian:George }
        elseif (%l == Sootopolis City) { var %npc = Joy:Helena:Diogo:Brooke }
        elseif (%l == Pacifidlog Town) { var %npc = Joy:Sarah:Aaron }
        elseif (%l == Evergrande City) { var %npc = Joy }
        elseif (%l == Viridian City) { var %npc = Joy:Penny:Max }
        elseif (%l == Pewter City) { var %npc = Joy:Josh }
        elseif (%l == Cerulean City) { var %npc = Joy:Ronny:Bill }
        elseif (%l == Vermilion City) { if ($start($nick)) { var %npc = Joy:Thomas:Lena } | else { var %npc = Joy:Lena } }
        elseif (%l == Lavender Town) { var %npc = Joy:Anth:Doug }
        elseif (%l == Celadon City) { var %npc = Joy:Julia:Rich }
        elseif (%l == Saffron City) { var %npc = Joy:Amanda }
        elseif (%l == Fuchsia City) { var %npc = Joy:Ann:Lucas:Cooper }
        elseif (%l == Cinnabar Island) { var %npc = Joy:Wade:Amara:Claire }
        elseif (%l == Indigo Plateau) { var %npc = Joy | if (!$dados($nick,Quests,Mazon)) { var %npc = $addtok(%npc,Mazon,58) } }
        elseif (%l == Olivine City) { var %npc = Joy:Shane:Franklin }
        elseif (%l == Cianwood City) { var %npc = Joy:Luis:Diana:Hugo:Morgan }
        elseif (%l == Ecruteak City) { var %npc = Joy:Molly }
        elseif (%l == Goldenrod City) { var %npc = Joy:Rayna:Dawson }
        elseif (%l == Azalea Town) { var %npc = Joy:Vance:Kurt:Tylor }
        elseif (%l == Violet City) { var %npc = Joy:Zac:Anya | if ($dados($nick,Quests,Mazon)) { var %npc = $addtok(%npc,Mazon,58) } | if ($dados($nick,Quests,Silver) == 1) { var %npc = $addtok(%npc,Silver,58) } }
        elseif (%l == Cherrygrove City) { var %npc = Joy:Luke:Clarice | if ($start($nick)) { var %npc = %npc $+ :Thomas } }
        elseif (%l == Mahogany Town) { var %npc = Joy:Dean }
        elseif (%l == Blackthorn City) { var %npc = Joy:Bryce:Flint }
        elseif (%l == White City) { var %npc = Joy:Derek:Mark:Ariana }
        elseif (%l == Peak Town) { var %npc = Joy:Oliver:Brent }
        elseif (%l == Sunrise City) { var %npc = Joy:Clarice:Marty }
        elseif (%l == Silverst City) { var %npc = Joy:Fred | if (!$dados($nick,Quests,Mew)) { var %npc = %npc $+ :Earl } | if ($dados($nick,Info,Start) == Hoenn) { var %npc = %npc $+ :Brendan } | elseif ($dados($nick,Info,Start) == Kanto) { var %npc = %npc $+ :May } | else { var %npc = %npc $+ :Silver } }
        if (%npc) {
          if ($findtok(%npc,Joy,0,58)) { var %npc = $remtok(%npc,Joy,1,58), %npc = $iif(%npc,Joy: $+ %npc,Joy) | msg =$nick $ct $+ Bem vindo ao Pokémon Center. Você pode ver a enfermeira $separecom(%npc,e,58,$cc,$ct) $+ $ct $+ . }
          else { msg =$nick $ct $+ Bem vindo ao Pokémon Center. Você pode ver $separecom(%npc,e,58,$cc,$ct) $+ $ct $+ . }
        }
        else { msg =$nick $ct $+ Bem vindo ao Pokémon Center. }
      }
      return
    }
    elseif ($2 == Search) {
      if ($3) && ($left($3,1) != <) && ($right($3,1) != >) {
        c.search. $+ $replace(%l,$chr(32),_) $3-
        return
      }
      else { msg =$nick $ct $+ Você utilizou este comando de forma incorreta. Especifique o que você procura nesta sintaxe: ' $+ $cc $+ .Cidade Search <pessoa/coisa> $+ $ct $+ '. | return }
    }
    else { msg =$nick $ct $+ Esta opção não existe na cidade. Digite ' $+ $cc $+ .Cidade $+ $ct $+ ' para listá-las. | return }
  }
  else {
    msg =$nick $ct $+ Lista de comandos relacionados à sua $cc $+ localização $+ $ct $+ :
    var %region = $dados($nick,Info,Region)
    if (%l == Littleroot Town) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade lab $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ laboratório $ct $+ do Prof Birch; }
    elseif (%l == Rustboro City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade devon $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Devon Corporation $+ $ct $+ ; }
    elseif (%l == Dewford City) {
      if ($dados($nick,Quests,Tomb)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade cave $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ caverna $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
    }
    elseif (%l == Slateport City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade museu $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ museu $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade port $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ porto $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ;
    }
    elseif (%l == Mauville City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade cycles $+ $ct $+ " para $cc $+ entrar $ct $+ na famosa $cc $+ loja $ct $+ de bicicletas;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade daycare $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ centro de criação $+ $ct $+ ;
    }
    elseif (%l == Fortree City) {
      if ($dados($nick,Quests,Tomb)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade cave $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ caverna $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade institute $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ Weather Institute $+ $ct $+ ;
    }
    elseif (%l == Lilycove City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade port $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ porto $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade safari $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Safari Zone $+ $ct $+ ;
    }
    elseif (%l == Mossdeep City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade space $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ Space Center $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ;
    }
    elseif (%l == Desert Underpass) {
      if ($dados($nick,Quests,Tomb)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade cave $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ caverna $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
    }
    elseif (%l == Power Plant) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade control $+ $ct $+ " para ir na $cc $+ sala $ct $+ de $cc $+ sala de controle $ct $+ de $cc $+ controle $+ $ct $+ ; }
    elseif (%l == Pacifidlog Town) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ; }
    elseif (%l == Sky Pillar) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade top $+ $ct $+ " para ir ao $cc $+ topo $ct $+ do $cc $+ Sky Pillar $+ $ct $+ ; }
    elseif (%l == Mt Ember) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade top $+ $ct $+ " para ir ao $cc $+ topo $ct $+ do $cc $+ Mt Ember $+ $ct $+ ; }
    elseif (%l == Evergrande City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade league $+ $ct $+ " para $cc $+ enfrentar $ct $+ a $cc $+ Elite Four $ct $+ de $cc $+ Hoenn $+ $ct $+ ; }
    elseif (%l == Pallet Town) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade lab $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ laboratório $ct $+ do Prof Oak; }
    elseif (%l == Pewter City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade museu $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ museu $ct $+ de $cc $+ Pewter $+ $ct $+ ; }
    elseif (%l == Vermilion City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade port $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ porto $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
    elseif (%l == SS Anne) || (%l == SS Tidal) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade ship $+ $ct $+ " para $cc $+ explorar $ct $+ o navio;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade room $+ $ct $+ " para $cc $+ entrar $ct $+ num $cc $+ quarto $ct $+ do $cc $+ %l $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade control $+ $ct $+ " para $cc $+ visitar $ct $+ a sala de $cc $+ museu $ct $+ de $cc $+ controle $ct $+ do navio;
    }
    elseif (%l == Lavender Town) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade tower $+ $ct $+ " para $cc $+ visitar $ct $+ a Pokémon Tower;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ;
    }
    elseif (%l == Celadon City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade corner $+ $ct $+ " para $cc $+ visitar $ct $+ o $cc $+ Game Corner $+ $ct $+ ;
    }
    elseif (%l == Saffron City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade silph $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Silph Corp $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade dojo $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ Fighting Dojo $+ $ct $+ ;
    }
    elseif (%l == Fuchsia City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade safari $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Safari Zone $+ $ct $+ ; }
    elseif (%l == Cinnabar Island) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade lab $+ $ct $+ " para $cc $+ entrar $ct $+ no laboratório da cidade; }
    elseif (%l == Seafoam Island) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade waterfall $+ $ct $+ " para $cc $+ subir $ct $+ a cachoeira; }
    elseif (%l == Indigo Plateau) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade league $+ $ct $+ " para $cc $+ enfrentar $ct $+ a $cc $+ Elite Four $ct $+ de $cc $+ Kanto $+ $ct $+ ; }
    elseif (%l == Olivine City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade light $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Lighthouse $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade farm $+ $ct $+ " para $cc $+ visitar $ct $+ uma $cc $+ fazenda $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade port $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ porto $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ;
    }
    elseif (%l == Ecruteak City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade tower $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Burned Tower $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade tin $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Tin Tower $+ $ct $+ ;
    }
    elseif (%l == Goldenrod City) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade tower $+ $ct $+ " para $cc $+ visitar $ct $+ a $cc $+ Radio Tower $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade haircut $+ $ct $+ " para $cc $+ visitar $ct $+ o $cc $+ salão de beleza $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade corner $+ $ct $+ " para $cc $+ visitar $ct $+ o $cc $+ Game Corner $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade flower $+ $ct $+ " para $cc $+ visitar $ct $+ a $cc $+ floricultura $+ $ct $+ ;
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade daycare $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ centro de criação $+ $ct $+ ;
    }
    elseif (%l == Azalea Town) {
      msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade home $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ casa $+ $ct $+ ;
    }
    elseif (%l == New Bark Town) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade lab $+ $ct $+ " para $cc $+ entrar $ct $+ no $cc $+ laboratório $ct $+ do Prof Elm; }
    elseif (%l == Silverst City) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade league $+ $ct $+ " para $cc $+ enfrentar $ct $+ a $cc $+ Elite Four $ct $+ de $cc $+ Johto $+ $ct $+ ; }
    elseif (%l == Marine Cave) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade lake $+ $ct $+ " para observar o enorme $cc $+ lago $+ $ct $+ ; }
    elseif (%l == Terra Cave) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade volcano $+ $ct $+ " para observar a enorme $cc $+ cratera $+ $ct $+ ; }
    elseif (%l == Ruins Of Alph) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade pillar $+ $ct $+ " para observar a enorme $cc $+ pilar $+ $ct $+ ; }
    if (!$findtok($readini(pkp\status.ini,%region,NoPC),%l,0,58)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade P.C $+ $ct $+ " para $cc $+ entrar $ct $+ num $cc $+ centro $ct $+ pokémon; }
    if ($readini(pkp\gym.ini,$iif($start($nick),Normal,Advanced),$replace(%l,$chr(32),_))) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade gym $+ $ct $+ " para $cc $+ desafiar $ct $+ o(a) líder do $cc $+ ginásio $+ $ct $+ ; }
    if ($shop(%l)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade shop $+ $ct $+ " para $cc $+ entrar $ct $+ numa $cc $+ loja $ct $+ da sua localização atual; }
    if ($findtok($readini(pkp\status.ini,%region,Market),%l,0,58)) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade market $+ $ct $+ " para $cc $+ ver $ct $+ o $cc $+ mercado $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
    if ($readini(pkp\status.ini,Tent,$replace(%l,$chr(32),_))) { msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade tent $+ $ct $+ " para $cc $+ entrar $ct $+ na $cc $+ Battle Tent $ct $+ de $cc $+ $nullfill($remove(%l,City,Town)) $+ $ct $+ ; }
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade wild <pokémon> $+ $ct $+ " para iniciar uma $cc $+ batalha $ct $+ com um pokémon $cc $+ selvagem $+ $ct $+ ;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade goto (<cidade>) $+ $ct $+ " para mudar sua $cc $+ localização $ct $+ para a $cc $+ cidade $ct $+ selecionada;
    msg =$nick $chr(160) $ct $+ Digite " $+ $cc $+ .cidade search <pessoa> $+ $ct $+ " para $cc $+ procurar $ct $+ por alguém na sua $cc $+ cidade $ct $+ atual;
    msg =$nick $ct $+ Fim da lista de comandos.
    var %other = $someone($nick) | if (%other) { msg =$nick $ct $+ Há mais pessoas nesta cidade além de você: $separecom(%other,e,59,$cc,$ct) $+ $ct $+ . }
    return
  }
}
