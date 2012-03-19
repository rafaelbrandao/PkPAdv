alias c.search.Littleroot_Town {
  if ($1 == May) && ($start($nick)) {
    if ($dados($nick,Quests,May1)) {
      if ($dados($nick,Quests,League)) {
        msg =$nick $ct $+ Você encontra-se com $cc $+ May $+ $ct $+ .
        var %x = $rini(cadastros,$nick,Clock,May), %o = $rini(cadastros,$nick,Info,Online)
        if ($calc(%o - %x) >= 28800) {
          if (!$rini(cadastros,$nick,Quests,May4)) { msg =$nick $chr(160) $cc $+ May $ct $+ - $nick $+ ! Parabéns primeiramente pelo desempenho na liga pokémon! Esses 'ribbons', ou medalhas, que seus pokémon receberam, sem dúvida são muito interessantes! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests May4 Ok }
          msg =$nick $chr(160) $cc $+ May $ct $+ - Mas vamos ao que interessa! Uma batalha pokémon! Sim, agora será para valer! Agora quem quer testar as habilidades sou eu, já que você é o campeão! Hahaha...
          msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK:May | return
        }
        else {
          msg =$nick $chr(160) $cc $+ May $ct $+ - Acho que sou melhor como amiga do que como treinadora, não acha? Como não? Deveria!! Hahaha...
          var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary), %x1 = $findtok(%x,Latias,0,58), %x2 = $findtok(%x,Latios,0,58), %x3 = $findtok(%x,Rayquaza,0,58)
          if (%x1) || (%x2) {
            if (%x1) && (%x2) { msg =$nick $chr(160) $cc $+ May $ct $+ - $nick $+ ! Você sabe da novidade?! Rumores dizem que dois pokémon desconhecidos, um vermelho e outro azul, estão sobrevoando toda Hoenn! Eles simplesmente podem aparecer em qualquer lugar, que estranho! Eu gostaria de ver um desses, mas não ficaria feliz se não conseguisse capturá-lo... }
            else { msg =$nick $chr(160) $cc $+ May $ct $+ - $nick $+ ! Você sabe da novidade?! Havia dois pokémon desconhecidos sobrevoando Hoenn, mas agora apenas um pokémon $iif(%x1,vermelho,azul) foi visto! Será que eles são fortes? Eu gostaria de encontra-lo, mas não gostaria de perdê-lo de vista, se eu realmente o encontrasse... }
            if (%x3) { msg =$nick $chr(160) $cc $+ May $ct $+ - Ah! Eu soube também que você despertou um pokémon no topo do Sky Pillar! Quem mora ali perto diz ouvir todo dia o temível rugido daquele pokémon! Se eu fosse você, ficaria longe dali! }
          }
          else {
            if (%x3) { msg =$nick $chr(160) $cc $+ May $ct $+ - $nick $+ ! Eu soube que você despertou um pokémon no topo do Sky Pillar! Quem mora ali perto diz ouvir todo dia o temível rugido daquele pokémon! Se eu fosse você, ficaria longe dali! }
            else { msg =$nick $chr(160) $cc $+ May $ct $+ - Como anda sua PokeDex? Eu não posso avaliá-lo, mas a minha está ficando incrível! Por quê você não fala com meu tio, o Prof Birch? Ele está no laboratório, com certeza! }
          }
        }
      }
      else { msg =$nick $cc $+ May $ct $+ não foi encontrada na cidade... }
      return
    }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ May $+ $ct $+ . | msg =$nick $chr(160) $cc $+ May $ct $+ - Olá, você já conseguiu seu primeiro pokémon?
      if ($totalpokes($nick)) {
        msg =$nick $chr(160) $cc $+ May $ct $+ - Ótimo! Então você já deve estar pronto para capturar pokémon! Mas antes disso, o que acha de uma batalha? | writeini pkp\cadastros\ $+ $nick $+ .ini Quests May1 Ok
        battle.npc $nick Start_May | sset [ [ B. ] $+ [ $checknickid($nick).ID ] $+ [ .Quest ] ] MAY | var %n = $gettok($rmoves($checknickid($nick).ID,1),1,58)
        msg =$nick $chr(160) $cc $+ May $ct $+ - Esta é a sua primeira batalha? Bem, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , então você não deve saber como batalhar. Para atacar com seu pokémon, digite " $+ $cc $+ .Golpe %n $+ $ct $+ ", sem as aspas, e $cc $+ $rini(cadastros,$nick,Team,1) $ct $+ usará o golpe $cc $+ %n $ct $+ em seu adversário. | return
      }
      else { msg =$nick $chr(160) $cc $+ May $ct $+ - Mas o que você está esperando! Meu tio, $cc $+ Prof Birch $+ $ct $+ , está no laboratório. | return }
    }
  }
  elseif ($1 == Birch) || ($1 == Professor) || ($1 == Prof Birch) { msg =$nick $ct $+ Acho que $cc $+ Prof Birch $ct $+ está no laboratório. | return }
  elseif ($1 == Mom) || ($1 == Mamãe) || ($1 == Mae) || ($1 == Mãe) {
    if ($start($nick)) {
      msg =$nick $ct $+ Você encontra-se com sua mãe.
      var %r = $dados($nick,Info,Region) | if (!$dados($nick,%r,Badges).n) {
        var %x = $rini(cadastros,$nick,Quests,Mom) | if (!%x) { var %x = 1 }
        if (%x == 1) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Filho, tem alguma dúvida sobre como batalhar? Eu vou tentar te explicar, há dois métodos: você cria uma batalha e espera por outro treinador, ou então você entra numa batalha criada. Para criar uma batalha, digite ' $+ $cc $+ .Criar <pokémon> $+ $ct $+ ', substituindo $cc $+ <pokémon> $ct $+ pelo nome do seu pokémon. A seguir, aguarde pelo seu adversário. Agora, se quiser entrar numa batalha de outro treinador, digite ' $+ $cc $+ .Entrar <ID> <pokémon> $+ $ct $+ ', onde $cc $+ <ID> $ct $+ é o ID da batalha respectiva e $cc $+ <pokémon> $ct $+ o nome do pokémon que você usará. Ah, para listar as batalhas criadas e seus IDs, digite ' $+ $cc $+ .Listar $+ $ct $+ '. }
        elseif (%x == 2) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Para usar algum item, use sempre o comando ' $+ $cc $+ .Item Use <item> $+ $ct $+ ', onde $cc $+ <item> $ct $+ é o item selecionado. Para ver mais funções desse comando, digite ' $+ $cc $+ .Item $+ $ct $+ '. Para comprar novos itens, como $cc $+ Poke  Ball $+ $ct $+ , você precisará visitar uma loja, usando o comando ' $+ $cc $+ .Loja $+ $ct $+ '. Aqui em $cc $+ Littleroot $ct $+ não há loja, mas você encontrará alguma nas próximas cidades. Alias, sabe como avançar entre cidades? Utilize o comando ' $+ $cc $+ .Cidade Goto $+ $ct $+ ' para saber quais cidades estão disponíveis e, a seguir, digite ' $+ $cc $+ .Cidade Goto <localização> $+ $ct $+ ', substituindo-o pelo nome da cidade. }
        elseif (%x == 3) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Para ver seus dados gerais, digite ' $+ $cc $+ .Dados $+ $ct $+ '. Para ver dados de outros treinadores, use o comando ' $+ $cc $+ .Dados <nick> $+ $ct $+ '. Ah, você também pode ver informações detalhadas sobre seu pokémon usando o comando ' $+ $cc $+ .Dados <pokémon> $+ $ct $+ ', ou ainda de outros treinadores (se possível), ' $+ $cc $+ .Dados <nick> <pokémon> $+ $ct $+ '. }
        elseif (%x == 4) { msg =$nick $chr(160) $cc $+ Mom $ct $+ - Querido, você pode personalizar seu cadastro, sabia? Utilizando o comando ' $+ $cc $+ .Perfil $+ $ct $+ ' você edita seu cadastro, e usando o comando ' $+ $cc $+ .Skin $+ $ct $+ ' você muda as cores do $cc $+ $me $+ $ct $+ ! Muito interessante, não? }
        else { msg =$nick $chr(160) $cc $+ Mom $ct $+ - $cc $+ $nick $+ $ct $+ , por que não dá uma olhada no ' $+ $cc $+ .Ajuda $+ $ct $+ '? Utilizando esse comando, você verá todos os comandos disponíveis! Se tiver alguma dúvida de como usá-los, lembre-se: informações contidas entre $cc $+ < $ct $+ e $cc $+ > $ct $+ são campos obrigatórios, substitua pelo termo correspondente; se tiverem contidas entre $cc $+ ( $ct $+ e $cc $+ ) $+ $ct $+ , serão campos opcionais, mas em alguns casos obrigatórios. Outros treinadores poderão ajudá-lo se ainda tiver dúvidas, filho. Boa sorte! | var %x = 0 }
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mom $calc(%x + 1)
      }
      else {
        if ($dados($nick,Quests,League)) {
          if ($item($nick,Silver Ticket).qnt) {
            if ($dados($nick,Kanto,League)) {
              if ($item($nick,Gold Ticket).qnt) {
                msg =$nick $chr(160) $cc $+ Mom $ct $+ - Então vai viajar novamente? Divirta-se e mande sempre notícias!
              }
              else { msg =$nick $chr(160) $cc $+ Mom $ct $+ - É bom ver que você está desenvolvendo bastante suas habilidades, filho. Mamãe fica sempre preocupada, mas sei também que você se sairá bem em qualquer desafio. Ah, parece que desenvolveram um navio muito resistente aqui mesmo em $cc $+ Hoenn $+ $ct $+ . Somente uma mente brilhante poderia desenvolvê-lo... Conhece algum especialista em navios, filho? }
            }
            else {
              msg =$nick $chr(160) $cc $+ Mom $ct $+ - Divirta-se, filho!
              msg =$nick $chr(160) $cc $+ Mom $ct $+ - Mamãe sentirá saudades...
            }
          }
          else {
            msg =$nick $chr(160) $cc $+ Mom $ct $+ - Meu filho você conseguiu derrotar a liga pokémon! Estou muito feliz, você conseguiu realizar seu sonho!
            msg =$nick $chr(160) $cc $+ Mom $ct $+ - Eu tinha feito uma poupança, mas achei melhor gastar o dinheiro comprando essa passagem de navio para $cc $+ Kanto $+ $ct $+ ! Parabéns filho, receba este presente!
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
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Oldale_Town {
  if ($1 == Thomas) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Thomas $+ $ct $+ , o criador de pokémon.
    if ($dados($nick,Clock,Thomas)) && ($calc($dados($nick,Info,Online) - $dados($nick,Clock,Thomas)) < 10800) { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - É bom saber que poderemos negociar sempre, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Que tal outra hora? | return }
    if ($totalpokes($nick) > 1) {
      msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Nossa! Seus pokémon estão incríveis! Você gostaria de vender algum deles para mim? | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar e $cc $+ .nao $ct $+ para rejeitar.
      set %confirm. [ $+ [ $nick ] ] THM | return
    }
    else { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Quando tiver mais pokémon, venha e vamos fazer negócio. | return }
  }
  elseif ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($start($nick)) {
      if (!$dados($nick,Quests,Joy1)) {
        msg =$nick $chr(160) $cc $+ Joy $ct $+ - Será que você está treinando seus pokémon corretamente? Deixe-me dar uma olhada em seu time...
        if ($groupev($nick) >= 510) {
          msg =$nick $chr(160) $cc $+ Joy $ct $+ - Parabéns, seu time está formidável! Desse jeito não haverá adversário forte o bastante para derrotá-lo em sua jornada!
          msg =$nick $chr(160) $cc $+ Joy $ct $+ - Minha velha amiga desenvolveu um incrível sistema de armazenamento de pokémon em PC. Você realmente deveria experimentar...
          if ($item($nick,PC).check == No!) { .msg =$nick $ct $+ Você ganhou o item $cc $+ PC $+ $ct $+ . | item.add $nick PC }
          else { .msg =$nick $ct $+ Você ganhou uma $cc $+ Small Box $ct $+ em seu $cc $+ PC $+ $ct $+ . | box.add $nick 30 } | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Joy1 Ok
        }
        else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu time ainda não está preparado... Lembre-se de derrotar adversários diferentes para aumentar o poder de seus atributos igualmente. Ah, claro, é possível ter um pokémon de level avançado e que não esteja treinado! }
        return
      }
    }
    var %pk = $dados($nick,$dados($nick,Team,1),Name), %n = $totalev($nick,%pk), %p = $calc(%n * 100 / 510)
    if (%n < 50) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu pokémon $cc $+ %pk $ct $+ ainda precisa treinar bastante! }
    elseif (%n < 85) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu pokémon $cc $+ %pk $ct $+ está fazendo realmente bons progressos! }
    elseif (%n < 100) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - seu pokémon $cc $+ %pk $ct $+ desenvolve-se formidavelmente! Não demorará até que seu treinamento esteja completo! }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu pokémon $cc $+ %pk $ct $+ terminou seu treinamento! Parabéns pelo seu esforço! | return }
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Lembre-se de treinar seu pokémon com adversários diferentes para que o mesmo desenvolva-se de forma balanceada.
    return
  }
  elseif ($1 == Matt) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Matt $+ $ct $+ .
    var %x = $dados($nick,Clock,Matt)
    if (%x) { if ($calc($dados($nick,Info,Online) - $dados($nick,Clock,Matt)) < 600) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Estou ajudando outros treinadores agora. Será que você pode voltar em alguns minutos? | return } }
    msg =$nick $chr(160) $cc $+ Matt $ct $+ - Olá! Vejo que você também é um treinador de pokémon. Já faz algum tempo que começei minha jornada e posso te passar algumas informações sobre o treinamento de pokémon.
    var %x = $rand(1,14) | if (%x == 1) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - De acordo com os adversários que seu pokémon derrota, seus Stats vão ser alterados. Por exemplo, se quiser aumentar a SPD do seu pokémon, tente derrotar vários Pidgeys e você vai ver a diferença. }
    elseif (%x == 2) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Você pode ver a "Nature" de seu pokémon. Cada uma delas indica uma variação que seu pokémon irá sofrer sobre os Stats dele. Por exemplo, a Nature Calm significa menos ATK no seu pokémon, porém ele terá um acréscimo em SDEF. }
    elseif (%x == 3) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - As "Traits" são habilidades que cada pokémon tem, e posso dizer que são bem úteis. Por exemplo, a Trait Intimidate intimida o adversário e diminui seu ATK no início da partida. Incrível! }
    elseif (%x == 4) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - É importante deixar seu pokémon feliz, confiança entre treinador e pokémon é fundamental. Pokémon com "Loyalty" alta são bem apreciados. }
    elseif (%x == 5) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Uns dizem que o melhor ataque é a defesa, outros que um poderoso ataque é sempre viável. Creio que uma boa estratégia é indispensável para a vitória de uma batalha. Tenha calma durante as lutas, e você vai se dar bem. }
    elseif (%x == 6) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - As batalhas de três contra três podem ter desfechos impressionantes! Mas detalhe: não é possível trocar de pokémon, a troca é automaticamente realizada após a derrota do mesmo. Organize seu time antes da partida e boa sorte! }
    elseif (%x == 7) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Os líderes de ginásio costumam batalhar com três pokémon, em leveis altos. É um verdadeiro desafio para o treinador, o que torna a vitória uma grande conquista! Prepare seus pokémon para serem os melhores, e não tema os líderes de ginásio! }
    elseif (%x == 8) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - A próxima cidade é Petalburg. Você poderá encontrar um gínasio, mas não creio que poderá lutar ainda. Talvez Roxanne seja sua primeira adversária rumo à Liga Pokémon. }
    elseif (%x == 9) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Fique sempre atento aos eventos que acontecem em cada cidade. Eu, por exemplo, ensino aos treinadores iniciantes técnicas para se desenvolverem ao longo do treinamento. Fique atento a outros eventos nas próximas cidades! }
    elseif (%x == 10) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Os Technical Machines (TMs) são golpes que o treinador pode ensinar ao pokémon! Você pode encontrar alguns destes em lojas ou derrotando líderes de ginásio! }
    elseif (%x == 11) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Mude sempre a ordem de seus pokémon, muitas vezes o pokémon que estiver liderando seu grupo interfere nos eventos. Quem sabe sua sorte mude de acordo com o pokémon no topo do seu time? Fique atento! }
    elseif (%x == 12) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Esteja preparado para as lutas de ginásio. Antes de enfrentar o líder, você terá que derrotar outros treinadores. Ou seja, você terá que vencer várias partidas para conquistar uma nova insígnea! }
    elseif (%x == 13) { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Se você ainda não tem o item PC, é bom se preocupar. Eu ouvi boatos de um presente da enfermeira Joy, mas o que raios será? Eu estou curioso... Quer saber? Treine seus pokémon e boa sorte! }
    else { msg =$nick $chr(160) $cc $+ Matt $ct $+ - Pokémon selvagens podem variar de cidade em cidade. Compre Poke  Balls em lojas para poder capturá-los. }
    writeini pkp\cadastros\ $+ $nick $+ .ini Clock Matt $dados($nick,Info,Online) | return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Petalburg_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Espero que esteja feliz aqui em Petalburg!
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Você poderá encontrar um ginásio pokémon! Estou falando da liga pokémon de Hoenn, você não sabia?
    if ($start($nick)) {
      var %badges = $dados($nick,$dados($nick,Info,Region),Badges).n, %badges = $iif(!%badges,0,%badges)
      if (%badges < 4) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Creio que Norman não batalhe com você até você adquirir mais insígneas. Ele é realmente um páreo duro, você vai precisar de mais experiência se quiser vencê-lo! } | else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Acho que você já está pronto. Boa sorte em sua jornada treinador! }
    }
    return
  }
  elseif ($1 == Writney) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,League)) { msg =$nick $ct $+ Acho que $cc $+ Writney $ct $+ não está mais na cidade... | return }
    msg =$nick $ct $+ Você encontra-se com $cc $+ Writney $+ $ct $+ , um velho navegador.
    msg =$nick $chr(160) $cc $+ Writney $ct $+ - Olá, $nick $+ !
    if ($rini(cadastros,$nick,Quests,Stone)) { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Precisa ir a Dewford? | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] WRT:Dewford City | return }
    else { msg =$nick $chr(160) $cc $+ Writney $ct $+ - Este meu Wingull Peeko é adoravel, não? Somos companheiros há bastante tempo. | return }
  }
  elseif ($1 == Derek) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Derek $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Derek $ct $+ - Droga! Eu sabia que não estava pronto para aquela batalha! Você já viu os pokémon de Norman?! São incríveis! Mas já sei o que vou fazer: vou treinar mais e em breve voltarei para desafiá-lo novamente! Ele vai ver só!
    return
  }
  elseif ($1 == Wally) && ($start($nick)) {
    if ($badge($nick,Balance Badge)) {
      if ($rini(cadastros,$nick,Quests,Wally1)) { msg =$nick $ct $+ Acho que $cc $+ Wally $ct $+ não está mais na cidade... | return }
      else {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Wally $+ $ct $+ , um treinador pokémon.
        msg =$nick $chr(160) $cc $+ Wally $ct $+ - Eu diria que aprendi bastante com a batalha! É assim, junto com meu pokémon, que eu pretendo batalhar e conquistar minhas insígneas. Obrigado, $nick $+ . Obrigado, Norman. Agora entendo tudo claramente.
        msg =$nick $ct $+ Você recebeu o item $cc $+ HM03 $+ $ct $+ . | item.add $nick HM03 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Wally1 Ok
        msg =$nick $chr(160) $cc $+ Wally $ct $+ - Eu vou seguindo a minha própria jornada agora. $nick $+ , nos veremos ainda antes da liga, eu prometo. E esteja preparado. | return
      }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($1 == Norman) {
    if ($badge($nick,Balance Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Norman $+ $ct $+ , líder do ginásio de Petalburg.
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Wally1)) { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Parabéns pela excelente batalha no ginásio. Quem sabe não teremos uma segunda algum dia? }
        else { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Wally está começando sua jornada agora, ele quer recompensá-lo pelo aprendizado que obteve enquanto batalhávamos. }
      }
      else { msg =$nick $chr(160) $cc $+ Norman $ct $+ - Excelente batalha, você possui uma habilidade incrível como treinador. Boa sorte. }
      return
    }
    else { msg =$nick $cc $+ Norman $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Moonlight_Woods { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Rustboro_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Bem vindo a Rustboro!
    if ($start($nick)) {
      msg =$nick $chr(160) $cc $+ Joy $ct $+ - Então você está participando da liga pokémon? Bem, aqui é onde os treinadores dão o seu primeiro passo!
      var %badges = $dados($nick,$dados($nick,Info,Region),Badges).n, %badges = $iif(!%badges,0,%badges)
      if (%badges >= 1) {
        if ($rini(cadastros,$nick,Quests,Joy2)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Lembre-se que ao ensinar um HM ao pokémon, ele não poderá esquecê-lo! Boa sorte! }
        else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Nossa! Você ganhou a insígnea! Parabéns, seus pokémon já podem usar a técnica $cc $+ Cut $+ $ct $+ ! | item.add $nick HM01 | msg =$nick $ct $+ Você ganhou o item $cc $+ HM01 $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Joy2 Ok }
      }
      else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Procure pelo ginásio na cidade para desafiá-lo, porém isso pode custar caro, você vai precisar desembolsar $cc $+ $chr(36) $+ 15000 $ct $+ por desafio! Então, boa sorte! }
    }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - A líder do ginásio desta cidade usa pokémon de pedra. Talvez ela seja 'durona' demais para você. }
    return
  }
  elseif ($1 == May) && ($start($nick)) {
    var %badges = $dados($nick,$dados($nick,Info,Region),Badges).n, %badges = $iif(!%badges,0,%badges)
    if (%badges == 1) {
      msg =$nick $chr(160) $cc $+ May $ct $+ - Yay! $nick $+ ! Como sabia que eu estava aqui? Sou tão previsível assim?
      msg =$nick $chr(160) $cc $+ May $ct $+ - Assim que soube da invenção de PokeDex, eu vim correndo até Rustboro adquirir a minha!
      if ($item($nick,PokeDex).qnt) { msg =$nick $chr(160) $cc $+ May $ct $+ - Não se esqueça de... você já tem a PokeDex... então é melhor eu me apressar! | return }
      else { msg =$nick $chr(160) $cc $+ May $ct $+ - Não se esqueça de pegar a sua também! | return }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($findtok(Stone:Mr Stone:Senhor Stone:Sr Stone,$1,0,58)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Mr Stone $+ $ct $+ , o dono da Devon Corporation.
    if ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Steven1)) {
        if ($rini(cadastros,$nick,Quests,Stone2)) {
          if ($rini(cadastros,$nick,Quests,Stone3)) {
            if ($rini(cadastros,$nick,Quests,League)) {
              if ($item($nick,Gold Ticket).qnt) && (!$dados($nick,Quests,Tidal)) { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Ei, estaremos aguardando a sua presença na viagem de inauguração do $cc $+ SS Tidal $+ $ct $+ ! Você já tem o ingresso, agora só precisa ir até o porto mais próximo. Nosso destino será $cc $+ Johto $+ $ct $+ , já ouviu falar neste continente? | return }
              if (!$item($nick,Gold Ticket).qnt) && ($dados($nick,Quests,Stern4)) {
                msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Oh céus, onde raios eu estava com a minha cabeça! Perdão, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , mas a inauguração do $cc $+ SS Tidal $ct $+ deixou-me um pouco pertubado... Era muita gente para convidar!
                msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Ainda consegue se lembrar de uma carta que eu pedi para entregar a meu filho, em $cc $+ Dewford City $+ $ct $+ ? Bem, tratava-se do projeto do próprio $cc $+ SS Tidal $+ $ct $+ , por isso $cc $+ Steven $ct $+ dirigiu a carta ao capitão $cc $+ Stern $+ $ct $+ , que ficou encarregado de desenvolvê-lo. Você ficará surpreso com o capitão do $cc $+ SS Tidal $+ $ct $+ ... Não direi mais nada, farei com que veja por si mesmo!
                item.add $nick Gold Ticket | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Gold Ticket $+ $ct $+ ! | return
              }
              var %x = $rini(cadastros,$nick,Clock,Stone), %o = $rini(cadastros,$nick,Info,Online)
              if ($calc(%o - %x) >= 18000) { var %x = $rand(0,1) | msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - $nick $+ , olhe, aqui está uma amostra grátis de mais um produto desenvolvido pela minha corporação: $cc $+ $iif(%x,Timer Ball,Repeat Ball) $+ $ct $+ ! | item.add $nick $iif(%x,Timer Ball,Repeat Ball) | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Stone %o | return }
              else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Você pode conferir as novas Poke  Balls criadas pela $cc $+ Devon Corp $ct $+ como a $cc $+ Repeat Ball $ct $+ e a $cc $+ Timer Ball $ct $+ na loja de milhagens! Elas estão ficando muito populares entre os treinadores. Por que não passa aqui depois? Eu vou arrumar uma amostra grátis quando puder. | return }
            }
            else {
              if ($rini(cadastros,$nick,Info,Scope)) { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Você deve gostar de mistérios, $nick $+ , por deixar seu $cc $+ Devon Scope $ct $+ ligado aqui em Rustboro. Eu ouvi falar numa floresta escondida por arbustos e muito escura perto de Petalburg City. Você sabe alguma coisa a respeito? | return }
              if ($team.hm($nick,Fly) == Ok!) { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Utilizar a técnica $cc $+ Fly $ct $+ é muito cômodo, não? Pena que não dá pra chegar em todos os pontos com esta técnica. | return }
              msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Estou desenvolvendo novos tipos de Poke  Balls, em breve você terá alguns desses modelos! Hahaha...
            }
          }
          else {
            if ($rini(cadastros,$nick,Quests,Steven2)) {
              msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Nossa, você andou até Fortree e voltou a Rustboro! Que caminhada, digo, que vôo! Meu filho avança as cidades mais rápido porque ele usa $cc $+ Running Shoes $+ $ct $+ . Que tal você experimentar também?
              msg =$nick $ct $+ Você ganhou o item $cc $+ Running Shoes $+ $ct $+ ! | item.add $nick Running Shoes | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stone3 Ok
            }
            else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Meu filho Steven é um treinador assim como você, por isso está sempre em sua jornada. Ele me disse que estava em uma cidade que foi construída em cima de árvores, acho que seu nome é Fortree City. }
          }

        }
        else {
          msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Obrigado, $nick $+ , por entregar a carta a meu filho Steven em Dewford. Receba isto como agradecimento pelo bom trabalho.
          msg =$nick $ct $+ Você recebeu cinco $cc $+ Great Balls $+ $ct $+ ! | var %x = 0 | while (%x < 5) { inc %x | item.add $nick Great Ball } | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stone2 Ok
        }
        return
      }
      else {
        msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Você é...? $nick $+ ! Ah, acho que Prof Birch me falou de você.
        msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Birch pediu-me para lhe entregar o novo produto que nossa corporação desenvolveu. Ele me garantiu que você é um treinador talentoso!
        if ($badge($nick,Stone Badge)) {
          if ($rini(cadastros,$nick,Quests,Stone)) { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Faz tempo que não vejo um jovem tão cheio de energia como você! Hahaha... Boa sorte! | if (!$findtok($rini(cadastros,$nick,Info,Visited),Dewford City,0,58)) { msg =$nick $chr(160) $cc $+ Devon $ct $+ - Ah, para ir a Dewford City, basta pegar uma balsa com meu amigo Writney em Petalburg. } | return }
          else {
            msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Incrível! Desculpe ter que fazê-lo provar o quanto é forte, eu já sabia que você era capaz. Quando chegar em $cc $+ Dewford City $+ $ct $+ , quero que entregue esta carta a $cc $+ Steven $+ $ct $+ , meu filho. Para isso, basta pegar uma balsa com $cc $+ Writney $+ $ct $+ , em $cc $+ Petalburg City $+ $ct $+ . Agora chega de conversa e vamos ao que interessa!
            msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Desenvolvemos uma enciclopédia pokémon chamada $cc $+ PokeDex $+ $ct $+ ! Fale com meu assistente $cc $+ Walter $+ $ct $+ , ele vai entregar-lhe uma. Boa sorte, $dados($nick,Info,Nick) $+ , na sua jornada!
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stone Ok | return
          }
        }
        else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Mostre-me o seu talento, e derrote a líder desta cidade, $cc $+ Roxanne $+ $ct $+ . Será que você consegue? Hmm, claro! Boa sorte! | return }
      }
    }
    else {
      if ($dados($nick,Hoenn,League)) {
        if ($dados($nick,Quests,Stone1)) {
          if ($dados($nick,Quests,Steven1)) {
            if ($item($nick,Gold Ticket).qnt) {
              if ($dados($nick,Quests,Tidal)) {
                var %x = $rini(cadastros,$nick,Clock,Stone), %o = $rini(cadastros,$nick,Info,Online)
                if ($calc(%o - %x) >= 18000) { var %x = $rand(0,1) | msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - $nick $+ , olhe, aqui está uma amostra grátis de mais um produto desenvolvido pela minha corporação: $cc $+ $iif(%x,Timer Ball,Repeat Ball) $+ $ct $+ ! | item.add $nick $iif(%x,Timer Ball,Repeat Ball) | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Stone %o }
                else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Você pode conferir as novas Poke  Balls criadas pela $cc $+ Devon Corp $ct $+ como a $cc $+ Repeat Ball $ct $+ e a $cc $+ Timer Ball $ct $+ na loja de milhagens! Elas estão ficando muito populares entre os treinadores. Por que não passa aqui depois? Eu vou arrumar uma amostra grátis quando puder. }
              }
              else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Estaremos aguardando a sua presença na viagem de inauguração. Está ancioso para conhecer $cc $+ Johto $+ $ct $+ ? }
            }
            else {
              msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Hahaha, vejo que você encontrou-se com $cc $+ Steven $+ $ct $+ , meu filho. Ele acabou de me comunicar que adorou a batalha que vocês tiveram e que, sem dúvida, você tinha muito talento...
              msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Sabe, adoro ajudar treinadores talentosos, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Não vejo outra saída a não ser convidá-lo a vir conosco a bordo do $cc $+ SS Tidal $+ $ct $+ ! Será a viagem de inauguração, tenho certeza de que vai gostar. Nosso destino será $cc $+ Johto $+ $ct $+ , mas eu pessoalmente terei que voltar pois há muito trabalho a ser feito...
              msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Gold Ticket $+ $ct $+ ! | item.add $nick Gold Ticket
            }
          }
          else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Prepare, estou certo de que, se ele encontrá-lo, vocês terão uma batalha e tanto! }
        }
        else {
          msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Hahaha, parabéns! Você conseguiu derrotar a liga pokémon de $cc $+ Hoenn $+ $ct $+ ! Sabe, vou contar-lhe um pequeno segredo: meu filho também é um treinador muito famoso, mas duvido que você tenha ouvido falar nele porque, digamos, ele não está mais na ativa... Bem, você encontrará respostas em $cc $+ Meteor Falls $+ $ct $+ : ele adora pedras raras!
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stone1 Ok
        }
      }
      else { msg =$nick $chr(160) $cc $+ Mr Stone $ct $+ - Então você é o famoso $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , huh? Você certamente é bem popular aqui em $cc $+ Hoenn $+ $ct $+ , pois já ouvi falar muito de você! }
    }
  }
  elseif ($1 == Walter) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Walter $+ $ct $+ , um cientista da Devon.
    if ($rini(cadastros,$nick,Quests,Stone)) {
      if ($rini(cadastros,$nick,Quests,Walter)) { msg =$nick $chr(160) $cc $+ Walter $ct $+ - Para ver informações de seu pokémon com a PokeDex, digite $cc $+ .pokedex <pokémon> $+ $ct $+ . Agora, vou voltar ao trabalho. | return }
      else { msg =$nick $chr(160) $cc $+ Walter $ct $+ - Huh? Ah sim, desculpe. Aqui está sua PokeDex. | item.add $nick PokeDex | msg =$nick $ct $+ Você ganhou o item $cc $+ PokeDex $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Walter Ok }
    }
    else {
      msg =$nick $chr(160) $cc $+ Walter $ct $+ - Por favor! Estou ocupado agora! | return
    }
  }
  elseif ($1 == Shelby) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Shelby $+ $ct $+ , a recepcionista da Devon.
    msg =$nick $chr(160) $cc $+ Shelby $ct $+ - Olá, $nick $+ ! Esta é a Corporação Devon, desenvolvemos por aqui tecnologias para uso de treinadores, como você! Por favor, não faça muito barulho, há cientistas trabalhando.
    return
  }
  elseif ($1 == Roxanne) {
    if ($badge($nick,Stone Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Roxanne $+ $ct $+ , líder do ginásio de Rustboro.
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Joy2)) { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Eu nunca achei que perderia usando meus pokémon e minha estratégia. Mas a sua superou a minha, no final das contas. }
        else { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Agora que ganhou sua insígnea, você pode ensinar a técnica Cut para seus pokémon. Procure pela enfermeira do centro pokémon. }
      }
      else { msg =$nick $chr(160) $cc $+ Roxanne $ct $+ - Muito bem, não fico triste por ter perdido uma batalha com alguém como você. É um aprendizado, na verdade. Boa sorte. }
      return
    }
    else { msg =$nick $cc $+ Roxanne $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. } | return
}
alias c.search.Dewford_City {
  if ($1 == Steven) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,Steven1)) { msg =$nick $ct $+ Acho que $cc $+ Steven $ct $+ não está mais na cidade. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Steven Stone $+ $ct $+ . | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Sim?
      if ($rini(cadastros,$nick,Quests,Stone)) { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Hm? Uma carta para mim? | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Ah, agora entendo. Você conquistou sua primeira insígnea com Roxanne, e logo após fiquei sabendo de sua existência. Seu nome é... $cc $+ $dados($nick,Info,Nick) $ct $+ certo? Nada mal, para um iniciante. | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Obrigado pela carta. A propósito, mostre-a ao capitão $cc $+ Stern $ct $+ em $cc $+ Slateport City $+ $ct $+ . Aqui está, o $cc $+ TM47 $+ $ct $+ . Ele ensina a técnica Steel Wing, é uma maravilha! Bem, esta é minha deixa. Até mais! | item.add $nick TM47 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Steven1 Ok | return }
      else { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Não entendo, nós nos conhecemos? | return }
    }
  }
  elseif ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Bem vindo a $cc $+ $dados($nick,Info,Locate) $+ $ct $+ ! Aqui você pode encontrar uma belíssima praia, e ainda uma caverna rochosa logo ao norte da cidade. Mas cuidado, ouvi rumores de pokémon fantasma naquela caverna! Assustador, não?
    return
  }
  elseif ($1 == Writney) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,League)) { msg =$nick $ct $+ Acho que $cc $+ Writney $ct $+ não está mais na cidade... | return }
    msg =$nick $ct $+ Você encontra-se com $cc $+ Writney $+ $ct $+ , um velho navegador.
    msg =$nick $chr(160) $cc $+ Writney $ct $+ - Olá, $nick $+ ! Deseja voltar a $cc $+ Petalburg City $ct $+ ou prosseguir até $cc $+ Slateport City $+ $ct $+ ?
    msg =$nick $ct $+ Para confirmar, digite ' $+ $cc $+ .Sim <destino> $+ $ct $+ ', especificando o destino, ou rejeite digitando ' $+ $cc $+ .nao $+ $ct $+ '. | set %confirm. [ $+ [ $nick ] ] WRT:Petalburg City;Slateport City
    return
  }
  elseif ($1 == Brawly) {
    if ($badge($nick,Knuckle Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Brawly $+ $ct $+ , líder do ginásio de Dewford.
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Steven1)) { msg =$nick $chr(160) $cc $+ Brawly $ct $+ - Com a insígnea $cc $+ Knuckle Badge $ct $+ que recebeu neste ginásio, você poderá usar $cc $+ Flash $ct $+ fora das batalhas. | if (!$item($nick,HM05).qnt) { item.add $nick HM05 | msg =$nick $ct $+ Você ganhou o item $cc $+ HM05 $+ $ct $+ . } }
        else { msg =$nick $chr(160) $cc $+ Brawly $ct $+ - Quando fui treinar na Granite Cave, conheci um treinador chamado $cc $+ Steven $ct $+ e ele me parece ser muito experiente como treinador de pokémon. }
      }
      else { msg =$nick $chr(160) $cc $+ Brawly $ct $+ - A força de um pokémon lutador, quando bem utilizada, pode derrubar montanhas... | return }
      return
    }
    else { msg =$nick $cc $+ Brawly $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Slateport_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Slateport é famosa por causa de sua grande variedade de itens em seu estoque, importadas de todos os cantos do mundo!
    if (!$rini(cadastros,$nick,Quests,Stern1)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Ah, ja visitou o museu? Se não, é bom dar uma olhada! }
    return
  }
  elseif ($1 == Aqua) || ($1 == Sam) {
    if ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Stern1)) { msg =$nick $ct $+ Aqueles ladrões já sairam da cidade... | return }
      else {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Sam $+ $ct $+ , membro da Equipe Aqua.
        msg =$nick $chr(160) $cc $+ Sam $ct $+ (AQUA) - Sim, sou membro da Equipe Aqua. Estou numa missão agora!
        if (!$rini(cadastros,$nick,Quests,Aqua1)) { msg =$nick $chr(160) $cc $+ Sam $ct $+ (AQUA) - Ah, garoto, toma isto e vai embora. | item.add $nick TM46 | msg =$nick $ct $+ Você ganhou o item $cc $+ TM46 $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Aqua1 Ok }
        return
      }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($1 == Stern) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Stern $+ $ct $+ , o famoso capitão marinho.
    if ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Stern3)) {
        if ($dados($nick,Kanto,League)) {
          if ($dados($nick,Quests,Stern4)) { msg =$nick $chr(160) $cc $+ Stern $ct $+ - $cc $+ SS Tidal $ct $+ é suficiente capaz de aguentar mares agitados da costa, como é o caso do continente $cc $+ Johto $+ $ct $+ . Há muitos redemoinhos por ali, por isso este navio fará certamente muito sucesso! }
          else {
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Bravo! Bravo! $cc $+ SS Tidal $ct $+ finalmente foi concluído! Você devia aproveitar para viajar na viagem de inauguração. Ah, não foi convidado? Tenho certeza que $cc $+ Mr Stone $ct $+ fará questão da sua presença naquele navio!
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stern4 Ok
          }
        }
        else { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Não se preocupe, quando eu finalmente concluir o $cc $+ SS Tidal $ct $+ darei um jeito de avisá-lo. Hahaha... }
        if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) {
          if ($dados($nick,Wailord,Name)) && ($dados($nick,Relicanth,Name)) {
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Me pergunto o que raios você faz com $cc $+ Wailord $ct $+ e $cc $+ Relicanth $ct $+ em seu time. Alias, já suspeito o que pretende fazer.
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Se estiveres em busca de respostas para a lenda de $cc $+ Pacifidlog Town $+ $ct $+ , saiba que esses pokémon são a chave. Como eu sei? Bem, eu já pesquisei muito a respeito disso nos últimos anos. Sei também que estes pokémon precisam estar perfeitamente posicionados no time para que a porta seja aberta.
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - A única parte do enigma que ainda não consegui decifrar é a localização da porta. Talvez um pokémon voador $cc $+ consiga $ct $+ alcançá-la, já que ela está nos céus.
          }
          elseif ($dados($nick,Wailord,Name)) { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Hm, é um $cc $+ Wailord $+ $ct $+ ? Ah, sabia! O gigante das águas... }
          elseif ($dados($nick,Relicanth,Name)) { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Hm, é um $cc $+ Relicanth $+ $ct $+ ? Ah, sabia! O ancião dos mares... }
          else { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Os mares de $cc $+ Hoenn $ct $+ guardam muitos mistérios, sabia? $cc $+ Kyogre $ct $+ não é o único pokémon ancião que habita as profundezas. }
        }
        return
      }
      if ($rini(cadastros,$nick,Quests,Stern1)) {
        if ($rini(cadastros,$nick,Quests,Stern2)) {
          if ($rini(cadastros,$nick,Quests,Aqua4)) {
            if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Não!! Eles acordaram Kyogre! Eu me sinto indiretamente culpado por isso... Eu não sabia que minha descoberta fosse provocar esta situação! }
            elseif ($rini(cadastros,$nick,Quests,Sky2)) {
              msg =$nick $chr(160) $cc $+ Stern $ct $+ - Ah! $nick $+ ! Eu soube de suas realizações em Sootopolis! Saiba que você salvou toda Hoenn com isso, além de que agora estou mais aliviado. Se a situação não melhorasse, eu iria passar o resto da minha vida me culpando pelo o que aconteceu... se eu não tivesse feito a descoberta... Mas finalmente! Agora estou feliz por tudo ter dado certo!
              var %i = $rand(0,1), %i = $iif(%i,Deepseatooth,Deepseascale) | msg =$nick $chr(160) $cc $+ Stern $ct $+ - Em minhas expedições marinhas, eu encontrei um item raro no fundo dos mares: $cc $+ %i $+ $ct $+ ! Aceite este item. Por favor, eu insisto! | item.add $nick %i | msg =$nick $ct $+ Você ganhou o item $cc $+ %i $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stern3 %i
            }
            else { msg =$nick $chr(160) $cc $+ Stern $ct $+ - Aqueles ladrões da Equipe Aqua... roubaram meu Submarino Explorer! Logo quando encontramos um pokémon que estava extinto bem no fundo dos oceanos, em Silver Bay... Se eles estiverem atrás desse pokémon... Não, não quero pensar nisso. }
            return
          }
          else {
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Obrigado por me ajudar. Agora posso concluir meus projetos em paz. | return
          }
        }
        else {
          msg =$nick $chr(160) $cc $+ Stern $ct $+ - Você conheceu o jovem Steven, em Dewford?
          if ($rini(cadastros,$nick,Quests,Steven1)) {
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Ah, ele me mandou uma carta do pai dele? Hmm... hmm... está certo. Que boas notícias!
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Ok, jovem, obrigado por esta carta. Deve ter tido um trabalho para vir deixá-la até mim, não? Certamente. Então, você merece isto.
            var %i = $rand(1,7), %i = $iif(%i == 7,Mystic Water,Soft Sand)
            item.add $nick %i | msg =$nick $ct $+ Você ganhou o item $cc $+ %i $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stern2 %i | return
          }
          else {
            msg =$nick $chr(160) $cc $+ Stern $ct $+ - Ah, não? Que pena... Ah, a propósito, ele é filho de Mr Stone. Você deve conhecê-lo, suponho. Mas não se preocupe, acho que Steven ainda está em Dewford.
            return
          }
        }
      }
      else {
        msg =$nick $chr(160) $cc $+ Stern $ct $+ - $nick $+ ! Me ajude! Estes ladrões querem roubar meu projeto do Submarino Explorer!
        msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] AQU:1 | return
      }
    }
    else {
      if ($dados($nick,Quests,Stern1)) {
        msg =$nick $chr(160) $cc $+ Stern $ct $+ - O que achou do meu museu? Deu muito trabalho construí-lo, mas é algo que eu tenho orgulho de ter feito! | return
      }
      else {
        msg =$nick $chr(160) $cc $+ Stern $ct $+ - Olá, sou o capitão $cc $+ Stern $+ $ct $+ . Você ouviu falar no $cc $+ Submarino Explorer $+ $ct $+ ?
        msg =$nick $chr(160) $cc $+ Stern $ct $+ - Ao navegá-lo, acabei encontrando uma caverna no fundo do mar, localizada próxima a $cc $+ Sootopolis City $+ $ct $+ . Mas roubaram meu submarino e despertaram nesse lugar um pokémon legendário. Quase que causam o fim do mundo...
        msg =$nick $chr(160) $cc $+ Stern $ct $+ - Então você é habitante de $cc $+ $dados($nick,Info,Start) $+ $ct $+ ? Interessante, eu adoraria visitar essa região. Ouvi falar que há pokémon que não aparecem por aqui em $cc $+ Hoenn $+ $ct $+ , é verdade?
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Stern1 Ok | return
      }
    }
  }
  elseif ($1 == Ricky) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ricky $+ $ct $+ , um estudante.
    msg =$nick $chr(160) $cc $+ Ricky $ct $+ - Stern, que construiu este belo museu, também é o líder de uma equipe de exploração oceânica. É por isso que todos o chamam de Capitão Stern.
    return
  }
  elseif ($1 == Rose) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Rose $+ $ct $+ , uma treinadora pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Rose $ct $+ - Nossa! Então existe um pokémon extinto no fundo dos mares...! Estou tão emocionada... }
    elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Rose $ct $+ - Meu sonho foi finalmente realizado, um dos mistérios dos mares foi descoberto! Nossa, como eu amo o mar! Será que existem mais mistérios em suas profundezas? }
    else { msg =$nick $chr(160) $cc $+ Rose $ct $+ - Quando eu era criança, eu costumava visitar o museu todos os dias e sonhava com os mistérios que existem no fundo dos oceanos... }
    if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Rose $ct $+ - Uma porta nos céus de $cc $+ Pacifidlog Town $+ $ct $+ ? Isso não faz o menor sentido. Se realmente existir uma, é melhor procurá-la rápido. }
    return
  }
  elseif ($1 == Writney) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,League)) { msg =$nick $ct $+ Acho que $cc $+ Writney $ct $+ não está mais na cidade... | return }
    msg =$nick $ct $+ Você encontra-se com $cc $+ Writney $+ $ct $+ , um velho navegador.
    msg =$nick $chr(160) $cc $+ Writney $ct $+ - Olá, $nick $+ !
    msg =$nick $chr(160) $cc $+ Writney $ct $+ - Precisa ir a Dewford? | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] WRT:Dewford City | return
    return
  }
  elseif ($1 == Aline) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Aline $+ $ct $+ , a responsável pelo porto.
    if ($dados($nick,$dados($nick,Info,Start),Badges).n == 8) {
      var %x = $dados($nick,Clock,Ship), %y = 0
      if (%x) { if ($calc($dados($nick,Info,Online) - %x) >= 21600) { var %y = 1 } } | else { var %y = 1 }
      if (%y) {
        if ($item($nick,Gold Ticket).qnt) && ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Aline $ct $+ - Oh, este é o $cc $+ Silver Ticket $ct $+ e o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Anne) $+ $ct $+ ) ou no $cc $+ SS Tidal $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Tidal) $+ $ct $+ ) $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim <barco> $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne;SS Tidal
        }
        elseif ($item($nick,Gold Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Aline $ct $+ - Oh, este é o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Tidal $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Tidal
        }
        elseif ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Aline $ct $+ - Oh, este é o $cc $+ Silver Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne
        }
        else { msg =$nick $chr(160) $cc $+ Aline $ct $+ - Você não pode embarcar se não tiver uma passagem de navio. }
      }
      else { msg =$nick $chr(160) $cc $+ Aline $ct $+ - Não há barcos nesse momento. Você deve aguardar seis horas $cc $+ online $ct $+ para tentar novamente. Neste momento, faltam aproximadamente $dur($calc(21600 - ($dados($nick,Info,Online) - %x)),$ct,$cc) $+ . }
      return
    }
    else { msg =$nick $chr(160) $cc $+ Aline $ct $+ - Ah, que pena. Infelizmente não há nenhum barco neste momento. | return }
  }
  elseif ($1 == May) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,May2)) { msg =$nick $ct $+ Acho que $cc $+ May $ct $+ não está mais na cidade. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ May $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ May $ct $+ - Ah! $nick $+ ! Estava mesmo precisando te encontrar!
      msg =$nick $chr(160) $cc $+ May $ct $+ - Eu capturei bastante pokémon nestes ultimos dias, e agora estão ficando bem fortes!
      msg =$nick $chr(160) $cc $+ May $ct $+ - Ei, que tal uma batalha? Eu usarei cinco pokémon, organize seu time e manda ver!
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] MAY:1 | return
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. } | return
}
alias c.search.Mauville_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Seja bem vindo a Mauville. É comum aparecerem pokémon elétricos na região e aparelhos eletrônicos quebrarem, graças a uma usina elétrica abandonada, mas acredito que ninguém tenha acesso a ela atualmente. | return
  }
  elseif ($1 == Russel) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Russel $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Russel $ct $+ - Aos arredores de Mauville existe uma usina elétrica abandonada. É por isso que aparecem tantos pokémon elétricos, pois esta usina guarda um gerador que emite ondas eletromagnéticas. Não sei, mas acho que alguém ainda tem acesso a ela... | return
  }
  elseif ($1 == Kessy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Kessy $+ $ct $+ , uma criadora pokémon.
    if ($badge($nick,Dynamo Badge)) {
      if ($item($nick,HM06).qnt) { msg =$nick $chr(160) $cc $+ Kessy $ct $+ - Às vezes eu me sinto mal com este ambiente de Mauville... Mas como está indo, $nick $+ , sua jornada? Ahh, estou enjoada. }
      else {
        msg =$nick $chr(160) $cc $+ Kessy $ct $+ - Nossa, mas nem o Magneton de Wattson teve energia suficiente para aguentar o poder dos seus pokémon!
        item.add $nick HM06 | msg =$nick $ct $+ Você recebeu o item $cc $+ HM06 $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Kessy $ct $+ - HM06 é Rock Smash. Agora você poderá quebrar as pedras que existem no caminho entre Mauville e Lavaridge. Boa sorte em sua jornada!
      }
    }
    else { msg =$nick $chr(160) $cc $+ Kessy $ct $+ - É impressionante como Magnetons absorvem energia elétrica do ambiente. É com toda essa energia que os pokémon de Wattson, líder do ginásio da cidade, derrotam qualquer oponente! }
    return
  }
  elseif ($1 == Emma) {
    if ($start($nick)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Emma $+ $ct $+ , ela parece assustada.
      if ($rini(cadastros,$nick,Quests,Aqua4)) {
        if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Emma $ct $+ - Mãe... Estou com medo... Ouvi falar que em $cc $+ Sootopolis $ct $+ uma batalha colossal está sendo travada... }
        elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Emma $ct $+ - $cc $+ Rayquaza $+ $ct $+ ... Mãe, eu disse! Aquele raio nos céus era realmente um pokémon! }
        else { msg =$nick $chr(160) $cc $+ Emma $ct $+ - Ahn... Mamãe não acredita em mim... Estou com um pressentimento ruim... }
      }
      else { msg =$nick $chr(160) $cc $+ Emma $ct $+ - Eu vi! Eu vi! Aquele raio nos céus era um pokémon! Eu juro! }
    }
    else {
      msg =$nick $chr(160) $cc $+ Emma $ct $+ - $cc $+ Rayquaza $ct $+ é um pokémon gigantesco que voa sobre as nuvens... Felizmente eu vi um outra vez, mas ninguém acredita em mim...
    }
    if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Emma $ct $+ - $cc $+ Rayquaza $ct $+ também mostrou-me onde a porta estava, mas foi muito rápido. Eu não pude vê-la por muito tempo... }
    return
  }
  elseif ($1 == Maria) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Maria $+ $ct $+ , a mãe de Emma.
    msg =$nick $chr(160) $cc $+ Maria $ct $+ - Certo, Emma! Se continuar assustando os visitantes com suas histórias eu não vou comprar a sua bicicleta!
    if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Maria $ct $+ - $cc $+ Emma $ct $+ está incrível hoje... Estou arrependida de tê-la levado a $cc $+ Sootopolis City $ct $+ outra vez. Em menos de $cc $+ dez $ct $+ segundos na cidade, ela berrou sobre uma história de porta nos céus... Preciso ter muita paciência para aguentar a mente criativa dela. }
    return
  }
  elseif ($1 == Rydel) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Rydel $+ $ct $+ , dono da loja de bicicletas.
    if ($rini(cadastros,$nick,Quests,Rydel) == Ok) {
      if ($item($nick,Mach Bike).qnt) {
        msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Deseja trocar sua $cc $+ Mach Bike $ct $+ pela $cc $+ Acro Bike $+ $ct $+ ?
        msg =$nick $ct $+ Digite ' $+ $cc $+ .sim $+ $ct $+ ' para confirmar, ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] RYD:Mach Bike | return
      }
      else {
        msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Deseja trocar sua $cc $+ Acro Bike $ct $+ pela $cc $+ Mach Bike $+ $ct $+ ?
        msg =$nick $ct $+ Digite ' $+ $cc $+ .sim $+ $ct $+ ' para confirmar, ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] RYD:Acro Bike | return
      }
    }
    else {
      if ($rini(cadastros,$nick,Info,Online) < 259200) { msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Oh, $nick $+ . Assim que você tiver suas 72 horas online, venha falar comigo e eu te darei uma bicicleta. | return }
      else {
        if ($start($nick)) { msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Incrível! Você andou desde Littleroot a pé? Nossa, você tem muita garra, garoto. Este é o espírito das bicicletas Rydel! } | else { msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Você veio de muito longe e nunca teve sequer uma bicicleta! Estou muito comovido, este é o espírito das bicicletas Rydel! }
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Rydel Ok
        item.add $nick Mach Bike | msg =$nick $ct $+ Você recebeu o item $cc $+ Mach Bike $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Com a Mach Bike, você receberá o dobro de milhagens que normalmente você deveria receber. Uma maravilha! | msg =$nick $chr(160) $cc $+ Rydel $ct $+ - Sempre que quiser mudar de bicicleta, venha falar comigo aqui em Mauville. | return
      }
    }
  }
  elseif ($1 == Edgar) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Edgar $+ $ct $+ , um pescador.
    msg =$nick $chr(160) $cc $+ Edgar $ct $+ - Hahaha, desta vez eu peguei um Magikarp dos grandes!
    if ($start($nick)) {
      if (!$item($nick,Old Rod).qnt) {
        msg =$nick $chr(160) $cc $+ Edgar $ct $+ - Então quer dizer que você não pode pescar? Ora, não fique triste, pode ficar com esta $cc $+ Old Rod $+ $ct $+ !
        item.add $nick Old Rod | msg =$nick $chr(160) $cc $+ Edgar $ct $+ - Para pescar usando sua Rod, basta utilizar o item antes de sua batalha com pokémon selvagem. Lembre-se de parar de usar o item quando não quiser mais pescar!
      }
    }
    return
  }
  elseif ($1 == Ana) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ana $+ $ct $+ , uma treinadora pokémon.
    msg =$nick $chr(160) $cc $+ Ana $ct $+ - Eu trouxe meus dois pokémon para o centro de criação e obtive um ovo! Mas o que é interessante é que o bebê nasceu com uns golpes que não achei que poderia aprender...! | return
  }
  elseif ($1 == Lola) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lola $+ $ct $+ , a criadora de pokémon do centro de criação.
    msg =$nick $chr(160) $cc $+ Lola $ct $+ - Olá, $nick $+ . Bem vindo ao Daycare Center, você quer obter uma nova geração dos seus pokémon? É muito simples, basta você digitar ' $+ $cc $+ .Daycare $+ $ct $+ '. | return
  }
  elseif ($1 == Tob) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Tob $+ $ct $+ , o criador de pokémon do centro de criação.
    msg =$nick $chr(160) $cc $+ Tob $ct $+ - Obter ovos de seus pokémon é muito importante, pois existem golpes que os pokémon só aprendem por cruzamentos. Você pode cruzar também seu pokémon com o de seu amigo, veja em ' $+ $cc $+ .Daycare $+ $ct $+ '. Mas lembre-se que quem vai ficar com o ovo é quem ficou em modo de espera inicialmente. | return
  }
  elseif ($1 == Wattson) {
    if ($badge($nick,Dynamo Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Wattson $+ $ct $+ , líder do ginásio de Mauville.
      msg =$nick $chr(160) $cc $+ Wattson $ct $+ - Hahaha... Gostei bastante de batalhar com você, $nick $+ . A propósito, já conhece o centro de criação para pokémon? É logo ali!
      if ($badge($nick,Thunder Badge)) {
        if ($dados($nick,Quests,Wattson) == No) {
          if ($dados($nick,Quests,PPlant)) {
            msg =$nick $chr(160) $cc $+ Wattson $ct $+ - Ah, finalmente o perigo foi embora, graça a você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Pode ficar com isto, aumentará o dano de ataques $cc $+ Electric $+ $ct $+ !
            item.add $nick Magnet | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Wattson Ok | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ Magnet $+ $ct $+ !
          }
          else { msg =$nick $chr(160) $cc $+ Wattson $ct $+ - Estou realmente preocupado com a $cc $+ Power Plant $ct $+ de $cc $+ Kanto $+ $ct $+ ... }
        }
        elseif (!$dados($nick,Quests,Wattson)) {
          msg =$nick $chr(160) $cc $+ Wattson $ct $+ - Preciso de um favor urgente, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Há um gerador na $cc $+ Power Plant $ct $+ de $cc $+ Kanto $ct $+ que está esquentando muito, e isso pode causar muitos problemas, principalmente para os pokémon! Você precisa desligar para mim, pode fazer isto?
          item.add $nick Power Key | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Wattson No | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ Power Key $+ $ct $+ .
        }
      }
      return
    }
    else { msg =$nick $cc $+ Wattson $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Verdanturf_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá. Esta é Verdanturf, que como o próprio nome já diz, a cidade mais verde de Hoenn! É incrível, todos estes jardins, a paisagem, a floresta, tudo faz com que este lugar seja realmente lindo. Os pokémon adoram, pelo menos.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Ao lado existe o Rusturf Tunnel, um túnel construido pra ser uma rota de fácil acesso entre Rustboro e Verdanturf, porém o projeto não se concluiu, e atualmente só conseguem atravessar treinadores com pokémon fortes. | return
  }
  elseif ($1 == Jay) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Jay $+ $ct $+ , uma naturalista.
    msg =$nick $chr(160) $cc $+ Jay $ct $+ - Este lugar é sem dúvida um paraíso. Sinta o cheiro do ar puro e da natureza, este lugar é abençoado. Sempre que posso eu passo em Verdanturf para relaxar.
    msg =$nick $chr(160) $cc $+ Jay $ct $+ - Já ouviu falar na Battle Tent? Nela você pode criar batalhas de até seis pokémon, perfeita para pequenas competições entre amigos. | return
  }
  elseif ($1 == Jerry) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Jerry $+ $ct $+ , um estudante.
    msg =$nick $chr(160) $cc $+ Jerry $ct $+ - Eu ouvi falar que para quebrar pedras, o pokémon precisa saber a técnica Rock Smash. Só não me lembro o que dizia no livro sobre uma insígnea... | return
  }
  elseif ($1 == Isabel) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Isabel $+ $ct $+ , uma criadora de pokémon.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Isabel $ct $+ - Seu nome é Koji. Ele está dentro do Rusturf Tunnel, e não consegue quebrar as pedras com a força de seus pokémon lutadores... | return }
    else { msg =$nick $chr(160) $cc $+ Isabel $ct $+ - Eu adoraria poder viajar entre continentes, assim como você. Infelizmente eu não tenho dinheiro... | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Rusturf_Tunnel {
  if ($1 == Koji) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Koji $+ $ct $+ , um treinador pokémon.
    if ($item($nick,HM04).qnt) { msg =$nick $chr(160) $cc $+ Koji $ct $+ - HM04 é Strength. Seu pokémon será capaz de mover blocos de pedras suspensos, mas infelizmente não conseguirá quebrá-los. }
    else {
      msg =$nick $chr(160) $cc $+ Koji $ct $+ - Você também está preso? Pode me ajudar? Não consigo quebrar as pedras...
      if ($team.hm($nick,Rock Smash) == Ok!) {
        msg =$nick $chr(160) $cc $+ Koji $ct $+ - Oh, obrigado. Então para quebrar pedras, preciso usar Rock Smash... Quando sair daqui eu vou atrás de ensinar esta técnica para meus pokémon lutadores.
        item.add $nick HM04 | msg =$nick $ct $+ Você ganhou o item $cc $+ HM04 $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Koji $ct $+ - Strength permite empurrar blocos de pedra suspensos, mas não poderá quebrá-los.
      }
      else { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Vejo que você também não consegue... Quando puder, por favor me avise. }
    }
    return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Lavaridge_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ . Esta cidade é Lavaridge, o clima aqui é bem quente porque a cidade está situada logo ao lado do Mt Chimney. | return
  }
  elseif ($1 == Elliot) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Elliot $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Elliot $ct $+ - $nick $+ , vai desafiar o ginásio? É bom você saber que a líder local usa pokémon de fogo. Eu tentei desafiar o ginásio, mas as batalhas individuais com os outros treinadores acabou me derrubando... | return
  }
  elseif ($1 == Ethan) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ethan $+ $ct $+ , um treinador pokémon.
    if ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Ethan $ct $+ - Vejo que você é um treinador muito experiente. No entanto, há ainda muito para se caminhar até a posição de $cc $+ mestre $ct $+ pokémon... | return }
    else { msg =$nick $chr(160) $cc $+ Ethan $ct $+ - Você é um treinador? Suponho que seja iniciante. Bem, para avançar seu nível em experiência, você precisará derrotar a liga. Então, até lá é uma longa caminhada, não? } | return
  }
  elseif ($1 == Cyndy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Cyndy $+ $ct $+ , uma habitante da cidade.
    if ($rini(cadastros,$nick,Quests,Cyndy)) {
      msg =$nick $chr(160) $cc $+ Cyndy $ct $+ - Sempre que precisar de um ovo pokémon, vá ao centro de criação em Mauville. | return
    }
    else {
      if ($teampos($nick,Egg)) { msg =$nick $chr(160) $cc $+ Cyndy $ct $+ - Oh, então você já tem um Egg? Quando ele se chocar, eu ficarei feliz de te dar este aqui. }
      else {
        msg =$nick $chr(160) $cc $+ Cyndy $ct $+ - Eu levei meus pokémon ao centro de criação e recebi um ovo, mas não tenho condições de criá-lo. Pode levar.
        if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você já tem $cc $+ seis $ct $+ pokémon. Libere espaço no seu time para recebe-lo. | return }
        var %r = $rand(1,10) | if (%r == 10) { var %pk = Wynaut } | elseif (%r > 6) { var %pk = Azurill } | else { var %pk = Pichu } | echo $addpoke($nick,Egg,%pk,Presente de Cyndy em Lavaridge,31: $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(15,25) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31),0,0)
        msg =$nick $ct $+ Parabéns! Você recebeu um $cc $+ Egg $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Cyndy %pk
      }
      return
    }
  }
  elseif ($findtok(Magma:Maxie:Magma Hideout:Hideout,$1-,0,58)) {
    if ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Magma2)) {
        if ($rini(cadastros,$nick,Quests,Magma2) == Ok) {
          msg =$nick $ct $+ Não há mais membros da Equipe $cc $+ Magma $ct $+ em $cc $+ Lavaridge $+ $ct $+ , seu $cc $+ Magma Hideout $ct $+ está deserto. | return
        }
        else {
          if ($item($nick,Magma Emblem).qnt) {
            if ($team.hm($nick,Strength) == No!) { msg =$nick $ct $+ A entrada do $cc $+ Magma Hideout $ct $+ está protegida por uma pedra, talvez você deva empurrá-la... | return }
            msg =$nick $ct $+ Você conseguiu entrar no $cc $+ Magma Hideout $+ $ct $+ , em $cc $+ $rini(cadastros,$nick,Info,Locate) $+ $ct $+ ! Alguns membros estão tentando expulsá-lo, o que você deseja fazer?
            msg =$nick $ct $+ Digite $cc $+ .Sim $ct $+ para batalhar contra eles e $cc $+ .nao $ct $+ para sair do $cc $+ Magma Hideout $+ $ct $+ . | set %confirm. [ $+ [ $nick ] ] MGM:2
          }
          else { msg =$nick $ct $+ Você não conseguiu encontrar o $cc $+ Magma Hideout $+ $ct $+ , parece que é necessário um item para isso. | return }
        }
      }
      else { msg =$nick $ct $+ Nada foi encontrado. }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. }
    return
  }
  elseif ($1 == Isaiah) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Isaiah $+ $ct $+ , um triatleta.
    msg =$nick $chr(160) $cc $+ Isaiah $ct $+ - Nossa, acho que vou subir o Mt Chimney ainda hoje! Tuff.. Tuff.. Melhor eu descansar. | return
  }
  elseif ($1 == Flannery) {
    if ($badge($nick,Heat Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Flannery $+ $ct $+ , líder do ginásio de Lavaridge.
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Cozmo) != Ok) { msg =$nick $chr(160) $cc $+ Flannery $ct $+ - Não consigo imaginar como seria se o Mt Chimney entrasse em erupção, imagine, todos os pokémon que vivem aqui... Seria um desastre! }
        else { msg =$nick $chr(160) $cc $+ Flannery $ct $+ - Antes de me tornar líder, eu fui a Meteor Falls mas não consegui achar nenhum $cc $+ Meteorite $+ $ct $+ . Dizem que aquele lugar é 'especial' por estranhas aparições de pokémon desconhecidos. }
      }
      else { msg =$nick $chr(160) $cc $+ Flannery $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ... Você já ouviu falar no $cc $+ Mt Ember $+ $ct $+ ? Ouvi rumores de que neste lugar, um pássaro guardião protege seu território com o calor de suas penas. Meu desejo é encontrar esse lugar. }
      return
    }
    else { msg =$nick $cc $+ Flannery $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Fallarbor_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Fallarbor é 'cinzenta' assim por causa das ocasionais fumaças que o Mt Chimney exala. É por isso que a luminosidade aqui é pouca, e alguns pokémon incomuns podem aparecer. | return
  }
  elseif ($1 == Penny) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Penny $+ $ct $+ , uma habitante de Lavaridge.
    if ($rini(cadastros,$nick,Quests,Cyndy)) { msg =$nick $chr(160) $cc $+ Penny $ct $+ - Meteor Falls... Será apenas mito o que é dito a respeito? Aquele lugar místico... Dizem que no passado foi um grande cometa que atingiu nosso planeta e agora é habitado por pokémon. }
    else { msg =$nick $chr(160) $cc $+ Penny $ct $+ - Tenho uma amiga que precisa de ajuda para criar um pokémon, será que pode ajudá-la? Procure por $cc $+ Cyndy $ct $+ em $cc $+ Lavaridge City $+ $ct $+ . }
    return
  }
  elseif ($1 == Josh) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Josh $+ $ct $+ , um pesquisador.
    msg =$nick $chr(160) $cc $+ Josh $ct $+ - Adoro fósseis, é por isso que não me separo do meu Sandslash! Juntos procuramos por fósseis, homens e pokémon trabalhando juntos e construindo a história! | return
  }
  elseif ($1 == Lanette) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lanette $+ $ct $+ , uma cientista.
    if ($rini(cadastros,$nick,Quests,Lanette)) {
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Lanette) == No) {
          if ($groupev($nick) >= 3050) {
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Seus pokémon estão formidáveis, todo o seu time!
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - É com muito prazer que eu te dou este Macho Brace.
            msg =$nick $ct $+ Você recebeu o item $cc $+ Macho Brace $+ $ct $+ . | item.add $nick Macho Brace | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Lanette Ok
          }
          else { msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Ainda não... Mas o desafio continua. }
        }
        else { msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Parabéns, $nick $+ . Estou convicta de que a liga pokémon não será tão dificil para você. Boa sorte! }
      }
      else {
        if ($earl.count($nick) == 17) {
          if ($dados($nick,Quests,Global)) { msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Espero poder ter ajudado bastante em sua jornada. Boa sorte! }
          else {
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Adivinhe! Depois de tanto trabalho, finalmente consegui interligar todas as redes. E você será o primeiro a ver o avanço da tecnologia sem fio!
            var %x = 1 | while ($exists(pkp\box\ $+ $nick $+ \ $+ %x $+ .ini)) { writeini pkp\box\ $+ $nick $+ \ $+ %x $+ .ini Info Link Hoenn:Kanto:Johto | inc %x }
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Que ótima celebração para seu desempenho na liga de $cc $+ Johto $+ $ct $+ ! Todas as suas boxes estão mundialmente interligadas! Fascinante, não?
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Global $dados($nick,Info,Online)
          }
        }
        else { msg =$nick $chr(160) $cc $+ Lanette $ct $+ - A única desvantagem é que, para suportar toda a informação, ela precisa ter um tamanho muito reduzido... Bem, eu disse que era um protótipo, não disse? }
      }
      return
    }
    else {
      if ($item($nick,PC).qnt) {
        if ($start($nick)) {
          msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Oh, você usa o sistema de PC que eu criei! Muito bem.
          if ($rini(cadastros,$nick,Quests,Joy1)) {
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Vejo que minha amiga Joy concedeu o meu sistema a você. Significa então que você deve treinar seus pokémon muito bem, não?
            msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Então eu te proponho algo. Se você me mostrar seis pokémon em seu melhor estado de treinamento, você ganhará o item Macho Brace, que fará seu pokémon ganhar o dobro de effort points por batalha. O que acha? Quando estiver pronto, fale comigo.
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Lanette No
          }
        }
        else {
          msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Espere ai, quer dizer que você vem de $cc $+ $dados($nick,Info,Start) $+ $ct $+ ?! Nossa, é realmente uma viagem e tanto! Você conheceu o $cc $+ Bill $+ $ct $+ , um pokémaniaco? Bem, ele me ajudou a desenvolver o PC que os treinadores utilizam atualmente.
          msg =$nick $chr(160) $cc $+ Lanette $ct $+ - O problema é que as caixas compradas só podem ser usadas em sua região de origem. Ainda estamos tentando resolver esses problemas, mas consegui criar um protótipo, e adoraria que você o testasse. Eu o chamo de $cc $+ Link Box $+ $ct $+ , a primeira caixa que possui uma rede exclusiva e uma área de alcance maior!
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests Lanette Ok | box.add $nick 5 | return
        }
      }
      else { msg =$nick $chr(160) $cc $+ Lanette $ct $+ - Nossa, você é o primeiro treinador que eu vejo e que não anda com um PC... }
    }
    return
  }
  elseif ($1 == Cozmo) {
    if ($rini(cadastros,$nick,Quests,Cozmo)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Prof Cozmo $+ $ct $+ , um estudioso de pokémon.
      if ($rini(cadastros,$nick,Quests,Cozmo) == Ok) || (!$start($nick)) {
        if ($item($nick,Star Sign)) {
          msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - Ah! Não foi um pokémon que eu vi! Foi esse $cc $+ Star Sign $+ $ct $+ . Agora, nem me pergunte como ele foi parar lá!
        }
        else {
          msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - Meteor Falls... Andei estudando aquele lugar durante um bom tempo, e posso afirmar que a sua atmosfera é diferente.
          msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - Não sei se foi um sonho, mas logo após de eu ter encontrado o $cc $+ Meteorite $ct $+ acho que vi um pokémon desconhecido naquela área. Foi muito rápido, e aquilo desapareceu em questão de segundos. Será que vou vê-lo novamente?
        }
      }
      else {
        if ($rini(cadastros,$nick,Quests,Magma1)) {
          if ($item($nick,Meteorite).qnt) {
            msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - Oh! Meu $cc $+ Meteorite $+ $ct $+ ! Obrigado, $nick $+ , por recuperá-lo.
            item.add $nick TM26 | msg =$nick $ct $+ Você recebeu o item $cc $+ TM26 $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Cozmo Ok | item.rem $nick Meteorite
            msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - TM26 é Earthquake, espero que faça bom proveito!
          }
          else { msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - Mas onde foi parar meu $cc $+ Meteorite $+ $ct $+ ? Que estranho! Espero poder encontrar outro em Meteor Falls... | writeini pkp\cadastros\ $+ $nick $+ .ini Info Quests Cozmo Ok }
        }
        else { msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - $nick $+ ! Meu $cc $+ Meteorite $ct $+ precisa ser recuperado! Por favor! }
      }

    }
    else { msg =$nick $ct $+ Acho que $cc $+ Prof Cozmo $ct $+ não está na cidade... }
    return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Desert_Underpass { msg =$nick $ct $+ Nada foi encontrado. | return }
alias c.search.Meteor_Falls {
  if ($1 == Magma) || ($1 == Meteorite) || ($1 == Cozmo) {
    if ($rini(cadastros,$nick,Quests,Cozmo)) || (!$start($nick)) { msg =$nick $ct $+ Nada foi encontrado. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com membros da equipe $cc $+ Magma $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Maxie $ct $+ - Saiam do caminho, agora finalmente encontrei o $cc $+ Meteorite $+ $ct $+ . Nosso plano está saindo como o planejado, felizmente! Obrigado, Cozmo.
      msg =$nick $chr(160) $cc $+ Maxie $ct $+ - Huh? Quem é você no meio? $nick $+ ? Não entendo o que você faz aqui, mas espero que seja a ultima vez que vejo você.
      msg =$nick $ct $+ Alguns membros da equipe $cc $+ Aqua $ct $+ aparecem.
      msg =$nick $chr(160) $cc $+ Maxie $ct $+ - Nossa, então a equipe Aqua apareceu também. Não tem problema, estamos de saída. Vamos, equipe Magma, para o Mt Chimney.
      msg =$nick $chr(160) $cc $+ Archie $ct $+ - Foi você que atrapalhou os planos de minha equipe em Slateport, mas eu achei que você fosse um membro da equipe Magma. Agora vejo que é só um treinador qualquer.
      msg =$nick $chr(160) $cc $+ Archie $ct $+ - A Equipe Magma é um grupo perigoso de fanáticos, eles querem a destruição, visando expandir a massa terrestre. Eles são nossos rivais, dos amantes do oceano, a Equipe Aqua! Vamos, equipe, preciso saber o que a Equipe Magma pretende fazer no Mt Chimney! E, $nick $+ , é bom você ficar de olho neles também.
      msg =$nick $chr(160) $cc $+ Prof Cozmo $ct $+ - $nick $+ ! Você precisa recuperar o $cc $+ Meteorite $+ $ct $+ ! Não tenho idéia do que pode acontecer se aquilo cair em mãos erradas... Eu vou voltar para Fallarbor. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Cozmo No
      return
    }
  }
  elseif ($1 == Steven) {
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %x = 1 } } | elseif ($dados($nick,$dados($nick,Info,Region),League)) && ($dados($nick,Quests,Steven1)) { var %x = 1 }
    if (%x) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
      var %x = $rini(cadastros,$nick,Clock,Steven), %o = $rini(cadastros,$nick,Info,Online)
      if ($calc(%o - %x) >= 86400) {
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , estava mesmo precisando me exercitar um pouco. O que acha de uma batalha? Ficar procurando por pedras raras pode ser um pouco cansativo... O que me diz?
        msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK:Steven | return
      }
      else {
        if ($item($nick,Devon Scope)) {
          if ($item($nick,Star Sign)) {
            msg =$nick $chr(160) $cc $+ Steven $ct $+ - Encontrou um $cc $+ Star Sign $ct $+ por aqui? De onde raios isso saiu? Será que há algum pokémon escondido por aí?
          }
          else {
            msg =$nick $chr(160) $cc $+ Steven $ct $+ - Se eu vi algum pokémon raro aqui? Claro que sim, você também deve ter visto um $cc $+ Bagon $ct $+ andando por ai. Outro pokémon raro? Não... Você viu algum?
          }
        }
        else { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Ei, talvez você consiga ver um pokémon raro por aí usando o $cc $+ Devon Scope $+ $ct $+ ! | item.add $nick Devon Scope | msg =$nick $ct $+ Você recebeu o item $cc $+ Devon Scope $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Para ver pokémon selvagens escondidos, use o item antes de batalhas com pokémon selvagem. Quem sabe você não encontre exatamente o que tanto procurou? }
        return
      }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($1 == Helen) {
    if ($rini(cadastros,$nick,Quests,Helen)) { msg =$nick $ct $+ Nada foi encontrado. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Helen $+ $ct $+ , uma treinadora expert.
      msg =$nick $chr(160) $cc $+ Helen $ct $+ - Hmm, como sabia que estava aqui? Bem, isto não é importante, se você me encontrou, é porque é um treinador muito experiente em batalhas. Quer testar suas habilidades comigo? Eu vou te dar apenas uma chance, estão, esteja preparado.
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] HLN | return
    }
  }
  elseif ($findtok(Symbol:Simbolo:Símbolo,$1,0,58)) {
    if (!$dados($nick,Quests,Symbol)) { var %x = 0:0:0:0 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol %x }
    else { var %x = $dados($nick,Quests,Symbol) }
    var %n = 2
    if ($gettok(%x,%n,58)) { msg =$nick $ct $+ Este símbolo já foi adquirido anteriormente. }
    else {
      if ($team.hm($nick,Waterfall) == Ok!) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol $puttok(%x,1,%n,58) | msg =$nick $cc $+ Water Symbol $ct $+ foi encontrado com sucesso. }
      else { msg =$nick $ct $+ Nada pôde ser encontrado. }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Mt_Chimney {
  if ($rini(cadastros,$nick,Quests,Cozmo)) && (!$rini(cadastros,$nick,Quests,Magma1)) && ($start($nick)) {
    if ($1 == Magma) || ($1 == Meteorite) || ($1 == Maxie) {
      msg =$nick $ct $+ Os membros da equipe $cc $+ Magma $ct $+ estão tentando usar o $cc $+ Meteorite $ct $+ para fazer o vulcão entrar em erupção!
      msg =$nick $ct $+ Se quiser batalhar contra eles, digite ' $+ $cc $+ .Sim $+ $ct $+ '. Ou então digite ' $+ $cc $+ .nao $+ $ct $+ ' para cancelar. | set %confirm. [ $+ [ $nick ] ] MGM:1 | return
    }
    elseif ($1 == Aqua) || ($1 == Archie) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Archie $+ $ct $+ , líder da equipe Aqua.
      msg =$nick $chr(160) $cc $+ Archie $ct $+ - Oh, $nick $+ ! Como pode ver, eu estou ocupado aqui cuidando destes membros, por favor, se puder avançar procure por Maxie e o detenha!
      if (!$rini(cadastros,$nick,Quests,Aqua1)) { msg =$nick $chr(160) $cc $+ Archie $ct $+ - Receba este TM como gratificação pela ajuda. | item.add $nick TM46 | msg =$nick $ct $+ Você ganhou o item $cc $+ TM46 $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Aqua1 Ok }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Fortree_City {
  var %y = $readini(pkp\status.ini,Hoenn,Legendary), %x1 = $findtok(%y,Groudon,0,58), %x2 = $findtok(%y,Kyogre,0,58)
  if (($dados($nick,Info,Start) == Johto) && ($dados($nick,Quests,League))) || ($dados($nick,Johto,League)) { var %x = 1 }
  if (%x) { if (%x1) || (%x2) { var %w = 1 } }
  if ($1 == Will) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Will $+ $ct $+ , um cientista.
    if (%w) { msg =$nick $chr(160) $cc $+ Will $ct $+ - Que estranho, há pouco tempo registramos mudanças de clima em diferentes ambientes de $cc $+ Hoenn $+ $ct $+ . Isso certamente não é normal... | return }
    if ($rini(cadastros,$nick,Quests,Magma1)) && ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Aqua2)) {
        if ($rini(cadastros,$nick,Quests,Will)) { msg =$nick $chr(160) $cc $+ Prof Will $ct $+ - Eu pesquiso as chuvas há anos, e acho ridículo o ser humano pensar que poderá controlar o clima. | return }
        else {
          if ($teampos($nick,Egg)) { msg =$nick $chr(160) $cc $+ Prof Will $ct $+ - Então você já tem um Egg? Quando ele se chocar, eu ficarei feliz de te dar este aqui. | return }
          else {
            msg =$nick $chr(160) $cc $+ Prof Will $ct $+ - Então eu descobri sobre o Castform, e como ele muda sua forma de acordo o clima! Quer experimentar? Tenho muitos aqui no instituto, ficarei feliz de dar este ovo.
            if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você já tem $cc $+ seis $ct $+ pokémon. Libere espaço no seu time para recebe-lo. | return }
            echo $addpoke($nick,Egg,Castform,Recebido de Prof Will no Weather Institute,$rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31) $+ : $+ $rand(0,31),0,0)
            msg =$nick $ct $+ Parabéns! Você recebeu um $cc $+ Egg $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Will Ok | return
          }
          return
        }
      }
      else { msg =$nick $chr(160) $cc $+ Prof Will $ct $+ - Ah! Esses membros da Equipe Aqua querem roubar o meu pokémon! Por favor me ajude! | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para recusar. | set %confirm. [ $+ [ $nick ] ] AQU:2 | return }
    }
    else { msg =$nick $chr(160) $cc $+ Prof Will $ct $+ - Hm, este pokémon muda de forma de acordo com o clima! Que descoberta! | return }
  }
  elseif ($1 == Sandra) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Sandra $+ $ct $+ , uma cientista.
    if (%w) {
      if (%x1) && (%x2) { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - Há duas massas de ar, uma seca e outra úmida, vagando por diferentes lugares. Não sei como posso explicar isso, mas basicamente elas se movem aleatoriamente em $cc $+ Hoenn $+ $ct $+ , às vezes desaparecem, mas reaparecem em seguida... }
      elseif (%x1) { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - Há apenas uma massa de ar agora, uma seca, e continua movendo-se aleatoriamente em $cc $+ Hoenn $+ $ct $+ . Às vezes ela desaparece, mas reaparece em seguida. É muito estranho... }
      elseif (%x2) { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - Há apenas uma massa de ar agora, uma úmida, e continua movendo-se aleatoriamente em $cc $+ Hoenn $+ $ct $+ . Às vezes ela desaparece, mas reaparece em seguida. É muito estranho... }
      return
    }
    if ($rini(cadastros,$nick,Quests,Magma1)) && ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Aqua2)) { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - O professor adora as chuvas, isto é um fato. Mas o problema é quando chove demais, e acaba causando problemas. | return }
      else { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - Nossa, precisamos de ajuda, esses membros da Equipe Aqua querem roubar o pokémon do Prof Will! Por favor, faça alguma coisa! | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para recusar. | set %confirm. [ $+ [ $nick ] ] AQU:2 | return }
    }
    else { msg =$nick $chr(160) $cc $+ Sandra $ct $+ - Aqui no Weather Institute fazemos as previsões do tempo de toda Hoenn. Acho que vai chover hoje... | return }
  }
  elseif ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Esta é Fortree City. Como pode ver, grande parte da cidade está construída emcima de grandes árvores, a vista é incrível! | if (!$rini(cadastros,$nick,Quests,May3)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Ah, antes de você chegar, passou uma garota atrás de você, $nick $+ . Eu não consigo me lembrar o nome, mas acho que você deve conhecê-la. } | return
  }
  elseif ($1 == Tob) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Tob $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Tob $ct $+ - Estes meus $cc $+ Running Shoes $ct $+ são incríveis, eu realmente estou andando mais rápido com eles. Onde comprei os meus? Acho que vi em algum lugar em $cc $+ Rustboro City $+ $ct $+ , ainda bem que comprei o meu antes de esgotar o estoque! | return
  }
  elseif ($1 == Lao) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lao $+ $ct $+ , um treinador pokémon.
    msg =$nick $chr(160) $cc $+ Lao $ct $+ - Acho que tive sorte! Eu fui evoluir meu $cc $+ Nincada $ct $+ para $cc $+ Ninjask $+ $ct $+ , e ao fazê-lo percebi que um pokémon apareceu na minha $cc $+ Ultra Ball $+ $ct $+ ! Só não entendo "como" isso aconteceu... | return
  }
  elseif ($1 == Steven) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,Steven2)) { msg =$nick $ct $+ Acho que $cc $+ Steven $ct $+ não está mais na cidade. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
      if ($rini(cadastros,$nick,Quests,Aqua2)) {
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - $nick $+ , veja isto! É um pokémon! Huh? Não está vendo? Ah, tem razão, você precisa usar isto.
        msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ Devon Scope $+ $ct $+ ! | item.add $nick Devon Scope
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Se você usar este item antes de uma batalha com pokémon selvagem, talvez um pokémon invisível apareça no seu caminho. Tente usá-la aqui em $cc $+ Fortree City $ct $+ e você verá, tenho certeza!
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Eu vou indo então, até depois $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Steven2 Ok | return
      }
      else { msg =$nick $chr(160) $cc $+ Steven $ct $+ - $nick $+ ! Há quanto tempo hein. Agora estou analisando um fenômeno incomum dos pokémon, poderia voltar outra hora? | return }
    }
  }
  elseif ($1 == May) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,May3)) { msg =$nick $ct $+ Acho que $cc $+ May $ct $+ não está mais na cidade. | return }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ May $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ May $ct $+ - $nick $+ ! Estava te procurando agora a pouco, até perceber uns estranhos pokémon invisíveis no caminho.
      msg =$nick $chr(160) $cc $+ May $ct $+ - Agora que treinei bastante meus pokémon, imagino que não perderão para os seus!
      msg =$nick $chr(160) $cc $+ May $ct $+ - Ei, que tal uma batalha? Eu usarei apenas três pokémon, os melhores! Organize seu time e manda ver!
      msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] MAY:2 | return
    }
  }
  elseif ($1 == Winona) {
    if ($badge($nick,Feather Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Winona $+ $ct $+ , líder do ginásio de $cc $+ Fortree City $+ $ct $+ .
      if ($rini(cadastros,$nick,Quests,Aqua2)) { msg =$nick $chr(160) $cc $+ Winona $ct $+ - O $cc $+ Weather Institute $ct $+ estuda o clima de $cc $+ Hoenn $+ $ct $+ , e parece que criaram um pokémon que muda conforme o clima. Eu admiro o trabalho desenvolvido, mas não acho que deva ser feito. Eu vejo pokémon como criaturas naturais, e não artificiais. }
      else { msg =$nick $chr(160) $cc $+ Winona $ct $+ - Eu gosto de usar meus pokémon voadores para voar junto com eles. É muito relaxante. }
      if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) {
        msg =$nick $chr(160) $cc $+ Winona $ct $+ - Está falando da lenda de $cc $+ Pacifidlog Town $+ $ct $+ ?
        msg =$nick $chr(160) $cc $+ Winona $ct $+ - Sim, a porta está $cc $+ realmente $ct $+ nos céus. Digo com certeza pois já estive de frente a ela, com a ajuda de meu pokémon voador, embora não consegui abri-la. É preciso ser rápido e preciso, pois, ao entrar em $cc $+ Pacifidlog Town $+ $ct $+ , a porta aparecerá e desaparecerá em alguns segundos. Voe, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Voe!
      }
      return
    }
    else { msg =$nick $cc $+ Winona $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Lilycove_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Bem vindo a Lilycove! Se você não conhece esta cidade, você vai adorar a zona do safari! É um ótimo lugar para quem quer completar a PokeDex, pois aparecem espécies variadas em seus habitats naturais. | return
  }
  elseif ($1 == Bernie) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Bernie $+ $ct $+ , um treinador pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Bernie $ct $+ - Não entendo como esta chuva começou, o dia estava tão ensolarado. Assim eu não vou poder fazer meus safaris, não com esta chuva! | return }
    else { msg =$nick $chr(160) $cc $+ Bernie $ct $+ - Nossa, consegui capturar um pokémon na zona do safari hoje, e ele é muito raro! Mal posso esperar para ir novamente amanhã. | return }
  }
  elseif ($1 == Robert) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Robert $+ $ct $+ , um habitante da cidade.
    msg =$nick $chr(160) $cc $+ Robert $ct $+ - Ahn... Acho que estou com problemas de sono.
    if ($rini(cadastros,$nick,Quests,Robert)) { msg =$nick $chr(160) $cc $+ Robert $ct $+ - Yawn... Dormir é essencial... | return }
    else { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Robert Ok | item.add $nick TM44 | msg =$nick $ct $+ Você ganhou o item $cc $+ TM44 $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Robert $ct $+ - Dormir é essencial para uma boa saúde... Durma e recupere suas energias... | return }
  }
  elseif ($1 == Serena) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Serena $+ $ct $+ , a responsável pelo porto.
    if ($dados($nick,$dados($nick,Info,Start),Badges).n == 8) {
      var %x = $dados($nick,Clock,Ship), %y = 0
      if (%x) { if ($calc($dados($nick,Info,Online) - %x) >= 21600) { var %y = 1 } } | else { var %y = 1 }
      if (%y) {
        if ($item($nick,Gold Ticket).qnt) && ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Serena $ct $+ - Oh, este é o $cc $+ Silver Ticket $ct $+ e o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Anne) $+ $ct $+ ) ou no $cc $+ SS Tidal $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Tidal) $+ $ct $+ ) $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim <barco> $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne;SS Tidal
        }
        elseif ($item($nick,Gold Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Serena $ct $+ - Oh, este é o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Tidal $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Tidal
        }
        elseif ($item($nick,Silver Ticket).qnt) {
          msg =$nick $chr(160) $cc $+ Serena $ct $+ - Oh, este é o $cc $+ Silver Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $+ $ct $+ ?
          msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne
        }
        else { msg =$nick $chr(160) $cc $+ Serena $ct $+ - Você não pode embarcar se não tiver uma passagem de navio. }
      }
      else { msg =$nick $chr(160) $cc $+ Serena $ct $+ - Não há barco ainda, você deve aguardar seis horas $cc $+ online $ct $+ para tentar novamente. Neste momento, faltam aproximadamente $dur($calc(21600 - ($dados($nick,Info,Online) - %x)),$ct,$cc) $+ . }
      return
    }
    else { msg =$nick $chr(160) $cc $+ Serena $ct $+ - Infelizmente estamos sem serviço, mas em breve funcionará. | return }
  }
  elseif ($1 == Lyo) && (!$rini(cadastros,$nick,Quests,Aqua4)) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lyo $+ $ct $+ , membro da equipe $cc $+ Aqua $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Lyo $ct $+ (AQUA) - Algo muito importante está perto de acontecer, eu sinto isso. É por isso que estou de guarda aqui em Lilycove, enquanto os outros membros voltam do Mt Py... Droga! Eu e minha boca grande! | return
  }
  elseif ($1 == Karn) && (!$rini(cadastros,$nick,Quests,Aqua4)) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lyo $+ $ct $+ , membro da equipe $cc $+ Aqua $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Karn $ct $+ (AQUA) - Se os objetivos de nossa facção se realizassem, humanos e pokémon seriam mais felizes. Não entendo como as pessoas julgam nosso time como vilões! | if (!$rini(cadastros,$nick,Quests,Aqua1)) { item.add $nick TM46 | msg =$nick $ct $+ Você ganhou o item $cc $+ TM46 $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Aqua1 Ok } | return
  }
  elseif ($1 == Ralf) && (!$rini(cadastros,$nick,Quests,Aqua4)) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ralf $+ $ct $+ , membro da equipe $cc $+ Aqua $+ $ct $+ .
    msg =$nick $chr(160) $cc $+ Ralf $ct $+ (AQUA) - Ah, eu não sei onde fica o $cc $+ Magma Hideout $+ $ct $+ ! Hm, está muito calmo ultimamente... Acho que eles estão tramando algo!! | return
  }
  elseif ($1 == Aqua) || ($1 == Archie) {
    if ($rini(cadastros,$nick,Quests,Aqua3)) && ($start($nick)) {
      if ($rini(cadastros,$nick,Quests,Aqua4)) { msg =$nick $ct $+ Nada foi encontrado. | return }
      else {
        if ($rini(cadastros,$nick,Quests,Magma2) == Ok) {
          msg =$nick $ct $+ Você conseguiu entrar no $cc $+ Aqua Hideout $+ $ct $+ , em $cc $+ $rini(cadastros,$nick,Info,Locate) $+ $ct $+ ! Alguns membros estão tentando expulsá-lo, o que você deseja fazer?
          msg =$nick $ct $+ Digite $cc $+ .Sim $ct $+ para batalhar contra eles e $cc $+ .nao $ct $+ para sair do $cc $+ Aqua Hideout $+ $ct $+ . | set %confirm. [ $+ [ $nick ] ] AQU:3 | return
        }
        else {
          msg =$nick $ct $+ Você encontra-se com um guarda da Equipe $cc $+ Aqua $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Rick $ct $+ (AQUA) $ct $+ - Você deve ser algum membro da Equipe $cc $+ Magma $ct $+ usando esse emblema! Saia daqui! Estamos ocupados demais para perder tempo com vocês! | return
        }
      }
    }
    else { msg =$nick $ct $+ Você pode ver alguns membros da $cc $+ Equipe Aqua $+ $ct $+ : Lyo $+ $ct $+ , $cc $+ Karn $ct $+ e $cc $+ Ralf $+ $ct $+ . | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Mt_Pyre {
  if ($1 == Aqua) || ($1 == Archie) {
    if ($rini(cadastros,$nick,Quests,Aqua3)) && ($start($nick)) {
      if (!$rini(cadastros,$nick,Quests,Weather)) && ($rini(cadastros,$nick,Quests,Sky2)) {
        if ($rini(cadastros,$nick,Quests,Magma4)) { msg =$nick $ct $+ Nada foi encontrado. }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Maxie $ct $+ e $cc $+ Archie $+ $ct $+ . Eles recolocaram as $cc $+ Orbs $ct $+ em seus lugares.
          msg =$nick $chr(160) $cc $+ Maxie $ct $+ - $nick $+ ... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Magma4 Ok
        } | return
      }
      else { msg =$nick $ct $+ Nada foi encontrado. | return }
    }
    else {
      if ($rini(cadastros,$nick,Quests,Magma2)) || (!$start($nick)) { msg =$nick $ct $+ Nada foi encontrado. | return }
      else {
        msg =$nick $ct $+ Você encontra-se com alguns membros da Equipe $cc $+ Aqua $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Archie $ct $+ - Quando chegamos aqui, a equipe Magma já tinha saído, mas não levou o prêmio principal... $cc $+ Red Orb $ct $+ nos fará completar o nosso objetivo! Este dia será lembrado...
        msg =$nick $chr(160) $cc $+ Shelly $ct $+ - Archie, precisamos ir, todos já estão a postos em Lilycove.
        msg =$nick $chr(160) $cc $+ Archie $ct $+ - Está certo. $nick $+ , não quero problemas com você, mas se voltar a aparecer, você terá problemas.
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Magma2 No | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Aqua3 Ok | return
      }
    }
  }
  elseif ($1 == Magma) || ($1 == Maxie) || ($1 == Item) || ($1 == Emblem) {
    if ($rini(cadastros,$nick,Quests,Magma2) == No) || (!$rini(cadastros,$nick,Quests,Magma2)) {
      if ($start($nick)) {
        if ($item($nick,Magma Emblem).qnt) { msg =$nick $ct $+ Nada foi encontrado. | return }
        else { msg =$nick $ct $+ Você pode ver um item deixado no chão por alguém, talvez por acidente. | msg =$nick $ct $+ Você achou o item $cc $+ Magma Emblem $+ $ct $+ ! | item.add $nick Magma Emblem }
      }
      else { msg =$nick $ct $+ Nada foi encontrado. | return }
    }
    else {
      if (!$rini(cadastros,$nick,Quests,Weather)) && ($rini(cadastros,$nick,Quests,Sky2)) {
        if ($rini(cadastros,$nick,Quests,Magma4)) { msg =$nick $ct $+ Nada foi encontrado. }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Maxie $ct $+ e $cc $+ Archie $+ $ct $+ . Eles recolocaram as $cc $+ Orbs $ct $+ em seus lugares.
          msg =$nick $chr(160) $cc $+ Maxie $ct $+ - $nick $+ ... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Magma4 Ok
        } | return
      }
      else { msg =$nick $ct $+ Nada foi encontrado. | return }
    }
  }
  elseif ($1 == Orb) || ($1 == Orbs) || ($1- == Red Orb) || ($1- == Blue Orb) {
    if ($rini(cadastros,$nick,Quests,Magma4)) {
      var %x = $dados($nick,Quests,Orb)
      if (%x == 5) || (!%x) { msg =$nick $ct $+ Você pode ver a $cc $+ Red Orb $ct $+ e a $cc $+ Blue Orb $+ $ct $+ , em seus lugares. }
      else { msg =$nick $ct $+ Parece-me que a $cc $+ Red Orb $ct $+ e a $cc $+ Blue Orb $ct $+ foram roubadas... } | return
    }
    else { msg =$Nick $ct $+ Nada foi encontrado. } | return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Silver_Bay { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Mossdeep_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { $chr(160) $cc $+ Joy $ct $+ - O clima mudou drasticamente há um tempo atrás, e isso não é nada normal! Nunca vi tanta chuva aqui em Mossdeep, será que estamos em risco? | return }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, $nick $+ ! Bem vindo a Mossdeep, esta ilha tem o clima ideal para o desenvolvimento do centro espacial. E no ginásio, você poderá encontrar duas líderes, gêmeas, que batalham juntas. É estranho, mas elas sabem exatamente o que a outra está pensando... | return }
  }
  elseif ($1 == Vivian) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Vivian $+ $ct $+ , uma treinadora pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Vivian $ct $+ - Meu deus! O que está acontecendo lá fora? Que clima louco é esse? Não dá pra nadar agora, a maré está muito agitada! É perigoso... | return }
    else { msg =$nick $chr(160) $cc $+ Vivian $ct $+ - Adoro nadar com meus pokémon! Acho que vou nadar daqui a pouco, o clima está ótimo! | return }
  }
  elseif ($1 == George) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ George $+ $ct $+ , um pescador.
    if ($item($nick,Super Rod).qnt) || (!$start($nick)) { msg =$nick $chr(160) $cc $+ George $ct $+ - Vá atras de pokémon no fundo dos mares usando sua $cc $+ Super Rod $+ $ct $+ ! | return }
    else {
      if ($item($nick,Good Rod).qnt) {
        msg =$nick $chr(160) $cc $+ George $ct $+ - Diga o que quiser, mas a $cc $+ Super Rod $ct $+ é realmente 'super'! Ela consegue alcançar pokémon que estão bem no fundo!
        item.add $nick Super Rod | msg =$nick $ct $+ Você ganhou o item $cc $+ Super Rod $+ $ct $+ ! | return
      }
      else { msg =$nick $chr(160) $cc $+ George $ct $+ - Você não me parece ter muito interesse pela pesca... Não, você não pode ser bom se não tiver nem ao menos uma $cc $+ Good Rod $+ $ct $+ ! | return }
    }
  }
  elseif ($1 == Dalton) {
    var %b = $dados($nick,$dados($nick,Info,Region),Badges) | msg =$nick $ct $+ Você encontra-se com $cc $+ Dalton $+ $ct $+ , cientista do $cc $+ Space Center $+ $ct $+ .
    if ($start($nick)) {
      if ($findtok(%b,Mind Badge,0,58)) {
        if ($rini(cadastros,$nick,Quests,Magma3)) { msg =$nick $chr(160) $cc $+ Dalton $ct $+ - A região de Hoenn era famosa por suas chuvas de meteoros durante muito tempo. }
        else { msg =$nick $chr(160) $cc $+ Dalton $ct $+ - Equipe Magma! Eles realmente apareceram! Olhe, Steven está em desvantagem! }
      }
      else { msg =$nick $chr(160) $cc $+ Dalton $ct $+ - Estamos sofrendo ameaças da Equipe Magma, mas felizmente Steven está aqui para nos ajudar. }
    }
    else { msg =$nick $chr(160) $cc $+ Dalton $ct $+ - Nossa, nosso combustível espacial quase foi roubado pela Equipe Magma. Felizmente, bons treinadores como $cc $+ Steven $ct $+ estavam aqui para ajudar. }
    return
  }
  elseif ($1 == Wilton) {
    var %b = $dados($nick,$dados($nick,Info,Region),Badges) | msg =$nick $ct $+ Você encontra-se com $cc $+ Wilton $+ $ct $+ , cientista do $cc $+ Space Center $+ $ct $+ .
    if ($start($nick)) {
      if ($findtok(%b,Mind Badge,0,58)) {
        if ($rini(cadastros,$nick,Quests,Magma3)) { msg =$nick $chr(160) $cc $+ Wilton $ct $+ - Mesmo se fizermos um foguete com 99% de chance de sucesso, não estaremos satisfeitos. Enquanto houve 1% de margem de erro, continuaremos trabalhando! }
        else { msg =$nick $chr(160) $cc $+ Wilton $ct $+ - Equipe Magma! Eles não podem levar nosso combustível! Precisamos dele! }
      }
      else { msg =$nick $chr(160) $cc $+ Wilton $ct $+ - Estou ficando preocupado com essas ameaças da Equipe Magma. }
    }
    else { msg =$nick $chr(160) $cc $+ Wilton $ct $+ - Eu não consigo entender a verdadeira razão de usar um combustível espacial para explodir um vulcão... Como isso poderia ajudar os pokémon? Equipe Magma é insana... }
    return
  }
  elseif ($1 == Magma) || ($1 == Maxie) {
    if ($rini(cadastros,$nick,Quests,Magma3)) || (!$start($nick)) { msg =$nick $ct $+ Nada foi encontrado. | return }
    else {
      var %b = $dados($nick,$dados($nick,Info,Region),Badges)
      if ($findtok(%b,Mind Badge,0,58)) {
        msg =$nick $ct $+ Você encontra-se com alguns membros da Equipe $cc $+ Magma $ct $+ e $cc $+ Steven $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Equipe Magma, o que há de importante em roubar o combustível dos foguetes?
        msg =$nick $chr(160) $cc $+ Maxie $ct $+ - Hahaha... Como você é curioso... merece uma explicação. Nós vamos colocar todo o combustível no Mt Chimney! Com o desaparecimento de Groudon, não há mais necessidade daquela montanha. Então vamos usar o poder dos combustíveis para fazê-lo entrar em erupção!
        msg =$nick $ct $+ Ajudar $cc $+ Steven $ct $+ a derrotá-los? Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] MGM:3 | return
      }
      else { msg =$nick $ct $+ Nada foi encontrado. }
      return
    }
  }
  elseif ($1 == Steven) {
    if ($rini(cadastros,$nick,Quests,Steven3)) { msg =$nick $cc $+ Steven $ct $+ não está em casa. }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Magma3)) {
          if ($item($nick,HM08).qnt) { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Parece que há uma caverna submersa em Silver Bay, aquela que o Capitão Stern descobriu com seu submarino. }
          else {
            msg =$nick $chr(160) $cc $+ Steven $ct $+ - Ah, $nick $+ , obrigado pela ajuda. Como recompensa, aqui está, este Hidden Machine Dive. Vamos, não seja tímido!
            item.add $nick HM08 | msg =$nick $ct $+ Você ganhou o item $cc $+ HM08 $+ $ct $+ . | msg =$nick $chr(160) $cc $+ Steven $ct $+ - Em alguns lugares, como em Silver Bay, você poderá mergulhar com seus pokémon. Eu ficarei por aqui. Ah sim, eu não moro em Rustboro City. Moro aqui mesmo, em Mossdeep.
          }
        }
        else {
          var %b = $dados($nick,$dados($nick,Info,Region),Badges)
          if ($findtok(%b,Mind Badge,0,58)) { msg =$nick $chr(160) $cc $+ Steven $ct $+ - $nick $+ , pode me ajudar a deter esta Equipe Magma? Fique com o Maxie, que eu cuido do Tabitha. }
          else { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Ah, olá $nick $+ ! Estou aqui no centro espacial porque soube de uma ameaça da Equipe Magma de roubar o combustível dos foguetes daqui. Vou ficar de olho, até eles aparecerem. Por que não vai dar uma olhada no resto da cidade? }
        }
      }
      else {
        if ($item($nick,HM08).qnt) { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Tenho o hábito de colecionar pedras raras. Você tem alguma para me oferecer? }
        else { msg =$nick $chr(160) $cc $+ Steven $ct $+ - Você não é daqui, certo? Meu nome é $cc $+ Steven $+ $ct $+ . Deve estar então se perguntando como vai chegar à $cc $+ Sootopolis City $+ $ct $+ ... Tudo bem, é só ensinar ao pokémon a técnica $cc $+ Dive $+ $ct $+ ! | item.add $nick HM08 | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM08 $+ $ct $+ ! }
      }
    }
    return
  }
  elseif ($findtok(Presente:Presente secreto:Gift:Hidden Gift,$1-,0,58)) && ($start($nick)) && ($dados($nick,Quests,Gift)) {
    if ($dados($nick,Quests,Gift) == Ok) { msg =$nick $ct $+ Não há mais presentes aqui... }
    else {
      var %x = Beldum
      msg =$nick $ct $+ Você encontrou um $cc $+ presente $+ $ct $+ ! Oh, é um pokémon!
      if ($dados($nick,%x,Name)) { msg =$nick $ct $+ Você não pôde recebê-lo porque já tem um pokémon com o mesmo $cc $+ nome $ct $+ no time... | return }
      if ($dados($nick,Team,6)) { msg =$nick $ct $+ Você não pôde recebê-lo porque não há espaço em seu time! | return }
      msg =$nick $ct $+ Parabéns! $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou o pokémon $cc $+ %x $+ $ct $+ !
      if (!$pokedex($nick,%x)) { .echo $pokedex($nick,%x).add } | addpoke $nick %x 20 20: $+ $dados($nick,Info,Locate) $+ :Poke  Ball
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Gift Ok
    }
    return
  }
  elseif ($1 == Tate) || ($1 == Liza) || ($1 == Tate&Liza) {
    if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Mind Badge,0,58)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Tate $ct $+ e $cc $+ Liza $+ $ct $+ , líderes do ginásio de Mossdeep.
      if ($rini(cadastros,$nick,Quests,Weather)) {
        msg =$nick $chr(160) $cc $+ Tate $ct $+ - Essa chuva ...
        msg =$nick $chr(160) $cc $+ Liza $ct $+ - ... não acaba nunca?
        msg =$nick $chr(160) $cc $+ Tate $ct $+ - O que estará ...
        msg =$nick $chr(160) $cc $+ Liza $ct $+ - ... por trás disso?
        msg =$nick $chr(160) $cc $+ Tate&Liza $ct $+ - Você sabe de alguma coisa, $nick $+ ?
      }
      else {
        msg =$nick $chr(160) $cc $+ Tate $ct $+ - Eu simplesmente sei o que a Liza está pensando.
        msg =$nick $chr(160) $cc $+ Liza $ct $+ - Eu também sei o que a Tate está pensando.
        msg =$nick $chr(160) $cc $+ Tate $ct $+ - Alguns podem achar entranho ...
        msg =$nick $chr(160) $cc $+ Liza $ct $+ - ... mas veja, somos gêmeas!
        msg =$nick $chr(160) $cc $+ Tate&Liza $ct $+ - Isso é telepatia! Pokémon psíquicos normalmente são portadores de habilidades semelhantes.
      }
      return
    }
    else { msg =$nick $cc $+ Tate $ct $+ e $cc $+ Liza $ct $+ estão no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Shoal_Cave { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Seafloor_Cavern {
  if ($1 == Aqua) || ($1 == Archie) {
    if ($start($nick)) {
      if (!$rini(cadastros,$nick,Quests,Weather)) && (!$rini(cadastros,$nick,Quests,Sky2)) && ($rini(cadastros,$nick,Quests,Magma3)) { msg =$nick $ct $+ Você encontrou alguns membros da Equipe $cc $+ Aqua $+ $ct $+ . | msg =$nick $ct $+ Deseja batalhar com eles? $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para cancelar. | set %confirm. [ $+ [ $nick ] ] AQU:4 | return }
      else { msg =$nick $ct $+ Nada foi encontrado. | return }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Sootopolis_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Aqueles pokémon batalhando... Aqueles são pokémon lendários, certo? Se eles não pararem, a cidade vai ficar completamente submersa! | return }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a Sootopolis, $nick $+ ! Nossa cidade é localizada no meio de montanhas, com Silver Bay nos arredores. É sem dúvida uma paisagem e tanto! Ah, o líder desta cidade usa pokémon aquáticos. Juan deve ser o líder mais elegante de todos! | return }
  }
  elseif ($1 == Brooke) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Brooke $+ $ct $+ , um treinador pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Brooke $ct $+ - Aqueles pokémon lendários, são realmente muito poderosos! São tão poderosos que eu prefiro não entrar no meio daquela batalha. | return }
    else {
      if ($start($nick)) {
        if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Rain Badge,0,58)) { msg =$nick $chr(160) $cc $+ Brooke $ct $+ - Acho que vou treinar meus pokémon para que sejam fortes como os seus, afinal, você é o meu herói! Hehehe... }
        elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Brooke $ct $+ - Nossa! Aquele pokémon verde que desceu dos céus, é incrível! Ele conseguiu acalmar os outros dois... Hahahaha... Que boas notícias! }
        else { msg =$nick $chr(160) $cc $+ Brooke $ct $+ - Adoro esta cidade, tudo é tão bonito e paradisíaco, é bom para relaxar... Vou precisar me preparar para a liga, mas antes vou ter que pegar a Rain Badge. Hmm, estou esperando o ginásio abrir também! }
      }
      else { msg =$nick $chr(160) $cc $+ Brooke $ct $+ - Nossa cidade já foi palco de uma batalha colossal! Hahaha, tive sorte, eu estava presente! Aqueles pokémon $cc $+ Groudon $ct $+ e $cc $+ Kyogre $+ $ct $+ ... Pra onde eles podem ter ido? }
      return
    }
  }
  elseif ($1 == Helena) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Helena $+ $ct $+ , uma habitante da cidade.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Helena $ct $+ - Ouch! O que vai acontecer se isto não parar?! Não, não quero nem imaginar... | return }
    else {
      if ($start($nick)) {
        if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Rain Badge,0,58)) { msg =$nick $chr(160) $cc $+ Helena $ct $+ - Sou eternamente grata pelo que você fez, jamais vou esquecer! Acho que tenho um novo ídolo a partir de agora... }
        elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Helena $ct $+ - Graças à aquele pokémon dos céus! Graças a ele, e a você, estamos salvos! Obrigada! }
        else { msg =$nick $chr(160) $cc $+ Helena $ct $+ - Nossa! O líder Juan é tão, tão, mas tão elegante, que eu me derreto toda só de pensar nele... Um dia vou ser treinadora e batalhar ao lado dele! Hahaha... }
      }
      else { msg =$nick $chr(160) $cc $+ Helena $ct $+ - Sootopolis é abençoada pela beleza, com certeza! Nunca vi cidade tão bela em minha vida! E, pode parecer estranho, mas é comum que apareçam Zubats $cc $+ verdes $ct $+ por esta área. Vejo todo dia alguns passando em direção à caverna. }
      return
    }
  }
  elseif ($1 == Diogo) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Diogo $+ $ct $+ , um pintor.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Isso é trágico e exuberantemente lindo... Mas trágico acima de tudo! | return }
    else {
      if ($start($nick)) {
        if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Rain Badge,0,58)) { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Estou emocionado, consegui fazer um desenho daquele pokémon verde! É o meu melhor trabalho! }
        elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Brilhante! Incrível! Artístico! Não tenho mais palavras para descrever, mas isso me deixou inspirado! }
        else { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Minhas pinturas retratam pokémon em seus habitats ou em batalhas. Eu queria encontrar um pokémon lendário para desenhá-lo! }
      }
      else { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Fiz diversas pinturas, mas minha última é uma obra de arte, sem dúvida! Graças a aqueles pokémon legendários que apareçam nessa área... }
      if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Diogo $ct $+ - " $+ $cc $+ Ancião dos mares $+ $ct $+ " é o título de uma das minhas pinturas! Veja... | msg =$nick $ct $+ Você pode ver apenas uma imagem manchada e com predominância de marrom. | msg =$nick $chr(160) $cc $+ Diogo $ct $+ - Esqueci de mencionar: minhas pinturas são abstratas! Bem, eu também não pude ver com clareza porque ele nadou até as profundezas de $cc $+ Underwater $+ $ct $+ . }
      return
    }
  }
  elseif ($1 == Magma) || ($1 == Maxie) {
    if ($rini(cadastros,$nick,Quests,Weather) == Ok) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Maxie $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Maxie $ct $+ - G... Groudon... Por favor! Pare com isso! Eu sei agora a extensão de seu poder, se você continuar, toda Hoenn, não só Sootopolis, ficará submersa! | return
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($1 == Aqua) || ($1 == Archie) {
    if ($rini(cadastros,$nick,Quests,Weather) == Ok) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Archie $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Archie $ct $+ - Kyogre! O que há de errado?! Olhe, aqui é a $cc $+ Red Orb $+ $ct $+ ! Acalme-se, Kyogre! Isto não está ajudando, ele não está respondendo... | return
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  elseif ($1 == Steven) {
    if ($rini(cadastros,$nick,Quests,Weather) == Ok) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
      if (!$rini(cadastros,$nick,Quests,Steven4)) {
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Aqueles pokémon lutando... Groudon e Kyogre... Estes dois pokémon lendários foram acordados de um longo sono, e agora eles estão atacando um ao outro com suas incontroláveis energias...
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - $nick $+ , ver você aqui me faz pensar que está preparado para se envolver nesta crise. Bem, então tem uma pessoa que eu gostaria que você conhecesse. Venha comigo. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Steven4 Ok
      }
      if ($rini(cadastros,$nick,Quests,Wallace)) {
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Sky Pillar... Nunca estive lá, me pergunto onde fica esse lugar. | return
      }
      else {
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Escute, $nick $+ . Dentro da $cc $+ Cave Of Origin $ct $+ você encontrará alguém chamado $cc $+ Wallace $+ $ct $+ . Acho que você tem o que ele precisa para ajudá-lo.
        writeini pkp\cadastros\ $+ $nick $+ .ini Info Locate Cave Of Origin | remini pkp\cadastros\ $+ $nick $+ .ini Time Goto | msg =$nick $ct $+ Você entrou na $cc $+ Cave Of Origin $+ $ct $+ . | return
      }
    }
    else {
      if ($rini(cadastros,$nick,Quests,Steven3)) && ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Magma4)) { msg =$nick $ct $+ Nada foi encontrado. | return }
        else {
          var %b = $dados($nick,$dados($nick,Info,Region),Badges)
          if ($findtok(%b,Rain Badge,0,58)) { msg =$nick $ct $+ Nada foi encontrado. | return }
          msg =$nick $ct $+ Você encontra-se com $cc $+ Steven $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Steven $ct $+ - Parece que Maxie e Archie sairam para algum lugar. Eles devem ter ido ao Mt Pyre colocar as $cc $+ Orbs $ct $+ de volta em seus devidos lugares. | return
        }
      }
      else { msg =$nick $ct $+ Nada foi encontrado. | return }
    }
  }
  elseif ($1 == Wallace) {
    if ($rini(cadastros,$nick,Quests,Sky)) {
      var %b = $dados($nick,$dados($nick,Info,Region),Badges)
      if ($findtok(%b,Rain Badge,0,58)) { msg =$nick $ct $+ Nada foi encontrado. }
      else {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Wallace $+ $ct $+ .
        if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Vamos, $nick $+ , procure Rayquaza no topo do Sky Pillar! Estamos contando com você! }
        else {
          if ($item($nick,HM07).qnt) { msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Estou certo de que você vai achar o estilo elegante de batalha do meu mentor muito interessante! }
          else {
            msg =$nick $chr(160) $cc $+ Wallace $ct $+ - $nick $+ , meus olhos não conseguem acreditar no que viram. Graças a sua ajuda, Sootopolis... não, toda Hoenn foi salva. Em nome da população, eu o agradeço. Este é um presente meu, por favor aceite.
            item.add $nick HM07 | msg =$nick $ct $+ Você ganhou o item $cc $+ HM07 $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Este Hidden Machine contém Waterfall. Com a Rain Badge, um pokémon que tiver aprendido esta técnica será capaz de subir cachoeiras. E onde pegar esta insígnea? Você sabe, certo? É isso ai, você tem que derrotar o líder desta cidade! Ok, vá em frente, $nick $+ . Boa sorte!
          }
        }
      }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. }
    return
  }
  elseif ($1 == Juan) {
    if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Rain Badge,0,58)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Juan $+ $ct $+ , líder do ginásio de Sootopolis.
      if ($start($nick)) {
        if ($rini(cadastros,$nick,Quests,Magma4)) { msg =$nick $chr(160) $cc $+ Juan $ct $+ - No final das contas, aqueles lunáticos colocaram a cabeça no lugar e devolveram as $cc $+ Orbs $ct $+ aos seus lugares. Acho que não teremos nenhum outro evento climático por mais alguns séculos! Hahaha... Já te disseram que sua roupa está fora de moda? }
        else { msg =$nick $chr(160) $cc $+ Juan $ct $+ - Depois da confusão, imagino que Maxie e Archie foram devolver as $cc $+ Orbs $ct $+ roubadas ao Mt Pyre. Você deve ter conhecido Wallace, saiba que tudo o que ele sabe sobre pokémon deve-se aos meus ensinamentos! Hahaha... Que orgulho ser mentor de alguém tão talentoso! }
      }
      else { msg =$nick $chr(160) $cc $+ Juan $ct $+ - E pensar que esta cidade já foi palco de uma batalha de pokémon legendários... Aquele pokémon aquático, gostaria de tê-lo no meu time. Eu seria definitivamente o mais elegante de todos! }
      if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Juan $ct $+ - " $+ $cc $+ Ancião dos mares $+ $ct $+ "? Hm, sou especialista em pokémon aquático, mas não procuro os anciões. Prefiro os pokémon magníficamente iguais a mim! }
      return
    }
    else { msg =$nick $cc $+ Juan $ct $+ está no ginásio, aguardando seu desafio. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Cave_Of_Origin {
  if ($1 == Wallace) {
    if ($rini(cadastros,$nick,Quests,Wallace)) { msg =$nick $ct $+ Nada foi encontrado. }
    elseif ($start($nick)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Wallace $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Então você é $nick $+ ? Eu ouvi histórias a seu respeito. Meu nome é Wallace. Eu ja fui líder do ginásio de Sootopolis, mas algo aconteceu. Eu passei o controle do ginásio para meu mentor Juan.
      msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Groudon e Kyogre, os dois pokémon que estão travando batalha neste momento, são considerados pokémon lendários. Mas não há apenas dois pokémon lendários. Existe mais algum... Em algum lugar, existe um pokémon lendário chamado Rayquaza. Lendas dizem que Rayquaza acalmou esses dois pokémon num passado distante. Mas eu não faço idéia de onde ele possa estar...
      msg =$nick $chr(160) $cc $+ Wallace $ct $+ - Ah, lembro que ouvi falar de um pokémon verde ter sido visto nas proximidades de Pacifidlog, ele deve estar no $cc $+ Sky Pillar $+ $ct $+ ! Não há tempo a se perder, precisamos ir ao $cc $+ Sky Pillar $ct $+ agora mesmo!
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Wallace Ok
    }
    else { msg =$nick $ct $+ Nada foi encontrado. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Pacifidlog_Town {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Pacifidlog está em risco! Se esta chuva não parar, logo a cidade afundará! Parece que as nuvens vêm de Sootopolis, o que pode estar havendo lá?! }
    else {
      msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a Pacifidlog, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Como pode ver, esta cidade é muito isolada. Ela foi construída em cima de corais formados por vários $cc $+ Corsola $+ $ct $+ . É como uma bóia gigante.
      if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Não conheço nada a respeito desta lenda local. Pra falar a verdade, não acredito nessas coisas... }
    } | return
  }
  elseif ($1 == Sarah) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Sarah $+ $ct $+ , uma treinadora pokémon.
    if ($rini(cadastros,$nick,Quests,Weather)) { msg =$nick $chr(160) $cc $+ Sarah $ct $+ - Recebi uma mensagem de uma amiga em Sootopolis, ela me disse que há pokémon lendários batalhando lá. Se a maré estivesse favorável eu iria até lá dar uma olhada, mas com este temporal... | return }
    else {
      if ($findtok($dados($nick,$dados($nick,Info,Region),Badges),Rain Badge,0,58)) { msg =$nick $chr(160) $cc $+ Sarah $ct $+ - Esta Rain Badge diz muita coisa, não? E então, está pronto para ir para a Liga Pokémon? Se estiver, ensine Waterfall para seu pokémon e suba a cascata em Silver Bay. }
      elseif ($rini(cadastros,$nick,Quests,Sky2)) { msg =$nick $chr(160) $cc $+ Sarah $ct $+ - Você viu também?! Acabou de voar um pokémon esverdeado enorme! Ele saiu do topo da Sky Pillar! Anh? Foi você?! Nossa, você é realmente muito talentoso. Conheço uma treinadora muito forte e talentosa, assim como você, mas não sei onde ela possa estar. Seu nome é $cc $+ Helen $ct $+ e ela adora mistério! Conhece algum lugar misterioso? Talvez ela possa estar lá! }
      else { msg =$nick $chr(160) $cc $+ Sarah $ct $+ - Sim, se você usar Surf para voltar a Slateport City, não poderá voltar para aqui usando Surf. É que há uma maré muito forte que empurra os treinadores em direção a Slateport. }
      if (!$dados($nick,Quests,Tomb)) && ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Sarah $ct $+ - Não sei qual o pokémon que a lenda se refere, mas acredito que seja um $cc $+ Wailmer $ct $+ o primeiro pokémon. Não sei se há outro mais pesado que este. E o último eu realmente não sei, vai ser difícil encontrar um pokémon tão velho assim. }
    }
    return
  }
  elseif ($1 == Nicolas) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Nicolas $+ $ct $+ , um expert em pokémon.
    msg =$nick $chr(160) $cc $+ Nicolas $ct $+ - Olá, $nick $+ ! Sou conhecido como 'Pokémon Move Deleter'! Você gostaria de fazer seu pokémon $cc $+ $rini(cadastros,$nick,Team,1) $ct $+ desaprender algum golpe?
    msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] NCL: $+ $rini(cadastros,$nick,Team,1) | return
  }
  elseif ($1 == Tucker) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Tucker $+ $ct $+ , um velho habitante da cidade.
    if ($dados($nick,Quests,Tomb)) {
      msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Agora entendo. Tratava-se de $cc $+ Wailord $ct $+ e $cc $+ Relicanth $+ $ct $+ ...
      if ($dados($nick,Quests,Regice)) && ($dados($nick,Quests,Regirock)) && ($dados($nick,Quests,Registeel)) {
        msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Está tudo muito claro para mim agora, graças a você. Obrigado.
        if (!$dados($nick,Quests,Tucker)) { item.add $nick Unknown Gene | msg =$Nick $chr(160) $cc $+ Tucker $ct $+ - Não me pergunte onde eu consegui este $cc $+ Unknown Gene $+ $ct $+ ... Desconheço totalmente a sua funcionalidade. Pode levar, como agradecimento pelo esclarecimento. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Tucker Ok }
      }
      else { msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Certamente, a entrada está aberta agora. Suas localizações estão espalhadas por $cc $+ Hoenn $+ $ct $+ . Em cada uma delas, haverá uma entidade, ou não. }
    }
    else {
      msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Moro aqui em $cc $+ $dados($nick,Info,Locate) $ct $+ há muito tempo, e meus avós também já moraram. Havia, no entanto, uma lenda local que envolvia dois pokémon...
      if ($dados($nick,Quests,League)) {
        msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Primeiramente, o pokémon que representa o " $+ $cc $+ gigante das águas $+ $ct $+ ". Finalmente, o pokémon conhecido como " $+ $cc $+ ancião dos mares $+ $ct $+ ", certamente muito antigo ou até extinto.
        msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Não conheço que entidade está sendo protegida por esta porta, mas sei que ela está nos céus. Talvez ela se abra, em alguns segundos... É certamente uma lenda confusa, nunca consegui compreendê-la.
      }
      else { msg =$nick $chr(160) $cc $+ Tucker $ct $+ - Talvez poderemos ter uma maior conversa posteriormente. Concentre-se agora em derrotar a liga pokémon. Boa sorte. }
    }
    return
  }
  elseif ($1 == Aaron) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Aaron $+ $ct $+ , um pescador.
    if ($item($nick,Good Rod).qnt) { msg =$nick $chr(160) $cc $+ Aaron $ct $+ - Adoro Pacifidlog, é perfeito para quem quer tranquilidade. Hmm, acho que algum pokémon fisgou a minha isca! | return }
    else {
      if ($item($nick,Old Rod).qnt) {
        msg =$nick $chr(160) $cc $+ Aaron $ct $+ - Você ainda usa Old Rod? Nossa, eu prefiro a minha $cc $+ Good Rod $+ $ct $+ ! Com certeza tem uma performance melhor que a sua! Por que não começa a usar uma agora?
        item.add $nick Good Rod | msg =$nick $ct $+ Você recebeu o item $cc $+ Good Rod $+ $ct $+ .
      }
      else { msg =$nick $chr(160) $cc $+ Aaron $ct $+ - Não tem nenhuma esperiência com peixes? Por que não fala com $cc $+ Edgar $+ $ct $+ , em $cc $+ Mauville $+ $ct $+ ? Todo pescador começa usando as piores iscas! Acho que $cc $+ Edgar $ct $+ poderá ajudá-lo. }
    }
    return
  }
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Underwater { msg =$nick $ct $+ Nada foi encontrado. | return }
alias c.search.Evergrande_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do centro pokémon.
    if ($rini(cadastros,$nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Sim, eu soube que você entrou para o Hall of Fame! Que bom! Mas e agora? O que vai fazer? Não pense que seu trabalho como treinador está acabado, porque definitivamente não está. Boa sorte, $nick $+ ! | return }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Parabéns! Estar aqui é um grande passo, $nick $+ ! Você poderá competir na liga pokémon, sabia? Mas vou adiantando que não será fácil! Os membros da Elite Four são muito experientes em batalhas, e têm pokémon raros! Então, forme seu melhor time e boa sorte! | return }
  }
  elseif ($1 == Wally) && ($start($nick)) {
    if ($rini(cadastros,$nick,Quests,Wally)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Wally $+ $ct $+ .
      var %x = $rini(cadastros,$nick,Clock,Wally), %o = $rini(cadastros,$nick,Info,Online)
      if ($calc(%o - %x) >= 28800) {
        msg =$nick $chr(160) $cc $+ Wally $ct $+ - $nick $+ ! Quero testar minhas habilidades com você novamente! O que acha de uma batalha agora?
        msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para aceitar ou $cc $+ .nao $ct $+ para rejeitar. | set %confirm. [ $+ [ $nick ] ] CLK:Wally | return
      }
      else { msg =$nick $chr(160) $cc $+ Wally $ct $+ - Nossa, estou precisando treinar meus pokémon. Vou pensar numa estratégia melhor para te derrotar, $nick $+ ! Só assim eu saberei se estou pronto ou não para a liga pokémon! | return }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Sky_Pillar { msg =$nick $ct $+ Nada foi encontrado. | return }
