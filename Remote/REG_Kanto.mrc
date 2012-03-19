alias c.search.Pallet_Town {
  if ($1 == Oak) || ($1 == Professor) || ($1 == Prof Oak) { msg =$nick $ct $+ Acho que $cc $+ Prof Oak $ct $+ está no laboratório. | return }
  elseif ($1 == Mom) || ($1 == Mamãe) || ($1 == Mae) || ($1 == Mãe) {
    if ($start($nick)) {
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
            if ($dados($nick,Hoenn,League)) {
              if ($item($nick,Gold Ticket).qnt) {
                msg =$nick $chr(160) $cc $+ Mom $ct $+ - Então vai viajar novamente? Divirta-se e mande sempre notícias!
              }
              else { msg =$nick $chr(160) $cc $+ Mom $ct $+ - É bom ver que você está desenvolvendo bastante suas habilidades, filho. Mamãe fica sempre preocupada, mas sei também que você se sairá bem em qualquer desafio. Ah, parece que desenvolveram um navio muito resistente em $cc $+ Hoenn $+ $ct $+ . Eu me pergunto quem conseguiria ter dinheiro o suficiente para investir nesse enorme navio... }
            }
            else {
              msg =$nick $chr(160) $cc $+ Mom $ct $+ - Divirta-se, filho!
              msg =$nick $chr(160) $cc $+ Mom $ct $+ - Mamãe sentirá saudades...
            }
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
  else { msg =$nick $ct $+ Nada foi encontrado. | return }
}
alias c.search.Viridian_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($start($nick)) {
      if (!$dados($nick,$dados($nick,Info,Start),Badges).n) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá! Está procurando um desafio de ginásio em $cc $+ Viridian $+ $ct $+ ? Sinto muito, mas o ginásio daqui está fechado. O líder desta cidade é um homem muito ocupado, você terá sorte se um dia encontrá-lo para desafiar... Mas não se preocupe, tente outro desafio em $cc $+ Pewter City $+ $ct $+ . Com certeza ele estará disponível para você desafiá-lo! | return }
    }
    var %pk = $dados($nick,Team,1), %nat = $dados($nick,%pk,Nature), %x = 1
    while ($nstat(%x)) {
      var %stat = $nstat(%x)
      if ($getp(%nat,%stat) > 1) { var %plus = %stat }
      elseif ($getp(%nat,%stat) < 1) { var %minus = %stat }
      inc %x
    }
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Os pokémon possuem traços de personalidade, sabia? É o que as $cc $+ natures $ct $+ significam. Por exemplo, deixe-me ver seu pokémon...
    if (%plus) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu pokémon $cc $+ $dados($nick,%pk,Name) $ct $+ tem a nature $cc $+ %nat $+ $ct $+ , dando-lhe vantagem em $cc $+ $upper(%plus) $ct $+ e desvantagem em $cc $+ $upper(%minus) $+ $ct $+ . }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Seu pokémon $cc $+ $dados($nick,%pk,Name) $ct $+ tem a nature $cc $+ %nat $+ $ct $+ , mas não provoca diferenciação alguma em seus atributos. }
    return
  }
  elseif ($1 == Max) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Max $+ $ct $+ , um treinador.
    msg =$nick $chr(160) $cc $+ Max $ct $+ - Eu estava treinando meu Rattata bastante, até ele poder aprender um golpe novo. Mas eu não sabia como ensiná-lo, e acho que você também não sabe. Bem, um pokémon não aprende automaticamente um golpe quando seus $cc $+ quatro $ct $+ golpes estão definidos. A partir daí, os novos golpes ficam em modo de espera e você pode ensiná-los quando quiser, apenas uma vez.
    msg =$nick $chr(160) $cc $+ Max $ct $+ - Para ensinar, digite, sem as aspas, " $+ $cc $+ .MoveSet <Pokémon> <Slot> <Novo Golpe> $+ $ct $+ ". $cc $+ <pokémon> $ct $+ é o seu pokémon, $cc $+ <slot> $ct $+ é o slot do golpe, digite " $+ $cc $+ .Dados <pokémon> $+ $ct $+ " para saber o slot do golpe que deseja substituir, e finalmente $cc $+ <novo golpe> $ct $+ é o golpe que você vai ensinar ao pokémon.
  }
  elseif ($1 == Penny) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Penny $+ $ct $+ , uma treinadora.
    if ($start($nick)) {
      if ($dados($nick,Kanto,Badges).n) {
        if ($dados($nick,Quests,Penny)) { .msg =$nick $chr(160) $cc $+ Penny $ct $+ - Lembro-me ainda hoje que treinar meu Caterpie foi difícil, mesmo utilizando o item $cc $+ Macho Brace $+ $ct $+ . Ah, mas quando eu o evolui, não teve para ninguém! }
        else { .msg =$nick $chr(160) $cc $+ Penny $ct $+ - Finalmente, meu Metapod evoluiu para Butterfree! Não preciso mais usar este $cc $+ Macho Brace $+ $ct $+ , pois o mesmo deixa meu pokémon bem mais lento. Você gostaria de ter este item? Então pode ficar. | item.add $nick Macho Brace | msg =$nick $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou o item $cc $+ Macho Brace $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Penny 1 }
      }
      else { msg =$nick $chr(160) $cc $+ Penny $ct $+ - Meu Caterpie passou tantos leveis que já pode evoluir para Metapod. Aliás, você sabe como evoluir seu pokémon? Se não souber o nome da sua evolução, digite apenas " $+ $cc $+ .Evoluir <pokémon> $+ $ct $+ ", sem as aspas, é claro. Sabendo o nome da evolução, digite finalmente " $+ $cc $+ .Evoluir <pokémon> <evolução> $+ $ct $+ ". No meu caso, para evoluir meu Caterpie, eu digito " $+ $cc $+ .Evoluir Caterpie Metapod $+ $ct $+ ". }
    }
    else { msg =$nick $chr(160) $cc $+ Penny $ct $+ - A cidade vizinha, em $cc $+ Pallet $+ $ct $+ , é onde novos treinadores começam suas jornadas aqui em $cc $+ Kanto $+ $ct $+ . }
  }
  elseif ($1 == Giovanni) {
    if ($start($nick)) {
      if ($badge($nick,Earth Badge)) {
        if ($dados($nick,Quests,Giovanni) == No) { msg =$nick $cc $+ Giovanni $ct $+ não está na cidade... }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Giovanni $+ $ct $+ , líder do ginásio de Viridian.
          if ($dados($nick,Quests,Giovanni) == Ok) { msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Finalmente entendo que errei. Todo o dinheiro que ganhei de trabalhar junto à equipe $cc $+ Rocket $ct $+ foi entregue às autoridades. Agora estou livre, tenho agora uma nova expectativa para o futuro. }
          else {
            msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Não pode ser verdade, eu não posso estar errado...
            if ($dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Preciso... Preciso ter o melhor pokémon do mundo! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Giovanni No }
          }
        }
      }
      else {
        if ($dados($nick,Quests,Rocket3)) { msg =$nick $cc $+ Giovanni $ct $+ está no ginásio, aguardando seu desafio. }
        else { msg =$nick $ct $+ Nada foi encontrado. }
      }
    }
    else {
      if ($badge($nick,Earth Badge)) {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Giovanni $+ $ct $+ , líder do ginásio de Viridian.
        msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Pokémon não são como eu imaginava. Sinto muito por ter causado tantos problemas junto a equipe $cc $+ Rocket $+ $ct $+ . Hoje não trabalho mais com eles.
      }
      else { msg =$nick $cc $+ Giovanni $ct $+ está no ginásio, aguardando seu desafio. }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Pewter_City {
  if ($1 == Joy) { msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center. | msg =$nick $chr(160) $cc $+ Joy $ct $+ - Aqui em Pewter, o líder Brock usa pokémon de pedra. Quer uma dica? Tente usar golpes do tipo $cc $+ Water $ct $+ ou $cc $+ Grass $ct $+ e você terá uma vantagem contra ele. }
  elseif ($1 == Josh) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Josh $+ $ct $+ , um habitante da cidade.
    if ($badge($nick,Boulder Badge)) { msg =$nick $chr(160) $cc $+ Josh $ct $+ - Ei, parabéns pela vitória contra $cc $+ Brock $+ $ct $+ ! Boa sorte! }
    else { msg =$nick $chr(160) $cc $+ Josh $ct $+ - Ei, você já foi dar uma olhada no ginásio da cidade? Cuidado, vá preparado. Afinal, você terá que pagar para desafiar o líder. }
  }
  elseif ($1 == Clara) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Clara $+ $ct $+ , uma habitante da cidade.
    if ($dados($nick,Quests,League)) { .msg =$nick $chr(160) $cc $+ Clara $ct $+ - Estou anciosa para saber se realmente existem símbolos antigos espalhados pelo mundo. Gostaria eu puder viajar por aí, em busca desses mistérios... }
    else { msg =$nick $chr(160) $cc $+ Clara $ct $+ - Adoro visitar o museu de ciência. Olhe só todos esses fósseis! Eu quero ser cientista quando crescer! }
  }
  elseif ($1 == Ben) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ben $+ $ct $+ , um treinador.
    msg =$nick $chr(160) $cc $+ Ben $ct $+ - $cc $+ Moon Stone $+ $ct $+ ... Aqui diz que é um meteorito encontrado no $cc $+ Mt Moon $+ $ct $+ ... Para mim, é uma pedra como outra qualquer!
  }
  elseif ($1 == Brock) {
    if ($badge($nick,Boulder Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Brock $+ $ct $+ , líder do ginásio de Pewter.
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Brock $ct $+ - Existem diversos tipos de treinadores no mundo. Você me parece um treinador nato. Quer uma sugestão? Vá para $cc $+ Cerulean City $ct $+ e teste suas habilidades. }
      else { msg =$nick $chr(160) $cc $+ Brock $ct $+ - Foi uma boa batalha, considerando que minha estratégia falhara muitas vezes. Boa sorte na liga de $cc $+ Kanto $+ $ct $+ . }
    }
    else { msg =$nick $cc $+ Brock $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Mt_Moon {
  if ($1 == Rocket) && ($dados($nick,Quests,Rocket1)) && ($start($nick)) {
    if ($dados($nick,Quests,Rocket1) == Ok) { msg =$nick $ct $+ Aqueles ladrões não estão mais aqui... }
    else {
      msg =$nick $ct $+ Você encontra-se com membros da equipe $cc $+ Rocket $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Track $ct $+ (ROCKET) - Ei você! Está querendo levar a $cc $+ Moon Stone $+ $ct $+ , é? Hahaha, é melhor você sair daqui ou eu vou ensiná-lo uma lição!
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para batalhar ou ' $+ $cc $+ .nao $+ $ct $+ ' para sair do $cc $+ Mt Moon $+ $ct $+ . | set %confirm. [ $+ [ $nick ] ] RKT:1
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Cerulean_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($dados($nick,Cascade Badge)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Dificil mesmo é encontrar fraquezas entre tantos pokémon aquáticos diferentes. Há tantos, mas tantos deles neste mundo que é impossível prever que estratégia o adversário vai utilizar. }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Olá, é sua primeira vez aqui em Cerulean? Se for, lembre-se de passar no ginásio da cidade. $cc $+ Misty $ct $+ usa pokémon do tipo $cc $+ Water $+ $ct $+ , será que você consegue vencer a habilidade dela? }
  }
  elseif ($1 == Ronny) { msg =$nick $ct $+ Você encontra-se com $cc $+ Ronny $+ $ct $+ , um treinador. | msg =$nick $chr(160) $cc $+ Ronny $ct $+ - A Equipe Rocket causa muitos problemas aqui em $cc $+ Kanto $+ $ct $+ , é bom você ter cuidado. Eles costumam roubar dinheiro de treinadores, mas já ouvi casos de furto de pokémon. Que ladrões! Alguém devia fazer alguma coisa! }
  elseif ($1 == Giovanni) && ($dados($nick,Quests,Giovanni) == No) {
    if ($dados($nick,Quests,UD)) { msg =$nick $cc $+ Giovanni $ct $+ não está mais na cidade... }
    else {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Giovanni $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Preciso capturar o melhor pokémon do mundo! Com ele todos terão que se curvar diante da equipe $cc $+ Rocket $+ $ct $+ !
      msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , não se intrometa! Isso será perigoso, mesmo não gostando de você prefiro avisá-lo do perigo.
      msg =$nick $ct $+ Você vê $cc $+ Giovanni $ct $+ entrando na $cc $+ Unknown Dungeon $+ $ct $+ . | writeini pkp\cadastros\ $+ $nick $+ .ini Quests UD Ok
    }
  }
  elseif ($1 == Elliot) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Elliot $+ $ct $+ , um pescador.
    if ($start($nick)) {
      if ($item($nick,Good Rod).qnt) {
        if ($item($nick,Super Rod).qnt) { msg =$nick $chr(160) $cc $+ Elliot $ct $+ - Hahahaha... $cc $+ Super Rod $ct $+ é imbatível! }
        else {
          msg =$nick $chr(160) $cc $+ Elliot $ct $+ - Tem razão, nada pode superar a $cc $+ Super Rod $+ $ct $+ ! Fique com esta, gostei de você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ !
          item.add $nick Super Rod | msg =$nick $chr(160) $cc $+ Elliot $ct $+ - Sua isca agora pode alcançar qualquer pokémon aquático! Prepare-se para encontrar alguns raros, hein!
        }
      }
      else { msg =$nick $chr(160) $cc $+ Elliot $ct $+ - Não me pertube enquanto eu estiver pescando, por favor! }
    }
    else { msg =$nick $chr(160) $cc $+ Elliot $ct $+ - Gosto da maneira como pesco, não sou impaciente. Sei que mais cedo ou mais tarde, eu pegarei um pokémon interessante! }
  }
  elseif ($1 == Bill) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Bill $+ $ct $+ , um pokémaniaco.
    if ($start($nick)) {
      if ($dados($nick,Quests,Bill1)) {
        if ($dados($nick,Quests,Anne)) {
          if ($dados($nick,Quests,Bill2)) {
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - E como está indo sua jornada? Será que você consegue derrotar a liga pokémon?
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Se não sabe onde ela se localiza, digite ' $+ $cc $+ .Map $+ $ct $+ '. Veja, existe um caminho à esquerda de $cc $+ Viridian City $+ $ct $+ , que vai à $cc $+ Victory Road $+ $ct $+ . É só seguir adiante e você chegará ao $cc $+ Indigo Plateau $+ $ct $+ . | return
          }
          else {
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Gostou do $cc $+ SS Anne $+ $ct $+ ? Bem, quem sabe você ainda não viaje nele futuramente...
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Ah, $cc $+ Lanette $ct $+ e eu desenvolvemos o PC. A nova tecnologia é dela, mas eu iniciei o projeto. Você já tem um $cc $+ PC $+ $ct $+ ?
            if ($item($nick,PC).qnt) {
              msg =$nick $chr(160) $cc $+ Bill $ct $+ - Ah, então que tal um upgrade? Pode ficar com esta $cc $+ Great Box $+ $ct $+ . | box.add $nick 60
              msg =$nick $ct $+ Parabéns, você ganhou uma $cc $+ Great Box $+ $ct $+ !
            }
            else {
              msg =$nick $chr(160) $cc $+ Bill $ct $+ - Oh, não?! Desculpe, eu deveria ter oferecido antes. Aqui está. | item.add $nick PC | box.add $nick 30 | box.add $nick 30 | box.add $nick 30
              msg =$nick $ct $+ Parabéns, você ganhou um $cc $+ PC $+ $ct $+ !
            }
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Bill2 Ok | return
          }
        }
        else { msg =$nick $chr(160) $cc $+ Bill $ct $+ - Pegue o $cc $+ SS Anne $ct $+ em $cc $+ Vermilion City $+ $ct $+ , e divirta-se! | return }
      }
      else {
        msg =$nick $chr(160) $cc $+ Bill $ct $+ - Ei, eu não sou um pokémon! Isto é uma fantasia... Infelizmente acabei ficando preso a ela... Pode me ajudar?
        msg =$nick $chr(160) $cc $+ Bill $ct $+ - Obrigado! Ah, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , eu fui convidado para a inauguração de um cruzeiro que sairá de $cc $+ Vermilion City $+ $ct $+ , mas estou muito ocupado. Você pode ir no meu lugar?
        msg =$nick $cc $+ $dados($nick,Info,Nick) $ct $+ recebeu o $cc $+ convite $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Bill1 Ok | return
      }
    }
    else {
      if ($dados($nick,Quests,Bill1)) {
        if ($earl.count($nick) == 17) {
          if ($dados($nick,Quests,Global)) { msg =$nick $chr(160) $cc $+ Bill $ct $+ - Hahaha, não achou que eu realmente apagaria todo o conteúdo do PC, não é mesmo? Aproveite. A rede pode ser acessada de qualquer região do mundo! }
          else {
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Inacreditável! Você conseguiu derrotar toda a liga de $cc $+ Johto $+ $ct $+ ! Orgulhe-se bastante disso, não é qualquer um...
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Também tenho uma novidade. $cc $+ Lanette $ct $+ e eu finalmente trabalhamos juntos e conseguimos interligar nossas redes através da moderna conexão sem fio! Que tal se você experimentar também?
            var %x = 1 | while ($exists(pkp\box\ $+ $nick $+ \ $+ %x $+ .ini)) { writeini pkp\box\ $+ $nick $+ \ $+ %x $+ .ini Info Link Hoenn:Kanto:Johto | inc %x }
            msg =$nick $chr(160) $cc $+ Bill $ct $+ - Pronto. Acabei de formatar todo o conteúdo das suas caixas. Até mais!
            writeini pkp\cadastros\ $+ $nick $+ .ini Quests Global $dados($nick,Info,Online)
          }
        }
        else {
          msg =$nick $chr(160) $cc $+ Bill $ct $+ - Por se tratar de apenas um protótipo, a $cc $+ $rtypebox(5) $ct $+ armazena poucos pokémon... Bem, é difícil manter uma rede poderosa como essa se seus usuários sobrecarregam as caixas, certo? Err, esqueça...
          msg =$nick $chr(160) $cc $+ Bill $ct $+ - Mudando de assunto, como está indo na liga de $cc $+ $dados($nick,Info,Region) $+ $ct $+ ?
        }
        return
      }
      else {
        msg =$nick $chr(160) $cc $+ Bill $ct $+ - Olá, eu sou o $cc $+ Bill $+ $ct $+ . As pessoas me conhecem como pokémaníaco, mas tudo o que faço é colecionar pokémon raros. Ora, quem não tem suas manias, afinal?
        msg =$nick $chr(160) $cc $+ Bill $ct $+ - Ah, você veio de $cc $+ $dados($nick,Info,Start) $+ $ct $+ ? Já fui convidado para um cruzeiro, mas não pude ir, estava muito ocupado...
        msg =$nick $chr(160) $cc $+ Bill $ct $+ - Hm, quer dizer então que não consegue acessar as boxes de $cc $+ $dados($nick,Info,Start) $+ $ct $+ ... Espere, devo ter um protótipo de uma box por aqui, com uma cobertura bem maior... Achei!
        msg =$nick $ct $+ Parabéns, você ganhou uma $cc $+ $rtypebox(5) $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Bill1 Ok | box.add $nick 5 | return
      }
    }
  }
  elseif ($1 == Misty) {
    if ($badge($nick,Cascade Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Misty $+ $ct $+ , líder do ginásio de Cerulean.
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Misty $ct $+ - Eu sempre gostei de pokémon aquáticos desde o início, e fiz o possível para me especializar neles. Agora sei que ainda tenho muito o que aprender... }
      else { msg =$nick $chr(160) $cc $+ Misty $ct $+ - Ah! Eu sei que ainda tenho muito que aprender, mas algumas pessoas simplesmente já possuem uma habilidade nata de treinar pokémon... Estou falando de você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! }
    }
    else { msg =$nick $cc $+ Misty $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Underground_Path {
  var %region = $dados($nick,Info,Region)
  if ($findtok(Old Amber:fóssil:fossil:Amber,$1-,0,58)) && ($dados($nick,Info,Path) == 1) {
    var %x = $readini(pkp\status.ini,%region,Item), %i = Old Amber
    if ($findtok(%x,%i,0,58)) {
      msg =$nick $ct $+ Você encontrou um fóssil! Parabéns, você ganhou o item $cc $+ %i $+ $ct $+ !
      item.add $nick %i | var %x = $remtok(%x,%i,1,58) | if (%x) { writeini pkp\status.ini %region Item %x } | else { remini pkp\status.ini %region Item }
    }
    else { msg =$nick $ct $+ Nada foi encontrado. | return }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Power_Plant { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Vermilion_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , enfermeira do Pokémon Center.
    if ($start($nick)) {
      if ($badge($nick,Thunder Badge)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Para entrar no ginásio da cidade, é necessário cortar os arbustos. Seu pokémon não consegue cortar? Bem, acho que o capitão do $cc $+ SS Anne $ct $+ poderá ajudá-lo. }
      else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Com a insígnea $cc $+ Thunder Badge $ct $+ você poderá usar a técnica $cc $+ Fly $ct $+ com seu pokémon. }
    }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a Vermilion City! É seu primeiro dia em $cc $+ Kanto $+ $ct $+ ? Divirta-se! }
  }
  elseif ($1 == Thomas) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Thomas $+ $ct $+ , o criador de pokémon.
    if ($dados($nick,Clock,Thomas)) && ($calc($dados($nick,Info,Online) - $dados($nick,Clock,Thomas)) < 10800) { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - É bom saber que poderemos negociar sempre, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Que tal outra hora? | return }
    if ($totalpokes($nick) > 1) {
      msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Nossa! Seus pokémon estão incríveis! Você gostaria de vender algum deles para mim? | msg =$nick $ct $+ Digite $cc $+ .sim $ct $+ para confirmar e $cc $+ .nao $ct $+ para rejeitar.
      set %confirm. [ $+ [ $nick ] ] THM | return
    }
    else { msg =$nick $chr(160) $cc $+ Thomas $ct $+ - Quando tiver mais pokémon, venha e vamos fazer negócio. | return }
  }
  elseif ($1 == Lena) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lena $+ $ct $+ , uma treinadora.
    msg =$nick $chr(160) $cc $+ Lena $ct $+ - Aqui em Vermilion há um porto, e muitos treinadores de outros continentes começam a liga de $cc $+ Kanto $ct $+ aqui.
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %l = 1 } } | elseif ($dados($nick,Kanto,League)) { var %l = 1 }
    if (%l) { msg =$nick $chr(160) $cc $+ Lena $ct $+ - Ei, não conte meu segredo a ninguém! Outro dia estava caminhando em $cc $+ Diglett Cave $ct $+ e achei ter visto um objeto esquisito lá. Tentei pegar mas não consegui. Será que se trata de um dos símbolos? }
  }
  elseif ($1 == Cory) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Cory $+ $ct $+ , o marujo.
    if ($start($nick)) && (!$dados($nick,Quests,Anne)) {
      if ($dados($nick,Quests,Bill1)) {
        msg =$nick $chr(160) $cc $+ Cory $ct $+ - Você tem o $cc $+ convite $+ $ct $+ . Quer dizer que pode visitar o navio. Mas seja breve, porque está prestes a partir. Deseja entrar no navio?
        msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne
      }
      else {
        msg =$nick $chr(160) $cc $+ Cory $ct $+ - Ei, só podem visitar o $cc $+ SS Anne $ct $+ quem for convidado!
        msg =$nick $chr(160) $cc $+ Cory $ct $+ - Hmm, $cc $+ Bill $ct $+ está atrasado? Você o viu em $cc $+ Cerulean City $+ $ct $+ ?
      }
    }
    else {
      if ($dados($nick,$dados($nick,Info,Start),Badges).n == 8) {
        var %x = $dados($nick,Clock,Ship), %y = 0
        if (%x) { if ($calc($dados($nick,Info,Online) - %x) >= 21600) { var %y = 1 } } | else { var %y = 1 }
        if (%y) {
          if ($item($nick,Gold Ticket).qnt) && ($item($nick,Silver Ticket).qnt) {
            msg =$nick $chr(160) $cc $+ Cory $ct $+ - Oh, este é o $cc $+ Silver Ticket $ct $+ e o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Anne) $+ $ct $+ ) ou no $cc $+ SS Tidal $ct $+ ( $+ $cc $+ $travel.ship($nick,SS Tidal) $+ $ct $+ ) $+ ?
            msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim <barco> $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne;SS Tidal
          }
          elseif ($item($nick,Gold Ticket).qnt) {
            msg =$nick $chr(160) $cc $+ Cory $ct $+ - Oh, este é o $cc $+ Gold Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Tidal $+ $ct $+ ?
            msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Tidal
          }
          elseif ($item($nick,Silver Ticket).qnt) {
            msg =$nick $chr(160) $cc $+ Cory $ct $+ - Oh, este é o $cc $+ Silver Ticket $+ $ct $+ . Deseja embarcar no $cc $+ SS Anne $+ $ct $+ ?
            msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] SHP:SS Anne
          }
          else { msg =$nick $chr(160) $cc $+ Cory $ct $+ - Você não pode embarcar se não tiver uma passagem de navio. }
        }
        else { msg =$nick $chr(160) $cc $+ Cory $ct $+ - Argh! Não há barcos agora... Lembre-se que é preciso aguardar seis horas $cc $+ online $ct $+ para pegar um barco novamente... Neste momento, faltam aproximadamente $dur($calc(21600 - ($dados($nick,Info,Online) - %x)),$ct,$cc) $+ . }
      }
      else { msg =$nick $chr(160) $cc $+ Cory $ct $+ - Não há nenhum barco neste momento em $cc $+ Vermilion $+ $ct $+ . }
    }
    return
  }
  elseif ($1 == Surge) || ($1- == Lt.Surge) {
    if ($badge($nick,Thunder Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Lt.Surge $+ $ct $+ , líder do ginásio de Vermilion.
      if ($start($nick)) {
        if ($badge($nick,Soul Badge)) && (!$item($nick,HM03).qnt) { msg =$nick $chr(160) $cc $+ Lt.Surge $ct $+ - Quer ensinar seus pokémon a surfar, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ? Tudo bem, basta ensiná-los a técnica $cc $+ Surf $+ $ct $+ ! | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM03 $+ $ct $+ ! | item.add $nick HM03 }
        else { msg =$nick $chr(160) $cc $+ Lt.Surge $ct $+ - Durante a segunda guerra mundial, pokémon elétricos salvaram a minha vida. Desde então, especializo-me no treinamento desse tipo de pokémon, e hoje estou certo de que fiz a escolha certa! }
      }
      else { msg =$nick $chr(160) $cc $+ Lt.Surge $ct $+ - O que seria da vida humana sem a eletricidade? Hahaha, monótona? }
    }
    else { msg =$nick $cc $+ Lt.Surge $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Diglett_Cave {
  if ($findtok(Symbol:Simbolo:Símbolo,$1,0,58)) {
    if (!$dados($nick,Quests,Symbol)) { var %x = 0:0:0:0 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol %x }
    else { var %x = $dados($nick,Quests,Symbol) }
    var %n = 1
    if ($gettok(%x,%n,58)) { msg =$nick $ct $+ Este símbolo já foi adquirido anteriormente. }
    else {
      if ($team.hm($nick,Earthquake) == Ok!) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol $puttok(%x,1,%n,58) | msg =$nick $cc $+ Earth Symbol $ct $+ foi encontrado com sucesso. }
      else { msg =$nick $ct $+ Nada pôde ser encontrado. }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.SS_Anne {
  if ($1 == Sammy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Sammy $+ $ct $+ , um treinador.
    if ($dados($nick,Info,Start) == Kanto) {
      msg =$nick $chr(160) $cc $+ Sammy $ct $+ - Estou ancioso para que este barco chegue ao seu destino. Mal posso esperar para ver espécies diferentes de pokémon nessa nova região!
      if (!$item($nick,HM01).qnt) { msg =$nick $chr(160) $cc $+ Sammy $ct $+ - Hm, este barco está demorando... Será que há algo de errado com o capitão? }
    }
    else {
      if (!$dados($nick,Quests,SSAnne)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne 0:0:0:0:0 }
      if ($gettok($dados($nick,Quests,SSAnne),1,58)) { msg =$nick $chr(160) $cc $+ Sammy $ct $+ - Este barco está a caminho de $cc $+ $dados($nick,Info,Dest) $+ $ct $+ . Já visitou esse continente alguma vez? }
      else {
        msg =$nick $chr(160) $cc $+ Sammy $ct $+ - Ah! Treinador! Vamos por em prática nossas habilidades!
        battle.npc $nick Trainer_Sammy | writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne $puttok($dados($nick,Quests,SSAnne),1,1,58)
      }
    }
  }
  elseif ($1 == Iris) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Iris $+ $ct $+ , uma treinadora.
    if ($dados($nick,Info,Start) == Kanto) {
      msg =$nick $chr(160) $cc $+ Iris $ct $+ - As vezes eu sinto náuzeas ao viajar de barco... Espero ficar bem desta vez!
      if (!$item($nick,HM01).qnt) { msg =$nick $chr(160) $cc $+ Iris $ct $+ - Ah sim, se este barco desembarcar... }
    }
    else {
      if (!$dados($nick,Quests,SSAnne)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne 0:0:0:0:0 }
      if ($gettok($dados($nick,Quests,SSAnne),2,58)) { msg =$nick $chr(160) $cc $+ Iris $ct $+ - É bom poder voltar a $cc $+ $dados($nick,Info,Dest) $+ $ct $+ ... Estava com saudades! }
      else {
        msg =$nick $chr(160) $cc $+ Iris $ct $+ - Você é um treinador pokémon?
        battle.npc $nick Lady_Iris | writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne $puttok($dados($nick,Quests,SSAnne),1,2,58)
      }
    }
  }
  elseif ($1 == Evan) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Evan $+ $ct $+ , um treinador.
    if ($dados($nick,Info,Start) == Kanto) {
      msg =$nick $chr(160) $cc $+ Evan $ct $+ - Em meus livros, eu descubro muita coisa. Sabia que há cavernas escondidas neste mundo? Eu queria encontrar todas elas!
      if (!$item($nick,HM01).qnt) { msg =$nick $chr(160) $cc $+ Evan $ct $+ - A mistura da minha ansiedade com o atraso deste navio não está dando certo... }
    }
    else {
      if (!$dados($nick,Quests,SSAnne)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne 0:0:0:0:0 }
      if ($gettok($dados($nick,Quests,SSAnne),3,58)) { msg =$nick $chr(160) $cc $+ Evan $ct $+ - Procurei bastante em $cc $+ Hoenn $ct $+ por cavernas secretas e não encontrei nada. Segundo meus livros, dois pokémon são necessários. Estou voltando para pesquisar mais a respeito... }
      else {
        msg =$nick $chr(160) $cc $+ Evan $ct $+ - Está atrás de mistérios também? Então vamos batalhar!
        battle.npc $nick Trainer_Evan | writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne $puttok($dados($nick,Quests,SSAnne),1,3,58)
      }
    }
  }
  elseif ($1 == Norry) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Norry $+ $ct $+ , um marujo.
    if ($dados($nick,Info,Region) == Kanto) {
      if ($item($nick,HM01).qnt) { msg =$nick $chr(160) $cc $+ Norry $ct $+ - Adeus, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! | msg =$nick $ct $+ O navio $cc $+ SS Anne $ct $+ partiu... }
      else { msg =$nick $chr(160) $cc $+ Norry $ct $+ - Tudo bem, você pode desembarcar. Alias, não tenho certeza sobre que horas vamos partir... Já estamos atrasados. }
      writeini pkp\cadastros\ $+ $nick $+ .ini Info Locate Vermilion City | msg =$nick $ct $+ Você está agora em $cc $+ $dados($nick,Info,Locate) $+ $ct $+ . | wlog user $nick Moved to $dados($nick,Info,Locate) $+ .
    }
    else {
      if (!$dados($nick,Quests,SSAnne)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne 0:0:0:0:0 }
      if ($gettok($dados($nick,Quests,SSAnne),4,58)) {
        if ($dados($nick,Quests,Anne)) {
          msg =$nick $chr(160) $cc $+ Norry $ct $+ - Chegamos! Pode desembarcar agora, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ .
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
        else { msg =$nick $chr(160) $cc $+ Norry $ct $+ - Calma, ainda não pode desembarcar. Estamos perto de chegar ao nosso destino. }
      }
      else {
        msg =$nick $chr(160) $cc $+ Norry $ct $+ - Eu trabalho aqui no $cc $+ SS Anne $ct $+ como marujo. Encontrei muitos pokémon diferentes em várias viagens, e um deles segurava isto...
        item.add $nick Leftovers | msg =$nick $ct $+ Parabéns, você ganhou um $cc $+ Leftovers $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne $puttok($dados($nick,Quests,SSAnne),1,4,58)
      }
    }
  }
  elseif ($findtok(Captain:Capitão:Capitao:Jay,$1,0,58)) {
    if ($dados($nick,Info,Region) == Kanto) {
      if ($dados($nick,Quests,Anne)) {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Jay $+ $ct $+ , o capitão do $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Jay $ct $+ - Ah, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Apresse-se! Estamos prestes a partir! Procure pelo marujo $cc $+ Norry $ct $+ para desembarcar.
      }
      else {
        if ($dados($nick,Quests,Gary2)) {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Jay $+ $ct $+ , o capitão do $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Jay $ct $+ - Coooffff... Coooffff... Arrrrrrrrghhh...
          msg =$nick $chr(160) $cc $+ Jay $ct $+ - Obrigado pela tapa nas costas, minha garganta realmente não anda muito bem...
          msg =$nick $chr(160) $cc $+ Jay $ct $+ - Ah sim, você precisa cortar arbustos? Então é só ensinar ao seu pokémon o $cc $+ HM01 $+ $ct $+ !
          item.add $nick HM01 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Anne Ok | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM01 $+ $ct $+ !
        }
        else {
          msg =$nick $chr(160) $cc $+ ??? $ct $+ - Espere!
          msg =$nick $chr(160) $cc $+ Gary $ct $+ - Sabia que era você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Sabe quantos pokémon eu já capturei? Mais de 70 espécies diferentes! Hahahaha... Estou imbatível!
          battle.npc $nick Novice_Gary | sset [ [ B. ] $+ [ $checknickid($nick).ID ] $+ [ .Quest ] ] GARY2
        }
      }
    }
    else {
      if ($dados($nick,Quests,SSAnne) == 1:1:1:1:1) {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Jay $+ $ct $+ , o capitão do $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
        if ($dados($nick,Info,Dest) == Kanto) { var %l = Vermilion City } | elseif ($dados($nick,Info,Dest) == Hoenn) { var %l = Slateport City } | elseif ($dados($nick,Info,Dest) == Johto) { var %l = Olivine City }
        msg =$nick $chr(160) $cc $+ Jay $ct $+ - Hahaha, finalmente chegamos em $cc $+ %l $+ $ct $+ ! É sua primeira vez em $cc $+ $dados($nick,Info,Dest) $+ $ct $+ ? Não fique nervoso, procure ajuda no centro pokémon. Boa sorte!
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Anne Ok
      }
      else {
        if (!$dados($nick,Quests,SSAnne)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne 0:0:0:0:0 }
        if ($gettok($dados($nick,Quests,SSAnne),5,58)) {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Jay $+ $ct $+ , o capitão do $cc $+ $dados($nick,Info,Locate) $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Jay $ct $+ - Olá, está gostando da viagem? Estamos perto de chegar, porque não dá uma explorada no navio enquanto isso?
        }
        else {
          msg =$nick $chr(160) $cc $+ ??? $ct $+ - Espere!
          msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Sinto muito, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , mas não nos conhecemos ainda. Meu nome é Brendan, sou filho de Norman. Sim, líder de Petalburg. Eu começei minha jornada há pouco tempo e ja fiz bons progressos! Veja você mesmo!
          battle.npc $nick Brendan | sset [ [ B. ] $+ [ $checknickid($nick).ID ] $+ [ .Quest ] ] Brendan | writeini pkp\cadastros\ $+ $nick $+ .ini Quests SSAnne $puttok($dados($nick,Quests,SSAnne),1,5,58)
        }
      }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Rock_Tunnel { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Lavender_Town {
  if ($1 == Fuji) || ($1- == Mr Fuji) {
    if ($start($nick)) {
      if ($item($nick,Poké Flute).qnt) { msg =$nick $ct $+ Você encontra-se com o senhor $cc $+ Fuji $+ $ct $+ , criador de pokémon. | msg =$nick $chr(160) $cc $+ Fuji $ct $+ - Minha $cc $+ Poké Flute $ct $+ ajudou-lhe em alguma coisa? }
      else { msg =$nick $ct $+ Não consigo encontrar o senhor $cc $+ Fuji $+ $ct $+ ... }
    }
    else {
      msg =$nick $ct $+ Você encontra-se com o senhor $cc $+ Fuji $+ $ct $+ , criador de pokémon.
      msg =$nick $chr(160) $cc $+ Fuji $ct $+ - Olá, eu gosto de criar pokémon que foram abandonados ou que estão órfãos. Eu sinto que estou fazendo o melhor por eles.
    }
  }
  elseif ($1 == Doug) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Doug $+ $ct $+ , um habitante da cidade.
    if ($start($nick)) { if ($dados($nick,Quests,League)) { var %l = 1 } } | elseif ($dados($nick,Kanto,League)) { var %l = 1 }
    if (%l) { msg =$nick $chr(160) $cc $+ Doug $ct $+ - Eu ouvi falar sobre a existência de quatro símbolos antigos, mas não pude encontrar nada. Acho que é preciso, além de muita sorte, fazer com que o pokémon tenha um golpe... }
    else { msg =$nick $chr(160) $cc $+ Doug $ct $+ - Lavender é conhecida como pólo de atração de almas de pokémon. As almas dos pokémon parecem se dirigir para a Pokémon Tower. }
  }
  elseif ($1 == Anth) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Anth $+ $ct $+ , um habitante da cidade.
    if ($start($nick)) {
      if ($item($nick,Poké Flute).qnt) { msg =$nick $chr(160) $cc $+ Anth $ct $+ - Ah, felizmente o senhor $cc $+ Fuji $ct $+ está são e salvo agora. }
      else { msg =$nick $chr(160) $cc $+ Anth $ct $+ - Socorro! Eu vi aqueles ladrões sequestrando o $cc $+ Fuji $ct $+ e levando-o à Pokémon Tower! Alguém precisa deter aqueles patifes! }
    }
    else { msg =$nick $chr(160) $cc $+ Anth $ct $+ - Eu gosto de visitar os pokémon do senhor $cc $+ Fuji $+ $ct $+ , eles são tão adoráveis... Ele sabe mesmo como criar um pokémon! }
  }
  elseif ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a Lavender Town. Você deve estar sentindo algo estranho na atmosfera daqui, não é mesmo? Tudo bem, esta cidade é especial por atrair pokémon fantasmas. Não se assuste! São apenas pokémon!
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Celadon_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a Celadon! Esta cidade é abençoada por ter o ginásio mais florido do mundo! Você poderá encontrar muitas garotas no ginásio, todas são atraídas pelo incrível aroma emanado pelos pokémon da líder... Delicioso!
  }
  elseif ($1 == Julia) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Julia $+ $ct $+ , uma habitante da cidade.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Julia $ct $+ - Você está gostando da cidade? É impressão minha ou o movimento daqui aumentou muito nos ultimos dias? Não me refiro a você, mas sujeitos estranhos têm transitado entre as cidades, vestidos com roupas pretas... Felizmente não houve nada de errado por aqui! }
    else { msg =$nick $chr(160) $cc $+ Julia $ct $+ - No passado, a equipe Rocket havia criado um esconderijo aqui no subsolo de Celadon. Não consigo imaginar como eles fizeram isso sem que ninguém percebesse... }
  }
  elseif ($1 == Rich) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Rich $+ $ct $+ , um treinador.
    if ($start($nick)) {
      if ($dados($nick,Quests,Rocket3)) { msg =$nick $chr(160) $cc $+ Rich $ct $+ - Ah! Bem que suspeitava que aquele guarda era um impostor! Maldita equipe Rocket, atrapalhando minha jornada... }
      else { msg =$nick $chr(160) $cc $+ Rich $ct $+ - Você foi barrado ao tentar passar para Saffron? Droga, eu também fui. Simplesmente não entendo e nem o guarda me deu explicações. Hm, aquele sujeito parecia-me suspeito... Será que realmente era um guarda? }
    }
    else { msg =$nick $chr(160) $cc $+ Rich $ct $+ - Eu não confio em qualquer guarda que tenta me barrar. Desconfie também quando guardas não deixam você passar e nem sequer dão uma explicação! }
  }
  elseif ($1 == Andrea) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Andrea $+ $ct $+ , uma treinadora.
    if ($start($nick)) { msg =$nick $ct $+ Andrea $ct $+ - Eu comprei uma $cc $+ Thunderstone $ct $+ e evolui meu $cc $+ Pikachu $+ $ct $+ . Sim, há pokémon que só evoluem usando pedras. Não há segredo, para evoluir um pokémon com pedra, basta ter o item em sua mochila e utilizar o comando ' $+ $cc $+ .Evoluir $+ $ct $+ '... Simples assim! }
    else { msg =$nick $ct $+ Andrea $ct $+ - $cc $+ Lt.Surge $+ $ct $+ , líder de Vermilion, tem um Raichu muito especial: ele sabe usar a técnica $cc $+ Surf $+ $ct $+ ! Quem dera o meu soubesse também... }
  }
  elseif ($1 == Lucas) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lucas $+ $ct $+ , um treinador.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Lucas $ct $+ - Eu comprei um pokémon no market e ele está mais forte que meus pokémon! Sabe por quê? É que pokémon com $cc $+ ID $ct $+ diferente do treinador ganham mais $cc $+ EXP $ct $+ por batalha! Hahaha, acho que vou comprar mais pokémon hoje! }
    else { msg =$nick $chr(160) $cc $+ Lucas $ct $+ - Esta é uma das melhores cidades de $cc $+ Kanto $+ $ct $+ , pois além de uma loja bem elaborada ainda há um $cc $+ market $+ $ct $+ ! Você o conhece? }
  }
  elseif ($1 == Chad) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Chad $+ $ct $+ , um habitante.
    msg =$nick $chr(160) $cc $+ Chad $ct $+ - Ahhh... Estou viciado em apostar minhas moedas no cassino! Preciso de mais moedas, as minhas estão acabando...
    if (!$dados($nick,Quests,Rocket2)) && ($start($nick)) { msg =$nick $chr(160) $cc $+ Chad $ct $+ - Ufa, finalmente aquele homem saiu. Seu olhar me intimidou... Alias, não o vi saindo pela porta. Pra onde ele foi afinal? }
  }
  elseif ($1 == Janice) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Janice $+ $ct $+ , uma treinadora.
    if ($dados($nick,Quests,Janice)) {
      msg =$nick $chr(160) $cc $+ Janice $ct $+ - Eu gostei desta cidade. Vou visitá-la mais vezes, e você?
    }
    else {
      msg =$nick $chr(160) $cc $+ Janice $ct $+ - Olha! Acho que estou com sorte! Ganhei mais moedas, hahahaha...
      if ($item($nick,Coin Case).qnt) {
        var %c = $dados($nick,Info,Coin), %r = $calc(%c + 50) | if (%r > 9999) { var %r = 9999 } | writeini pkp\cadastros\ $+ $nick $+ .ini Info Coin %r
        msg =$nick $chr(160) $cc $+ Janice $ct $+ - Tome estas moedas! Espero que você também tenha sorte! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Janice Ok
      }
      else { msg =$nick $chr(160) $cc $+ Janice $ct $+ - Hm, quando conseguir um $cc $+ Coin Case $ct $+ eu vou dar-te algumas moedas, ok? }
      if (!$dados($nick,Quests,Rocket2)) && ($start($nick)) { msg =$nick $chr(160) $cc $+ Janice $ct $+ - Havia um homem muito estranho que contemplava aquele $cc $+ poster $ct $+ da parede. Não sei onde ele foi parar. }
    }
  }
  elseif ($1 == Kay) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Kay $+ $ct $+ , a balconista do cassino.
    if ($item($nick,Coin Case).qnt) {
      msg =$nick $chr(160) $cc $+ Kay $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Cada moeda custa $cc $+ $chr(36) $+ $getmoney($readini(pkp\status.ini,Active,Coin)) $+ $ct $+ . Você deseja trocar seu dinheiro por moedas?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar. | set %confirm. [ $+ [ $nick ] ] COIN:Kay:1
    }
    else { msg =$nick $chr(160) $cc $+ Kay $ct $+ - Não posso ajudá-lo... Você não pode comprar moedas se não tiver um $cc $+ Coin Case $+ $ct $+ ... }
  }
  elseif ($findtok(Poster:Pôster,$1,0,58)) && ($start($nick)) {
    if ($dados($nick,Quests,Poster)) { msg =$nick $ct $+ Não há mais nada além de um botão escondido neste pôster. }
    else {
      msg =$nick $ct $+ Você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , deu uma olhada no pôster e achou um botão!
      msg =$nick $ct $+ Ao apertá-lo, uma passagem abriu no subsolo. Espere! Membros da equipe $cc $+ Rocket $ct $+ estão ali! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Poster Ok
    }
  }
  elseif ($1 == Rocket) && ($start($nick)) && ($dados($nick,Quests,Poster)) {
    if ($dados($nick,Quests,Rocket2)) { msg =$nick $ct $+ Não há mais nenhum membro da equipe $cc $+ Rocket $ct $+ nesta cidade. }
    else {
      msg =$nick $ct $+ Você entrou no $cc $+ Rocket Hideout $+ $ct $+ ! Membros da equipe $cc $+ Rocket $ct $+ estão querendo batalhar com você.
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para batalhar ou ' $+ $cc $+ .nao $+ $ct $+ ' para fugir. | set %confirm. [ $+ [ $nick ] ] RKT:2
    }
  }
  elseif ($1 == Celena) {
    if ($start($nick)) {
      if ($item($nick,HM02).qnt) {
        if ($dados($nick,Quests,Celena)) { msg =$nick $cc $+ $dados($nick,Info,Nick) $ct $+ não conseguiu encontrá-la... }
        else {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Celena $+ $ct $+ , escondida...
          msg =$nick $chr(160) $cc $+ Celena $ct $+ - Hey, depois que ensinar a técnica $cc $+ Fly $ct $+ ao seu pokémon, digite " $+ $cc $+ .Fly $+ $ct $+ " para voar para localizações diversas, sem esperar tempo!
          msg =$nick $chr(160) $cc $+ Celena $ct $+ - Agora vou arrumar um novo esconderijo, espero que eu tenha sido útil! Hahaha, até! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Celena Ok
        }
      }
      else {
        msg =$nick $ct $+ Você finalmente encontrou $cc $+ Celena $+ $ct $+ !
        msg =$nick $chr(160) $cc $+ Celena $ct $+ - Nossa, como sabia que eu estava aqui?! Bem, não importa agora. Ensine a seus pokémon a técnica $cc $+ Fly $+ $ct $+ .
        item.add $nick HM02 | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM02 $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Celena $ct $+ - Mas não conte a ninguém sobre o meu esconderijo!
      }
    }
    else { msg =$nick $ct $+ Você encontra-se com $cc $+ Celena $+ $ct $+ , uma treinadora. | msg =$nick $chr(160) $cc $+ Celena $ct $+ - É divertido esconder-se de treinadores! Se pudesse, eu compraria uma casa bem isolada para morar. }
  }
  elseif ($findtok(Presente:Presente secreto:Gift:Hidden Gift,$1-,0,58)) && ($start($nick)) && ($dados($nick,Quests,Gift)) {
    if ($dados($nick,Quests,Gift) == Ok) { msg =$nick $ct $+ Não há mais presentes aqui... }
    else {
      var %x = Eevee
      msg =$nick $ct $+ Você encontrou um $cc $+ presente $+ $ct $+ ! Oh, é um pokémon!
      if ($dados($nick,%x,Name)) { msg =$nick $ct $+ Você não pôde recebê-lo porque já tem um pokémon com o mesmo $cc $+ nome $ct $+ no time... | return }
      if ($dados($nick,Team,6)) { msg =$nick $ct $+ Você não pôde recebê-lo porque não há espaço em seu time! | return }
      msg =$nick $ct $+ Parabéns! $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou o pokémon $cc $+ %x $+ $ct $+ !
      if (!$pokedex($nick,%x)) { .echo $pokedex($nick,%x).add } | addpoke $nick %x 30 30: $+ $dados($nick,Info,Locate) $+ :Poke  Ball
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Gift Ok
    }
    return
  }
  elseif ($1 == Erika) {
    if ($badge($nick,Rainbow Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Erika $+ $ct $+ , líder do ginásio de Celadon.
      msg =$nick $chr(160) $cc $+ Erika $ct $+ - Eu adoro pokémon do tipo planta. Além dos agradáveis aromas, esses pokémon possuem uma relação mais forte com a natureza. Sempre que algo está errado, eles o demonstram com certa inquietação.
    }
    else { msg =$nick $cc $+ Erika $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Saffron_City {
  if ($1 == Koji) && ($start($nick)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Koji $+ $ct $+ , um lutador.
    if ($start($nick)) {
      if ($dados($nick,Quests,Rocket3)) {
        if ($badge($nick,Soul Badge)) {
          if ($item($nick,HM04).qnt) { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Com $cc $+ Strength $+ $ct $+ , seu pokémon poderá mover blocos de pedra livres no chão. }
          else { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Hahaha, você conseguiu a insígnea! Parabéns! Então ensine $cc $+ Strength $ct $+ aos seus pokémon também! | item.add $nick HM04 | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM04 $+ $ct $+ ! }
        }
        else { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Nossa, não consegui derrotar a líder com meus pokémon, e eu achei que o golpe $cc $+ Strength $ct $+ daria conta dela... }
      }
      else { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Quando esses ladrões finalmente sairem da cidade, vou tentar ganhar a minha insígnea com $cc $+ Sabrina $+ $ct $+ . }
    }
    else { msg =$nick $chr(160) $cc $+ Koji $ct $+ - Finalmente consegui derrotar a $cc $+ Sabrina $+ $ct $+ ... Sabe qual foi a minha estratégia? $cc $+ Bulk Up $ct $+ $chr(43) $cc $+ Strength $+ $ct $+ ! }
  }
  elseif ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    if ($start($nick)) {
      if ($dados($nick,Quests,Rocket3)) { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Esta cidade finalmente está livre da equipe $cc $+ Rocket $+ $ct $+ . Sabia que havia membros disfarçados de guardas? }
      else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Não entendo o que ocorre na cidade. Parece-me que foi tomada pela Equipe $cc $+ Rocket $+ $ct $+ ... Ninguém pode entrar nem sair da cidade. Espero que alguém faça algo para ajudar. }
    }
    else { msg =$nick $chr(160) $cc $+ Joy $ct $+ - Esta grande cidade possui uma das mais importantes empresas de produtos relacionados à pokémon: a $cc $+ Silph Corporation $+ $ct $+ . Porém, certa vez esta empresa foi vítima da própria fama: atraiu a Equipe $cc $+ Rocket $+ $ct $+ ... }
  }
  elseif ($findtok(President:Presidente:Silph,$1,0,58)) {
    if ($dados($nick,Info,Start) == Hoenn) { var %pf = Birch } | elseif ($dados($nick,Info,Start) == Kanto) { var %pf = Oak } | else { var %pf = Elm }
    var %dex = $dados($nick,Info,Pokedex), %n = $int($calc(%dex / 100))
    if ($start($nick)) {
      if ($dados($nick,Quests,Silph2)) {
        if (%n) {
          msg =$nick $ct $+ Você encontra-se com $cc $+ Silph $+ $ct $+ , o presidente da $cc $+ Silph Corp $+ $ct $+ .
          msg =$nick $chr(160) $cc $+ Silph $ct $+ - Hm, eu te dei uma $cc $+ Master Ball $ct $+ por ter derrotado a equipe $cc $+ Rocket $+ $ct $+ ? Nossa, fui muito generoso. Não conte com isso de novo, a menos que faça por merecer! Hah!
          if (!$dados($nick,Quests,%pf $+ 1)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests $+(%pf,1) Ok }
          elseif (!$dados($nick,Quests,%pf $+ 2)) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests $+(%pf,2) Ok }
          else { writeini pkp\cadastros\ $+ $nick $+ .ini Quests $+(%pf,3) Ok }
          remini pkp\cadastros\ $+ $nick $+ .ini Quests Silph2 | return
        }
      }
      if ($dados($nick,Quests,Rocket3)) {
        msg =$nick $ct $+ Você encontra-se com $cc $+ Silph $+ $ct $+ , o presidente da $cc $+ Silph Corp $+ $ct $+ .
        if ($dados($nick,Quests,Silph)) {
          if (!$dados($nick,Quests,League)) { msg =$nick $chr(160) $cc $+ Silph $ct $+ - Não vou mentir para você, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ . Há sim outros itens que foram desenvolvidos pela $cc $+ Silph Corp $+ $ct $+ . Mas por questões éticas, manterei-as em segredo. | return }
        }
        else {
          msg =$nick $chr(160) $cc $+ Silph $ct $+ - Estou impressionado... $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , como pôde derrotá-los simplesmente? Não, não conte nada. Cada treinador deve manter suas estratégias em segredo até a hora da batalha, certo?
          writeini pkp\cadastros\ $+ $nick $+ .ini Quests Silph Ok | item.add $nick Upgrade
          msg =$nick $chr(160) $cc $+ Silph $ct $+ - Fique, por favor, com este $cc $+ Upgrade $+ $ct $+ . Não se engane, este item poderá evoluir um pokémon inventado aqui mesmo na corporação: $cc $+ Porygon $+ $ct $+ . Boa sorte em sua jornada! | return
        }
      }
      else { msg =$nick $ct $+ Não dá para entrar em $cc $+ Silph Corp $+ $ct $+ . Há membros da equipe $cc $+ Rocket $ct $+ na entrada... | return }
    }
    else {
      if (!$dados($nick,Quests,Silph)) {
        msg =$nick $chr(160) $cc $+ Silph $ct $+ - Ora ora, mas veja quem temos aqui em nossa corporação! Você é mesmo $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ...? Hah! Eu sabia. $cc $+ Prof %pf $ct $+ foi realmente muito fiel nos detalhes. | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Silph Ok | item.add $nick Upgrade
        msg =$nick $chr(160) $cc $+ Silph $ct $+ - Bem, soubemos de seu brilhante desempenho e decidimos assistí-lo quando possível. Afinal de contas, tenho dinheiro o bastante para investir em quem eu quiser! Hah! Por favor, fique com este $cc $+ Upgrade $ct $+ e será possível evoluir $cc $+ Porygon $+ $ct $+ . Aproveite! | return
      }
    }
    if (%n) && (!$dados($nick,Quests,%pf $+ %n)) {
      msg =$nick $chr(160) $cc $+ Silph $ct $+ - Acabo de falar com $cc $+ Prof %pf $ct $+ e fui comunicado de seu atual feito brilhante! Ora vamos, não seja modesto, diga-me...
      msg =$nick $chr(160) $cc $+ Silph $ct $+ - Exato! Você capturou no mínimo $cc $+ $calc(%n * 100) $ct $+ pokémon diferentes! É incrível! Sua cooperação no estudo das espécies está cada vez mais influente e grandiosa. Para esta ocasião, nada melhor que um item grandioso à altura de seu devido crédito.
      msg =$nick $ct $+ Parabéns! Você ganhou uma $cc $+ Master Ball $+ $ct $+ ! | item.add $nick Master Ball | writeini pkp\cadastros\ $+ $nick $+ .ini Quests $+(%pf,%n) Ok
    }
    else {
      if ($item($nick,Master Ball).qnt) { msg =$nick $chr(160) $cc $+ Silph $ct $+ - Lembre-se que a $cc $+ Master Ball $ct $+ é a única capaz de capturar qualquer espécie de pokémon sem dificuldades na batalha. Os materais usados para fabricá-la são tão raros que praticamente esta pokébola é desconhecida. De certa forma, é um alívio. Os pokémon não gostariam de saber que teríamos uma ferramenta capaz de capturar até o mais resistente deles! }
      else { msg =$nick $chr(160) $cc $+ Silph $ct $+ - Quer uma dica? Sempre que encontrar uma espécie de pokémon que não estiver registrado em sua pokédex, não se esqueça jamais de capturá-lo! Treinadores e pesquisadores pokémon precisam trabalhar juntos para catalogar, se não todos, ao menos o máximo possível de pokémon existentes! }
    }
  }
  elseif ($1 == Koichi) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Koichi $+ $ct $+ , líder do $cc $+ Fighting Dojo $+ $ct $+ .
    if ($start($nick)) {
      if ($dados($nick,Quests,Dojo)) {
        if ($dados($nick,Quests,Dojo) == Ok) {
          var %x = Hitmonchan:Hitmonlee | if ($dados($nick,$gettok(%x,1,58),Name)) { var %x = $remtok(%x,$gettok(%x,1,58),1,58) } | if ($dados($nick,$gettok(%x,2,58),Name)) { var %x = $remtok(%x,$gettok(%x,2,58),1,58) } | if ($dados($nick,Team,6)) { var %x = 0 }
          if (%x) {
            if ($gettok(%x,0,58) == 2) {
              msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Parabéns, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Como eu havia prometido, você ganhará um pokémon. Escolha qual destes vai querer: $cc $+ Hitmonchan $ct $+ ou $cc $+ Hitmonlee $+ $ct $+ .
              msg =$nick $ct $+ Digite o nome do pokémon que você vai escolher. | set %getpk. [ $+ [ $nick ] ] %x
            }
            else {
              msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Parabéns, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Como eu havia prometido, este $cc $+ %x $ct $+ é seu.
              if (!$pokedex($nick,%x)) { .echo $pokedex($nick,%x).add } | addpoke $nick %x 30 30:Fighting Dojo:Poke  Ball | msg =$nick $ct $+ Parabéns, $cc $+ $nick $ct $+ ganhou o pokémon $cc $+ %x $+ $ct $+ ! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Dojo Ok: $+ %x
            }
          }
          else { msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Você tem muitos pokémon em seu time, volte quando tiver espaço disponível para escolher meu pokémon. }
        }
        elseif ($gettok($dados($nick,Quests,Dojo),1,58) == Ok) { var %x = $gettok($dados($nick,Quests,Dojo),2,58) | msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Você escolheu $cc $+ %x $+ $ct $+ , um ótimo pokémon para se ter no time, sem dúvida. }
        else { msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Não haverá uma nova chance, treinador. Sinto muito, mas você tem potencial. Boa sorte! }
      }
      else {
        msg =$nick $chr(160) $cc $+ Koichi $ct $+ - Então, visitante? Vai desafiar os lutadores do $cc $+ Fighting Dojo $+ $ct $+ ? Se vencer, ganhará um pokémon lutador.
        msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para aceitar ou ' $+ $cc $+ .nao $+ $ct $+ ' para recusar. | set %confirm. [ $+ [ $nick ] ] DOJ
      }
    }
    else { msg =$nick $chr(160) $cc $+ Koichi $ct $+ - $cc $+ Hitmonchan $ct $+ possui incríveis habilidades com os punhos, enquanto que $cc $+ Hitmonlee $+ $ct $+ , nos pés. São dois grandes lutadores e são membros do meu time, certamente! }
  }
  elseif ($1 == Rocket) && ($start($nick)) && (!$dados($nick,Quests,Rocket3)) {
    msg =$nick $ct $+ Membros da equipe $cc $+ Rocket $ct $+ perceberam sua presença na $cc $+ Silph Corp $+ $ct $+ !
    msg =$nick $ct $+ O que deseja fazer? Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para batalhar contra eles ou ' $+ $cc $+ .nao $+ $ct $+ ' para escapar. | set %confirm. [ $+ [ $nick ] ] RKT:3
  }
  elseif ($1 == Amanda) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Amanda $+ $ct $+ , uma habitante da cidade.
    if ($start($nick)) {
      if ($dados($nick,Quests,Rocket3)) {
        if ($item($nick,Coin Case).qnt) { msg =$nick $chr(160) $cc $+ Amanda $ct $+ - E pensar que já perdi muito dinheiro para a equipe $cc $+ Rocket $+ $ct $+ ... Isso me deixa aborrecida. }
        else { msg =$nick $chr(160) $cc $+ Amanda $ct $+ - Nunca mais vou no cassino, está decidido! Não quero fazer nada que possa beneficar a equipe $cc $+ Rocket $+ $ct $+ . Pegue isto. | item.add $nick Coin Case | msg =$nick $ct $+ Parabéns, $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou um $cc $+ Coin Case $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Amanda $ct $+ - Naquele jogo de azar eu não jogarei mais! }
      }
      else { msg =$nick $chr(160) $cc $+ Amanda $ct $+ - O que? É verdade que havia um esconderijo secreto da equipe $cc $+ Rocket $ct $+ no subsolo do cassino de $cc $+ Celadon $+ $ct $+ ?! Estou pasma... }
    }
    else {
      if ($item($nick,Coin Case).qnt) { msg =$nick $chr(160) $cc $+ Amanda $ct $+ - E pensar que já perdi muito dinheiro para a equipe $cc $+ Rocket $+ $ct $+ ... Isso me deixa aborrecida. }
      else { msg =$nick $chr(160) $cc $+ Amanda $ct $+ - Eu tenho um $cc $+ Coin Case $ct $+ e costumava jogar em $cc $+ Celadon City $+ $ct $+ , no cassino. Mas quando descobri que a equipe $cc $+ Rocket $ct $+ fica com os lucros daqueles jogos, eu decidi que preciso me livrar disto agora mesmo! Tome, pode ficar. | item.add $nick Coin Case | msg =$nick $ct $+ Parabéns, $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou um $cc $+ Coin Case $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Amanda $ct $+ - Lembre-se do que eu falei, e faça o que você quiser. Não me meto mais em jogos de azar... }
    }
  }
  elseif ($1 == Sabrina) {
    if ($badge($nick,Marsh Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Sabrina $+ $ct $+ , líder do ginásio de Saffron.
      if ($start($nick)) {
        if ($item($nick,HM02).qnt) { msg =$nick $chr(160) $cc $+ Sabrina $ct $+ - Eu sempre soube que a equipe $cc $+ Rocket $ct $+ estava atacando a $cc $+ Silph Corp $+ $ct $+ , mas previ também que você viria ajudar. }
        else { msg =$nick $chr(160) $cc $+ Sabrina $ct $+ - Consigo captar a presença de uma jovem em $cc $+ Celadon City $ct $+ que se esconde... Seu nome é $cc $+ Celena $+ $ct $+ . }
      }
      else { msg =$nick $chr(160) $cc $+ Sabrina $ct $+ - Tive problemas na infância em controlar meus poderes psíquicos, mas hoje consigo controlá-los perfeitamente. A telepatia e o teletransporte são habilidades psíquicas que aprendi ao longo do meu desenvolvimento. }
    }
    else { msg =$nick $cc $+ Sabrina $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Seafoam_Island { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Fuchsia_City {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo, treinador! Esta cidade é privilegiada por ter uma $cc $+ Safari Zone $+ $ct $+ ! Muitas espécies raras de pokémon podem ser encontradas lá.
  }
  elseif ($1 == Lucas) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Lucas $+ $ct $+ , um treinador.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Lucas $ct $+ - Nossa não sabia que havia limite de pokébolas usadas na $cc $+ Safari Zone $+ $ct $+ , senão teria usado minhas $cc $+ Ultra Ball $+ $ct $+ ! }
    else { msg =$nick $chr(160) $cc $+ Lucas $ct $+ - Ahhh... Perdi um $cc $+ Chansey $+ $ct $+ ... Acho que nunca vou encontrá-lo de novo... }
  }
  elseif ($1 == Cooper) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Cooper $+ $ct $+ , um treinador.
    if ($start($nick)) { msg =$nick $chr(160) $cc $+ Cooper $ct $+ - Meus pokémon agora podem usar a técnica $cc $+ Surf $+ $ct $+ , pois já possuo a insígnea $cc $+ Soul Badge $+ $ct $+ . Queria que algum pokémon meu fosse como o $cc $+ Raichu $ct $+ de $cc $+ Lt.Surge $+ $ct $+ ... }
    else { msg =$nick $chr(160) $cc $+ Cooper $ct $+ - Meus pokémon já conseguem usar a técnica $cc $+ Surf $+ $ct $+ ! Acho que vou visitar a $cc $+ Seafoam Island $+ $ct $+ . }
  }
  elseif ($1 == Ann) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ann $+ $ct $+ , uma habitante.
    msg =$nick $chr(160) $cc $+ Ann $ct $+ - Droga, queria ter uma bicicleta! Ouvi falar que na $cc $+ Cycling Road $ct $+ há um pokémon dorminhoco. Queria capturá-lo.
  }
  elseif ($1 == Koga) {
    if ($badge($nick,Soul Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Koga $+ $ct $+ , líder do ginásio de Fuchsia.
      if ($start($nick)) { msg =$nick $chr(160) $cc $+ Koga $ct $+ - A liga pokémon localiza-se em $cc $+ Indigo Plateau $+ $ct $+ . Só os melhores compõem a $cc $+ Elite Four $+ $ct $+ . }
      else { msg =$nick $chr(160) $cc $+ Koga $ct $+ - Ensino a meus discípulos como envenenar dolorosamente seus adversários e vencê-los sem dificuldades. }
    }
    else { msg =$nick $cc $+ Koga $ct $+ está no ginásio, aguardando seu desafio. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Cinnabar_Island {
  var %region = $dados($nick,Info,Region)
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - $cc $+ Cinnabar Island $ct $+ é banhada pelo vasto oceano e é muito conhecida pelo seu famoso laboratório. No passado, havia também uma mansão que estudava os pokémon, mas agora só resta as suas cinzas.
  }
  elseif ($1 == Wade) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Wade $+ $ct $+ , um pescador.
    if ($start($nick)) && (!$item($nick,Old Rod).qnt) { msg =$nick $chr(160) $cc $+ Wade $ct $+ - Você nunca pescou na vida? Sinto que preciso ajudá-lo, pode ficar com esta $cc $+ Old Rod $+ $ct $+ ! | item.add $nick Old Rod | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ Old Rod $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Wade $ct $+ - Para pescar, digite ' $+ $cc $+ .Item USE Old Rod $+ $ct $+ ' e inicie uma batalha com pokémon selvagem. }
    elseif ($start($nick)) { msg =$nick $chr(160) $cc $+ Wade $ct $+ - Admito que a $cc $+ Old Rod $ct $+ não é muito boa, mas eu não podia dar também a minha vara de pescar. | if (!$item($nick,Good Rod)) { msg =$nick $chr(160) $cc $+ Wade $ct $+ - Conhece o pescador $cc $+ Ronald $+ $ct $+ ? Ele costuma pescar em $cc $+ Coral Bridge $+ $ct $+ . Talvez ele tenha uma vara de pescar melhor. } }
    else { msg =$nick $chr(160) $cc $+ Wade $ct $+ - Eu não sei quem inventou que pescador tem fama de mentiroso! Posso jurar que vi um Gyarados vermelho outro dia, acredita em mim? Eu disse Gyarados, não Magikarp... }
  }
  elseif ($1 == Amara) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Amara $+ $ct $+ , uma treinadora.
    msg =$nick $chr(160) $cc $+ Amara $ct $+ - $cc $+ Pokémon House $ct $+ era palco de inúmeras pesquisas envolvendo pokémon, mas uma delas destruiu o próprio laboratório. Não consigo imaginar o que eles pesquisavam ali.
    msg =$nick $chr(160) $cc $+ Amara $ct $+ - Atualmente, há outro laboratório na cidade e muitos pesquisadores frequentam este lugar. É que foi criado a $cc $+ Ressurection Machine $+ $ct $+ , ou simplesmente máquina de ressureição, que traz fósseis de volta a vida. É impressionante!
  }
  elseif ($1 == Claire) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Claire $+ $ct $+ , uma habitante.
    msg =$nick $chr(160) $cc $+ Claire $ct $+ - Alguns anos após o incidente da $cc $+ Pokémon House $ct $+ eu vim morar aqui. A casa virou habitat para diversos pokémon. É estranho, mas a estrutura da casa continua firme, embora a maioria dela esteja em cinzas.
  }
  elseif ($1 == Blaine) {
    if ($badge($nick,Volcano Badge)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Blaine $+ $ct $+ , líder do ginásio de Cinnabar.
      msg =$nick $chr(160) $cc $+ Blaine $ct $+ - Certa vez fiquei perdido nas montanhas, felizmente estava bem. Quando anoiteceu, um pássaro de fogo apareceu e com sua luz consegui encontrar meu caminho para descer.
      if ($dados($nick,Quests,League)) && (!$findtok($dados($nick,%region,Visited),Mt Ember,0,58)) {
        msg =$nick $chr(160) $cc $+ Blaine $ct $+ - Você deveria visitar o lugar, é uma pequena ilha próxima daqui. Chama-se $cc $+ Mt Ember $+ $ct $+ . A única forma de chegar até lá é usando $cc $+ Fly $+ $ct $+ . A localização já está marcada no mapa, boa sorte!
        if ($dados($nick,%region,Visited)) { writeini pkp\cadastros\ $+ $nick $+ .ini %region Visited $dados($nick,%region,Visited) $+ :Mt Ember }
        else { writeini pkp\cadastros\ $+ $nick $+ .ini %region Visited Mt Ember }
      }
    }
    else { msg =$nick $cc $+ Blaine $ct $+ está no ginásio, aguardando seu desafio. }
  }
  elseif ($1 == Phil) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Phil $+ $ct $+ , um cientista famoso.
    msg =$nick $chr(160) $cc $+ Phil $ct $+ - Você provavelmente já deve ter me visto em alguma revista. Sou realmente muito famoso, e posso ressucitar qualquer fóssil com a $cc $+ Ressurection Machine $+ $ct $+ !
    if ($item($nick,Old Amber).qnt) {
      if (!$dados($nick,Aerodactyl,Name)) && (!$dados($nick,Team,6)) { item.rem $nick Old Amber | if (!$pokedex($nick,Aerodactyl)) { .echo $pokedex($nick,Aerodactyl).add } | addpoke $nick Aerodactyl 30 30:Ressurection Machine:Poke  Ball | msg =$nick $ct $+ Parabéns, $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou o pokémon $cc $+ Aerodactyl $+ $ct $+ ! }
      else { msg =$nick $chr(160) $cc $+ Phil $ct $+ - Você provavelmente deseja ressucitar seu $cc $+ Old Amber $+ $ct $+ . Então libere espaço no time para ganhar o pokémon. }
    }
    elseif ($item($nick,Unknown Gene).qnt) {
      if (!$dados($nick,Team,6)) {
        var %pk.list = Deoxys:Deoxys.E:Deoxys.F:Deoxys.L, %x = 1
        while ($gettok(%pk.list,%x,58)) {
          var %pk = $gettok(%pk.list,%x,58)
          if ($dados($nick,%pk,Name)) || ($pokedex($nick,%pk)) { var %pk.list = $remtok(%pk.list,%pk,58) }
          else { inc %x }
        }
        if (%pk.list) {
          item.rem $nick Unknown Gene, %x = $rand(1,$gettok(%pk.list,0,58)), %pk = $gettok(%pk.list,%x,58)
          if (!$pokedex($nick,%pk)) { .echo $pokedex($nick,%pk).add } | addpoke $nick %pk 40 40:Ressurection Machine:Poke  Ball | msg =$nick $ct $+ Parabéns, $cc $+ $dados($nick,Info,Nick) $ct $+ ganhou o pokémon $cc $+ %pk $+ $ct $+ !
        }
        else {
          msg =$nick $chr(160) $cc $+ Phil $ct $+ - Não consegui! Que incrível! Esta é a primeira vez que acontece!
        }
      }
      else { msg =$nick $chr(160) $cc $+ Phil $ct $+ - Você provavelmente deseja ressucitar seu $cc $+ Unknown Gene $+ $ct $+ . Então libere espaço no time para ganhar o pokémon. }
    }
    else { msg =$nick $chr(160) $cc $+ Phil $ct $+ - Fósseis como $cc $+ Old Amber $ct $+ podem ser ressucitados pela minha máquina. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Mt_Ember {
  if ($findtok(Symbol:Simbolo:Símbolo,$1,0,58)) {
    if (!$dados($nick,Quests,Symbol)) { var %x = 0:0:0:0 | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol %x }
    else { var %x = $dados($nick,Quests,Symbol) }
    var %n = 4
    if ($gettok(%x,%n,58)) { msg =$nick $ct $+ Este símbolo já foi adquirido anteriormente. }
    else {
      if ($team.hm($nick,Fire Spin) == Ok!) { writeini pkp\cadastros\ $+ $nick $+ .ini Quests Symbol $puttok(%x,1,%n,58) | msg =$nick $cc $+ Fiery Symbol $ct $+ foi encontrado com sucesso. }
      else { msg =$nick $ct $+ Nada pôde ser encontrado. }
    }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
}
alias c.search.Coral_Bridge {
  if ($1 == Ronald) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Ronald $+ $ct $+ , um pescador.
    if ($start($nick)) {
      if ($item($nick,Old Rod).qnt) {
        if ($item($nick,Good Rod).qnt) { msg =$nick $chr(160) $cc $+ Ronald $ct $+ - Bem, a $cc $+ Good Rod $ct $+ só é superada mesmo pela $cc $+ Super Rod $+ $ct $+ ! Nada consegue ser mais eficaz que ela! Quando $cc $+ Elliot $ct $+ mostrou-me seu desempenho, admito que fiquei com inveja... }
        else {
          msg =$nick $chr(160) $cc $+ Ronald $ct $+ - Ahhh, então você quer pescar de forma mais profissional, certo? Tudo bem, esta $cc $+ Good Rod $ct $+ resolverá seus problemas!
          item.add $nick Good Rod | msg =$nick $chr(160) $cc $+ Ronald $ct $+ - Sua isca pode alcançar pokémon que ficam em águas mais fundas do que pescando com uma $cc $+ Old Rod $+ $ct $+ ...
        }
      }
      else { msg =$nick $chr(160) $cc $+ Ronald $ct $+ - Espere, estou pescando agora! Alias, quem é você mesmo? }
    }
    else { msg =$nick $chr(160) $cc $+ Ronald $ct $+ - $cc $+ Coral Bridge $ct $+ é um ótimo lugar para pescar! Minha $cc $+ Good Rod $ct $+ é suficientemente capaz de me deixar satisfeito! }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Cycling_Road {
  if ($findtok(Pokémon:pokemon:dorminhoco:dormindo:sleep:dorme:snorlax,$1,0,58)) {
    var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary)
    if ($findtok(%x,Snorlax,0,58)) {
      if ($dados($nick,Quests,Snorlax)) { msg =$nick $ct $+ Não há pokémon dormindo nesta localização. }
      else {
        msg =$nick $ct $+ Você encontrou o pokémon $cc $+ Snorlax $ct $+ dormindo na estrada!
        if (!$item($nick,Poké Flute).qnt) { msg =$nick $ct $+ Ele está dormindo... Não há como acordá-lo! | return }
        if ($rini(cadastros,$nick,Snorlax,Name)) { msg =$nick $ct $+ Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
        if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
        if ($appeared(Snorlax)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ Snorlax $ct $+ neste momento! | return }
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Snorlax Ok | msg =$nick $cc $+ $dados($nick,Info,Nick) $ct $+ está tocando sua $cc $+ Poké Flute $+ $ct $+ !
        .echo $addpoke($nick,Snorlax,40,40: $+ $dados($nick,Info,Locate)).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Snorlax)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
      }
    }
    else { msg =$nick $ct $+ Não há pokémon dormindo nesta localização. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Victory_Road { msg =$nick $ct $+ Nada foi encontrado. }
alias c.search.Indigo_Plateau {
  if ($1 == Joy) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Joy $+ $ct $+ , a enfermeira do Pokémon Center.
    msg =$nick $chr(160) $cc $+ Joy $ct $+ - Bem vindo a $cc $+ $dados($nick,Info,Locate) $+ $ct $+ ! Apenas grandes treinadores conseguem chegar aqui. Ganhar todas as insígneas não é uma tarefa fácil, mas infelizmente ganhar da $cc $+ Elite Four $ct $+ é pior ainda! Bem, boa sorte!
  }
  elseif ($1 == Mazon) && (!$dados($nick,Quests,Mazon)) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Mazon $+ $ct $+ , um velho historiador.
    var %s = $dados($nick,Quests,Symbol)
    if (%s) {
      if ($findtok(%s,1,0,58) == 4) {
        msg =$nick $chr(160) $cc $+ Mazon $ct $+ - Ah, então você adquiriu os quatro símbolos! Devo admitir que eu jamais conseguiria ser tão habilidoso neste aspecto. Parabéns! Estes símbolos foram usados por civilizações muito antigas para descrever o equilíbrio da natureza. Esta foi talvez a primeira demonstração da escrita humana. O convívio com pokémon que se apresentavam em diferentes formas provavelmente despertou este interesse humano em relação à comunicação. Por enquanto, trata-se apenas de hipóteses. As pessoas certamente acham muito difícil de acreditar que os pokémon poderiam ter ensinado aos homens muito mais do que o convívio em harmonia com a natureza, mas atividades complexas como ler e escrever.
        msg =$nick $chr(160) $cc $+ Mazon $ct $+ - Há pouco tempo atrás, uma região conhecida como $cc $+ Ruins Of Alph $+ $ct $+ , ou ruínas do alfabeto, foi localizada em $cc $+ Johto $+ $ct $+ . Até onde eu sei, fica nas proximidades de $cc $+ Violet City $ct $+ e provavelmente é o único lugar onde as palavras ocultas destes pokémon simbólicos foram preservadas. Acredito agora que, juntamente com estes símbolos, encontrarei uma forma de entrar naquelas ruínas. Preciso partir agora, nos encontraremos em $cc $+ Johto $+ $ct $+ !
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mazon 1
      }
      else { msg =$nick $chr(160) $cc $+ Mazon $ct $+ - Parabéns, parece que você está indo na direção certa. Mas lembre-se, até onde eu sei, apenas quatro símbolos foram feitos. Estou muito entusiasmado com estas novas descobertas, então faça o favor de mostrar-me todos estes artefatos quando você encontrá-los. }
    }
    else { msg =$nick $chr(160) $cc $+ Mazon $ct $+ - Em meus últimos anos de estudo, descobri que existem quatro símbolos pré-históricos que representam os quatro elementos da natureza: $cc $+ Água $+ $ct $+ , $cc $+ Fogo $+ $ct $+ , $cc $+ Terra $ct $+ e $cc $+ Ar $+ $ct $+ . Segundo as escrituras que descreviam estes símbolos, os mesmos têm uma intríseca relação entre seres humanos e pokémon místicos. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Unknown_Dungeon {
  if ($findtok(Giovanni:Mewtwo,$1,0,58)) && ($dados($nick,Quests,Giovanni) == No) {
    msg =$nick $ct $+ Você encontra-se com $cc $+ Giovanni $+ $ct $+ .
    var %x = $readini(pkp\status.ini,$dados($nick,Info,Region),Legendary)
    if ($findtok(%x,Mewtwo,0,58)) {
      if ($dados($nick,Quests,Mewtwo)) { msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Você... $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , tem razão. Tratei meus pokémon de forma ignorante todo esse tempo e por isso perdi a oportunidade de capturar o melhor pokémon. Agora entendo que os pokémon são nossos amigos, que merecem receber atenção e nosso carinho. Obrigado, agora entendo... | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Giovanni Ok }
      else {
        msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Não consegui capturá-lo porque meus pokémon se recusam a me obedecer...
        if ($rini(cadastros,$nick,Mewtwo,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Mewtwo $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
        if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Mewtwo $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
        if ($appeared(Mewtwo)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ Mewtwo $ct $+ neste momento! | return }
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mewtwo Ok | msg =$nick $ct $+ Pokémon $cc $+ Mewtwo $ct $+ está vindo em direção a $cc $+ $dados($nick,Info,Nick) $+ $ct $+ !
        .echo $addpoke($nick,Mewtwo,70,70: $+ $dados($nick,Info,Locate)).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Mewtwo)
        sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
      }
    }
    else {
      msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Capturei o melhor pokémon! Eu financiei a pesquisa de desenvolvimento deste pokémon a partir do gene de uma nova espécie de pokémon descoberta na América do Sul. Embora tenha destrúido o laboratório onde fora desenvolvido, sempre soube do seu esconderijo! Esperei para invadir a $cc $+ Silph Corp $ct $+ e pegar a $cc $+ Master Ball $ct $+ para finalmente tê-lo!
      msg =$nick $chr(160) $cc $+ Giovanni $ct $+ - Meu pokémon será minha ferramenta para dominar o mundo! Você será o primeiro, prepare-se.
      battle.npc $nick Giovanni_Mewtwo | sset [ [ B. ] $+ [ $checknickid($nick).ID ] $+ [ .Quest ] ] GIOVANNI
    }
  }
  elseif ($1 == Mewtwo) {
    var %x = $readini(pkp\status.ini,%region,Legendary)
    if ($findtok(%x,Mewtwo,0,58)) && (!$dados($nick,Quests,Mewtwo)) {
      if ($rini(cadastros,$nick,Mewtwo,Name)) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Mewtwo $+ $ct $+ . Você não pode batalhar agora, porque você já tem um pokémon com o mesmo nome no time. | return }
      if ($totalpokes($nick) == 6) { msg =$nick $ct $+ Você pode ver o pokémon $cc $+ Mewtwo $+ $ct $+ . Você não pode batalhar agora, porque você já tem seis pokémon no time. | return }
      if ($appeared(Mewtwo)) { msg =$nick $ct $+ Parece que há um treinador batalhando com $cc $+ Mewtwo $ct $+ neste momento! | return }
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Mewtwo Ok | msg =$nick $ct $+ Pokémon $cc $+ Mewtwo $ct $+ está vindo em direção a $cc $+ $dados($nick,Info,Nick) $+ $ct $+ !
      .echo $addpoke($nick,Mewtwo,70,70: $+ $dados($nick,Info,Locate)).wild | b.create.fila $nick $rini(cadastros,$nick,Team,1) | var %ID = $checknickid($nick).id | b.join %ID Wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam($nick,Mewtwo)
      sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] 10 | sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON | b.start.fight %ID
    }
    else { msg =$nick $ct $+ Nada foi encontrado. }
  }
  else { msg =$nick $ct $+ Nada foi encontrado. }
  return
}
alias c.search.Heavy_Den { msg =$nick $ct $+ Nada foi encontrado. }
