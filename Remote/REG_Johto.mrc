alias c.search.Olivine_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($start($nick)) { msg =$nick $cht(160) $cc $+ Joy $ct $+ - Bem vindo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Exausto da longa viagem? Não se incomode, pode se sentar e descansar. }
    else {
      if ($badge($nick,Mineral Badge)) { msg =$nick $cht(160) $cc $+ Joy $ct $+ - Parabéns pela sua vitória contra $cc $+ Jasmine $+ $ct $+ . Sabia que ela cuida de vários pokémon na $cc $+ Lighthouse $+ $ct $+ ? Ela é tão doce... }
      else { msg =$nick $cht(160) $cc $+ Joy $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Seja muito bem vindo. Sabe, você não é o único estrangeiro por aqui. Todos os dias, chegam vários treinadores de vários lugares do planeta em busca de novos desafios e claro, novos pokémon. }
    }
  }
  elseif ($1 == Shane) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Shane $+ $ct $+ , uma treinadora pokémon.
    if ($badge($nick,Mineral Badge)) { msg =$nick $chr(160) $cc $+ Shane $ct $+ - Bem, mas como qualquer pokémon, cada tipo tem lá suas fraquezas, não é verdade? Parabéns pela vitória, e boa sorte na liga de $cc $+ Johto $+ $ct $+ ! }
    else { msg =$nick $chr(160) $cc $+ Shane $ct $+ - Cuidado! A líder desta cidade usa pokémon metálico! Isso significa que você não tem muitas possibilidades de efetividade... }
  }
  elseif ($1 == Franklin) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Franklin $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Franklin $ct $+ - Existe uma ilha localizada ao extremo sul, mas como o mar é muito agitado ela não pode ser alcançada. É muito perigoso para qualquer treinador avançar naqueles redemoinhos...
    msg =$nick $chr(160) $cc $+ Franklin $ct $+ - No entanto, existe uma rota segura que o levará a $cc $+ Cianwood City $+ $ct $+ . Hahaha, cuidado em sua viagem!
  }
  elseif ($1 == Greg) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Greg $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Greg $ct $+ - Eu gosto de visitar a $cc $+ Lighthouse $+ $ct $+ , pois além de um ambiente incrível esta torre auxilia os navios a encontrarem um caminho seguro até o porto. Afinal, nem todos os lugares do mar são realmente seguros!
  }
  elseif ($1 == Nelson) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Nelson $+ $ct $+ , um fazendeiro.
    if ($dados($nick,Quests,Milk) == Ok) {
      msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Está procurando por $cc $+ MooMoo Milk $+ $ct $+ ?
      var %x = $dados($nick,Clock,Milk), %o = $dados($nick,Info,Online) | if ($calc(%o - %x) < 10800) { msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Sinto muito, minhas $cc $+ Miltanks $ct $+ ainda não produziram-no. Por que não volta aqui mais tarde? | return }
      if ($findtok(Monday,$day,0,58)) { var %price = 6000 } | else { var %price = 9000 }
      msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Tudo bem, eu venderei uma garrafa por $cc $+ $chr(36) $+ $getmoney(%price) $+ $ct $+ . Deseja realmente comprar $cc $+ MooMoo Milk $+ $ct $+ ?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar.
      set %confirm. [ $+ [ $nick ] ] MILK: $+ %price
    }
    elseif ($dados($nick,Quests,Milk) == No) {
      msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Oh, então é amigo de minha sobrinha $cc $+ Whitney $+ $ct $+ ? Parece que vocês tiveram uma ótima batalha no ginásio, que tal descansar um pouco? Seus pokémon devem estar exaustos, então bebam um pouco de $cc $+ MooMoo Milk $+ $ct $+ !
      msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ MooMoo Milk $+ $ct $+ ! | item.add $nick MooMoo Milk | msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Sabe, meus pokémon produzem esse leite saboroso e os pokémon adoram! Deixam-nos mais feliz e cheios de energia, porque essa bebida é rica em proteínas. Essa é apenas uma amostra grátis, se quiser mais, volte aqui e eu venderei uma quando puder.
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Milk Ok | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Milk $dados($nick,Info,Online)
    }
    else { msg =$nick $chr(160) $cc $+ Nelson $ct $+ - Hey, o que você pensa que está fazendo na minha fazenda? Não é assim não, entrando sem ser convidado... Acabará assustando minhas preciosas $cc $+ Miltanks $+ $ct $+ ! }
  }
  elseif ($1 == Luna) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Luna $+ $ct $+ , uma maruja.
    if ($dados($nick,$dados($nick,Info,Start),Badges).n == 8) {
      var %x = $dados($nick,Clock,Ship), %y = 0
      if (%x) { if ($calc($dados($nick,Info,Online) - %x) >= 21600) { var %y = 1 } } | else { var %y = 1 }
      if (%y) {
        if ($item($nick,Gold Ticket).qnt) && ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Luna $ct $+ - Oh, este é o $cc $+ Silver Ticket $ct $+ e o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Anne) $+ $ct $+ ) ou no $cc $+ SS Tidal $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Tidal) $+ $ct $+ ) $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim <barco> $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne;SS Tidal
        }
        elseif ($item($nick,Gold Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Luna $ct $+ - Oh, este é o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Tidal $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Tidal
        }
        elseif ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Luna $ct $+ - Oh, este é o $cc $+ Silver Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne
        }
        else { msg =$nick $chr(160) $cc $+ Luna $ct $+ - Você não pode embarcar se não tiver uma passagem de navio. }
      }
      else { msg =$nick $chr(160) $cc $+ Luna $ct $+ - Não há barcos nesse momento. Você deve aguardar seis horas $cc $+ online $ct $+ para tentar novamente. Neste momento, faltam aproximadamente $dur($calc(21600 - ($dados($nick,Info,Online) - %x)),$ct,$cc) $+ . }
      return
    }
    else { msg =$nick $chr(160) $cc $+ Luna $ct $+ - Ah, que pena. Infelizmente não há nenhum barco neste momento. | return }
  }
  elseif ($1 == Jasmine) {
    if ($badge($nick,Mineral Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Jasmine $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Oh, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , que bom revê-lo! Posso ajudá-lo? Veja, meu pokémon está radiante! Deixe-me analisar como está o seu pokémon...
      var %p = $dados($nick,Team,1), %x = 0, %r = 0, %m = 0
      while (%x < 6) { inc %x | var %iv = $dados($nick,%p,IV $+ $nstat(%x)), %r = $calc(%r + %iv) | if (%iv > %m) { var %m = %iv, %biv = $nstat(%x) } | elseif (%iv == %m) { if (%biv) { var %biv = %biv $nstat(%x) } | else { var %biv = $nstat(%x) } } }
      if (%r isnum 0-60) { var %gstate = habilidades medianas }
      elseif (%r isnum 61-114) { var %gstate = habilidades melhores que a média }
      elseif (%r isnum 115-174) { var %gstate = habilidades impressionantes }
      else { var %gstate = habilidades maravilhosamente formidáveis }
      if (%m isnum 0-11) { var %state = Este atributo é relativamente bom... } | elseif (%m isnum 12-21) { var %state = Este atributo está interessante. } | elseif (%m isnum 22-30) { var %state = Este atributo está incrível! } | else { var %state = É infalível! É digno de perfeição! }
      if ($gettok(%biv,0,32) > 1) { var %biv = $gettok(%biv,$rand(1,$gettok(%biv,0,32)),32) }
      msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - $cc $+ %p $+ $ct $+ , em geral, eu poderia dizer que tem %gstate $+ . Seu melhor atributo é, sem dúvida, $cc $+ $upper(%biv) $+ $ct $+ . %state
    }
    else {
      if ($dados($nick,Quests,Jasmine)) {
        if ($dados($nick,Quests,Jasmine) == Ok) { msg =$nick $cc $+ Jasmine $ct $+ está no ginásio, aguardando seu desafio. }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Jasmine $+ $ct $+ .
          if ($dados($nick,Info,Start) == Hoenn) {
            if ($item($nick,MooMoo Milk).qnt) { msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Oh, então $cc $+ MooMoo Milk $ct $+ alegra os pokémon? Poderia me dar um desses, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ? Por favor... | msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar ou ' $+ $cc $+ .nao $+ $ct $+ ' para recusar. | set %confirm. [ $+ [ $nick ] ] JSM:1 }
            else { msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Quando descobrir algo, por favor, me procure... Meu pokémon precisa realmente se animar... }
          }
          else {
            if ($item($nick,Rare Potion)) { msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Então, $cc $+ Rare Potion $ct $+ é capaz de curar a doença do meu pokémon? Será que você poderia me dar um desses? Por favor... | msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar ou ' $+ $cc $+ .nao $+ $ct $+ ' para recusar. | set %confirm. [ $+ [ $nick ] ] JSM:2 }
            else { msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Ouvi dizer que o pesquisador mora em $cc $+ Cianwood City $+ $ct $+ ... Será que ele tem algum remédio para o meu pokémon? }
          }
        }
      }
      else {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Jasmine $+ $ct $+ .
        if ($dados($nick,Info,Start) == Hoenn) { msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Uma batalha de ginásio? Eu adoraria, mas meu pokémon está muito mal humorado hoje... Sabe, depois que ele se recuperou da doença, não parece mais o mesmo. Será que existe algum remédio ou alguma bebida que deixe meu pokémon mais alegre? }
        else {
          msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Ah, você falou em uma batalha no ginásio? Sinto muito, mas neste momento eu realmente não posso pensar nisso. Meu amável pokémon está muito doente, não sei o que será de mim se algo acontecer a ele...
          msg =$nick $chr(160) $cc $+ Jasmine $ct $+ - Então, você acha que pode ajudá-lo? Nossa, eu ficaria muito feliz se você encontrasse um famoso pesquisador que desenvolve remédios a partir de substâncias produzidas por pokémon! É fantástico, ouvi falar que ele reside em $cc $+ Cianwood City $+ $ct $+ .
        }
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Jasmine No
      }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Cianwood_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($badge($nick,Storm Badge)) { msg =$nick $cht(160) $cc $+ Joy $ct $+ - Parabéns pela sua vitória, é mais um passo em direção ao hall da fama! Divirta-se em suas viagens e cuidado com as marés agitadas! }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, visitante! Como vai a sua jornada aqui em $cc $+ Johto $+ $ct $+ ? Nesta cidade você poderá desafiar o líder $cc $+ Chuck $+ $ct $+ . Sua especialidade é pokémon lutador! Muito cuidado, eles são muito bem treinados! }
  }
  elseif ($1 == Luis) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Luis $+ $ct $+ , um esportista.
    msg =$nick $chr(160) $cc $+ Luis $ct $+ - Uma dica! Fique longe das águas agitadas da costa! Sabe, existem vários redemoinhos nas proximidades, é por isso que é mais seguro ficar longe. E mesmo se tentar atravessar, sugiro que passe por baixo da água, usando $cc $+ Dive $+ $ct $+ .
  }
  elseif ($1 == Diana) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Diana $+ $ct $+ , uma criadora de pokémon.
    msg =$nick $cht(160) $cc $+ Diana $ct $+ - Eu nunca me dediquei a conquistar insígneas com meus pokémon. Prefiro cuidar muito bem da saúde deles e dar muito amor, assim eles ficam mais felizes e me deixam feliz também. Sabe, $cc $+ MooMoo Milk $ct $+ é uma bebida muito boa, os pokémon adoram! Eles se sentem mais animados após beber um pouco.
  }
  elseif ($1 == Hugo) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Hugo $+ $ct $+ , um pesquisador pokémon.
    if ($dados($nick,Info,Start) == Hoenn) { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Meus últimos trabalhos me levaram a resultados magníficos! Desenvolvi remédio basicamente milagroso para pokémon. Mas não se preocupe, os pokémon não ficam doentes constantemente. Os seus parecem estar ótimos! }
    else {
      if ($dados($nick,Quests,Jasmine)) {
        if ($dados($nick,Quests,Jasmine) == Ok) {
          if ($dados($nick,Quests,Hugo)) { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - O segredo das minhas poções é colocar uma mistura de feromônios dentro da casca de um $cc $+ Shuckle $ct $+ por meses! O resultado disso é uma mistura saborosa e revigorante! }
          else {
            msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Então minha $cc $+ Rare Potion $ct $+ realmente funciona?! É incrível, fico muito grato em saber disso! Não se incomode por eu tê-lo usado apenas como cobaia, como recompensa pode ficar com este pokémon.
            if ($dados($nick,Team,6)) { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Mas você não tem espaço no time neste momento. Tudo bem, volte aqui quando puder! | return }
            if ($dados($nick,Shuckle,Name)) { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Hm, você já tem o pokémon que eu vou dar, então não tem graça! Se quiser recebê-lo, tire $cc $+ Shuckle $ct $+ do seu time! | return }
            addpoke $nick Shuckle 20 20: $+ $dados($nick,Info,Locate) $+ :Poke  Ball | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Hugo Ok
            msg =$nick $ct $+ Parabéns, você recebeu o pokémon $cc $+ Shuckle $+ $ct $+ !
          }
        }
        else {
          if ($item($nick,Rare Potion).qnt) { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Sua amiga deve estar realmente precisando desta $cc $+ Rare Potion $+ $ct $+ . Não se preocupe, eu tenho o bastante aqui! Pode ficar. }
          else { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - O que? Um pokémon doente? Que coincidência, meu remédio provavelmente poderá ajudá-lo! $cc $+ Jasmine $ct $+ ficará muito contente com esta $cc $+ Rare Potion $+ $ct $+ . | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Rare Potion $+ $ct $+ . | item.add $nick Rare Potion }
        }
      }
      else { msg =$nick $chr(160) $cc $+ Hugo $ct $+ - Finalmente conclui meu remédio! É muito poderoso! Esta $cc $+ Rare Potion $ct $+ cura várias doenças de pokémon. }
    }
  }
  elseif ($1 == Morgan) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Morgan $+ $ct $+ , um pescador.
    if ($start($nick)) {
      if (!$item($nick,Good Rod).qnt) { msg =$nick $chr(160) $cc $+ Morgan $ct $+ - Eu não posso ajudá-lo ainda... Você precisa adquirir mais prática em pescaria de pokémon! | return }
      if ($item($nick,Super Rod).qnt) { msg =$nick $chr(160) $cc $+ Morgan $ct $+ - Agora sim! Considere-se finalmente um pescador profissional! Divirta-se pescando pokémon! }
      else { msg =$nick $chr(160) $cc $+ Morgan $ct $+ - Depois de praticar bastante com sua $cc $+ Good Rod $+ $ct $+ , vejo que finalmente está pronto para receber a melhor vara de pescar existente! Parabéns, fique com esta $cc $+ Super Rod $+ $ct $+ . | item.add $nick Super Rod | msg =$nick $chr(160) $cc $+ Morgan $ct $+ - Se usá-la, a isca poderá chegar até as profundezas das águas, onde vivem pokémon raros... }
    }
    else { msg =$nick $chr(160) $cc $+ Morgan $ct $+ - Imagino que você tenha encontrado muitos pokémon diferentes em $cc $+ $dados($nick,Info,Region) $+ $ct $+ ... }
  }
  elseif ($1 == Chuck) {
    if ($badge($nick,Storm Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Chuck $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      if ($start($nick)) {
        if ($item($nick,HM04).qnt) { msg =$nick $chr(160) $cc $+ Chuck $ct $+ - Seus pokémon precisam de mais força! Por que não os ensina a técnica $cc $+ Strength $+ $ct $+ ? | item.add $nick HM04 | msg =$nick $ct $+ Parabéns, você ganhou o $cc $+ HM04 $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Chuck $ct $+ - Com este HM seu pokémon poderá mover pedras pesadas que fixam em seu caminho! É força pura! }
        else { msg =$nick $chr(160) $cc $+ Chuck $ct $+ - Mantenha seus punhos firmes para defender-se de seus oponentes caso seja necessário. Antigamente pokémon e treinadores lutavam juntos, por isso mantenho a tradição! }
      }
      else { msg =$nick $chr(160) $cc $+ Chuck $ct $+ - Hahaha, eu não podia esperar por isto! Sua batalha foi muito intensa, não duvido que conseguirás chegar ainda mais longe! }
    }
    else { msg =$nick $cc $+ Chuck $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Ecruteak_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, treinador! $cc $+ $dados($nick,Info,Locate) $ct $+ é uma cidade marcada por muitas lentas. Por exemplo, há uma torre que há séculos atrás foi queimada, liberando um pokémon lendário. Na tentativa de trazê-lo de volta, foi construída outra torre, mas o pokémon não voltou... Será que ainda restam esperanças?
  }
  elseif ($1 == Nancy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Nancy $+ $ct $+ , uma dançarina.
    if ($dados($nick,Quests,Pail)) { remini pkp\cadastros\ $+ $Nick $+ .ini Quests Pail | item.add $nick Wailmer Pail | msg =$nick $chr(160) $cc $+ Nancy $ct $+ - Ei, você teve problemas com um arbusto estranho? Ah, deve ser um pokémon! Fique com este $cc $+ Wailmer Pail $ct $+ e use naquele arbusto. Tenho certeza que ele sairá de seu caminho. | return }
    msg =$nick $chr(160) $cc $+ Nancy $ct $+ - Esta cidade possui muitas tradições e mantém ainda sua arquitetura de séculos atrás.
    if (!$dados($nick,Quests,Dancing)) {
      var %x = $dados($nick,Clock,Dancing) | if (%x) { var %r = $calc($dados($nick,Info,Online) - %x) | if (%r < 14400) { msg =$nick $chr(160) $cc $+ Nancy $ct $+ - Por que não nos visita mais tarde? Precisamos de mais tempo para nos arrumar! Hahaha, vamos ter outra batalha emocionante! | return } }
      msg =$nick $chr(160) $cc $+ Nancy $ct $+ - Nosso espetáculo também é bastante apreciado, gostaria de experimentar?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar o desafio ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitá-lo. | set %confirm. [ $+ [ $nick ] ] DNC
    }
  }
  elseif ($1 == Stan) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Stan $+ $ct $+ , um religioso.
    if ($dados($nick,Quests,Rocket6) == 2) { msg =$nick $chr(160) $cc $+ Stan $ct $+ - Não é possível! A equipe $cc $+ Rocket $ct $+ se apoderou da pena do poderoso $cc $+ Ho-oh $+ $ct $+ ! Segundo a lenda, o treinador que carregá-la consigo atrairá o pokémon legendário para o seu caminho. Se eles conseguirem capturá-lo, terão todo o poder necessário para devastar o mundo inteiro! }
    elseif ($dados($nick,Quests,Rocket6) == 4) { msg =$nick $chr(160) $cc $+ Stan $ct $+ - Felizmente a ameaça da equipe $cc $+ Rocket $ct $+ se foi. Espero que a $cc $+ Rainbow Feather $ct $+ esteja sendo mantida agora por um treinador responsável e pacífico, ou que jamais seja reencontrada, pelo bem da humanidade... }
    else {
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Stan $ct $+ - Nossas preces não foram suficientes para que pokémon sagrado retornasse à nova torre... Só nos resta agora a lembrança de dias felizes e de muita paz. }
      else { msg =$nick $chr(160) $cc $+ Stan $ct $+ - É verdade, a nova torre foi criada na espectativa de que o pokémon sagrado voltasse, mas não o agradou pelo visto... Ele ficará apenas na memória dos moradores mais antigos da cidade... }
    }
  }
  elseif ($findtok(rocket:equipe:equipe rocket:team rocket:thief:thiefs:ladrão:ladrões,$1-,0,58)) && ($dados($nick,Quests,Rocket6) == 2) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Bunch $+ $ct $+ , chefe da atual equipe $cc $+ Rocket $+ $ct $+ .
    msg =$nick $chr(160) Bunch $ct $+ - Não entendo, o que você está procurando aqui? Esta $cc $+ Rainbow Feather $ct $+ é nossa! Com ela, poderemos finalmente despertar o tão estimado $cc $+ Ho-oh $ct $+ e com ele dominaremos todo o mundo!
    msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para batalhar contra os membros da equipe ou ' $+ $cc $+ .nao $+ $ct $+ ' para fugir.
    set %confirm. [ $+ [ $nick ] ] RKT:8
  }
  elseif ($1 == Molly) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Molly $+ $ct $+ , uma habitante da cidade.
    msg =$nick $chr(160) $cc $+ Molly $ct $+ - Antigamente, bem depois do sumiço dos pokémon sagrados, tudo o que restara foram apenas uma recordação dos pokémon: $cc $+ Rainbow Feather $ct $+ e $cc $+ Silver Feather $+ $ct $+ . Ninguém mais ouviu falar sobre estes artefatos, nem o que aconteceu ou se ainda existem. Diziam também que funcionavam como verdadeiros amuletos.
  }
  elseif ($1 == Morty) {
    if ($badge($nick,Fog Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Morty $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Morty $ct $+ - É verdade, esta cidade tem muitas histórias e poucas delas são verdadeiras. Esperamos que um dia o pokémon volte à nova torre... }
      else {
        if ($dados($nick,Johto,League)) {
          if ($dados($nick,Quests,BTower)) { msg =$nick $chr(160) $cc $+ Morty $ct $+ - É incrível poder conhecer os pokémon que até então eram apenas lendas... É revigorante para qualquer treinador! }
          else {
            msg =$nick $chr(160) $cc $+ Morty $ct $+ - Parabéns pela sua vitória na liga de $cc $+ Johto $+ $ct $+ ! Enquanto você esteve batalhando, eu estive aqui pesquisando a respeito da $cc $+ Burned Tower $+ $ct $+ . Não tenho certeza, mas acho que descobri algo.
            msg =$nick $cc $+ Morty $ct $+ aperta algo e um leve terremoto acontece. Vocês caem no andar de baixo e encontram $cc $+ três $ct $+ pokémon.
            msg =$nick $chr(160) $cc $+ Morty $ct $+ - Funcionou! Olhe, são eles! $cc $+ Raikou $+ $ct $+ , $cc $+ Entei $ct $+ e $cc $+ Suicune $+ $ct $+ ! Ah não, eles fugiram! Que azar... Bem, pelo menos já descobri a relação deles com esta torre. Espero poder encontrá-los outra vez.
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests BTower Ok
          }
        }
        else { msg =$nick $chr(160) $cc $+ Morty $ct $+ - Nossa batalha foi muito empolgante, não esperava um desempenho tão impressionante. No entanto, enquanto batalhávamos, estava com a cabeça em outro lugar, pensando nas lendas sobre as torres... }
      }
    }
    else {
      if ($start($nick)) {
        if ($dados($nick,Quests,BTower)) { msg =$nick $cc $+ Morty $ct $+ está no ginásio, aguardando seu desafio. }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Morty $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Morty $ct $+ - Estou procurando alguma passagem secreta aqui na $cc $+ Burned Tower $+ $ct $+ . Meus sentidos apontam para este lugar, mas não entendo...
          msg =$nick $ct $+ De repente, acontece um leve terremoto e vocês caem no andar de baixo e encontram $cc $+ três $ct $+ pokémon.
          msg =$nick $chr(160) $cc $+ Morty $ct $+ - Olhe, são eles! $cc $+ Raikou $+ $ct $+ , $cc $+ Entei $ct $+ e $cc $+ Suicune $+ $ct $+ ! Ah não, eles fugiram! Nossa, mas foi muito rápido! Bem, você é... $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Voltarei ao ginásio agora, para batalharmos se assim quiser, afinal você me ajudou a encontrar aqueles lendários. Estarei esperando!
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests BTower Ok
        }
      }
      else { msg =$nick $cc $+ Morty $ct $+ está no ginásio, aguardando seu desafio. }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Goldenrod_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, treinador! Descanse, pois se pretende batalhar com a líder local, seus pokémon vão precisar de muita energia! $cc $+ Whitney $ct $+ será um forte oponente, então esteja preparado. }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . $cc $+ $dados($nick,Info,Locate) $ct $+ é conhecida como a grande metrópole de $cc $+ Johto $+ $ct $+ . Neste clima de muita agitação, as pessoas podem ser um pouco mais estressadas, mas não se incomode. }
  }
  elseif ($1 == Rayna) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Rayna $+ $ct $+ , uma treinadora.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Rayna $ct $+ - Acabei de chegar em $cc $+ $dados($nick,Info,Locate) $ct $+ e já percebi que é bem diferente das outras cidades que eu já havia visitado. Pelo contrário, a agitação daqui é tanta que me deixa um pouco angustiada... Falaram-me muitas coisas sobre a líder local. Dizem até que sua $cc $+ Miltank $ct $+ é invencível! Acredita? }
    else { msg =$nick $chr(160) $cc $+ Rayna $ct $+ - Ah, você já visitou o $cc $+ DayCare Center $+ $ct $+ ? É o único de $cc $+ Johto $ct $+ e você pode efetuar cruzamentos usando seus pokémon. Peça mais informações quando for visitar o centro de criação. }
  }
  elseif ($1 == Dawson) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Dawson $+ $ct $+ , um habitante da cidade.
    msg =$nick $chr(160) $cc $+ Dawson $ct $+ - Certa vez eu acabei me perdendo na cidade, para você ver como nem mesmo os habitantes conhecem-na bem. Fique atento para não acabar perdido, assim como eu fiquei...
  }
  elseif ($1 == Warren) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Warren $+ $ct $+ , um cabelereiro.
    var %x = $dados($nick,Clock,Haircut) | if (%x) { if ($calc($dados($nick,Info,Online) - %x) < 18000) { msg =$nick $chr(160) $cc $+ Warren $ct $+ - Que tal você voltar outra hora? Estou cheio de clientes neste momento. | return } }
    var %pk = $dados($nick,Team,1)
    if ($dados($nick,%pk,Level) == 100) { msg =$nick $chr(160) $cc $+ Warren $ct $+ - Não adianta eu trabalhar com seu pokémon $cc $+ %pk $+ $ct $+ , ele não poderá mais se animar com meus maravilhosos cortes de cabelo. | return }
    if ($gettok($dados($nick,%pk,Loyalty),1,58) == 255) { msg =$nick $chr(160) $cc $+ Warren $ct $+ - Hm, o visual do seu pokémon $cc $+ %pk $ct $+ já está bem interessante! Que tal outro pokémon? | return }
    var %price = 7000 | if ($findtok(Saturday:Wednesday,$day,0,58)) { var %price = $int($calc(%price * 0.5)) }
    msg =$nick $chr(160) $cc $+ Warren $ct $+ - Oh, deseja mudar o visual de seu pokémon $cc $+ %pk $+ $ct $+ ? Cobrarei apenas $cc $+ $chr(36) $+ $getmoney(%price) $+ $ct $+ ! Hahaha, ele ficará magnífico!
    msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar.
    set %confirm. [ $+ [ $nick ] ] CUT $+ : $+ %price
  }
  elseif ($1 == Kaomi) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Kaomi $+ $ct $+ , uma criadora de pokémon.
    if ($earl.count($nick) == 17) { msg =$nick $chr(160) $cc $+ Kaomi $ct $+ - A melhor maneira de desenvolver o relacionamento com seu pokémon é trabalhando em equipe com o mesmo. Lembre-se também de evitar a fadiga! Pokémon ficam intediados se vencerem sempre o mesmo adversário. }
    else { msg =$nick $chr(160) $cc $+ Kaomi $ct $+ - Adorei o trabalho de $cc $+ Warren $ct $+ na minha $cc $+ Clefairy $+ $ct $+ ! Já não posso dizer o mesmo de $cc $+ Snubbull $+ $ct $+ ... Bem, todos erram as vezes, então tudo bem, não fiquei chateada. }
  }
  elseif ($1 == Nicole) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Nicole $+ $ct $+ , uma criadora de pokémon.
    msg =$nick $chr(160) $cc $+ Nicole $ct $+ - Bem vindo ao centro de criação, ou $cc $+ Daycare Center $+ $ct $+ . Neste lugar você poderá efetuar o cruzamento de seus pokémon e ganhar $cc $+ Eggs $+ $ct $+ , ou ovos de pokémon. Digite ' $+ $cc $+ .Daycare $+ $ct $+ ' para mais informações de como fazer um cruzamento.
  }
  elseif ($1 == Mymo) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Mymo $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Mymo $ct $+ - Obtive um dia desses um bebê de $cc $+ Mr.mime $ct $+ com o golpe Mimic! Foi uma surpresa, não sabia que ele podia aprender isso, muito menos por cruzamentos! Hahaha, já tenho uma ótima estratégia!
    if ($earl.count($nick) == 17) { msg =$nick $chr(160) $cc $+ Mymo $ct $+ - É verdade que existe um pokémon pré-evoluido do $cc $+ Mr.mime $+ $ct $+ ?! Definitivamente será meu! }
  }
  elseif ($1 == Hector) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Hector $+ $ct $+ , um treinador pokémon.
    if ($start($nick)) {
      if (!$item($nick,Coin Case).qnt) {
        msg =$nick $chr(160) $cc $+ Hector $ct $+ - Droga! Fiquei sem moedas! Quer saber de uma coisa? Pode ficar com esta droga de $cc $+ Coin Case $+ $ct $+ !
        msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Coin Case $+ $ct $+ !
        item.add $nick Coin Case
      }
      else { msg =$nick $chr(160) $cc $+ Hector $ct $+ - Não tem quem me faça jogar de novo nesses jogos de azar! Não vou perder mais meu tempo... }
    }
    else { msg =$nick $chr(160) $cc $+ Hector $ct $+ - Passei aqui só por curiosidade e acabei me viciando totalmente! Estou até pensando em desistir da liga de $cc $+ Johto $+ $ct $+ ... Ouvi dizer que é o maior desafio existente em todo o mundo! }
  }
  elseif ($1 == Foster) {
    if ($dados($nick,Quests,Foster)) {
      msg =$nick $chr(160) $cc $+ Foster $ct $+ - Bem, acho que não vou mais jogar hoje. Felizmente eu sei a hora de parar, mas tem gente aqui simplesmente viciada!
    }
    else {
      msg =$nick $chr(160) $cc $+ Foster $ct $+ - Yahoo! Acho que estou com sorte! Estou cheio de moedas hoje, tá dificil carregá-las...
      if ($item($nick,Coin Case).qnt) {
        var %c = $dados($nick,Info,Coin), %r = $calc(%c + 50) | if (%r > 9999) { var %r = 9999 } | writeini pkp\cadastros\ $+ $nick $+ .ini Info Coin %r
        msg =$nick $chr(160) $cc $+ Foster $ct $+ - Tome estas moedas! Espero que você também tenha sorte! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Foster Ok
      }
      else { msg =$nick $chr(160) $cc $+ Foster $ct $+ - Hm, quando conseguir um $cc $+ Coin Case $ct $+ eu vou dar-te algumas moedas, ok? }
    }
  }
  elseif ($1 == Kenny) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Kenny $+ $ct $+ , o balconista do cassino.
    if ($item($nick,Coin Case).qnt) {
      msg =$nick $chr(160) $cc $+ Kenny $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Cada moeda custa $cc $+ $chr(36) $+ $getmoney($readini(pkp\status.ini,Active,Coin)) $+ $ct $+ . Você deseja trocar seu dinheiro por moedas?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] COIN:Kenny:1
    }
    else { msg =$nick $chr(160) $cc $+ Kenny $ct $+ - Não posso ajudá-lo... Você não pode comprar moedas se não tiver um $cc $+ Coin Case $+ $ct $+ ... }
  }
  elseif ($1 == Lisa) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lisa $+ $ct $+ , a dona da floricultura.
    if ($item($nick,Wailmer Pail).qnt) { msg =$nick $chr(160) $cc $+ Lisa $ct $+ - Nem tudo é o que parece. Por exemplo, o pokémon $cc $+ Sudowoodo $ct $+ parece ser uma árvore, mas na verdade é um pokémon que odeia água... A natureza é realmente perfeita. }
    else {
      if ($dados($nick,Quests,Pail)) {
        if ($badge($nick,Plain Badge)) { remini pkp\cadastros\ $+ $Nick $+ .ini Quests Pail | item.add $nick Wailmer Pail | msg =$nick $chr(160) $cc $+ Nancy $ct $+ - Ei, você teve problemas com um arbusto estranho? Ah, fique com este $cc $+ Wailmer Pail $ct $+ e use nele. Tenho certeza que você terá uma surpresa incrível. }
        else { .msg =$nick $chr(160) $cc $+ Lisa $ct $+ - Está com problemas com uma árvore no caminho? Hm, não me lembro de nenhuma... Eu darei uma olhada. Enquanto isso, por que não batalha com a líder da cidade? }
      }
      else { .msg =$nick $chr(160) $cc $+ Lisa $ct $+ - Cuidar das plantas é uma atividade muito relaxante, principalmente nesta cidade, onde tudo é tão movimentado e cheio de stress. Precisamos fazer algo pela natureza, sabia? Faça em sua casa também, plante uma semente para que uma nova árvore tranquilize a vida de seus netos. }
    }
  }
  elseif ($1 == Grace) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Grace $+ $ct $+ , a radialista da $cc $+ Radio Tower $+ $ct $+ .
    if ($dados($nick,Quests,Rocket5) == No) { msg =$nick $chr(160) $cc $+ Grace $ct $+ - Ahh... O que estes trapaceiros querem aqui na torre de rádio?! Não se pode mais trabalhar em paz nesta cidade! }
    else {
      if ($dados($nick,Quests,Rocket5) == Ok) && (!$item($nick,Radio).qnt) { msg =$nick $chr(160) $cc $+ Grace $ct $+ - Muito obrigada por tudo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Não sei o que poderia acontecer se aqueles trapaceiros continuassem com o plano deles. Ei, você já sintonizou a rádio de Goldenrod City? Então fique com este $cc $+ Radio $+ $ct $+ . | item.add $nick Radio | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Radio $+ $ct $+ ! | return }
      if ($item($nick,Radio).qnt) {
        if ($calc($dados($nick,Info,Online) - $dados($nick,Clock,Radio)) < 21600) { msg =$nick $chr(160) $cc $+ Grace $ct $+ - Não é possível dar mais de uma entrevista em menos de $cc $+ seis $ct $+ horas online... | return }
        var %opt = News:Trainer:Tale
        var %x = 1 | while ($gettok(%opt,%x,58)) { var %n = $gettok(%opt,%x,58) | if ($calc($ctime($date) - $readini(pkp\radio.ini,Time,%n)) > 86400) { var %r = $addtok(%r,%n,58) } | inc %x }
        if (%r) {
          var %x = $randtok(%opt,58), %x = $gettok(%x,1,58)
          if (%x == Tale) { msg =$nick $chr(160) $cc $+ Grace $ct $+ - "E aqui estamos em mais um 'Dia de Treinador' com nosso amigo $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Certamente ele tem uma brilhante história para nos contar!" }
          elseif (%x == News) { msg =$nick $chr(160) $cc $+ Grace $ct $+ - "Nosso informante mais intrigante acaba de nos conceder uma entrevista: $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Vamos, não seja tímido! Pode nos contar a novidade!" }
          else { msg =$nick $chr(160) $cc $+ Grace $ct $+ - "Nosso aspirante a mestre pokémon, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , nos dará uma entrevista! Diga-nos, qual o segredo do sucesso? Dê alguma dica para os treinadores iniciantes de todas as partes do mundo e que o admiram!" }
          writeini pkp\cadastros\ $+ $nick $+ .ini Clock Radio $dados($nick,Info,Online)
          writeini pkp\radio.ini TIME %x $ctime($date) | writeini pkp\radio.ini RADIO %x $dados($nick,Info,Nick) $+ :...
          msg =$nick $ct $+ Digite o que você deseja comentar nesta entrevista. | set %radio. [ $+ [ $nick ] ] %x
        }
        else { msg =$nick $chr(160) $cc $+ Grace $ct $+ - Não estou mais gravando nada agora, volte mais tarde se quiser me dar alguma entrevista, ok? }
      }
      else { msg =$nick $chr(160) $cc $+ Grace $ct $+ - Olá, estou no meio de uma transmissão agora, não posso falar... Depois, ok? }
    }
  }
  elseif ($1 == Irene) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Irene $+ $ct $+ , a recepcionista da $cc $+ Radio Tower $+ $ct $+ .
    if ($dados($nick,Quests,Rocket5) == No) { msg =$nick $chr(160) $cc $+ Irene $ct $+ - Isto é terrível... O que a equipe $cc $+ Rocket $ct $+ está querendo aqui?! }
    else { msg =$nick $chr(160) $cc $+ Irene $ct $+ - Bem vindo à $cc $+ Radio Tower $+ $ct $+ ! Não faça muito barulho, $cc $+ Grace $+ $ct $+ , a radialista, pode estar gravando uma entrevista neste momento... }
  }
  elseif ($1 == Rocket) && ($dados($nick,Quests,Rocket5) == No) {
    msg =$nick $ct $+ Você encontrou membros da equipe $cc $+ Rocket $ct $+ na $cc $+ Radio Tower $+ $ct $+ !
    msg =$nick $ct $+ Se deseja batalhar contra eles, digite ' $+ $cc $+ .Sim $+ $ct $+ ' ou ' $+ $cc $+ .nao $+ $ct $+ ' para fugir. | set %confirm. [ $+ [ $nick ] ] RKT:6
  }
  elseif ($1 == Whitney) {
    if ($badge($nick,Plain Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Whitney $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Whitney $ct $+ - Nossa batalha foi incrível! Você tem muito talento, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , e certamente chegará muito longe em sua jornada. Enquanto isso, tentarei aprender um pouco mais e ficar mais forte ainda, para em caso de revanche, isto não voltar a acontecer!
      if (!$dados($nick,Quests,Milk)) { msg =$nick $chr(160) $cc $+ Whitney $ct $+ - Meu tio possui uma fazenda de $cc $+ Miltank $ct $+ em $cc $+ Olivine City $+ $ct $+ . Diga que me conhece, e ele será gentil com você. Sabe, ele não gosta de estranhos em sua fazenda... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Milk No }
    }
    else { .msg =$nick $cc $+ Whitney $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Ilex_Forest {
  if ($1 == Alex) && ($start($nick)) && (!$item($nick,HM01).qnt) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Alex $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Alex $ct $+ - Nossa, acabei de encontrar meu $cc $+ Farfetch'd $+ $ct $+ . Às vezes ele sai sozinho para cortar lenha e me deixa muito preocupado. Você deseja atravessar a floresta? Talvez seja necessário cortar algum arbusto no caminho com $cc $+ Cut $+ $ct $+ .
    msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ HM01 $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Alex $ct $+ - Tudo o que seu pokémon precisa é aprender o ataque e ter a insígnea de $cc $+ Azalea Town $+ $ct $+ . A propósito, voltarei à minha casa agora. Até!
  }
  elseif ($findtok(templo:temple:santuario:santuário:oratorio:oratório,$1,0,58)) {
    msg =$nick $ct $+ Você está vendo o $cc $+ santuário $ct $+ erguido em $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
    msg =$nick $ct $+ Há uma escritura nele: "Para o protetor das florestas: proteja-a ao longo das eras."
    if ($dados($nick,Quests,Kurt) == 5) && ($item($nick,GS Ball).qnt) {
      msg =$nick $cc $+ GS Ball $ct $+ está reagindo ao santuário...
      var %pk = Celebi, %lv = 30
      if ($rini(cadastros,$nick,%pk,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
      if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ %pk $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests %pk Ok | msg =$nick $ct $+ Pokémon $cc $+ %pk $ct $+ foi libertado da $cc $+ GS Ball $+ $ct $+ ! | item.rem $nick GS Ball
      .echo $addpoke($nick,%pk,%lv,%lv $+ : $+ %l).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,%pk)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 5 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Azalea_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a $cc $+ $dados($nick,Info,Locate) $+ $ct $+ ! Por muito tempo, não tivemos mais ginásio na cidade devido ao fracasso do último ao dominar pokémon insetos. No entanto, um novo membro veio ocupar o lugar do antigo líder e provou exatamente contrário: nunca subestime o poder de um pokémon inseto!
  }
  elseif ($1 == Alex) && ($item($nick,HM01).qnt) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Alex $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Alex $ct $+ - Para atravessar a $cc $+ Ilex Forest $ct $+ faça como meus pais me ensinaram: use $cc $+ Cut $ct $+ nos arbustos. Basta ensinar a técnica ao seu pokémon e ele poderá atravessar o novo caminho.
  }
  elseif ($1 == Jonathan) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Jonathan $+ $ct $+ , um habitante da cidade.
    if ($item($nick,HM01).qnt) { msg =$nick $chr(160) $cc $+ Jonathan $ct $+ - Meu filho $cc $+ Alex $ct $+ me ajuda a pegar lenha e produzir $cc $+ Charcoal $+ $ct $+ , que aumenta o poder de golpes do tipo Fire. | if (!$dados($nick,Quests,Charcoal)) { msg =$nick $chr(160) $cc $+ Jonathan $ct $+ - Experimente você mesmo, pode ficar com este $cc $+ Charcoal $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Charcoal Ok | item.add $nick Charcoal } }
    else { msg =$nick $chr(160) $cc $+ Alex $ct $+ - Huh? Pensei que fosse meu filho $cc $+ Alex $+ $ct $+ . Algo deve tê-lo acontecido em $cc $+ Ilex Forest $+ $ct $+ , ele está demorando muito. }
  }
  elseif ($1 == Kurt) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Kurt $+ $ct $+ , um especialista.
    var %x = $dados($nick,Quests,Kurt)
    if (%x) {
      if (%x == 1) {
        if (($start($nick)) && ($dados($nick,Quests,League))) || ($dados($nick,Johto,League)) { .msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Oh, então você é o novo campeão da liga de $cc $+ Johto $+ $ct $+ ! Há tempos eu não ouvia falar em treinadores que conseguiam derrotá-la. Parabéns, parabéns! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Kurt 2 }
        else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Já ouviu falar no santúario existente em $cc $+ Ilex Forest $+ $ct $+ ? É estranho, não consigo dizer quando ele foi construído, mas parece que está lá há bastante tempo. Dizem que é uma espécie de oratório para um pokémon, protetor das florestas. }
      }
      elseif (%x == 2) {
        if ($findtok($dados($nick,Kanto,Visited),Heavy Den,0,58)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Kurt 3 | msg =$nick $chr(160) $cc $+ Kurt $ct $+ - $cc $+ Heavy Den $+ $ct $+ ? Hm, agora que você mencionou este lugar, lembro-me que encontraram algo lá... }
        else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Escavações em $cc $+ Kanto $ct $+ descobriram um lugar onde habitavam pokémon que já são considerados extintos atualmente. Está em algum lugar próximo a $cc $+ Cerulean City $+ $ct $+ . | if (!$dados($nick,Quests,HD)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests HD Ok } }
      }
      elseif (%x == 3) {
        if ($item($nick,GS Ball).qnt) {
          msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Oh, você trouxe-a até mim! Que bom, finalmente poderei estudar a $cc $+ GS Ball $+ $ct $+ .
          msg =$nick $ct $+ Você entregou a $cc $+ GS Ball $ct $+ ao $cc $+ Kurt $+ $ct $+ .
          item.rem $nick GS Ball | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Kurt 4 | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Kurt $dados($nick,Info,Online)
        }
        else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Fui informado da descoberta de um tipo único de pokébola chamada $cc $+ GS Ball $+ $ct $+ . Ela tem uma coloração dourada e prateada, e as letras GS cravadas em seu exterior. Ninguém conseguiu descobrir como ela funciona, pois nenhum meio de tentar abrí-la teve sucesso. Disseram-me que enviariam-na para eu poder examiná-la, mas até agora nada. Espero que em $cc $+ Kanto $ct $+ já estejam tomando providências. }
      }
      elseif (%x == 4) {
        var %r = $calc($dados($nick,Info,Online) - $dados($nick,Clock,Kurt)), %t = 604800
        if (%r < %t) {
          var %p = $calc(%r / %t * 100)
          if (%p < 50) { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Ainda estou trabalhando duro para tentar desvendar alguma coisa neste artefato. Paciência, meu caro, paciência... }
          elseif (%p < 80) { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Estou conseguindo bons progressos e já estou sentindo que aproximo-me de descobrir alguma coisa. Deseje-me sorte! }
          elseif (%p < 95) { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Ah, o quebra cabeça está quase pronto, só preciso ter certeza de algumas peças que estão faltando. Em breve terei boas notícias! }
          else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Finalmente estou próximo de terminar meu trabalho aqui. Aguarde pacientemente mais algum tempo até que eu tenha certeza do que estou prestes a descobrir. Posso adiantar que o que esta $cc $+ GS Ball $ct $+ reserva é algo grandioso... Você entenderá posteriormente. }
        }
        else {
          msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Ah! $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Adivinhe, consegui finalmente entender como a $cc $+ GS Ball $ct $+ funciona! Lembra-se da existência de um santuário em $cc $+ Ilex Forest $+ $ct $+ ? Pois bem, este artefato parece ser a chave. Bem, fique com ela, e quando estiver pronto, procure o santuário.
          msg =$nick $ct $+ Você recebeu novamente o item $cc $+ GS Ball $+ $ct $+ ! | item.add $nick GS Ball | remini pkp\cadastros\ $+ $nick $+ .ini Clock Kurt | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Kurt 5
        }
      }
      else {
        if ($item($nick,GS Ball).qnt) { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Lembra-se da existência de um santuário em $cc $+ Ilex Forest $+ $ct $+ ? Pois bem, a $cc $+ GS Ball $ct $+ parece ser a chave. Quando estiver pronto, procure o santuário. }
        else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Então, o protetor das florestas apareceu diante de você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ? É fantástico a ligação entre este artefato e um pokémon tão raro, talvez nunca aparecido para nenhum outro treinador. Boa sorte em sua jornada, vejo que carrega consigo uma sorte que o levará até o topo do mundo! }
      }
    }
    else {
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Então, você está começando a sua jornada? Já tentou derrotar o líder da cidade? Bem, desejo muito boa sorte. Eu estudo as poké bolas e acabei me tornando um especialista nelas, muito famoso. É muito bom quando reconhecem seu trabalho internacionalmente, não é mesmo? }
      else { msg =$nick $chr(160) $cc $+ Kurt $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Ouvi muito falar de sua terra natal, $cc $+ $dados($nick,Info,Start) $+ $ct $+ . Eu estudo as diferentes poké bolas e acabei me tornando um especialista nelas, de renome internacional. É bom quando reconhecem o seu trabalho, não é mesmo? }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Kurt 1
    }
  }
  elseif ($1 == Vance) { msg =$nick $ct $+ Você encontra-se com $cc $+ Vance $+ $ct $+ , um treinador pokémon. | msg =$nick $chr(160) $cc $+ Vance $ct $+ - Droga! Eu pensei que meu pokémon de fogo fosse suficientemente capaz de derrotar o líder desta cidade, mas me arrependi amargamente agora. Não esperava por isso! }
  elseif ($1 == Tylor) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Tylor $+ $ct $+ , um pescador.
    if ($start($nick)) {
      if (!$item($nick,Old Rod).qnt) { msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Você disse que gosta de pescar? Mas como? Não vejo nenhuma vara de pescar em sua mochila... | return }
      if ($item($nick,Good Rod).qnt) {
        if ($item($nick,Super Rod).qnt) { msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Já encontrou quantos pokémon diferentes usando sua vara de pescar? Eu já encontrei doze... Verdade! }
        else { msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Eu já sei quem poderá ajudá-lo com uma $cc $+ Super Rod $+ $ct $+ . Em $cc $+ Cianwood City $+ $ct $+ , há um pescador simpático chamado $cc $+ Morgan $+ $ct $+ . Você deveria falar com ele. }
      }
      else { msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Ah, que pena! Você usa ainda uma $cc $+ Old Rod $+ $ct $+ ! Nossa, não fale mais nada, leve esta $cc $+ Good Rod $ct $+ e seja feliz! | item.add $nick Good Rod | msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Diferentemente da sua antiga vara de pescar, esta nova poderá alcançar lugares ainda mais fundos e, portanto, mais pokémon! }
    }
    else { msg =$nick $chr(160) $cc $+ Tylor $ct $+ - Modéstia parte, eu pesco muito bem. Sabe, outro dia eu peguei um $cc $+ Remoraid $+ $ct $+ ! Hahaha, incrível! }
  }
  elseif ($1 == Bugsy) {
    if ($badge($nick,Hive Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Bugsy $+ $ct $+ , líder de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Bugsy $ct $+ - Existe uma passagem em $cc $+ Ilex Forest $ct $+ que o levará até $cc $+ Goldenrod City $+ $ct $+ . Mas será preciso cortar os arbustos do caminho... }
      else { msg =$nick $chr(160) $cc $+ Bugsy $ct $+ - Eu ainda não acredito que você conseguiu me vencer. Será que foi um golpe de sorte? Heh, nunca saberemos. Boa sorte! }
    }
    else { msg =$nick $cc $+ Bugsy $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Violet_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a $cc $+ $dados($nick,Info,Locate) $+ $ct $+ . Se você ver um vulto nos céus da cidade, não se assuste, é apenas o líder rondando para proteger os habitantes de invasores mal-intensionados. Ah, outra coisa, não diga na frente dele que pokémon voadores são fracos contra elétricos...
  }
  elseif ($1 == Zac) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Zac $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Zac $ct $+ - Deuses! Para que raios eu inventei de falar que os pokémon do líder eram fracos contra golpes elétricos...! Eu fui totalmente derrotado na batalha, isso me deixou incrivelmente decepcionado. Cuide-se, hein!
  }
  elseif ($1 == Anya) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Anya $+ $ct $+ , uma habitante da cidade.
    msg =$nick $chr(160) $cc $+ Anya $ct $+ - Aqui na cidade há uma torre onde o mastro central que a sustenta balança constantemente, como um $cc $+ Bellsprout $+ $ct $+ . É estranho, e filosófico até, se você parar para pensar.
  }
  elseif ($1 == Beck) {
    if ($start($nick)) && (!$item($nick,HM05).qnt) { msg =$nick $cc $+ Beck $ct $+ está agora na $cc $+ Sprout Tower $+ $ct $+ . }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Beck $+ $ct $+ , um monge.
      msg =$nick $chr(160) $cc $+ Beck $ct $+ - A $cc $+ Sprout Tower $ct $+ nos ensina algo muito importante, para as nossas vidas. Nos faz perceber que, quando o peso dos problemas parece ser mais forte e tudo parece estar prestes a desabar, é possível reerguer-se e sustentá-la, mesmo quando não estamos totalmente firmes.
    }
  }
  elseif ($1 == Rocket) && ($start($nick)) && (!$item($nick,HM05).qnt) {
    msg =$nick $ct $+ Alguns membros da equipe $cc $+ Rocket $ct $+ estão na $cc $+ Sprout Tower $+ $ct $+ , neste momento.
  }
  elseif ($1 == Mazon) && ($dados($nick,Quests,Mazon)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Mazon $+ $ct $+ , um velho historiador.
    msg =$nick $chr(160) $cc $+ Mazon $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Graças à sua colaboração, estou conseguindo decifrar muitas mensagens dos $cc $+ Unown $+ $ct $+ . Estou muito contente, não tenho dúvidas de que meus trabalhos serão reconhecidos pela comunidade científica!
  }
  elseif ($1 == Silver) && ($dados($nick,Quests,Silver) == 1) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Silver $+ $ct $+ .
    var %item = $iif($dados($nick,Quests,Rocket6) == 3,Silver,Rainbow) Feather, %oitem = $iif($dados($nick,Quests,Rocket6) == 3,Rainbow,Silver) Feather
    if ($item($nick,%item).qnt) {
      msg =$nick $chr(160) $cc $+ Silver $ct $+ - E aí? Pensou sobre nossa aposta? Batalharemos apenas uma vez, numa batalha de três contra três pokémon. Se você perder, perderá também seu $cc $+ %item $+ $ct $+ . O mesmo vale para mim. O que você me diz?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar.
      set %confirm. [ $+ [ $nick ] ] SVR: $+ %oitem
    }
    else {
      msg =$nick $chr(160) $cc $+ Silver $ct $+ - Estava pensando em apostar minha $cc $+ %oitem $ct $+ em troca de uma $cc $+ %item $+ $ct $+ ... Bem, já que não é possível, preciso capturar um pokémon...
      if (%oitem == Silver Feather) { var %team = 1434 } | else { var %team = 1435 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Silver %team
    }
  }
  elseif ($1 == Falkner) {
    if ($badge($nick,Zephyr Badge)) {
      msg =$nick $chr(160) $cc $+ Falkner $ct $+ - Odeio quando treinadores julgam vários pokémon pelo tipo deles, como acontece com os pokémon voadores. Hahaha, mas para esses treinadores eu tenho uma surpresa! E que eles aprendam a não subestimar mais o poder de um voador!
    }
    else { msg =$nick $cc $+ Falkner $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Water_Path { .msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Whirl_Islands { .msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Mt_Mortar { .msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Cherrygrove_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, treinador! É uma parada para descansar? Sente-se e relaxe um pouco! Há um longo dia pela frente.
  }
  elseif ($1 == Thomas) && ($start($nick)) {
    if ($dados($nick,Clock,Thomas)) && ($calc($dados($nick,Info,Online) - $dados($nick,Clock,Thomas)) < 10800) { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - É bom saber que poderemos negociar sempre, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Que tal outra hora? | return }
    if ($totalpokes($nick) > 1) {
      msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Nossa! Seus pokémon estão incríveis! Você gostaria de vender algum deles para mim? | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar e $cc $+ .nao $ct $+ para rejeitar.
      set %confirm. [ $+ [ $nick ] ] THM | return
    }
    else { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Quando você tiver vários pokémon e estiver disposto a vender algum, não hesite em me procurar! | return }
  }
  elseif ($1 == Clarice) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Clarice $+ $ct $+ , uma treinadora pokémon.
    msg =$nick $chr(160) $cc $+ Clarice $ct $+ - Que chatisse! Começei minha jornada ontem e ao chegar aqui percebi que não havia loja na cidade. Preguiça de ir até $cc $+ Violet City $+ $ct $+ ... Ahn...
  }
  elseif ($1 == Luke) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Luke $+ $ct $+ , um habitante da cidade.
    msg =$nick $chr(160) $cc $+ Luke $ct $+ - Ontem eu vi um $cc $+ Ledyba $ct $+ voando entre as árvores. Devem ser raros, eu nunca havia visto um desses por aqui.
  }
  else { msg =$nick Nada foi encontrado. }
}
alias c.search.New_Bark_Town {
  if ($findtok(Elm:Professor:Prof Elm,$1,0,58)) { msg =$nick $ct $+ Acho que $cc $+ Prof Elm $ct $+ está no laboratório. | return }
  elseif ($findtok(Mom:Mãe:Mamãe:Mae:Mamae:Mommy,$1,0,58)) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com sua mãe.
    var %r = $dados($nick,Info,Region) | if (!$dados($nick,%r,Badges).n) {
      var %x = $rini(cadastros,$nick,Quests,Mom) | if (!%x) { var %x = 1 }
      if (%x == 1) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Filho, tem alguma dúvida sobre como batalhar? Eu vou tentar te explicar, há dois métodos: você cria uma batalha e espera por outro treinador, ou então você entra numa batalha criada. Para criar uma batalha, digite ' $+ $cc $+ .Criar <pokémon> $+ $ct $+ ', substituindo $cc $+ <pokémon> $ct $+ pelo nome do seu pokémon. A seguir, aguarde pelo seu adversário. Agora, se quiser entrar numa batalha de outro treinador, digite ' $+ $cc $+ .Entrar <ID> <pokémon> $+ $ct $+ ', onde $cc $+ <ID> $ct $+ é o ID da batalha respectiva e $cc $+ <pokémon> $ct $+ o nome do pokémon que você usará. Ah, para listar as batalhas criadas e seus IDs, digite ' $+ $cc $+ .Listar $+ $ct $+ '. }
      elseif (%x == 2) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Para usar algum item, use sempre o comando ' $+ $cc $+ .Item Use <item> $+ $ct $+ ', onde $cc $+ <item> $ct $+ é o item selecionado. Para ver mais funções desse comando, digite ' $+ $cc $+ .Item $+ $ct $+ '. Para comprar novos itens, como $cc $+ Poke  Ball $+ $ct $+ , você precisará visitar uma loja, usando o comando ' $+ $cc $+ .Loja $+ $ct $+ '. Aqui em $cc $+ Pallet $ct $+ não há loja, mas você encontrará alguma nas próximas cidades. Alias, sabe como avançar entre cidades? Utilize o comando ' $+ $cc $+ .Cidade Goto $+ $ct $+ ' para saber quais cidades estão disponíveis e, a seguir, digite ' $+ $cc $+ .Cidade Goto <localização> $+ $ct $+ ', substituindo-o pelo nome da cidade. }
      elseif (%x == 3) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Para ver seus dados gerais, digite ' $+ $cc $+ .Dados $+ $ct $+ '. Para ver dados de outros treinadores, use o comando ' $+ $cc $+ .Dados <nick> $+ $ct $+ '. Ah, você também pode ver informações detalhadas sobre seu pokémon usando o comando ' $+ $cc $+ .Dados <pokémon> $+ $ct $+ ', ou ainda de outros treinadores (se possível), ' $+ $cc $+ .Dados <nick> <pokémon> $+ $ct $+ '. }
      elseif (%x == 4) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Querido, você pode personalizar seu cadastro, sabia? Utilizando o comando ' $+ $cc $+ .Perfil $+ $ct $+ ' você edita seu cadastro, e usando o comando ' $+ $cc $+ .Skin $+ $ct $+ ' você muda as cores do $cc $+ $me $+ $ct $+ ! Muito interessante, não? }
      else { msg =$nick $chr(160) $cc $+ Mom $ct $+ - $cc $+ $nick $+ $ct $+ , por que não dá uma olhada no ' $+ $cc $+ .Ajuda $+ $ct $+ '? Utilizando esse comando, você verá todos os comandos disponíveis! Se tiver alguma dúvida de como usá-los, lembre-se: informações contidas entre $cc $+ < $ct $+ e $cc $+ > $ct $+ são campos obrigatórios, substitua pelo termo correspondente; se tiverem contidas entre $cc $+ ( $ct $+ e $cc $+ ) $+ $ct $+ , serão campos opcionais, mas em alguns casos obrigatórios. Outros treinadores poderão ajudá-lo se ainda tiver dúvidas, filho. Boa sorte! | var %x = 0 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mom $calc(%x + 1) | return
    }
    else {
      if ($dados($nick,Quests,League)) {
        if ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Mom $ct $+ - Divirta-se, filho!
          msg =$nick $chr(160) $cc $+ Mom $ct $+ - Mamãe sentirá saudades...
        }
        else {
          msg =$nick $chr(160) $cc $+ Mom $ct $+ - Meu filho você conseguiu derrotar a liga pokémon! Estou muito feliz, você conseguiu realizar seu sonho!
          msg =$nick $chr(160) $cc $+ Mom $ct $+ - Eu tinha feito uma poupança, mas achei melhor gastar o dinheiro comprando essa passagem de navio para $cc $+ Hoenn $+ $ct $+ ! Parabéns filho, receba este presente!
          msg =$nick $ct $+ Parabéns, você ganhou o $cc $+ Silver Ticket $+ $ct $+ ! | item.add $nick Silver Ticket
        }
      }
      else {
        msg =$nick $chr(160) $cc $+ Mom $ct $+ - Filho, como vai sua jornada? Conseguiu capturar muitos pokémon?
        msg =$nick $chr(160) $cc $+ Mom $ct $+ - Não se esqueça de visitar a mamãe sempre!
      }
    }
    return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}


alias c.search.SS_Tidal {
  if (!$dados($nick,Quests,SSTidal)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal 0:0:0:0:0:0:0:0:0:0 }
  if ($findtok(Prof Birch:Birch:Professor,$1-,0,58)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Prof Birch $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),1,58)) { msg =$nick $chr(160) $cc $+ Prof Birch $ct $+ - Só estou mesmo à passeio, não posso sair de $cc $+ Hoenn $ct $+ por muito tempo. Estou muito atarefado observando o habitat dos pokémon, mas estarei torçendo por você! }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Prof Birch $ct $+ - Então, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , está indo para $dados($nick,Info,Dest) $+ ? Sabe, eu não esperava que a liga de Johto fosse tão dura... Precisar de 24 insígneas para ingressá-la é uma tarefa muito difícil mesmo, mas estou certo que você conseguirá. Nos veremos em $cc $+ Hoenn $+ $ct $+ ! }
      elseif ($dados($nick,Info,Start) == Kanto) {
        msg =$nick $chr(160) $cc $+ Prof Birch $ct $+ - Nossa, $cc $+ Prof Oak $ct $+ que se cuide! Afinal, seu discípulo está se saindo melhor do que todos esperavam! Hahahaha, você tem muito talento, garoto. Estou torçendo por você!
        item.add $nick Leftovers | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Leftovers $+ $ct $+ !
      }
      else { msg =$nick $chr(160) $cc $+ Prof Birch $ct $+ - Que orgulho poder prestigiá-lo! É muito bom saber que você chegou tão longe, certamente fará um enorme sucesso! Parabéns, mas lembre-se de não subestimar seus adversários... Ouvi rumores de que a liga de $cc $+ Johto $ct $+ é muito difícil de ser alcançada. Então, mais uma vez, boa sorte! }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,1,58)
    }
  }
  elseif ($1 == Wallace) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Wallace $+ $ct $+ , membro de Elite Four de $cc $+ Hoenn $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),2,58)) { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Eu não pretendo ir a $cc $+ $dados($nick,Info,Dest) $ct $+ realmente, estou apenas marcando presença no passeio de inauguração. }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Hahaha, ainda não nos conhecemos, suponho. Sou $cc $+ Wallace $+ $ct $+ , e teremos uma batalha futuramente na liga pokémon de $cc $+ Hoenn $+ $ct $+ . Estou ancioso para ver suas habilidades, ouvi dizer que conseguiu pegar todas as insígneas de $cc $+ Johto $+ $ct $+ ! Parabéns, mas, até lá, não batalharemos. Hahaha, cuide-se! }
      elseif ($dados($nick,Info,Start) == Kanto) { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Nossa, você já está partindo para mais uma competição em outro continente? Hahaha, isso é que é energia! Você realmente me impressiona, que tal uma nova batalha, será rápida, só para não perder o ritmo... | battle.npc $nick 1136 }
      else { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Ah, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , bom vê-lo de novo! E então, pretende fazer grandiosas realizações em $cc $+ $dados($nick,Info,Dest) $ct $+ assim como fez em Hoenn? Hahaha, isso vai deixar muitos de queixo caído! Que tal uma rápida batalha, só para não perder o ritmo... | battle.npc $nick 1136 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,2,58)
    }
  }
  elseif ($1 == Sidney) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Sidney $+ $ct $+ , membro de Elite Four de $cc $+ Hoenn $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),3,58)) { msg =$nick $chr(160) $cc $+ Sidney $ct $+ - Quem dera eu poder passar uns dias em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ ... Mas ser membro da liga pokémon exige muito do nosso tempo! }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Sidney $ct $+ - Já ouviu falar de mim, garoto? Sou $cc $+ Sidney $+ $ct $+ , e nos encontraremos depois na liga pokémon de $cc $+ Hoenn $+ $ct $+ . Posso te contar um segredo? Há uma montanha em $cc $+ Johto $ct $+ protegida por autoridades e cheio de espécies diferentes de pokémon. Quando finalmente derrotar a liga de $cc $+ Johto $+ $ct $+ , você finalmente poderá visitá-la. }
      elseif ($dados($nick,Info,Start) == Kanto) { msg =$nick $chr(160) $cc $+ Sidney $ct $+ - Quanta celebridade aqui presente! Olha só como você ficou famoso em tão pouco tempo, tem mesmo muito talento! Hahaha, fiquei com vontade de batalhar uma outra vez, que acha disso? | battle.npc $nick 1137 }
      else { msg =$nick $chr(160) $cc $+ Sidney $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Estava mesmo falando de você! Não creio que esteja tentando participar de mais um campeonato... Chega, precisamos de uma nova batalha! | battle.npc $nick 1137 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,3,58)
    }
  }
  elseif ($1 == Phoebe) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Phoebe $+ $ct $+ , membro de Elite Four de $cc $+ Hoenn $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),4,58)) { msg =$nick $chr(160) $cc $+ Phoebe $ct $+ - Estou adorando a viagem de inauguração, e você? }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Phoebe $ct $+ - Muito prazer em conhecê-lo. Sei que está indo para $cc $+ $dados($nick,Info,Dest) $+ $ct $+ , certo? Quando chegar em Hoenn, nos encontraremos na liga pokémon. Então se prepare para a batalha! }
      else { msg =$nick $chr(160) $cc $+ Phoebe $ct $+ - Bom revê-lo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Soube que está partindo para uma nova competição... Bem, estarei torçendo pelo seu sucesso! | item.add $nick Spell Tag | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Spell Tag $+ $ct $+ ! }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,4,58)
    }
  }
  elseif ($1 == Roxanne) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Roxanne $+ $ct $+ , líder do ginásio de $cc $+ Rustboro City $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),5,58)) { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Muitos de nós que estamos aqui não viemos realmente para viajar. Sair de nossas obrigações diárias não é tão fácil, eu não posso demorar muito também. }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Lembre-se de passar em $cc $+ Rustboro $ct $+ quando for a Hoenn, ok? Poderemos batalhar, e espero que seja divertida! }
      else { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Estou muito anciosa para voltar a $cc $+ Hoenn $+ $ct $+ , preciso cuidar do ginásio e esperar novos desafiantes, assim como você já esteve lá e batalhou comigo. Bem, que tal uma nova batalha? Prometo não perder desta vez! | battle.npc $nick 1138 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,5,58)
    }
  }
  elseif ($1 == Tate&Liza) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Tate&Liza $+ $ct $+ , líderes do ginásio de $cc $+  City $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),10,58)) { msg =$nick $chr(160) $cc $+ Tate&Liza $ct $+ - Telecinesia é um dom que nós desenvolvemos aos quatro anos de idade. É por isso que sentimos facilidade em treinar pokémon psíquicos... }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Tate $ct $+ - Olá, eu sou... $cc $+ Tate $+ $ct $+ . | msg =$nick $chr(160) $cc $+ Liza $ct $+ - E eu sou... $cc $+ Liza $+ $ct $+ . | msg =$nick $chr(160) $cc $+ Tate&Liza $ct $+ - Somos irmãs gêmeas e temos a capacidade de saber o que o outro está pensando. Hahaha, acha que pode nos derrotar? Então venha nos visitar em $cc $+ Mossdeep $+ $ct $+ ! }
      else { msg =$nick $chr(160) $cc $+ Tate $ct $+ - Eu tive uma idéia... | msg =$nick $chr(160) $cc $+ Liza $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Que tal... | msg =$nick $chr(160) $cc $+ Tate&Liza $ct $+ - Uma batalha em dupla? | battle.npc $nick 1139 }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,10,58)
    }
  }
  elseif ($1 == Lore) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lore $+ $ct $+ , um marujo.
    if ($gettok($dados($nick,Quests,SSTidal),6,58)) {
      if ($dados($nick,Quests,Tidal)) {
        msg =$nick $chr(160) $cc $+ Lore $ct $+ - Chegamos! Pode desembarcar agora, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ .
        var %d = $dados($nick,Info,Dest)
        if (%d == Hoenn) { if ($dados($nick,Info,Region) == Johto) { var %l = Lilycove City } | else { var %l = Slateport City } }
        elseif (%d == Kanto) { var %l = Vermilion City }
        elseif (%d == Johto) { var %l = Olivine City }
        writeini pkp\cadastros\ $+ $nick $+ .ini Info Region %d | writeini pkp\cadastros\ $+ $nick $+ .ini Info Locate %l | remini pkp\cadastros\ $+ $nick $+ .ini Info Dest
        msg =$nick $ct $+ Você está agora em $cc $+ $dados($nick,Info,Locate) $ct $+ ( $+ $cc $+ $dados($nick,Info,Region) $+ $ct $+ ).
        wlog user $nick Traveled on the ship and arrived at $dados($nick,Info,Region) $+ .
        var %v = $dados($nick,$dados($nick,Info,Region),Visited) | writeini pkp\cadastros\ $+ $nick $+ .ini $dados($nick,Info,Region) Visited $addtok(%v,$dados($nick,Info,Locate),58)
        writeini pkp\cadastros\ $+ $nick $+ .ini Clock Ship $dados($nick,Info,Online)
      }
      else { msg =$nick $chr(160) $cc $+ Lore $ct $+ - Calma, ainda não pode desembarcar. Estamos perto de chegar ao nosso destino. }
    }
    else { msg =$nick $chr(160) $cc $+ Lore $ct $+ - SS Tidal é talvez o mais luxuoso navio do mundo! $cc $+ Mr Stone $ct $+ que propôs a sua construção, mas quem realmente o fez foi $cc $+ Stern $+ $ct $+ . Salve! }
    writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,6,58)
  }
  elseif ($1 == Norman) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Norman $+ $ct $+ , líder do ginásio de $cc $+ Petalburg City $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),7,58)) { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Hahaha, aguente firme os futuros desafios e não desista! O mais importante agora é concentrar-se para atingir seu objetivo maior: tornar-se um mestre pokémon. }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Muito prazer. Minha especialidade é em pokémon do tipo Normal. A grande variedade de espécies existentes me deixa mais confiante em minhas estratégias, e nenhum pokémon lutador será capaz de derrubá-los! Quando visitar $cc $+ Hoenn $+ $ct $+ , lembre-se de passar em Petalburg para batalharmos! }
      elseif ($dados($nick,Info,Start) == Kanto) { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Hahaha, e aqui estamos! Quem poderia esperar disso hein? Seu sucesso veio muito cedo, garoto! Olhe, já é até uma celebridade. Continue assim e você se sairá muito bem em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ . }
      else { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Nossa, hahahaha! Que surpresa agradável, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Eu não poderia esperar revê-lo, e muito menos aqui! Eu imagino que $cc $+ Wally $ct $+ ainda esteja em $cc $+ Hoenn $+ $ct $+ ... Deve estar com inveja, certamente! Parabéns. }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,7,58)
    }
  }
  elseif ($1 == Lance) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lance $+ $ct $+ , membro de Elite Four de $cc $+ Kanto $+ $ct $+ .
    if ($gettok($dados($nick,Quests,SSTidal),8,58)) { msg =$nick $chr(160) $cc $+ Lance $ct $+ - Meu futuro é incerto. Mas estou torçendo pelo seu sucesso, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Lance $ct $+ - Oh, então não sabia que eu era membro da Elite Four? Bem, não falei nada para não deixá-lo constrangido ou algo parecido. Obrigado mais uma vez pela ajuda fornecida em $cc $+ Johto $+ $ct $+ . Até! }
      else { msg =$nick $chr(160) $cc $+ Lance $ct $+ - Meus informantes de $cc $+ Johto $ct $+ alertaram-me sobre a presença de membros da equipe $cc $+ Rocket $+ $ct $+ . Estou indo agora tentar resolver a situação, não gosto nem um pouco daqueles lunáticos. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Lance No }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,8,58)
    }
  }
  elseif ($1 == Steven) && ($gettok($dados($nick,Quests,SSTidal),9,58)) && ($dados($nick,Info,Start) != Johto) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Steven $ct $+ - Ah, esqueci de desejar boa sorte em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ ! Continue persistente em direção ao seu objetivo e derrote todos os seus adversários!
    if (!$dados($nick,Quests,Herb)) { item.add $nick White Herb | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Fique com esta $cc $+ White Herb $+ $ct $+ . Se você fizer seu pokémon segurá-la, durante uma batalha, quando houver uma perda de ataque, defesa, ou qualquer outro atributo, ele será recuperado! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Herb Ok }
  }
  elseif ($findtok(Captain:Capitão:Capitao:Writney,$1,0,58)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Writney $+ $ct $+ , o capitão do SS Tidal.
    if ($gettok($dados($nick,Quests,SSTidal),9,58)) {
      if ($findtok($dados($nick,Quests,SSTidal),1,0,58) == 10) { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Finalmente! Chegamos em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ . Não fique nervoso, sei que tudo dará certo para você nesta nova etapa. Fale com $cc $+ Lore $ct $+ para desembarcar. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Tidal Ok }
      else { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Hahaha, já conhece toda a tripulação? Distraia-se um pouco e tente relaxar, ainda não chegamos em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ ... }
    }
    else {
      if ($dados($nick,Info,Start) == Johto) { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Bem vindo ao meu navio, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Parabéns pelo seu desempenho em $cc $+ $dados($nick,Info,Region) $+ $ct $+ . Não se desespere, a viagem será segura e você não tardará a chegar ao seu destino. }
      elseif ($dados($nick,Info,Start) == Kanto) { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Olá, bem vindo à viagem de inauguração do $cc $+ SS Tidal $+ $ct $+ . Espero que esteja confortável e não se preocupe, a viagem é segura e tranqüila! }
      else { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Ah, há quanto tempo! Nossa, como você está? Vejo que se tornou um dos melhores treinadores do mundo! É muito bom saber disso. Eu tive que me ausentar porque estava sendo recrutado a ser o capitão deste navio, mesmo já estando aposentado. Eu nunca me canso disso, para falar a verdade! É um prazer que sinto em conduzir as pessoas aos seus destinos, achando sempre um caminho seguro pelos mares! }
      if ($dados($nick,Info,Start) != Johto) {
        msg =$nick $cc $+ Steven $ct $+ aparece subitamente. | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Nossa, eu realmente o assustei?! Hehehe, desculpe! Não esperava encontrá-lo aqui, podia jurar que não tinha comparecido... Mas já que nos encontramos, o que diria então de uma batalha? | battle.npc $nick 1140
      }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSTidal $puttok($dados($nick,Quests,SSTidal),1,9,58)
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Mahogany_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo! $cc $+ $dados($nick,Info,Locate) $ct $+ é uma das mais antigas cidades deste continente e o líder da cidade está no seu posto desde o início... Hah, ninguém consegue derrotá-lo! É incrível!
    if ($dados($nick,Quests,Lance) != Ok) && (!$dados($nick,Quests,Rocket4)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Um treinador muito suspeito dirigiu-se ao $cc $+ Lake Of Rage $+ $ct $+ . Seu nome é $cc $+ Lance $+ $ct $+ , e tenho a impressão de já tê-lo visto antes. }
  }
  elseif ($1 == Dean) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Dean $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Dean $ct $+ - Que estranho! Um dias desses eu estava procurando pokémon em $cc $+ Lake Of Rage $ct $+ e percebi algo estranho no lugar... Não sei dizer exatamente o que, mas meus pokémon perceberam e não gostaram nem um pouco. Daí eu os trouxe ao centro pokémon e eles finalmente melhoraram...
  }
  elseif ($findtok(Rocket:Esconderijo:Hideout:Rocket Hideout,$1-,0,58)) && ($dados($nick,Quests,Rocket4)) {
    msg =$nick $ct $+ Você entrou no $cc $+ Rocket Hideout $+ $ct $+ .
    if ($dados($nick,Quests,Rocket4) == Ok) { msg =$nick $ct $+ Parece não haver mais ninguém aqui... }
    else { msg =$nick $ct $+ Olhe! Há membros da equipe $cc $+ Rocket $ct $+ aqui! O que deseja fazer? | msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para desafiá-los ou ' $+ $cc $+ .nao $+ $ct $+ ' para fugir. | set %confirm. [ $+ [ $nick ] ] RKT:5 }
  }
  elseif ($1 == Pryce) {
    if ($badge($nick,Glacier Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Pryce $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Pryce $ct $+ - Apenas o admiro ainda mais, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ... Obrigado por nossa batalha tão revigorante!
    }
    else { .msg =$nick $cc $+ Pryce $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Lake_Of_Rage {
  if ($1 == Lance) && ($dados($nick,Quests,Lance) != Ok) && (!$dados($nick,Quests,Rocket4)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lance $+ $ct $+ .
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Lance $ct $+ - E você, quem é? Ah, desculpe $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , pela minha grosseria. É que estou no meio de uma investigação. Parece-me que a equipe $cc $+ Rocket $+ $ct $+ , um grupo de fanáticos, estão tentando evoluir pokémon usando algum método não conhecido... Preciso encontrar o esconderijo deles agora, sei que é próximo daqui. Por favor, não se envolva nisso, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . É muito perigoso... Adeus! }
    else { msg =$nick $chr(160) $cc $+ Lance $ct $+ - Ah, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , tomei um enorme susto com a sua chegada. É que estou no meio de uma investigação. Parece-me que a equipe $cc $+ Rocket $+ $ct $+ , um grupo de fanáticos que talvez você já tenha ouvido falar, estão tentando evoluir pokémon usando algum método desconhecido... Preciso encontrar o esconderijo deles agora, sei que é próximo daqui. Não pretendo envolvê-lo nisso, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . É muito perigoso... Até! }
    writeini pkp\cadastros\ $+ $nick $+ .ini Quests Lance No | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Rocket4 No
  }
  else { .msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Mt_Mortar { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Ice_Path { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Blackthorn_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Esta cidade é conhecida como o berço dos dragões. Pessoas famosas que treinam pokémon do tipo $cc $+ Dragon $ct $+ já treinaram nesta cidade e hoje são excepcionais treinadores.
  }
  elseif ($1 == Flint) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Flint $+ $ct $+ , um pescador.
    if ($start($nick)) {
      if ($item($nick,Old Rod).qnt) {
        if ($item($nick,Good Rod).qnt) { msg =$nick $chr(160) $cc $+ Flint $ct $+ - E aí? Praticando muito suas habilidades na pescaria? Olha, achei um $cc $+ Goldeen $+ $ct $+ ! }
        else { msg =$nick $chr(160) $cc $+ Flint $ct $+ - Quem sabe você não encontra uma $cc $+ Good Rod $ct $+ em $cc $+ Azalea Town $+ $ct $+ ... Ah, lembrei, $cc $+ Tylor $ct $+ poderá ajudá-lo. }
      }
      else { msg =$nick $chr(160) $cc $+ Flint $ct $+ - Então você quer pescar? Certamente vai precisar de um instrumento para fazê-lo, portanto fique com esta $cc $+ Old Rod $+ $ct $+ . | item.add $nick Old Rod | msg =$nick $chr(160) $cc $+ Flint $ct $+ - Para usá-la, digite ' $+ $cc $+ .item use Old Rod $+ $ct $+ ' antes de iniciar uma batalha com pokémon selvagem. Lembre-se que não há muitas espécies na água, ou seja, é perfeitamente normal que apareçam muitos pokémon que você já tenha... }
    }
    else { msg =$nick $chr(160) $cc $+ Flint $ct $+ - Não faz muito tempo que começei a pescar, mas já estou me sentindo muito profissional. Olhe só, eu mesmo peguei esse $cc $+ Magikarp $+ $ct $+ ! }
  }
  elseif ($1 == Bryce) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Bryce $+ $ct $+ , um treinador pokémon.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Bryce $ct $+ - Apesar de $cc $+ Clair $+ $ct $+ , a líder da cidade, ser especialista em pokémon dragões, não creio que seu talento se limite apenas a estes tipos de pokémon. É o que se pode ver ao batalhar com os treinadores antes dela, eles não parecem estar preocupados em usar pokémon do tipo $cc $+ Dragon $+ $ct $+ . }
    else { msg =$nick $chr(160) $cc $+ Bryce $ct $+ - $cc $+ Clair $ct $+ é especialista em pokémon do tipo $cc $+ Dragon $+ $ct $+ , assim como $cc $+ Lance $+ $ct $+ . Ouvi falar que os dois treinaram juntos nesta cidade e batalharam entre si para decidir quem seria o líder. $cc $+ Clair $ct $+ venceu, mas não tenho certeza se $cc $+ Lance $ct $+ batalhou para valer... }
  }
  elseif ($1 == Clair) {
    if ($badge($nick,Rising Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Clair $+ $ct $+ , líder do ginásio de $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Clair $ct $+ - Alguns pokémon precisam estar felizes para evoluir. Há várias formas de alegrá-lo. Por exemplo, se você batalhar usando o mesmo pokémon durante batalhas com treinadores diferentes, ele ficará mais feliz, assim como usar pokémon diferentes contra o mesmo treinador, alternadamente em ambos os casos.
    }
    else { .msg =$nick $cc $+ Clair $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.White_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Esta é a "cidade pálida", como muitos a conhecem. O motivo disso é a ausência de cores nas construções dela, é proibido usar qualquer outra cor que não for branco em casas, edifícios, e até mesmo no centro pokémon. Pode parecer estranho para quem é visitante, mas os habitantes adoram e já se acostumaram com a idéia.
  }
  elseif ($1 == Derek) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Derek $+ $ct $+ , um habitante da cidade.
    msg =$nick $chr(160) $cc $+ Derek $ct $+ - Não acredito que pintaram a parede da minha casa ontem... Aquela tinta usada na pintura não me engana não, certamente foi meu vizinho! Se eu pegá-lo fazendo isso, ele vai ver só!
  }
  elseif ($1 == Mark) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Mark $+ $ct $+ , um treinador pokémon.
    if ($dados($nick,Smeargle,Name)) { msg =$nick $chr(160) $cc $+ Derek $ct $+ - Sim, foi esse pokémon que eu vi mesmo! $cc $+ Smeargle $ct $+ huh? Deve ser um pokémon raro... Mas que sorte a sua! }
    else { msg =$nick $chr(160) $cc $+ Derek $ct $+ - Não creio que seja uma 'pessoa' que esteja realmente dando cores a esta cidade... Não vou dizer nada sem ter provas, mas guarde as minhas palavras! }
  }
  elseif ($1 == Ariana) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ariana $+ $ct $+ , uma treinadora pokémon.
    msg =$nick $chr(160) $cc $+ Ariana $ct $+ - Parece até contraditoriedade, mas este lugar já trouxe inspiração para muitos artistas famosos. Não sei o que há por trás disso, mas eu também gosto dela... Até os pokémon são brancos, que lindo!
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Dark_Cave { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Peak_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo à cidade, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Se estiver passando mal por causa da altitude, respire um pouco mais e beba alguma coisa. Como a cidade foi erguida exatamente em cima de um pico, é comum que treinadores visitantes não se sintam bem. Bem, qualquer coisa avise!
  }
  elseif ($1 == Oliver) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Oliver $+ $ct $+ , um treinador pokémon.
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %x = 1 } } | elseif ($dados($nick,Johto,League)) { var %x = 1 }
    if (%x) { msg =$nick $chr(160) $cc $+ Oliver $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Tudo bem, não mentirei para você: sou o $cc $+ Move Relearner $+ $ct $+ , conhecido por fazer pokémon reaprenderem técnicas que por alguma razão não podem mais aprender. Deseja que eu dê uma olhada em seu $cc $+ $dados($nick,Team,1) $+ $ct $+ ? | msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] RLN:Oliver }
    else { msg =$nick $chr(160) $cc $+ Oliver $ct $+ - Meus pokémon voadores já estão acostumados com o ar um tanto rarefeito daqui. Como é? $cc $+ Move Relearner $+ $ct $+ ? Nunca ouvi falar... Você deve estar confundindo-me com outra pessoa. }
  }
  elseif ($1 == Brent) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Brent $+ $ct $+ , um habitante da cidade.
    msg =$nick $chr(160) $cc $+ Brent $ct $+ - Se estiver pensando em ir à liga pokémon de $cc $+ $dados($nick,Info,Region) $ct $+ sugiro então que siga para $cc $+ Sunrise City $+ $ct $+ ... Eu vim aqui à procura do $cc $+ Move Relearner $+ $ct $+ , mas vejo que cometi um engano terrível!
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Sunrise_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - É triste informá-lo que esta cidade já foi habitat de vários pokémon, mas hoje quase não vemos pokémon por aqui... Por isso é preciso proteger a natureza. Quando eu passar em $cc $+ Goldenrod City $ct $+ novamente, lembrarei de comprar alguma planta na floricultura, assim pelo menos eu farei a minha parte!
  }
  elseif ($1 == Clarice) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Clarice $+ $ct $+ , uma habitante da cidade.
    msg =$nick $chr(160) $cc $+ Clarice $ct $+ - A cidade devastou muito das belezas naturais desta ilha, o que acabou causando o afastamento de vários pokémon. Hoje, no entanto, pokémon polinizadores visitam a ilha todas as manhãs, na tentativa de reflorestá-la. Na verdade, torço para que eles consigam...
  }
  elseif ($1 == Marty) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Marty $+ $ct $+ , um treinador pokémon.
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %l = 1 } } | elseif ($dados($nick,$dados($nick,Info,Region),League)) { var %l = 1 }
    if (%l) {
      var %t = $asctime(HH)
      if (%t < 5) { msg =$nick $chr(160) $cc $+ Marty $ct $+ - Sabe de uma coisa? Vou ficar e esperar pelos pokémon. Falta cerca de $cc $+ $numero2($calc(5 - %t)) $ct $+ horas para os primeiros raios solares aparecerem... }
      elseif (%t == 5) { msg =$nick $chr(160) $cc $+ Marty $ct $+ - Ah! Achei um pokémon em $cc $+ Sunrise City $+ $ct $+ ! Pena que eles só aparecem neste horário aqui na cidade... }
      else { msg =$nick $chr(160) $cc $+ Marty $ct $+ - Se quiser encontrar pokémon selvagens, terá que esperar até amanhã, quando o sol estiver nascendo... }
    }
    else { msg =$nick $chr(160) $cc $+ Marty $ct $+ - Não creio que deixaram isto acontecer... É uma pena, mas esta cidade não tem pokémon mesmo! Eu ouvi boatos de aparição de algumas espécies durante o amanhecer, mas não tenho tempo para vir aqui cedo e checar por mim mesmo. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Fog_Cave { msg =$nick $ct $+ Nada foi encontrado. }
alias earl.count {
  var %r = $dados($1-,Johto,Battle), %t = WTR
  var %n = 1508 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %n = 1509 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %t = FLY, %n = 1515 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %n = 1516 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %t = PSY, %n = 1517 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %n = 1518 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  var %n = 1519 | if ($findtok(%r,%n,0,58)) { var %r = $remtok(%r,%n,1,58), %r = $addtok(%r,%t,58) }
  return $iif(%r,$gettok(%r,0,58),0)
}
alias c.search.Silverst_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Parabéns por ter chegado até aqui, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Esta é a famosa ilha prateada, e você está agora em $cc $+ $dados($nick,Info,Locate) $+ $ct $+ , lugar onde você encontrará seu maior desafio! Não fique muito tenso, e confie em seu time! Vocês já chegaram até aqui, e provavelmente enfrentaram muitos desafios tortuosos no caminho. Tudo o que posso fazer agora é desejar boa sorte...
  }
  elseif ($1 == Earl) && (!$dados($nick,Quests,Mew)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Earl $+ $ct $+ , um habitante da cidade.
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %x = 1 } } | elseif ($dados($nick,Johto,League)) { var %x = 1 }
    if (%x) {
      if ($dados($nick,Johto,Battle)) && (!$dados($nick,Quests,Mew)) {
        var %b = $dados($nick,Johto,Battle)
        if ($gettok(%b,0,58) > 21) {
          var %x = 1
          while ($gettok(%b,%x,58)) {
            var %p = $gettok(%b,%x,58)
            while ($findtok(%b,%p,0,58) > 1) { var %b = $deltok(%b,$findtok(%b,%p,$findtok(%b,%p,0,58),58),58) }
            inc %x
          }
          writeini pkp\cadastros\ $+ $nick $+ .ini Johto Battle %b
        }
        var %n = $earl.count($nick)
        if (%n == 17) {
          msg =$nick $chr(160) $cc $+ Earl $ct $+ - Você realmente conseguiu... Derrotou todos os times aleatórios da $cc $+ Elite Four $ct $+ de $cc $+ Johto $+ $ct $+ ! Para treinadores como você, este desafio foi mais que revigorante. Imagino que esteja inspirado neste exato momento na formação de times ainda mais articulados. Não há dúvidas que seu desenvolvimento estratégico progrediu bastante, e sei que continuará progredindo, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ !
          if ($teampos($nick,Egg)) { msg =$nick $chr(160) $cc $+ Earl $ct $+ - Sinto muito, mas você já tem um $cc $+ Egg $ct $+ em seu time... Quando finalmente chocar-se, volte a falar comigo. | return }
          if ($dados($nick,Team,6)) { msg =$nick $chr(160) $cc $+ Earl $ct $+ - Que pena, você já tem seis pokémon no time... Libere espaço para receber este $cc $+ Egg $+ $ct $+ . | return }
          echo $addpoke($nick,Egg,Mew,Sua origem é desconhecida...,$rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31),0,0)
          msg =$nick $chr(160) $cc $+ Earl $ct $+ - Por favor, cuide deste $cc $+ Egg $+ $ct $+ , adquirido num local onde nenhuma embarcação nem pokémon podem alcançar. Bem distante, onde os sonhos terminam... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mew $dados($nick,Info,Online)
          msg =$nick $chr(160) $cc $+ Earl $ct $+ - Adeus!
        }
        else { msg =$nick $chr(160) $cc $+ Earl $ct $+ - Como você já deve ter reparado, a $cc $+ Elite Four $ct $+ usa diversos times, aleatórios, de tipos variados. Eu adoraria ver um treinador derrotando todos os diferentes times... Se você conseguir cumprir esta notável tarefa, volte a falar comigo. Terei algo para você. }
      }
      else { msg =$nick $chr(160) $cc $+ Earl $ct $+ - Encontrei-o numa ilha deserta há muito tempo, uma que hoje não é acessível atualmente, talvez ele estivesse ali abandonado. Não sei se este ovo é realmente de um pokémon, pois não aparentava que o mesmo desejava nascer. }
    }
    else { msg =$nick $chr(160) $cc $+ Earl $ct $+ - Você parece estar preparado para o maior desafio, que é a $cc $+ Elite Four $+ $ct $+ . Avisarei previamente que não será fácil. Ao longo da minha vida, vi muitos treinadores confiantes avançarem até três membros da elite, mas jamais derrotarem-nos. Sera que você é experiente o bastante para vencer mais esta etapa? }
  }
  elseif ($1 == Fred) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Fred $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Fred $ct $+ - Prata é o que não falta nesta ilha, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Sabe, há um lugar conhecido como 'montanha prateada' onde poucos podem acessá-la, pois é uma área protegida por autoridades. Ouvi apenas rumores de pokémon raros habitando aquela montanha.
  }
  elseif ($1 == Brendan) && ($dados($nick,Info,Start) == Hoenn) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Brendan $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Ah, não se espante, só estou aqui para vê-lo batalhar... Não sei se estou pronto para esta poderosa $cc $+ Elite Four $+ $ct $+ ...
    var %x = $rini(cadastros,$nick,Clock,Brendan), %o = $rini(cadastros,$nick,Info,Online)
    if ($calc(%o - %x) >= 28800) {
      msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Estou com vontade de batalhar agora, o que me diz?
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK:1324 | return
    }
    else {
      msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Tudo bem, continuarei treinando para ser, algum dia, um treinador ainda mais brilhante que você!
      var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary), %x1 = $findtok(%x,Raikou,0,58), %x2 = $findtok(%x,Suicune,0,58), %x3 = $findtok(%x,Entei,0,58), %x4 = $findtok(%x,Ho-oh,0,58), %x5 = $findtok(%x,Lugia,Ho-oh)
      if (%x1) || (%x2) || (%x3) { msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Sabe o que me deixa impressionado? $cc $+ Ecruteak City $+ $ct $+ . Há muitas lendas sobre aquela cidade, acho realmente que há algo escondido nela... Não consigo descrever o quê, estou apenas com um pressentimento. }
      elseif (%x4) || (%x5) { msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Ouvi falar que três pokémon lendários foram capturados nos territórios de $cc $+ Johto $+ $ct $+ . Será que há ainda algum restando? Se eu descobrir algo, aviso... }
      elseif ($dados($nick,Quests,Rocket6) isnum 1-2) { msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Equipe $cc $+ Rocket $ct $+ aqui em $cc $+ Johto $+ $ct $+ ? Só pode estar brincando! Eles de novo? Talvez, dessa vez, eles aprenderão de vez a lição. Ah, você vai ensiná-los, não é? }
    }
  }
  elseif ($1 == May) && ($dados($nick,Info,Start) == Kanto) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ May $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ May $ct $+ - Oh, sabia que eu poderia encontrá-lo aqui! Sabe, foi muito difícil chegar em $cc $+ $dados($nick,Info,Locate) $ct $+ mas eu sabia que valeria a pena... Não sei se estou pronta para esta poderosa $cc $+ Elite Four $+ $ct $+ ...
    var %x = $rini(cadastros,$nick,Clock,May), %o = $rini(cadastros,$nick,Info,Online)
    if ($calc(%o - %x) >= 28800) {
      msg =$nick $chr(160) $cc $+ May $ct $+ - Estou com vontade de batalhar agora, o que me diz?
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK:1325 | return
    }
    else {
      var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary), %x1 = $findtok(%x,Raikou,0,58), %x2 = $findtok(%x,Suicune,0,58), %x3 = $findtok(%x,Entei,0,58), %x4 = $findtok(%x,Ho-oh,0,58), %x5 = $findtok(%x,Lugia,Ho-oh)
      if (%x1) || (%x2) || (%x3) { msg =$nick $chr(160) $cc $+ May $ct $+ - Sabe o que me deixa realmente impressionada? $cc $+ Ecruteak City $+ $ct $+ . Há muitas lendas sobre aquela cidade, acho realmente que há algo escondido nela... Não consigo descrever o quê, estou apenas com um pressentimento. }
      elseif (%x4) || (%x5) { msg =$nick $chr(160) $cc $+ May $ct $+ - Ouvi falar que três pokémon lendários foram capturados nos territórios de $cc $+ Johto $+ $ct $+ . Será que há ainda algum restando? Se eu descobrir algo, aviso... }
      elseif ($dados($nick,Quests,Rocket6) isnum 1-2) { msg =$nick $chr(160) $cc $+ May $ct $+ - Equipe $cc $+ Rocket $ct $+ aqui em $cc $+ Johto $+ $ct $+ ?! Como isso pode ser possível? Acho melhor você detê-los agora, antes que se transforme em mais uma catástrofe! }
      else { msg =$nick $chr(160) $cc $+ May $ct $+ - Ficarei treinando por aqui, então você poderá me visitar sempre que quiser! }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Mt_Silver {
  if ($findtok(Symbol:Simbolo:Símbolo,$1,0,58)) {
    if (!$dados($nick,Quests,Symbol)) { var %x = 0:0:0:0 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol %x }
    else { var %x = $dados($nick,Quests,Symbol) }
    var %n = 3
    if ($gettok(%x,%n,58)) { msg =$nick $ct $+ Este símbolo já foi adquirido anteriormente. }
    else {
      if ($team.hm($nick,Whirlwind) == Ok!) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol $puttok(%x,1,%n,58) | msg =$nick $cc $+ Air Symbol $ct $+ foi encontrado com sucesso. }
      else { msg =$nick $ct $+ Nada pôde ser encontrado. }
    }
  }
  elseif ($1 == Silver) && ($dados($nick,Quests,Silver) > 1) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Silver $+ $ct $+ .
    var %x = $rini(cadastros,$nick,Clock,Silver), %o = $rini(cadastros,$nick,Info,Online)
    if ($calc(%o - %x) >= 43200) {
      msg =$nick $chr(160) $cc $+ Silver $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , chegou a tempo de ver toda a força do meu time! Vamos batalhar um pouco! Nada de apostas desta vez...
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK: $+ $dados($nick,Quests,Silver)
    }
    else {
      if ($count($unown.code($nick),*) < 6) {
        msg =$nick $chr(160) $cc $+ Silver $ct $+ - Isso é um $cc $+ Unown $+ $ct $+ ? Hah, confesso que são pokémon realmente misteriosos! As palavras formadas que eles formam são carregadas de muito poder, não duvide disso.
        if ($earl.count($nick) == 17) {
          msg =$nick $chr(160) $cc $+ Silver $ct $+ - Contarei um segredo agora, então, por favor, não espalhe! Certa vez, tive a $cc $+ brilhante $ct $+ idéia de escrever com os $cc $+ Unown $ct $+ a palavra $cc $+ SHINY $ct $+ em meu time.
          msg =$nick $chr(160) $cc $+ Silver $ct $+ - Quer mesmo saber o que aconteceu? Até agora nada. Hahaha, te peguei! Acha mesmo que eu me preocupo para essas lendas de $cc $+ Johto $+ $ct $+ ?!
        }
        else { msg =$nick $chr(160) $cc $+ Silver $ct $+ - Não creio que você tenha habilidade suficiente para compreender o que eu sei sobre esses pokémon... E que tal você se concentrar na liga de $cc $+ Johto $+ $ct $+ ? Será bom, para variar... }
      }
      else { msg =$nick $chr(160) $cc $+ Silver $ct $+ - Se estiver cansado da $cc $+ Elite Four $ct $+ de $cc $+ Johto $+ $ct $+ , avise-me e você terá uma batalha de verdade! Modéstia parte, claro... }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Whirl_Island {
  if ($findtok(rocket:equipe:equipe rocket:team rocket:thief:thiefs:ladrão:ladrões,$1-,0,58)) && ($dados($nick,Quests,Rocket6) == 1) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Bunch $+ $ct $+ , chefe da atual equipe $cc $+ Rocket $+ $ct $+ .
    msg =$nick $chr(160) Bunch $ct $+ - Não entendo, o que você está procurando aqui? Esta $cc $+ Silver Feather $ct $+ é nossa! Com ela, poderemos finalmente despertar o tão estimado $cc $+ Lugia $ct $+ e com ele dominaremos todo o mundo!
    msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para batalhar contra os membros da equipe ou ' $+ $cc $+ .nao $+ $ct $+ ' para fugir.
    set %confirm. [ $+ [ $nick ] ] RKT:7
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Ruins_Of_Alph { .msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Tin_Tower { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Whirl_Edge { msg =$nick $ct $+ Nada foi encontrado. }
