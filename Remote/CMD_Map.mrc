alias cmd.Map {
  var %l = $rini(cadastros,$nick,Info,Locate), %r = $dados($nick,Info,Region)
  msg =$nick $ct $+ Visualizando a região de $cc $+ %r $+ $ct $+ ...
  msg =$nick $ct $+ $str(_,64)
  if (%r == Hoenn) {
    if (%l == Littleroot Town) { var %l = 1 }
    elseif (%l == Oldale Town) { var %l = 2 }
    elseif (%l == Petalburg City) { var %l = 3 }
    elseif (%l == Moonlight Woods) { var %l = 4 }
    elseif (%l == Rustboro City) { var %l = 5 }
    elseif (%l == Dewford City) { var %l = 6 }
    elseif (%l == Slateport City) { var %l = 7 }
    elseif (%l == Mauville City) { var %l = 8 }
    elseif (%l == Verdanturf Town) { var %l = 9 }
    elseif (%l == Lavaridge Town) { var %l = 10 }
    elseif (%l == Mt Chimney) { var %l = 11 }
    elseif (%l == Fallarbor Town) { var %l = 12 }
    elseif (%l == Desert Underpass) { var %l = 12 }
    elseif (%l == Meteor Falls) { var %l = 13 }
    elseif (%l == Fortree City) { var %l = 14 }
    elseif (%l == Lilycove City) { var %l = 15 }
    elseif (%l == Mt Pyre) { var %l = 16 }
    elseif (%l == Mossdeep City) { var %l = 17 }
    elseif (%l == Underwater) { var %l = 18 }
    elseif (%l == Seafloor Cavern) { var %l = 18 }
    elseif (%l == Sootopolis City) { var %l = 19 }
    elseif (%l == Cave Of Origin) { var %l = 19 }
    elseif (%l == Pacifidlog Town) { var %l = 20 }
    elseif (%l == Evergrande City) { var %l = 21 }
    elseif (%l == Rusturf Tunnel) { var %l = 22 }
    elseif (%l == Sky Pillar) { var %l = 23 }
    elseif (%l == Shoal Cave) { var %l = 24 }
    else { var %l = 0 }
    msg =$nick 3,3                                                    9,9  12,12          
    if (%l == 24) { msg =$nick 3,3                                                   9,9    12,12     0,5<>12,12   }
    else { msg =$nick 3,3                                                   9,9    12,12     5,5  12,12   }
    msg =$nick 3,3    9,9                    3,3     9,9  3,3           9,9           12,12       10,10  12,12  
    msg =$nick 3,3  9,9                        3,3   9,9    3,3       9,9           12,12         10,10  12,12  
    if (%l == 10) { msg =$nick 3,3  5,5  8,8     4,4  8,8            0,4<>9,9  3,3   9,9        4,4  8,8       4,4    10,10      12,12   8,8  9,9   }
    elseif (%l == 12) { msg =$nick 3,3  5,5  8,8     0,4<>8,8            4,4  9,9  3,3   9,9        4,4  8,8       4,4    10,10      12,12   8,8  9,9   }
    elseif (%l == 13) { msg =$nick 3,3  0,5<>8,8     4,4  8,8            4,4  9,9  3,3   9,9        4,4  8,8       4,4    10,10      12,12   8,8  9,9   }
    elseif (%l == 14) { msg =$nick 3,3  5,5  8,8     4,4  8,8            4,4  9,9  3,3   9,9        0,4<>8,8       4,4    10,10      12,12   8,8  9,9   }
    elseif (%l == 15) { msg =$nick 3,3  5,5  8,8     4,4  8,8            4,4  9,9  3,3   9,9        4,4  8,8       0,4<>  10,10      12,12   8,8  9,9   }
    else { msg =$nick 3,3  5,5  8,8     4,4  8,8            4,4  9,9  3,3   9,9        4,4  8,8       4,4    10,10      12,12   8,8  9,9   }
    if (%l == 11) { msg =$nick 3,3  8,8  9,9           3,3      0,5<>8,8  9,9 3,3   9,9  12,12    9,9   8,8  9,9     12,12  10,10  12,12      10,10  12,12   4,4  9,9   }
    else { msg =$nick 3,3  8,8  9,9           3,3      5,5  8,8  9,9 3,3   9,9  12,12    9,9   8,8  9,9     12,12  10,10  12,12      10,10  12,12   4,4  9,9   }
    if (%l == 17) { msg =$nick 3,3  8,8  9,9           3,3        8,8  9,9      12,12    9,9   8,8  9,9   12,12    10,10  12,12      10,10     0,4<>9,9   }
    else { msg =$nick 3,3  8,8  9,9           3,3        8,8  9,9      12,12    9,9   8,8  9,9   12,12    10,10  12,12      10,10     4,4  9,9   }
    if (%l == 16) { msg =$nick 3,3  8,8  9,9           3,3        8,8  9,9  12,12        9,9   8,8  9,9  12,12   0,5<>10,10  12,12      10,10  12,12        }
    else { msg =$nick 3,3  8,8  9,9           3,3        8,8  9,9  12,12        9,9   8,8  9,9  12,12   5,5  10,10  12,12      10,10  12,12        }
    msg =$nick 3,3  8,8  9,9        3,3       9,9    8,8  9,9  12,12    9,9       8,8  9,9   12,12  10,10  12,12        10,10  12,12       
    if (%l == 18) { msg =$nick 3,3  8,8  3,3  9,9                 8,8  9,9  12,12    9,9       8,8  9,9   12,12  10,10  12,12    0,2  <>10,10  12,12        }
    else { msg =$nick 3,3  8,8  3,3  9,9                 8,8  9,9  12,12    9,9       8,8  9,9   12,12  10,10  12,12    2,2    10,10  12,12        }
    msg =$nick 3,3  4,4  3,3      9,9             8,8  9,9  12,12      9,9     8,8  9,9     8,8  9,9  12,12  2,2    10,10  12,12       
    if (%l == 5) { msg =$nick 3,3  0,4<>8,8      5,5  8,8    4,4  8,8     4,4    10,10      8,8              9,9  12,12  4,4  2,2  10,10  12,12        }
    elseif (%l == 22) { msg =$nick 3,3  4,4  8,8      0,5<>8,8    4,4  8,8     4,4    10,10      8,8              9,9  12,12  4,4  2,2  10,10  12,12        }
    elseif (%l == 9) { msg =$nick 3,3  4,4  8,8      5,5  8,8    0,4<>8,8     4,4    10,10      8,8              9,9  12,12  4,4  2,2  10,10  12,12        }
    elseif (%l == 8) { msg =$nick 3,3  4,4  8,8      5,5  8,8    4,4  8,8     0,4<>  10,10      8,8              9,9  12,12  4,4  2,2  10,10  12,12        }
    elseif (%l == 19) { msg =$nick 3,3  4,4  8,8      5,5  8,8    4,4  8,8     4,4    10,10      8,8              9,9  12,12  0,4<>2,2  10,10  12,12        }
    else { msg =$nick 3,3  4,4  8,8      5,5  8,8    4,4  8,8     4,4    10,10      8,8              9,9  12,12  4,4  2,2  10,10  12,12        }
    msg =$nick 3,3  8,8  3,3          9,9         8,8  9,9  12,12      9,9  3,3         9,9     12,12  2,2    10,10  12,12       
    msg =$nick 3,3  8,8  3,3        9,9           8,8  9,9  12,12      9,9  3,3         9,9     12,12      10,10  12,12       
    msg =$nick 3,3  8,8  3,3        9,9           8,8  9,9  12,12      9,9  3,3        9,9      12,12      10,10  12,12       
    msg =$nick 3,3  8,8  3,3        9,9    12,12  9,9     8,8  9,9  12,12      9,9              12,12        10,10  12,12       
    if (%l == 4) { msg =$nick 9,9  8,8  0,3  <>    9,9    12,12    9,9   8,8  9,9  12,12        9,9          12,12          10,10  12,12   9,9     }
    else { msg =$nick 9,9  8,8  3,3        9,9    12,12    9,9   8,8  9,9  12,12        9,9          12,12          10,10  12,12   9,9     }
    if (%l == 3) { msg =$nick 9,9  0,4<>  8,8      4,4  8,8  10,10    8,8     9,9  12,12                            10,10  12,12   4,4  9,9   }
    elseif (%l == 2) {  msg =$nick 9,9  4,4    8,8      0,4<>8,8  10,10    8,8     9,9  12,12                            10,10  12,12   4,4  9,9   }
    else { msg =$nick 9,9  4,4    8,8      4,4  8,8  10,10    8,8     9,9  12,12                            10,10  12,12   4,4  9,9   }
    if (%l == 21) { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   8,8  9,9  12,12                            10,10     0,4<>9,9   }
    else { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   8,8  9,9  12,12                            10,10     4,4  9,9   }
    if (%l == 23) { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   8,8  9,9  12,12              0,5<>12,12            10,10  12,12   9,9     }
    else { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   8,8  9,9  12,12              5,5  12,12            10,10  12,12   9,9     }
    if (%l == 7) { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   0,4<>10,10             4,4  10,10                 12,12        }
    elseif (%l == 20) { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   4,4  10,10             0,4<>10,10                 12,12        }
    else { msg =$nick 12,12  10,10  12,12  9,9      8,8  9,9  12,12    9,9   4,4  10,10             4,4  10,10                 12,12        }
    if (%l == 1) { msg =$nick 12,12  10,10  12,12  9,9      0,4<>9,9  12,12    9,9   4,4  12,12                                        }
    else { msg =$nick 12,12  10,10  12,12  9,9      4,4  9,9  12,12    9,9   4,4  12,12                                        }
    msg =$nick 12,12  10,10  12,12  9,9          12,12       10,10  12,12                                       
    msg =$nick 12,12  10,10  12,12  9,9        12,12         10,10  12,12                                       
    msg =$nick 12,12  10,10  12,12                   10,10  12,12                                       
    msg =$nick 12,12  10,10  12,12                   10,10  12,12                                       
    if (%l == 6) { msg =$nick 9,9  0,4<>10,10                     12,12                                        }
    else { msg =$nick 9,9  4,4  10,10                     12,12                                        }
    msg =$nick 9,9    12,12                                                            
    msg =$nick 12,12                                                                
  }
  elseif (%r == Kanto) {
    if (%l == Pallet Town) { var %l = 1 }
    elseif (%l == Viridian City) { var %l = 2 }
    elseif (%l == Pewter City) { var %l = 3 }
    elseif (%l == Mt Moon) { var %l = 4 }
    elseif (%l == Cerulean City) { var %l = 5 }
    elseif (%l == Vermilion City) { var %l = 6 }
    elseif (%l == Rock Tunnel) { var %l = 7 }
    elseif (%l == Lavender Town) { var %l = 8 }
    elseif (%l == Celadon City) { var %l = 9 }
    elseif (%l == Saffron City) { var %l = 10 }
    elseif (%l == Coral Bridge) { var %l = 11 }
    elseif (%l == Fuchsia City) { var %l = 12 }
    elseif (%l == Cycling Road) { var %l = 13 }
    elseif (%l == Seafoam Island) { var %l = 15 }
    elseif (%l == Cinnabar Island) { var %l = 16 }
    elseif (%l == Victory Road) { var %l = 17 }
    elseif (%l == Indigo Plateau) { var %l = 18 }
    elseif (%l == Unknown Dungeon) { var %l = 19 }
    elseif (%l == Mt Ember) { var %l = 20 }
    else { var %l = 0 }
    msg =$nick 03,03                                              12,12                  
    msg =$nick 03,03                                            09,09  12,12                  
    msg =$nick 03,03                                        09,09      12,12                  
    if ($dados($nick,Quests,UD)) {
      if (%l == 19) { msg =$nick 03,03                    09,09     03,03         09,09  03,03      00,05<>12,12    09,09           12,12      }
      else { msg =$nick 03,03                    09,09     03,03         09,09  03,03      05,05  12,12    09,09           12,12      }
    }
    else { msg =$nick 03,03                    09,09     03,03         09,09  03,03      09,09  12,12    09,09           12,12      }
    msg =$nick 03,03                 09,09           03,03    09,09      03,03   12,12     09,09  03,03         09,09    12,12   
    if (%l == 18) { msg =$nick 03,03  00,04<>03,03     09,09              05,05  08,08                  04,04    08,08          05,05  09,09  12,12    }
    elseif (%l == 4) { msg =$nick 03,03  04,04  03,03     09,09              00,05<>08,08                  04,04    08,08          05,05  09,09  12,12    }
    elseif (%l == 5) { msg =$nick 03,03  04,04  03,03     09,09              05,05  08,08                  00,04  <>08,08          05,05  09,09  12,12    }
    elseif (%l == 7) { msg =$nick 03,03  04,04  03,03     09,09              05,05  08,08                  04,04    08,08          00,05<>09,09  12,12    }
    else { msg =$nick 03,03  04,04  03,03     09,09              05,05  08,08                  04,04    08,08          05,05  09,09  12,12    }
    msg =$nick 03,03  08,08  03,03     09,09              08,08  03,03                    08,08  09,09   03,03       08,08  09,09  12,12   
    if (%l == 3) { msg =$nick 03,03  08,08  03,03    00,04<>08,08               03,03                    08,08  09,09       03,03   08,08  09,09  12,12    }
    else { msg =$nick 03,03  08,08  03,03    04,04  08,08               03,03                    08,08  09,09       03,03   08,08  09,09  12,12    }
    msg =$nick 03,03  08,08  03,03    08,08  03,03  05,05  03,03                               08,08  09,09       03,03   08,08  09,09  12,12   
    if (%l == 17) { msg =$nick 03,03  00,05<>03,03    08,08  03,03                                   08,08  09,09          08,08  09,09  12,12    }
    else { msg =$nick 03,03  05,05  03,03    08,08  03,03                                   08,08  09,09          08,08  09,09  12,12    }
    msg =$nick 03,03  08,08  03,03    08,08  03,03         09,09            03,03              08,08  09,09          08,08  09,09  12,12   
    if (%l == 9) { msg =$nick 03,03  08,08  03,03    08,08  03,03    09,09          08,08  00,04  <>08,08             04,04    08,08          04,04  09,09  12,12    }
    elseif (%l == 10) { msg =$nick 03,03  08,08  03,03    08,08  03,03    09,09          08,08  04,04    08,08             00,04  <>08,08          04,04  09,09  12,12    }
    elseif (%l == 8) { msg =$nick 03,03  08,08  03,03    08,08  03,03    09,09          08,08  04,04    08,08             04,04    08,08          00,04<>09,09  12,12    }
    else { msg =$nick 03,03  08,08  03,03    08,08  03,03    09,09          08,08  04,04    08,08             04,04    08,08          04,04  09,09  12,12    }
    msg =$nick 03,03  08,08  03,03    08,08  09,09              08,08  09,09                   08,08  09,09 03,03         08,08  09,09  12,12   
    msg =$nick 03,03  08,08  03,03    08,08  09,09        12,12      08,08  12,12                 09,09  08,08  09,09   03,03       08,08  09,09 12,12    
    if (%l == 2) { msg =$nick 03,03  08,08      00,04<>09,09      12,12        08,08  12,12                 09,09  08,08  09,09        03,03  08,08  12,12      }
    else { msg =$nick 03,03  08,08      04,04  09,09      12,12        08,08  12,12                 09,09  08,08  09,09        03,03  08,08  12,12      }
    msg =$nick 03,03     09,09   08,08  09,09    12,12          08,08  12,12                   08,08  09,09          08,08  12,12     
    if (%l == 13) { msg =$nick 09,09        08,08  09,09    12,12          01,08<>12,12                   04,04  09,09  05,05  09,09    12,12  08,08  12,12      }
    else { msg =$nick 09,09        08,08  09,09    12,12          08,08  12,12                   04,04  09,09  05,05  09,09    12,12  08,08  12,12      }
    if (%l == 6) { msg =$nick 09,09        08,08  09,09    12,12          08,08  12,12                   00,04<>08,08            12,12      }
    elseif (%l == 11) { msg =$nick 09,09        08,08  09,09    12,12          08,08  12,12                   04,04  01,08          <>12,12      }
    else { msg =$nick 09,09        08,08  09,09    12,12          08,08  12,12                   04,04  08,08            12,12      }
    msg =$nick 12,12   09,09     08,08  09,09    12,12          08,08  12,12                   09,09        12,12    08,08  12,12     
    if (%l == 1) { msg =$nick 12,12     09,09   00,04<>09,09    12,12          08,08  12,12               09,09      03,03  09,09   12,12     08,08  12,12      }
    else { msg =$nick 12,12     09,09   04,04  09,09    12,12          08,08  12,12               09,09      03,03  09,09   12,12     08,08  12,12      }
    msg =$nick 12,12        10,10  12,12              08,08  12,12            09,09    03,03         09,09    12,12  08,08  12,12     
    if (%l == 12) { msg =$nick 12,12        10,10  12,12              08,08                00,04<>08,08                 12,12      }
    else { msg =$nick 12,12        10,10  12,12              08,08                04,04  08,08                 12,12      }
    msg =$nick 12,12        10,10  12,12                            09,09  08,08  09,09               12,12       
    msg =$nick 12,12        10,10  12,12                              10,10  12,12                      
    msg =$nick 12,12        10,10  12,12                              10,10  12,12                      
    if (%l == 16) { msg =$nick 12,12        00,04<>10,10                   05,05  10,10           12,12                       }
    elseif (%l == 15) { msg =$nick 12,12        04,04  10,10                   00,05<>10,10           12,12                       }
    else { msg =$nick 12,12        04,04  10,10                   05,05  10,10           12,12                       }
    msg =$nick 12,12                                                                
    if ($findtok($dados($nick,%r,Visited),Mt Ember,0,58)) {
      if (%l == 20) { msg =$nick 12,12                09,09  00,05<>09,09 12,12                                            }
      else { msg =$nick 12,12                09,09  05,05  09,09 12,12                                            }
      msg =$nick 12,12                                                                
    }
  }
  else {
    if (%l == New Bark Town) { var %l = 1 }
    elseif (%l == Cherrygrove City) { var %l = 2 }
    elseif (%l == Violet City) { var %l = 3 }
    elseif (%l == Azalea Town) { var %l = 4 }
    elseif (%l == Ilex Florest) { var %l = 5 }
    elseif (%l == Goldenrod City) { var %l = 6 }
    elseif (%l == Ecruteak City) { var %l = 7 }
    elseif (%l == Olivine City) { var %l = 8 }
    elseif (%l == Cianwood City) { var %l = 9 }
    elseif (%l == Whirl Island) { var %l = 10 }
    elseif (%l == Mt Mortar) { var %l = 11 }
    elseif (%l == Mahogany Town) { var %l = 12 }
    elseif (%l == Lake Of Rage) { var %l = 13 }
    elseif (%l == Ice Path) { var %l = 14 }
    elseif (%l == Blackthorn City) { var %l = 15 }
    elseif (%l == Victory Road) { var %l = 16 }
    elseif (%l == Mt Silver) { var %l = 17 }
    elseif (%l == Water Path) { var %l = 18 }
    elseif (%l == White City) { var %l = 19 }
    elseif (%l == Dark Cave) { var %l = 20 }
    elseif (%l == Peak Town) { var %l = 21 }
    elseif (%l == Sunrise City) { var %l = 22 }
    elseif (%l == Fog Cave) { var %l = 23 }
    elseif (%l == Silverst City) { var %l = 24 }
    else { var %l = 0 }
    if (%l < 19) {
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                       03,03   12,12                      
      msg =$nick 12,12                                09,09  03,03            09,09  12,12                
      msg =$nick 12,12                               09,09  03,03    12,12       03,03   09,09  12,12               
      msg =$nick 12,12                               09,09  03,03    12,12       03,03    09,09  12,12              
      if (%l == 13) { msg =$nick 12,12                                09,09   03,03     01,08<>03,03      09,09   12,12              }
      else { msg =$nick 12,12                                09,09   03,03     08,08  03,03      09,09   12,12              }
      msg =$nick 12,12                                  09,09      08,08  03,03         09,09  12,12           
      msg =$nick 12,12      09,09                      12,12      09,09      08,08  09,09    03,03      09,09 12,12           
      if (%l == 11) {
        if ($dados($nick,Info,Path) == 1) { msg =$nick 12,12      09,09 03,03   09,09                  00,05<>12,12    05,05  09,09    08,08  09,09   03,03      09,09  12,12            }
        else { msg =$nick 12,12      09,09 03,03   09,09                  05,05  12,12    00,05<>09,09    08,08  09,09   03,03      09,09  12,12            }
      }
      else { msg =$nick 12,12      09,09 03,03   09,09                  05,05  12,12    05,05  09,09    08,08  09,09   03,03      09,09  12,12            }
      msg =$nick 12,12     03,03        09,09               08,08  12,12    08,08  09,09    08,08  09,09   03,03    09,09   12,12            
      if (%l == 7) { msg =$nick 12,12    03,03     08,08             00,04  <>08,08    10,10    08,08    04,04    08,08      05,05  09,09  12,12             }
      elseif (%l == 12) { msg =$nick 12,12    03,03     08,08             04,04    08,08    10,10    08,08    00,04  <>08,08      05,05  09,09  12,12             }
      elseif (%l == 14) { msg =$nick 12,12    03,03     08,08             04,04    08,08    10,10    08,08    04,04    08,08      00,05<>09,09  12,12             }
      else { msg =$nick 12,12    03,03     08,08             04,04    08,08    10,10    08,08    04,04    08,08      05,05  09,09  12,12             }
      msg =$nick 12,12   09,09  03,03    08,08  03,03         09,09    08,08  09,09    12,12    09,09     03,03       09,09  08,08  09,09  12,12          09,09  
      msg =$nick 12,12   09,09      08,08  09,09   03,03  09,09        08,08  09,09    12,12    09,09     03,03        09,09 08,08  12,12          09,09    
      if (%l == 15) { msg =$nick 12,12    09,09     08,08  09,09             08,08  09,09    12,12    09,09     03,03         00,04<>12,12        05,05  08,08     }
      elseif (%l == 17) { msg =$nick 12,12    09,09     08,08  09,09             08,08  09,09    12,12    09,09     03,03         04,04  12,12        00,05<>08,08     }
      else { msg =$nick 12,12    09,09     08,08  09,09             08,08  09,09    12,12    09,09     03,03         04,04  12,12        05,05  08,08     }
      msg =$nick 12,12      09,09   08,08  09,09             08,08  09,09      12,12   09,09  03,03           08,08  12,12        09,09      
      if (%l == 8) { msg =$nick 12,12       09,09  00,04<>  09,09      03,03     08,08  09,09       12,12  03,03      09,09     03,03  08,08  12,12               }
      else { msg =$nick 12,12       09,09  04,04    09,09      03,03     08,08  09,09       12,12  03,03      09,09     03,03  08,08  12,12               }
      msg =$nick 12,12         10,10  12,12   09,09   03,03       08,08  03,03   09,09    03,03     09,09       08,08     12,12              
      if (%l == 3) { msg =$nick 12,12         10,10  12,12     09,09 03,03   08,08              00,04  <>08,08   09,09    08,08  09,09   12,12               }
      else { msg =$nick 12,12         10,10  12,12     09,09 03,03   08,08              04,04    08,08   09,09    08,08  09,09   12,12               }
      msg =$nick 12,12  10,10         12,12     09,09  03,03  08,08  09,09     03,03   08,08  03,03     09,09  08,08  09,09    08,08  09,09   12,12              
      if (%l == 9) { msg =$nick 09,09  00,04<>12,12               09,09 04,04  09,09  03,03      08,08  03,03     09,09  08,08  09,09 03,03   08,08  09,09   12,12               }
      elseif (%l == 6) { msg =$nick 09,09  04,04  12,12               09,09 00,04<>09,09  03,03      08,08  03,03     09,09  08,08  09,09 03,03   08,08  09,09   12,12               }
      else { msg =$nick 09,09  04,04  12,12               09,09 04,04  09,09  03,03      08,08  03,03     09,09  08,08  09,09 03,03   08,08  09,09   12,12               }
      msg =$nick 09,09    12,12       02,02  12,12      09,09 04,04  09,09  03,03      08,08  03,03      09,09 08,08  03,03    08,08  09,09   12,12              
      msg =$nick 12,12     02,02  12,12  02,02    12,12       08,08  09,09  03,03      08,08  12,12   09,09 03,03   08,08  03,03    08,08  09,09   12,12              
      msg =$nick 12,12  02,02          12,12        08,08  03,03        08,08  12,12   09,09    08,08  09,09 03,03   08,08  09,09   12,12              
      msg =$nick 12,12  02,02          12,12      03,03  08,08  03,03        08,08  12,12    09,09   08,08  09,09 03,03   08,08  03,03   12,12              
      if (%l == 18) { msg =$nick 12,12  00,02    <>    12,12    03,03    08,08  03,03        08,08  12,12    09,09   08,08  09,09    08,08  09,09 03,03    12,12        09,09     }
      else { msg =$nick 12,12  02,02          12,12    03,03    08,08  03,03        08,08  12,12    09,09   08,08  09,09    08,08  09,09 03,03    12,12        09,09     }
      if (%l == 1) { msg =$nick 12,12   02,02       12,12      09,09  03,03  08,08  03,03      09,09  08,08  12,12    09,09   08,08  04,04  08,08           00,04<>10,10    05,05  08,08   }
      elseif (%l == 2) { msg =$nick 12,12   02,02       12,12      09,09  03,03  08,08  03,03      09,09  08,08  12,12    09,09   08,08  00,04<>08,08           04,04  10,10    05,05  08,08   }
      elseif (%l == 16) { msg =$nick 12,12   02,02       12,12      09,09  03,03  08,08  03,03      09,09  08,08  12,12    09,09   08,08  04,04  08,08           04,04  10,10    00,05<>08,08   }
      else { msg =$nick 12,12   02,02       12,12      09,09  03,03  08,08  03,03      09,09  08,08  12,12    09,09   08,08  04,04  08,08           04,04  10,10    05,05  08,08   }
      if (%l == 4) { msg =$nick 12,12     02,02    09,09    12,12     03,03  08,08       00,04<>08,08   12,12     09,09                   12,12    09,09     }
      else { msg =$nick 12,12     02,02    09,09    12,12     03,03  08,08       04,04  08,08   12,12     09,09                   12,12    09,09     }
      if (%l == 10) { msg =$nick 12,12      02,02   09,09  00,05<>12,12     03,03       09,09     12,12                                   }
      else { msg =$nick 12,12      02,02   09,09  05,05  12,12     03,03       09,09     12,12                                   }
      msg =$nick 12,12       02,02   12,12           03,03  09,09     12,12                                    
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
    }
    else {
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                              09,09     12,12                             
      if (%l == 23) && ($dados($nick,Info,Path) == 1) { msg =$nick 12,12                              00,05<>08,08     12,12                            }
      else { msg =$nick 12,12                              05,05  08,08     12,12                            }
      msg =$nick 12,12                              09,09     08,08  09,09  12,12                         
      if (%l == 22) { msg =$nick 12,12                                 09,09  00,04<>09,09  12,12                          }
      else { msg =$nick 12,12                                 09,09  04,04  09,09  12,12                          }
      msg =$nick 12,12                                   10,10  12,12                           
      msg =$nick 12,12                                   10,10  12,12                           
      msg =$nick 12,12                                   10,10  12,12                           
      msg =$nick 09,09    12,12    09,09     12,12                      10,10  12,12                03,03    12,12       
      if (%l == 23) && ($dados($nick,Info,Path) == 2) { msg =$nick 09,09    04,04  08,08         00,05<>12,12                  10,10  12,12              03,03      12,12        }
      else { msg =$nick 09,09    04,04  08,08         05,05  12,12                  10,10  12,12              03,03      12,12        }
      if (%l == 24) { msg =$nick 08,08    00,04<>09,09           12,12                  10,10  12,12              09,09  03,03    12,12        }
      else { msg =$nick 08,08    04,04  09,09           12,12                  10,10  12,12              09,09  03,03    12,12        }
      if (%l == 21) { msg =$nick 09,09        12,12                           10,10                00,04<>09,09  03,03    12,12      }
      else { msg =$nick 09,09        12,12                           10,10                04,04  09,09  03,03    12,12      }
      msg =$nick 12,12                                                   10,10  12,12           
      msg =$nick 12,12                                                   10,10  12,12           
      msg =$nick 12,12                                                   10,10  12,12           
      msg =$nick 12,12                                                   10,10  12,12           
      msg =$nick 12,12                                                   10,10  12,12           
      if (%l == 20) && ($dados($nick,Info,Path) == 2) { msg =$nick 12,12                      09,09      12,12                     09,09  00,05<>12,12            }
      else { msg =$nick 12,12                      09,09      12,12                     09,09  05,05  12,12            }
      if (%l == 20) && ($dados($nick,Info,Path) == 1) { msg =$nick 12,12                      00,05<>09,09  12,12                       09,09    12,12            }
      else { msg =$nick 12,12                      05,05  09,09  12,12                       09,09    12,12            }
      msg =$nick 12,12                      10,10  12,12                           09,09  12,12           
      msg =$nick 12,12                      10,10  12,12                                        
      if (%l == 19) { msg =$nick 09,09      00,04<>10,10                12,12                                         }
      else { msg =$nick 09,09      04,04  10,10                12,12                                         }
      msg =$nick 08,08      04,04  12,12                                                        
      msg =$nick 09,09    12,12                                                            
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
      msg =$nick 12,12                                                                
    }
  }
  msg =$nick $ct $+ $str(¯,64)
  msg =$nick $ct $+ Legenda:
  msg =$nick $chr(160) 12,12  $ct água 9,9  $ct vegetação 3,3  $ct densa floresta 2,2  $ct água profunda 4,4  $ct cidade
  msg =$nick $chr(160) $chr(160) $chr(160) 5,5  $ct montanha 8,8  $ct rota terrestre 10,10  $ct rota marítima $cc $+ <> $ct $+ sua posição
}
alias addexp {
  var %nick = $dados($1,Info,Nick), %poke = $2, %level = $dados(%nick,%poke,Level), %learn = $rini(cadastros,%nick,%poke,Learn), %exp = $3, %etype = $basestat(%poke,etype), %mexp = $exp(%etype,100)
  var %aexp = $dados(%nick,%poke,Exp)
  while (%exp) {
    var %next = $exp(%etype,$calc(%level + 1)), %texp = $calc(%aexp + %exp)
    if (%level == 100) { var %aexp = %next, %exp = 0 }
    else {
      if (%texp >= %next) {
        var %exp = $calc(%texp - %next), %aexp = %next | inc %level
        var %m = $check.move(%poke,%level), %x = 1
        if (%m) { while ($gettok(%m,%x,58)) { var %move = $gettok(%m,%x,58) | if (!$findtok(%learn,%move,0,58)) { if ($learned(%nick,%poke,%move) == No!) { if ($rini(cadastros,%nick,%poke,Move4)) { if (%learn) { var %learn = %learn $+ : $+ %move } | else { var %learn = %move } } | else { addmove %nick %poke %move } } } | inc %x } }
      }
      else { var %aexp = %texp, %exp = 0 }
    }
  }
  if (%level > $dados(%nick,%poke,Level)) {
    wlog user %nick %poke grew from level $dados(%nick,%poke,Level) to $iif(%level > 100,100,%level) $+ !
    var %next = $exp(%etype,$calc(%level + 1))
    if (%level < 100) { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Exp %aexp | writeini pkp\cadastros\ $+ %nick $+ .ini %poke Next %next }
    else { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Exp %mexp | writeini pkp\cadastros\ $+ %nick $+ .ini %poke Next %mexp }
    if (%learn) { writeini pkp\cadastros\ $+ %nick $+ .ini %poke Learn %learn }
    var %l = $rini(cadastros,%nick,%poke,Loyalty), %r = $calc($gettok(%l,1,58) + $iif($gettok(%l,2,58),$gettok(%l,2,58),0) + $iif($dados(%nick,%poke,Hold) == Soothe Bell,5,3) * (%level - $dados(%nick,%poke,Level)))
    if (%r < 0) { var %r = 0 } | if (%r > 255) { var %r = 255 }
    writeini pkp\cadastros\ $+ %nick $+ .ini %poke Loyalty %r
    writeini pkp\cadastros\ $+ %nick $+ .ini %poke Level %level
    recalc %nick %poke
  }
  elseif ($dados(%nick,%poke,Level) < 100) {
    writeini pkp\cadastros\ $+ %nick $+ .ini %poke Exp %aexp
  }
}
alias exp {
  var %etype = $1, %n = $2 | if (%n > 100) { var %n = 100 } | elseif (!%n) { var %n = 1 }
  if (%etype == Erratic) {
    if (%n isnum 1-50) { return $int($calc(%n ^ 3 * (100 - %n) / 50)) }
    elseif (%n isnum 51-68) { return $int($calc(%n ^ 3 * (150 - %n) / 100)) }
    elseif (%n isnum 69-98) {
      var %r = $calc(%n % 3) | if (%r == 1) { var %r = 0.008 } | elseif (%r == 2) { var %r = 0.014 }
      return $int($calc((%n ^ 3 * (1.274 - 1 / 50 * (%n / 3) - %r))))
    }
    elseif (%n isnum 99-100) { return $int($calc(%n ^ 3 * (160 - %n) / 100)) }
  }
  elseif (%etype == Fast) { return $int($calc(0.8 * %n ^ 3)) }
  elseif (%etype == Med-Fast) { return $int($calc(%n ^ 3)) }
  elseif (%etype == Med-Slow) { return $int($calc(1.2 * %n ^ 3 - 15 * %n ^ 2 + 100 * %n - 140)) }
  elseif (%etype == Slow) { return $int($calc(1.25 * %n ^ 3)) }
  elseif (%etype == Fluctuating) {
    if (%n isnum 1-15) { return $int($calc(%n ^ 3 * (24 + ((%n + 1) / 3)) / 50)) }
    elseif (%n isnum 16-35) { return $int($calc(%n ^ 3 * (14 + %n) / 50)) }
    elseif (%n isnum 36-100) { return $int($calc(%n ^ 3 * (32 + (%n / 2)) / 50)) }
  }
}
alias move {
  if ($1) {
    var %move = $1, %n = $read(pkp\moveslist.txt,s,%move), %l = $readn
    var %move = $read(pkp\moveslist.txt,%l), %move = $remove(%move,%n)
    return $remchar(%move)
  }
}

alias place.events {
  var %d = $dados($nick,Info,Locate), %region = $dados($nick,Info,Region), %ld = $dados($nick,Info,LastLocate), %other = $someone($nick)
  if (%other) { msg =$nick $ct $+ Olha, há mais gente aqui: $separecom(%other,e,59,$cc,$ct) $+ $ct $+ ! }
  if (%d == Pacifidlog Town) { sset $+(Clock.,$nick) 10 | .timerClock $+ $nick 0 1 /clock $nick }
  if (%d == Violet City) {
    if ($dados($nick,Quests,Mazon)) && (!$item($nick,Alph Key).qnt) {
      msg =$nick $ct $+ Você sente uma mão apertando seu ombro neste momento.
      msg =$nick $chr(160) $cc $+ Mazon $ct $+ - Consegui! Achei uma maneira de entrar em $cc $+ Ruins of Alph $+ $ct $+ ! Após completar o quebra-cabeça com os quatro símbolos, esta chave apareceu subitamente.
      msg =$nick $ct $+ Parabéns! Você recebeu o item $cc $+ Alph Key $+ $ct $+ ! | item.add $nick Alph Key
    }
  }
  if (%d == Ruins Of Alph) {
    if (!$dados($nick,Quests,Rocket6)) {
      msg =$nick $chr(160) $cc $+ Bunch $ct $+ (ROCKET) - Ah, não creio no que estou vendo... $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Lamento não poder derrotá-lo agora, mas acabei de achar algo que colocará definitivamente nossa equipe no topo do mundo!
      msg =$nick $chr(160) $cc $+ Bunch $ct $+ (ROCKET) - Espero que tenha entendido que não há limites para nosso time, e se você realmente tem amor à vida não virá procurar mais encrenca conosco!
      var %x = $rand(1,2) | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Rocket6 %x
    }
  }
  if (%ld == Ruins Of Alph) {
    if ($dados($nick,Quests,Rocket6) > 2) && (!$dados($nick,Quests,Silver)) {
      writeini pkp\cadastros\ $+ $nick $+ .ini Quests Silver 1
      var %item = $iif($dados($nick,Quests,Rocket6) == 3,Silver,Rainbow) Feather, %oitem = $iif($dados($nick,Quests,Rocket6) == 3,Rainbow,Silver) Feather
      msg =$nick $chr(160) $cc $+ ??? $ct $+ - Ei! É com você mesmo!
      msg =$nick $chr(160) $cc $+ Silver $ct $+ - Olá, meu nome é $cc $+ Silver $+ $ct $+ . Ouvi falar que você possui um $cc $+ %item $+ $ct $+ ...
      if ($item($nick,%item).qnt) {
        msg =$nick $chr(160) $cc $+ Silver $ct $+ - Então se é verdade, achei a pessoa certa! Gostaria de propô-lo uma troca que envolverá riscos. Estou pretendendo apostar meu $cc $+ %oitem $ct $+ pelo seu $cc $+ %item $+ $ct $+ . Batalharemos numa partida de três contra três, apenas uma vez. E finalmente, se você perder, eu ficarei com seu $cc $+ %item $+ $ct $+ . Se você ganhar, ficará com meu $cc $+ %oitem $+ $ct $+ .
        msg =$nick $chr(160) $cc $+ Silver $ct $+ - Decida-se a respeito antes de me procurar. Preciso levar meus pokémon ao centro pokémon mais próximo!
      }
      else { msg =$nick $chr(160) $cc $+ Silver $ct $+ - Desculpe-me, provavelmente me enganei. }
    }
  }
  if (%d == Whirl Edge) {
    if ($item($nick,Silver Feather).qnt) {
      msg =$nick $ct $+ Há um pokémon provocando enorme turbilhão de água nesta região. Deseja usar o item $cc $+ Silver Feather $ct $+ agora?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar.
      set %confirm. [ $+ [ $nick ] ] FEA:Silver
    }
  }
  if (%d == Tin Tower) {
    if ($item($nick,Rainbow Feather).qnt) {
      msg =$nick $ct $+ Há um pokémon emanando luz intensa e radiante. Deseja usar o item $cc $+ Rainbow Feather $ct $+ agora?
      msg =$nick $ct $+ Digite ' $+ $cc $+ .Sim $+ $ct $+ ' para confirmar ou ' $+ $cc $+ .nao $+ $ct $+ ' para rejeitar.
      set %confirm. [ $+ [ $nick ] ] FEA:Rainbow
    }
  }
  if (%d == Whirl Island) {
    if ($dados($nick,Quests,Rocket6) == 1) { msg =$nick $ct $+ Há membros da equipe $cc $+ Rocket $ct $+ neste lugar! }
  }
  if (%d == Ecruteak City) {
    if ($dados($nick,Quests,Rocket6) == 2) { msg =$nick $ct $+ Há membros da equipe $cc $+ Rocket $ct $+ neste lugar! }
  }
  if ($start($nick)) {
    if (%d == Sky Pillar) && ($rini(cadastros,$nick,Quests,Wallace)) && (!$rini(cadastros,$nick,Quests,Sky)) {
      msg =$nick $ct $+ Você encontra-se com $cc $+ Wallace $+ $ct $+ .
      msg =$nick $chr(160) $cc $+ Wallace $ct $+ - $nick $+ ! Desculpe por deixá-lo pra trás na Cave of Origin. Eu abri a entrada do Sky Pillar. $nick $+ , agora siga seu caminho.
      msg =$nick $chr(160) $cc $+ Wallace $ct $+ - É um terremoto! Não há tempo para perder! Precisamos nos apressar. Droga, isto não é bom... o clima distorcido está afetando até aqui. $nick $+ , Rayquaza deve estar no topo desta torre. Estou preocupado com Sootopolis, vou deixar isto em suas mãos. Por favor, não falhe! | writeini pkp\cadastros\ $+ $nick $+ .ini Quests Sky Ok
    }
    if (%d == Sootopolis City) && ($rini(cadastros,$nick,Quests,Weather) == Ok) {
      msg =$nick $ct $+ Você pode ver dois pokémon lendários batalhando: $cc $+ Groudon $ct $+ e $cc $+ Kyogre $+ $ct $+ .
      if ($rini(cadastros,$nick,Quests,Sky2)) {
        msg =$nick $ct $+ Um pokémon aparece dos céus: $cc $+ Rayquaza $+ $ct $+ !
        msg =$nick $cc $+ Rayquaza $ct $+ acalmou os pokémon $cc $+ Groudon $ct $+ e $cc $+ Kyogre $+ $ct $+ ! $cc $+ Rayquaza $ct $+ saiu voando!
        msg =$nick $ct $+ Parabéns, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Agora o clima voltou ao normal! | remini pkp\cadastros\ $+ $nick $+ .ini Quests Weather
        msg =$nick $chr(160) $cc $+ Maxie $ct $+ - Então os pokémon lendários não eram apenas Groudon e Kyogre. Depois de tudo isso, uma simples ação daquele pokémon colocou tudo de volta a sua normalidade como se nada tivesse acontecido. Hahahahaha...
        msg =$nick $chr(160) $cc $+ Archie $ct $+ - Groudon e Kyogre fugiram, ninguém sabe para onde. O tempo em Hoenn voltou ao normal. Hahahaha... Talvez o que estávamos tentando fazer era algo pequeno, mesmo sem sentido, para o bem dos pokémon.
      }
    }
    elseif (%d == Seafloor Cavern) { if (!$rini(cadastros,$nick,Quests,Weather)) && (!$rini(cadastros,$nick,Quests,Sky2)) && ($rini(cadastros,$nick,Quests,Magma3)) { msg =$nick $ct $+ Você pode ver o submarino que a Equipe $cc $+ Aqua $ct $+ roubou! } }
    elseif (%d == Meteor Falls) && (!$rini(cadastros,$nick,Quests,Cozmo)) { msg =$nick $ct $+ Você pode ver alguns membros da equipe $cc $+ Magma $+ $ct $+ . }
    elseif (%d == Vermilion City) && (!$item($nick,Running Shoes).qnt) {
      msg =$nick $chr(160) $cc $+ ??? $ct $+ - Um momento! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , sou eu de novo, o assistente do $cc $+ Prof Oak $+ $ct $+ . O mesmo me pediu para entregar-lhe estes sapatos, vai fazer você andar mais rápido!
      item.add $nick Running Shoes | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ Running Shoes $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - $cc $+ Running Shoes $ct $+ reduz o tempo de mudança de cidades com o ' $+ $cc $+ .cidade goto $+ $ct $+ '. Isso com certeza é agradável, não acha? Boa sorte!
    }
    elseif (%d == Cinnabar Island) && (!$item($nick,HM05).qnt) {
      msg =$nick $chr(160) $cc $+ ??? $ct $+ - Um momento! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ , sou eu de novo, o assistente do $cc $+ Prof Oak $+ $ct $+ . O mesmo me pediu para entregar-lhe este HM, contém a técnica $cc $+ Flash $+ $ct $+ .
      item.add $nick HM05 | msg =$nick $ct $+ Parabéns, você ganhou o item $cc $+ HM05 $+ $ct $+ ! | msg =$nick $chr(160) $cc $+ Oak's Aide $ct $+ - $cc $+ Flash $ct $+ iluminará lugares escuros, como cavernas. Ensine a técnica ao seu pokémon e procure por pokémon selvagens. Se antes não era possível encontrá-los, tente agora e veja o resultado. Boa sorte!
    }
    elseif (%d == Seafoam Island) && (!$item($nick,HM07).qnt) && ($dados($nick,Quests,League)) {
      msg =$nick $chr(160) $cc $+ Lorelei $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Desculpe aparecer de repente, mas notei que seus pokémon não conseguem subir cachoeiras ainda. Aceite este item e ensine-os a técnica $cc $+ Waterfall $+ $ct $+ . | item.add $nick HM07 | msg =$nick $ct $+ Parabéns, você recebeu o item $cc $+ HM07 $+ $ct $+ !
      if ($findtok($readini(pkp\status.ini,%region,Legendary),Articuno,0,58)) { msg =$nick $chr(160) $cc $+ Lorelei $ct $+ - Há um pokémon lendário vivendo acima da cachoeira, eu não consegui capturá-lo. Boa sorte... }
      msg =$nick $chr(160) $cc $+ Lorelei $ct $+ - Vou voltar agora ao $cc $+ Indigo Plateau $+ $ct $+ . Esperarei seu desafio.
    }
    elseif (%d == Victory Road) && (!$dados($nick,Quests,Gary3)) && (%region == Kanto) {
      msg =$nick $chr(160) $cc $+ Gary $ct $+ - Salve! Você não morre mais, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Estava aqui lembrando de quando éramos apenas vizinhos e você sempre perdia nas nossas competições...
      var %x = $calc($iif($dados($nick,Quests,Gary1) == Ok,1,0) + $iif($dados($nick,Quests,Gary2) == Ok,1,0))
      if (%x < 2) { msg =$nick $chr(160) $cc $+ Gary $ct $+ - Isso se reflete ainda hoje, não é mesmo? Hahahaha... Admita, eu sou o melhor! }
      else { msg =$nick $chr(160) $cc $+ Gary $ct $+ - Não se orgulhe só por ter ganho algumas batalhas contra mim, eu peguei leve desde o início! }
      msg =$nick $chr(160) $cc $+ Gary $ct $+ - Tudo bem, então vamos batalhar! Vou pegar "menos leve" com você desta vez!
      battle.npc $nick Expert_Gary | var %ID = $checknickid($nick).ID
      sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] GARY3 | return
    }
  }
  else {
    if (%d == Meteor Falls) {
      if ($dados($nick,Quests,Stone1)) && (!$dados($nick,Quests,Steven1)) {
        msg =$nick $chr(160) $cc $+ ??? $ct $+ - Um momento!
        msg =$nick $chr(160) $cc $+ Steven $ct $+ - Oi, espero não tê-lo assustado. Meu nome é $cc $+ Steven Stone $+ $ct $+ . Sim, isso mesmo, eu sou filho de $cc $+ Mr Stone $+ $ct $+ . Eu não estou mais disposto a conquistar insígneas como antigamente, meu fascínio sobre pedras raras é ainda maior que tentar me tornar um mestre pokémon. Mas uma batalha é uma batalha! Vejo que nós precisamos batalhar, verei finalmente do que você é capaz!
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Steven1 Ok | writeini pkp\cadastros\ $+ $nick $+ .ini Clock Steven $dados($nick,Info,Online) | battle.npc $nick Steven | return
      }
    }
    if (!$dados($nick,%region,Badges).n) {
      if (%region == Hoenn) && (!$dados($nick,Quests,May1)) {
        msg =$nick $chr(160) $cc $+ ??? $ct $+ - Ei!!
        msg =$nick $chr(160) $cc $+ May $ct $+ - Desculpe incomodar, ainda não nos conhecemos... Tuff... Estou exausta! Meu nome é May, sou sobrinha do $cc $+ Prof Birch $+ $ct $+ . Nunca ouviu falar dele? Tudo bem, você não é daqui mesmo, mas não deixe de visitá-lo em $cc $+ Littleroot Town $+ $ct $+ !
        msg =$nick $chr(160) $cc $+ May $ct $+ - Certamente eu vim porque preciso batalhar com você. $iif($dados($nick,Quests,League),Preciso batalhar com o campeão da liga de $cc $+ $dados($nick,Info,Start) $+ $ct $+ !,Preciso testar minhas habilidades agora mesmo!)
        battle.npc $nick 1300 | var %ID = $checknickid($nick).ID
        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] REG:May1 | return
      }
    }
    if ($dados($nick,%region,Badges).n >= 4) {
      if (%region == Hoenn) && (!$dados($nick,Quests,May2)) {
        msg =$nick $chr(160) $cc $+ May $ct $+ - Hahaha, olha só quem está aqui! $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Não acredito, já conseguiu quatro insígneas? Hahaha, que interessante! Sinto que precisamos batalhar! Vamos!
        battle.npc $nick 1301 | var %ID = $checknickid($nick).ID
        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] REG:May2 | return
      }
      if (%region == Kanto) && (!$dados($nick,Quests,Brendan2)) {
        msg =$nick $chr(160) $cc $+ Brendan $ct $+ - Olá, $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Lembra-se de mim? Também estou ganhando insígneas aqui em $cc $+ %region $+ $ct $+ ! Você já tem quatro é? Incrível! Que tal uma batalha?
        battle.npc $nick 1303 | var %ID = $checknickid($nick).ID
        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] REG:Brendan2 | return
      }
    }
    if ($dados($nick,%region,Badges).n == 8) {
      if (%region == Hoenn) && (!$dados($nick,Quests,May3)) {
        msg =$nick $chr(160) $cc $+ May $ct $+ - Quase não consigo alcançá-lo... Como é? Todas as insígneas? É impossível! Digo, estou surpresa! Está indo para a liga pokémon, imagino... Precisamos... Precisamos batalhar! Uma última batalha, não posso perdê-la! Vamos!
        battle.npc $nick 1302 | var %ID = $checknickid($nick).ID
        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] REG:May3 | return
      }
      if (%region == Kanto) && (!$dados($nick,Quests,Brendan3)) {
        msg =$nick $chr(160) $cc $+ Brendan $ct $+ - $cc $+ $dados($nick,Info,Nick) $+ $ct $+ ! Veja, já estou pronto para a liga pokémon! E você? Nossa, você também tem oito insígneas! Ok, nossa última batalha... Vamos!
        battle.npc $nick 1304 | var %ID = $checknickid($nick).ID
        sset [ [ B. ] $+ [ %ID ] $+ [ .Quest ] ] REG:Brendan3 | return
      }
    }
  }
  if (%d == Meteor Falls) {
    var %c = $unown.code($nick), %cnt = 4
    if ($count(%c,*) < 6) && (!$dados($nick,Quests,Star)) {
      if (S isin %c) { .msg =$nick $cc $+ Unown $+ $ct $+ ! Este ' $+ $cc $+ S $+ $ct $+ ' está mesmo agitado! | dec %cnt }
      if (T isin %c) { .msg =$nick $cc $+ Unown $+ $ct $+ ! Este ' $+ $cc $+ T $+ $ct $+ ' está mesmo agitado! | dec %cnt }
      if (A isin %c) { .msg =$nick $cc $+ Unown $+ $ct $+ ! Este ' $+ $cc $+ A $+ $ct $+ ' está mesmo agitado! | dec %cnt }
      if (R isin %c) { .msg =$nick $cc $+ Unown $+ $ct $+ ! Este ' $+ $cc $+ R $+ $ct $+ ' está mesmo agitado! | dec %cnt }
      if (!%cnt) {
        item.add $nick Star Sign
        writeini pkp\cadastros\ $+ $nick $+ .ini Quests Star Ok
        msg =$nick $ct $+ Parabéns! Você encontrou o item $cc $+ Star Sign $+ $ct $+ !
      }
    }
  }
}
alias clock {
  var %n = $1, %x = $v($+(Clock.,%n)), %p = $2
  if (%x) {
    var %s = $timer(Clock $+ %n).delay, %x = $calc(%x $iif(%p,%p,-) %s)
    if (%x < 1) { uset $+(Clock.,%n) | .timerClock $+ %n off }
    else { sset $+(Clock.,%n) %x }
  }
  else { .timerClock $+ %n off }
}

alias getteam² {
  tokenize 59 $1-
  var %hidden = $hp($16,$17,$18,$19,$20,$21)
  var %x = $else.null($move($35)) $+ : $+ $else.null($move($36)) $+ : $+ $else.null($move($37)) $+ : $+ $else.null($move($38)) $+ :0:0:0:0
  return $1 $+ : $+ $3 $+ : $+ $4 $+ : $+ $5 $+ : $+ $7 $+ : $+ $8 $+ : $+ $gettok($13,1,58) $+ : $+ $14 $+ : $+ $28 $+ : $+ $29 $+ : $+ $30 $+ : $+ $31 $+ : $+ $32 $+ : $+ $33 $+ : $+ $28 $+ :0: $+ %x $+ : $+ %hidden

  ; Pokémon:Level:Nature:Sex:Shiny:Trait:Loyalty:Hold:HP:ATK:DEF:SPD:SATK:SDEF:HPAtual:Status:Move1:Move2:Move3:Move4:PP1:PP2:PP3:PP4:HiddenPower
}
alias getevolves {
  var %pk = $1, %chr = 58
  var %t = $readini(d:\architect\pkpadv\pkp\evolve.ini,Evolve,%pk), %x = 0, %y = $gettok(%t,0,59)
  while (%x < %y) {
    inc %x | var %z = $gettok(%t,%x,59)
    if (%r) { var %r = %r $+ $chr(%chr) $+ $gettok(%z,1,58) } | else { var %r = $gettok(%z,1,58) }
  }
  if (%r) { return %r } | else { return $false }
}
alias getmaxevolves {
  var %pk = $1, %chr = 58, %e = $getevolves(%pk), %except = $2
  if (%except) { if (%e) { var %z = 1 | while ($gettok(%e,%z,%chr)) { if ($findtok(%except,$gettok(%e,%z,%chr),0,%chr)) { var %e = $remtok(%e,$gettok(%e,%z,%chr),1,%chr) } | else { inc %z } } } }
  :loop
  var %x = 0, %y = $gettok(%e,0,%chr)
  while (%x < %y) {
    inc %x | var %n = $gettok(%e,%x,%chr), %te = $getevolves(%n)
    if (%te) { var %g = 1 | if (%r) { var %r = %r $+ $chr(%chr) $+ %te } | else { var %r = %te } }
  }
  if (%g) {
    if (%except) { var %z = 1 | while ($gettok(%r,%z,%chr)) { if ($findtok(%except,$gettok(%r,%z,%chr),0,%chr)) { var %r = $remtok(%r,$gettok(%r,%z,%chr),1,%chr) } | else { inc %z } } }
    var %e = %r, %g = 0, %r = 0 | goto loop
  }
  else { return $iif(%e,%e,$false) }
}
alias box.search {
  var %nick = $1, %pk = $2

  var %x = 1 | while ($isfile(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini)) {
    if ($count(%pk,*)) {
      var %y = 0, %y² = $ini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,0) | while (%y < %y²) {
        inc %y | var %n = $ini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%y)
        if ($wildtok(%n,%pk,0,58)) { if ($3 == r) { if (%r) { var %r = %r $+ : $+ %x } | else { var %r = %x } } | else { return $readini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%n) } }
      }
    }
    else { if ($readini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%pk)) { if ($3 == r) { if (%r) { var %r = %r $+ : $+ %x } | else { var %r = %x } } | else { return $readini(pkp\box\ $+ %nick $+ \ $+ %x $+ .ini,Box,%pk) } } }
    inc %x
  }
  if (%r) { return %r }
}
alias returnpokes² {
  var %x = 0, %y = $totalpokes($1), %r = 0
  while (%x < %y) {
    inc %x
    if (%r) {
      var %name = $rini(cadastros,$1,Team,%x)
      if (%name == Egg) { var %r = %r Egg(?)/?? }
      else { var %r = %r $rini(cadastros,$1,%name,Name) $+ ( $+ $iif($rini(cadastros,$1,%name,Sex) == Male,M,$iif($rini(cadastros,$1,%name,Sex) == Female,F,N/A)) $+ $iif($rini(cadastros,$1,%name,Shiny) == ON,+,$+) $+ )/ $+ $rini(cadastros,$1,%name,Level) }
    }
    else {
      var %name = $rini(cadastros,$1,Team,%x)
      if (%name == Egg) { var %r = Egg(?)/?? }
      else { var %r = $rini(cadastros,$1,%name,Name) $+ ( $+ $iif($rini(cadastros,$1,%name,Sex) == Male,M,$iif($rini(cadastros,$1,%name,Sex) == Female,F,N/A)) $+ $iif($rini(cadastros,$1,%name,Shiny) == ON,+,$+) $+ )/ $+ $rini(cadastros,$1,%name,Level) }
    }
  }
  return %r
}
alias wlog {
  if ($1 == user) {
    var %n = $dados($2,Info,Nick)
    var %file = pkp\log\users\ $+ $dateformat($date) $+ \ $+ %n $+ .txt
    if (!$exists($nofile(%file))) { .mkdir $nofile(%file) }
    write -il1 %file ( $+ $time(HH:nn) $+ ) $3-
    var %r = $read(%file,s,-), %r = $readn
    if (%r) { if (!$calc(%r % 21)) { var %a = 1 } }
    else { if (!$calc($lines(%file) % 20)) { var %a = 1 } }
    if (%a) {
      write -il1 %file -
      write -il1 %file $chr(160) Pontuação: $getmoney($pontuacao(%n)) Pontos
      write -il1 %file $chr(160) Localização: $rini(cadastros,%n,Info,Locate)
      write -il1 %file $chr(160) Milhagem: $dados(%n,Info,Milhagem) PokéMilhas
      write -il1 %file $chr(160) Online: $replace($gettok($duration($rini(cadastros,%n,Info,Online),2),1-2,32),wk,$chr(32) $+ semana,day,$chr(32) $+ dia,hr,$chr(32) $+ hora,min,$chr(32) $+ minuto,sec,$chr(32) $+ segundo)
      write -il1 %file $chr(160) PokéDex: $rini(cadastros,%n,Info,Pokedex) Pokémon
      var %y = $gettok($rini(cadastros,%n,Time,Market),2,59), %y = $iif(!%y,0,%y), %of = $rini(cadastros,%n,Info,StoreMarket) | if (%y == 3) { var %r = $calc($ctime($date $time) - $ctime($gettok($rini(cadastros,%n,Time,Market),1,59))) | if (%r >= 43200) && (%r < 3) { var %y = 0 } | elseif (%r < 172800) { var %y = %y } | else { var %y = 0 } }
      write -il1 %file $chr(160) Market: $iif(%of,%of,Nenhuma) oferta $+ $iif(%of > 1,s) $+ $iif(%y == 3,$+ $chr(44) novas ofertas em: $replace($duration($calc(172800 - %r),2),day,$chr(32) $+ dia $+ $chr(32),hr,$chr(32) $+ hora,min,$chr(32) $+ minuto,sec,$chr(32) $+ segundo))
      write -il1 %file $chr(160) Dinheiro: $chr(36) $+ $getmoney($rini(cadastros,%n,Info,Money))
      write -il1 %file $chr(160) Pokémon: $strip($returnpokes²(%n))
      write -il1 %file -
    }
  }
  else { write -il1 pkp\log\ $+ $1 $+ .txt $1- }
}
alias dateformat {
  var %d = $1
  return $gettok(%d,3,47) $+ $gettok(%d,2,47) $+ $gettok(%d,1,47)
}
alias battle.wild {
  var %n = $dados($1,Info,Nick), %pk = $dados(%n,$2,Name), %wild = $3, %lv = $4, %q = $iif($nick == %n,1,0), %locate = $dados(%n,Info,Locate), %region = $dados(%n,Info,Region)

  if (!%q) && (!$nick) { var %q = 1 }
  if (!%n) { return } | if (!$2) { return }
  if (!%pk) { if ($dados(%n,Team,1)) { var %pk = $dados(%n,Team,1) } | else { return } }
  if (%wild != $null) {
    if ($basestat(%wild,Name)) { if ($dados(%n,%wild,Name)) { var %wild } | else { var %wild = $basestat(%wild,name) } | if (%lv) { if (%lv isnum) { var %mode = $5- | if (%lv isnum 1-100) { var %lv = $int(%lv) } | else { return } } | else { var %lv, %mode = $4- } } }
    elseif (%wild isnum) { var %lv = %wild, %mode = $4-, %wild | if (%lv isnum 1-100) { var %lv = $int(%lv) } | else { return } }
    else { var %mode = $3-, %wild }
  }
  if (%mode) { var %par = $deltok(%mode,1,32), %mode = $gettok(%mode,1,32) }

  var %x = 0, %y = $len(%mode)
  while (%x < %y) {
    inc %x | var %temp = $mid(%mode,%x,1)
    if (q isin %temp) { var %query = 1 }
    if (z isin %temp) { var %locate = Safari Zone, %safari = 1 }
  }

  if (!$checkteam(%n,%pk)) { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) não tem o pokémon selecionado. | return }
  if ($totalpokes(%n) == 6) { msg =$nick $ct $+ Oops... $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) já tem seis pokémon no time. | return }
  if (%query) && (%confirm. [ $+ [ %n ] ]) { if ($gettok(%confirm. [ $+ [ %n ] ],1,58) != SFR) { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) já possui uma solicitação de confirmação neste momento. | return } }

  var %w = $replace(%locate,$chr(32),_), %rod = $dados(%n,Info,Rod)
  if ($dados(%n,Info,Path)) { var %w = %w $+ : $+ $dados(%n,Info,Path) }
  if (%confirm. [ $+ [ %n ] ]) { var %confirm = %confirm. [ $+ [ %n ] ] | unset %confirm. [ $+ [ %n ] ] }

  if ($checknickid(%n) == Ok!) {
    var %ID = $checknickid(%n).ID
    if ($v([ [ B. ] $+ [ %ID ] $+ [ .Player.2 ] ]) == Wild) && (!$v([ [ B. ] $+ [ %ID ] $+ [ .View ] ])) {
      var %last.pk = $v([ [ B. ] $+ [ %ID ] $+ [ .Poke.2 ] ]) | uset [ [ B. ] $+ [ %ID ] $+ [ .*2 ] ] | remini pkp\cadastros\ $+ %n $+ .ini %last.pk
    }
    elseif ($v([ [ B. ] $+ [ %ID ] $+ [ .Player.2 ] ])) { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) $ct $+ já está batalhando neste momento... | return }
  }

  if (!%wild) {
    if ($findtok(Moonlight Woods:Rock Tunnel:Heavy Den:Victory Road:Unknown Dungeon:Dark Cave,%locate,0,58)) {
      if ($team.hm(%n,Flash) == No!) { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) $ct $+ não conseguiu encontrar pokémon nesta escuridão... | return }
    }
    if (%locate == Sunrise City) && (!$dados(%n,Info,Rod)) && ($asctime(HH) != 5) { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) $ct $+ não conseguiu encontrar pokémon neste momento... | return }

    if ($dados(%n,Info,Rod)) { if (!$rini(wild,%region $+ _rod,Comum,%w)) { msg =$nick $ct $+ Não há pokémon selvagens disponíveis para a $cc $+ pesca $ct $+ nesta localidade. | return } }
    elseif (!$rini(wild,%region $+ _wild,Comum,%w)) { msg =$nick $ct $+ Não há pokémon selvagens na $cc $+ grama $ct $+ desta localidade. | return }
  }

  ; Applying wild's cost to user...

  if (%safari) { writeini pkp\cadastros\ $+ %n $+ .ini Time Safari $date $time }
  else {
    var %time = $dados(%n,Time,Wild), %r = $calc($ctime($date $time) - $ctime($gettok(%time,1,59))), %x = $gettok(%time,2,59) | if (%r >= 14400) { var %x = 0 }
    if ($dados(%n,Info,Premium)) { var %limit = 6 } | else { var %limit = 3 }
    if (%x < %limit) { writeini pkp\cadastros\ $+ %n $+ .ini Time Wild $iif(%x,$gettok(%time,1,59),$date $time) $+ ; $+ $calc(%x + 1) }
    else { writeini pkp\cadastros\ $+ %n $+ .ini Clock Wild $dados(%n,Info,Online) }
  }

  if (%safari) { if (!%confirm) { msg $+(=,%n) $ct $+ Bem vindo a $cc $+ Safari Zone $+ $ct $+ , em $cc $+ $dados(%n,Info,Locate) $+ $ct $+ ! Seu safari $cc $+ $iif(%rod,aquático,normal) $ct $+ foi iniciado. } }
  else { if (l !isin %mode) { msg =$nick $ct $+ Procurando por pokémon selvagem... } }

  var %luck = $rluck
  if ($dados(%n,Quests,Luck) == 3) { var %luck = Rarissimo | remini pkp\cadastros\ $+ %n $+ .ini Quests Luck }
  var %l = $rini(wild,%region $+ _wild,%luck,%w), %try = 0, %dt = 0
  if (%rod) {
    if ($rini(wild,%region $+ _rod,%luck,%w)) {
      if (%rod == Old Rod) { var %luck = Comum, %try = 55 }
      elseif (%rod == Good Rod) { var %luck = Incomum, %try = 28 }
      elseif (%rod == Super Rod) {
        if (%luck == Comum) { var %x = $rand(0,4), %luck = $iif(%x,Raro,Incomum) }
        elseif (%luck == Incomum) { var %x = $rand(0,1), %luck = $iif(%x,Raro,Comum) }
        elseif (%luck == Raro) { var %luck = Rarissimo }
      }
      var %l = $rini(wild,%region $+ _rod,%luck,%w)
    }
    else {
      remini pkp\cadastros\ $+ %n $+ .ini Info Rod
      msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) não pode usar $cc $+ %rod $ct $+ em $cc $+ %locate $+ $ct $+ .
      var %rod = 0
    }
  }
  elseif ($dados(%n,Info,Scope)) {
    remini pkp\cadastros\ $+ %n $+ .ini Info Scope
    if (%locate == Fortree City) { var %luck = Raro, %try = 60, %dt = 1 }
    elseif (%locate == Dewford City) { var %luck = Raro, %try = 60, %dt = 2 }
    elseif (%locate == Meteor Falls) && ($item(%n,Star Sign)) { msg =$nick $ct $+ O item $cc $+ Star Sign $ct $+ está mais radiante do que nunca! Nossa, ele desapareceu! | item.rem %n Star Sign | var %l = Jirachi 40 }
    else { msg =$nick $iif(%q,$ct $+ Você,$cc $+ %n $+ $ct) não conseguiu encontrar nenhum pokémon usando $cc $+ Devon Scope $+ $ct $+ . | return }
  }

  ; Legendary analysis...

  if ($start(%n)) { if ($dados(%n,Quests,League)) { var %league = 1 } } | elseif ($dados(%n,%region,League)) { var %league = 1 }
  if (%league) && (!%rod) && (!%safari) {
    if ($readini(pkp\status.ini,%region,Legendary)) {
      var %leg = $readini(pkp\status.ini,%region,Legendary)
      if (!$findtok(Underwater:Seafloor Cavern:Water Path:Safari Zone,%locate,0,58)) && (%leg) {
        if (%region == Johto) && ($dados(%n,Quests,BTower) == Ok) {
          var %luck.1 = $rluck, %luck.2 = $rluck
          if ((%luck.1 == %luck.2) && (%luck.1 == Incomum)) {
            if (!$appeared(Raikou)) && (!$appeared(Entei)) && (!$appeared(Suicune)) {
              if ($findtok(%leg,Raikou,0,58)) || ($findtok(%leg,Entei,0,58)) || ($findtok(%leg,Suicune,0,58)) { var %l }
              if ($findtok(%leg,Raikou,0,58)) { var %l = $addtok(%l,Raikou 40,58) }
              if ($findtok(%leg,Entei,0,58)) { var %l = $addtok(%l,Entei 40,58) }
              if ($findtok(%leg,Suicune,0,58)) { var %l = $addtok(%l,Suicune 40,58) }
            }
          }
        }
        elseif (%region == Hoenn) {
          if (%luck == Raro) {
            if (!$appeared(Latias)) && (!$appeared(Latios)) {
              if ($findtok(%leg,Latias,0,58)) { var %l = $addtok(%l,Latias 40,58) }
              if ($findtok(%leg,Latios,0,58)) { var %l = $addtok(%l,Latios 40,58) }
            }
          }
        }
      }
    }
  }
  if (%locate == Power Plant) && (!$dados(%n,Quests,PPlant)) { var %l = Slugma 20 30 }
  if (!%try) { var %try = 0 }

  ; Finally, searching the wild pokémon...

  while (!%wild) {
    if (%try >= 66) { if (%rod) { msg =$nick $ct $+ Nenhum pokémon foi fisgado usando $cc $+ %rod $+ $ct $+ ... } | else { msg =$nick $ct $+ Nenhum pokémon selvagem encontrado! } | return }
    if (%dt) { var %t = %dt } | else { var %t = $gettok(%l,0,58), %t = $rand(1,%t) }
    var %temp = $gettok(%l,%t,58), %tpk = $gettok(%temp,1,32)
    if ($dados(%n,%tpk,Name)) || (%last.pk == %tpk) { inc %try }
    else {
      var %wild = %tpk
      if (!%lv) || (%lv < 1) || (%lv > 100) {
        if ($gettok(%temp,3,32)) { var %lv = $rand($gettok(%temp,2,32),$gettok(%temp,3,32)) } | elseif ($gettok(%temp,2,32)) { var %lv = $gettok(%temp,2,32) }
      }
    }
  }
  if (!%lv) { if ($dados(%n,%pk,Level) > 3) { var %lv = $int($calc($dados(%n,%pk,Level) / 2)) } | else { var %lv = 5 } }
  .echo $addpoke(%n,%wild,%lv,%lv $+ : $+ %locate).wild
  if ($findtok(Cave Of Origin:Sunrise City,%locate,0,58)) { var %x = $rluck | if (%luck == Incomum) && (%x == Incomum) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Shiny ON } }
  if ($findtok(Latias:Latios,%wild,0,58)) { var %x = $rand(0,3) | if (!%x) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold Soul Dew } }
  if ($findtok(Chansey:Blissey,%wild,0,58)) { var %x = $rand(0,3) | if (!%x) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold Lucky Egg } }
  if (%wild == Miltank) { var %x = $rand(0,1) | if (!%x) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold $gettok(Soothe Bell:MooMoo Milk:MooMoo Milk,$rand(1,3),58) } }
  if (%locate == Ruins Of Alph) && (%luck == Comum) { var %x = $rluck | if (%x == Incomum) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold MT $+ $base($rand(1,30),10,10,2) } }
  if ($findtok(Lake Of Rage:Ilex Florest:Meteor Falls:Mt Moon:Heavy Den:Shoal Cave:Mt Silver,%locate,0,58)) { var %x = $rluck, %y = $rluck | if (%x == Raro) || (%y == Raro) || ((%x == %y) && (%x != Comum)) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold Rare Candy } }
  if ($dados(%n,Quests,Luck) isnum 1-2) { remini pkp\cadastros\ $+ %n $+ .ini Quests Luck | writeini pkp\cadastros\ $+ %n $+ .ini %wild Shiny ON }
  if (SHINY isin $unown.code(%n)) { if ($rluck == Raro) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Shiny ON } }

  if (!%ID) { b.create.fila %n %pk | var %ID = $checknickid(%n).id }

  var %gv = $database(%wild,GV)
  if ($findtok(Raikou:Entei:Suicune,%wild,0,58)) { sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] $rand(1,5) }

  while (%mode) {
    var %p = $left(%mode,1), %mode = $right(%mode,-1)
    if (%gv isnum 0-255) {
      if (%p == f) { if (%gv > 0) { writeini pkp\cadastros\ $+ %n $+ .ini %wild GV $rand(0,%gv) | writeini pkp\cadastros\ $+ %n $+ .ini %wild Sex Female } }
      if (%p == m) { if (%gv < 255) { writeini pkp\cadastros\ $+ %n $+ .ini %wild GV $rand($calc($iif(%gv,%gv,-1) + 1),255) | writeini pkp\cadastros\ $+ %n $+ .ini %wild Sex Male } }
    }
    if (%p == s) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Shiny ON }
    if (%p == u) {
      var %x = 1
      while ($nstat(%x)) {
        writeini pkp\cadastros\ $+ %n $+ .ini %wild IV $+ $nstat(%x) 31
        inc %x
      }
    }
    if (%p == h) { if ($item.data($gettok(%par,1,44),desc)) { writeini pkp\cadastros\ $+ %n $+ .ini %wild Hold $gettok(%par,1,44) } | var %par = $deltok(%par,1,44) }
    if (%p == b) { if ($gettok(%par,1,44) isnum 1-25) { sset [ [ B. ] $+ [ %ID ] $+ [ .Ball ] ] $gettok(%par,1,44) } | var %par = $deltok(%par,1,44) }
  }

  b.join %ID Wild %wild | sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ 1 ] $+ ] : ] $+ [ 2 ] ] $getteam(%n,%wild)
  wlog user %n %wild was found at $iif(%q,$+ wild.,wild created by $nick $+ .)

  sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON | sset [ [ B. ] $+ [ %ID ] $+ [ .Wild ] ] ON | if (%rod) { sset [ [ B. ] $+ [ %ID ] $+ [ .Rod ] ] ON }

  if (%query) {
    var %appear = $gettok(%confirm,2,58), %appear = $calc($iif(%appear,%appear,0) + 1), %limit = $iif($dados(%n,Info,Premium),4,2)
    msg $+(=,%n) $cc $+ %n $+ $ct $+ , um pokémon selvagem apareceu em seu safari: $cc $+ %wild $+ $ct $+ $iif($dados(%n,%wild,Shiny) == ON,4+ $+ $ct,$+) $+ ( $+ $iif($dados(%n,%wild,Sex) == Female,13F,$iif($dados(%n,%wild,Sex) == Male,12M,14N/A)) $+ $ct $+ )/ $+ $cc $+ %lv $+ $ct $+ . O que você deseja fazer? Digite $cc $+ .sim $ct $+ para aceitar a batalha ou $cc $+ .nao $ct $+ para $iif(%appear >= %limit,finalizar o seu safari.,procurar outro pokémon selvagem.)
    set %confirm. [ $+ [ %n ] ] SFR: $+ %appear
  }
  else { b.start.fight %ID }
}

alias usernick {
  var %n = $1, %new = $2
  if (!$exists(pkp\cadastros\ $+ %new $+ .ini)) {
    .rename pkp\cadastros\ $+ %n $+ .ini pkp\cadastros\ $+ %new $+ .ini
    writeini pkp\cadastros\ $+ %new $+ .ini Info Nick %new
    var %x = 1 | while (%x < 6) { var %pk = $dados(%new,Team,%x) | if ($dados(%new,%pk,ID) == %n) { writeini pkp\cadastros\ $+ %new $+ .ini %pk ID %new } | inc %x }
    if ($exists(pkp\box\ $+ %n $+ \)) {
      if (!$exists(pkp\box\ $+ %new $+ \)) {
        .mkdir pkp\box\ $+ %new $+ \
        while ($findfile(pkp\box\ $+ %n $+ \,*.ini,0)) {
          var %f1 = $findfile(pkp\box\ $+ %n $+ \,*.ini,1), %f2 = pkp\box\ $+ %new $+ \ $+ $nopath(%f1)
          .copy %f1 %f2 | .remove %f1
          var %x = 1 | while ($ini(%f2,Box,%x)) { var %t = $ini(%f2,Box,%x), %d = $readini(%f2,Box,%t) | if ($gettok(%d,2,59) == %n) { writeini %f2 Box %t $puttok(%d,%new,2,59) } | inc %x }
        }
      }
      .rmdir pkp\box\ $+ %n $+ \
    }
    var %y = 1 | while ($findfile(pkp\market\,*.ini,%y)) {
      var %m = $findfile(pkp\market\,*.ini,%y), %ID
      while ($findtok($readini(%m,Store,Nick),%n,0,58)) {
        var %r = $readini(%m,Store,Nick)
        if (%ID == $null) { var %ID = $gettok($readini(%m,Store,ID),$findtok(%r,%n,1,58),58) }
        else { var %ID = %ID $+ : $+ $gettok($readini(%m,Store,ID),$findtok(%r,%n,1,58),58) }
        writeini %m Store Nick $reptok(%r,%n,%new,1,58)
      }
      while ($gettok(%ID,1,58)) {
        var %t = $gettok(%ID,1,58), %ID = $deltok(%ID,1,58), %pk = $readini(%m,%t,Pokemon)
        if ($readini(%m,%t,Nick) == %n) { writeini %m %t Nick %new }
        if ($gettok(%pk,2,59) == %n) { writeini %m %t Pokemon $puttok(%pk,%new,2,59) }
      }
      inc %y
    }
    if ($top.pos(%n)) { top.rem %n | top.add %new }
  }
}
alias league.win {
  var %n = $1
  if ($dados(%n,Quests,League)) { var %r = $addtok(%r,$dados(%n,Info,Start),58) }
  if ($dados(%n,Kanto,League)) { var %r = $addtok(%r,Kanto,58) }
  if ($dados(%n,Hoenn,League)) { var %r = $addtok(%r,Hoenn,58) }
  if ($dados(%n,Johto,League)) { var %r = $addtok(%r,Johto,58) }
  return %r
}
alias dex.search {
  var %n = $1, %pk = $2, %reg = $league.win(%n)


  var %x = 1 | while ($gettok(%reg,%x,58)) {
    var %region = $gettok(%reg,%x,58), %f = PkP\Wild\ $+ %region $+ _ $+ $iif($prop == rod,rod,wild) $+ .ini
    var %l = Comum:Incomum:Raro:Rarissimo, %y = 1
    while ($gettok(%l,%y,58)) {
      var %rarety = $gettok(%l,%y,58), %z = 1
      while ($ini(%f,%rarety,%z)) {
        var %locate = $ini(%f,%rarety,%z), %found = $readini(%f,%rarety,%locate), %locate = $gettok(%locate,1,58)
        if ($wildtok(%found,%pk *,0,58)) {
          var %do = 1
          if ($findtok(%res. [ $+ [ %y ] ],$replace(%locate,_,$chr(160)),0,58)) { var %do = 0 }
          elseif ($gettok(%res. [ $+ [ %y ] ],0,58) == 5) {
            var %rnd = $rand(0,2)
            if (%rnd) { var %res. [ $+ [ %y ] ] $deltok(%res. [ $+ [ %y ] ],1,58) }
            else { var %do = 0 }
          }
          if (%do) { var %res. [ $+ [ %y ] ] $addtok(%res. [ $+ [ %y ] ],$replace(%locate,_,$chr(160)),58) }
        }

        inc %z
      }
      inc %y
    }
    inc %x
  }
  return $+($else.null(%res.1),;,$else.null(%res.2),;,$else.null(%res.3),;,$else.null(%res.4))

}

alias battle.thief {
  var %ID = $1, %win = $battle.side($2), %p, %x = 0
  if (!$2) { var %win = 0 }
  while (%x < 4) { inc %x | var %p = $addtok(%p,$battle.player(%ID,%x),58) }

  var %x = 1
  while ($gettok(%p,%x,58)) {
    var %n = $gettok(%p,%x,58), %tn = 0
    while (%tn < 6) {
      inc %tn
      var %team = $v([ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %tn ] $+ ] : ] $+ [ %n ] ])
      if (%team) {
        var %tpk = $gettok(%team,1,58), %thief = $v([ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ %n ] ])
        if (%thief) {
          if ($battle.side(%n) == %win) {
            if (!$npc($v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]))) { writeini pkp\cadastros\ $+ $v([ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %n ] ]) $+ .ini %tpk Hold $gettok(%thief,1,59) }
          }
          if (!$npc($gettok(%thief,2,59))) { writeini pkp\cadastros\ $+ $gettok(%thief,2,59) $+ .ini $gettok(%thief,3,59) Hold 0 }
          uset [ [ B. ] $+ [ %ID ] $+ [ .Thief [ $+ [ %tn ] $+ ] : ] $+ [ %n ] ]
        }
      }
    }
    inc %x
  }
}

alias bot.online {
  var %n = 0, %t = 0
  while (%n < $chat(0)) {
    inc %n
    if ($chat(%n).status == Active) {
      if (!$findtok(%accesslist,$chat(%n),0,58)) && (!$findtok(%cadlist,$chat(%n),0,58)) && (!$dados($chat(%n),Info,Hide)) { inc %t }
    }
  }
  return %t
}

alias someone {
  var %n = 0, %nick = $1, %locate = $+($dados(%nick,Info,Region),:,$dados(%nick,Info,Locate)), %res
  while (%n < $chat(0)) {
    inc %n
    if ($chat(%n).status == Active) && ($chat(%n) != %nick) {
      if (!$findtok(%accesslist,$chat(%n),0,58)) && (!$findtok(%cadlist,$chat(%n),0,58)) && (!$dados($chat(%n),Info,Hide)) {
        if ($+($dados($chat(%n),Info,Region),:,$dados($chat(%n),Info,Locate)) == %locate) { var %res = $addtok(%res,$chat(%n),59) }
      }
    }
  }
  if ($prop == n) { if (%res) { return $gettok(%res,0,59) } | else { return 0 } }
  else { return %res }
}

alias random.battle {
  var %nick = $1
  if ($checknick(%nick) == Ok!) {
    var %ID = $checknickid(%nick).id
    if (%ID != No!) {
      if (!$v([ [ B. ] $+ [ %ID ] $+ [ .Player.2 ] ])) {
        b.remove.fila %nick | uset [ [ B. ] $+ [ %ID ] $+ [ * ] ]
        var %random = $readini(pkp\region_battles.ini,$dados(%nick,Info,Region),$replace($dados(%nick,Info,Locate),$chr(32),_))
        if (%random) {
          var %n = $gettok(%random,0,58), %npc = $gettok(%random,$rand(1,%n),58)
          battle.npc %nick %npc
        }
      }
    }
  }
}

alias random.battle.time {
  var %res = $calc( ( ($bot.online * 2) - 1) * 10 + ( $int($calc($bot.online / 4)) * 30 ) )
  if (%res > 300) { var %res = 300 }
  elseif (%res == 0) { var %res = 10 }

  return %res
}

alias travel.ship {
  var %nick = $1, %s = $2
  if (%s == SS Anne) {
    if ($dados(%nick,Info,Region) == Kanto) { var %d = Hoenn }
    elseif ($dados(%nick,Info,Region) == Johto) { if ($start(%nick)) { var %d = Hoenn } | else { var %d = $iif($dados(%nick,Info,Start) == Kanto,Hoenn,Kanto) } }
    else { if ($dados(%nick,Info,Start) == Johto) { var %d = Johto } | else { var %d = Kanto } }
  }
  elseif (%s == SS Tidal) {
    if ($dados(%nick,Info,Region) == Kanto) { var %d = Johto }
    elseif ($dados(%nick,Info,Region) == Johto) { if ($start(%nick)) { var %d = Kanto } | else { var %d = $dados(%nick,Info,Start) } }
    else { var %d = Johto }
  }
  return %d
}

; Battle Rental Studios
; (40%) 1 (30%) 2 (20%) 3 (10%) 4 (0%) 5 [ Stage 1 ]
; (34%) 1 (32%) 2 (22%) 3 (11%) 4 (1%) 5 [ Stage 2 ]
; (21%) 1 (39%) 2 (26%) 3 (13%) 4 (1%) 5 [ Stage 3 ]
; (11%) 1 (44%) 2 (29%) 3 (15%) 4 (1%) 5 [ Stage 4 ]
; (---) 1 (50%) 2 (33%) 3 (16%) 4 (1%) 5 [ Stage 5 ]
; (---) 1 (41%) 2 (38%) 3 (19%) 4 (2%) 5 [ Stage 6 ]
; (---) 1 (31%) 2 (45%) 3 (22%) 4 (2%) 5 [ Stage 7 ]

alias rental.random {
  var %n = $1, %f = pkp\rental_tier.ini
  var %types, %result, %num, %x = 0
  while (%x < %n) {
    inc %x
    var %rand = $rand(0,217)
    if (%rand <= 54) { var %rare = 1 }
    elseif (%rand <= 130) { var %rare = 2 }
    elseif (%rand <= 163) { var %rare = 3 }
    elseif (%rand <= 202) { var %rare = 4 }
    else { var %rare = 5 }

    var %r = 0, %total = $ini(%f,%rare,0)
    while (!%r) {
      var %y = $rand(1,%total), %pk = $basestat($ini(%f,%rare,%y),name)
      if (%pk) {
        var %type = $gettok($basestat(%pk,type),1,32)
        if (!$findtok(%types,%type,0,32)) && (!$findtok(%result,%pk,0,32)) && (!$findtok(%num,$basestat(%pk,num),0,32)) { var %r = 1, %types = $iif(%types,%types %type,%type), %types = $iif(%num,%num $basestat(%pk,num),$basestat(%pk,num)) }
      }
    }
    var %result = $iif(%result,%result %pk,%pk)
  }
  return %result
}

alias rental.random2 {
  var %n = $1, %f = pkp\rental_tier.ini
  var %types, %result, %num, %x = 0
  while (%x < %n) {
    inc %x
    var %rand = $rand(0,100)
    if (%rand <= 5) { var %rare = 5 }
    elseif (%rand <= 20) { var %rare = 4 }
    elseif (%rand <= 45) { var %rare = 3 }
    elseif (%rand <= 80) { var %rare = 2 }
    else { var %rare = 1 }

    var %r = 0, %total = $ini(%f,%rare,0)
    while (!%r) {
      var %y = $rand(1,%total), %pk = $basestat($ini(%f,%rare,%y),name)
      if (%pk) {
        var %type = $gettok($basestat(%pk,type),1,32)
        if (!$findtok(%types,%type,0,32)) && (!$findtok(%result,%pk,0,32)) && (!$findtok(%num,$basestat(%pk,num),0,32)) { var %r = 1, %types = $iif(%types,%types %type,%type), %types = $iif(%num,%num $basestat(%pk,num),$basestat(%pk,num)) }
      }
    }
    var %result = $iif(%result,%result %pk,%pk)
  }
  return %result
}

alias b.rental.set.players {
  var %nick = $1, %x = 0, %v = $dados(%nick,Rental,Victory)
  while (%x < 7) { inc %x | writeini pkp\cadastros\ $+ %nick $+ .ini Rental %x $rental.random2(3,%v) }
}
alias rental.set.team {
  return $rental.random(6)
}
alias b.rental.fight {
  var %nick = $1
  unset %rental. [ $+ [ %nick ] ]

  b.create.fila %nick

  var %n = 1, %player = 1, %team = $dados(%nick,Rental,Team), %ID = $checknickid(%nick).ID
  while (%n <= 3) {
    sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %n ] $+ ] : ] $+ [ %Player ] ] $rental.pk($gettok(%team,%n,32))
    inc %n
  }

  var %n = 1, %player = 2, %team = $dados(%nick,Rental,$dados(%nick,Rental,Battle))

  if (!$calc( ($dados(%nick,Rental,Victory) + 1) % 7 )) && ($dados(%nick,Rental,Battle) == 7) {
    var %brain = $dados(%nick,Rental,Brain)
    if (%brain) && ($is_rental(%brain)) { sset [ [ B. ] $+ [ %ID ] $+ [ .TruePlayer:2 ] ] %brain | unset %rental. [ $+ [ %brain ] ] }

    var %brain = $gettok($readini(pkp\status.ini,Active,Brain),1,58) | if (%confirm. [ $+ [ %brain ] ] == $+(BRN,:,%nick)) { unset %confirm. [ $+ [ %brain ] ] | if ($checknick(%brain) == Ok!) { msg $+(=,%brain) $ct $+ Não é mais necessário sua confirmação. Seu adversário já começou a batalha. } }

    sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] Brain
    sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Player ] ] $brain.outfit()
    if ($gettok($readini(pkp\status.ini,Active,Brain),2,58)) { var %team = $gettok($readini(pkp\status.ini,Active,Brain),2,58) }
  }
  else {
    sset [ [ B. ] $+ [ %ID ] $+ [ .Player. ] $+ [ %Player ] ] Trainer
    sset [ [ B. ] $+ [ %ID ] $+ [ .Outfit: ] $+ [ %Player ] ] $rand(3,17)
  }

  while (%n <= 3) {
    sset [ [ B. ] $+ [ %ID ] $+ [ .Team [ $+ [ %n ] $+ ] : ] $+ [ %Player ] ] $rental.pk($gettok(%team,%n,32))
    inc %n
  }

  sset [ [ B. ] $+ [ %ID ] $+ [ .Match ] ] 3
  sset [ [ B. ] $+ [ %ID ] $+ [ .PP ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .PPUp ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .Switch ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:1 ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .NoEXP:2 ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .Rental ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .Auto ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .SLPClause ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .FRZClause ] ] ON
  sset [ [ B. ] $+ [ %ID ] $+ [ .Arena ] ] Estádio

  b.start.fight %ID
}

alias rental.pk {
  var %pk = $box.search(Corpse,$1)
  if (!%pk) { .echo 4 Pokémon $1 não foi encontrado no PC de Corpse. | var %pk = $box.search(Corpse,Ditto) }
  return $getteam²(%pk)
}

alias brain.outfit { return 94 }

alias view.dados.rental {
  var %p = $1, %c = $2
  if (!%p) { msg =$nick $ct $+ Você errou a sintaxe deste comando. Especifique o $cc $+ nick $ct $+ do usuário para a exibição de dados. | return }
  if (!$dados(%p,Info,Nick)) { msg =$nick $ct $+ Este usuário $cc $+ %p $ct $+ não está cadastrado no sistema. | return }
  if (%c) {
    if ($dados(%p,Rental,Battle) == 1) && (!$dados(%p,Rental,Team)) { var %team = %rental. [ $+ [ %p ] ] }
    else { var %team = $dados(%p,Rental,Team) }
    if (!$findtok(%team,%c,1,32)) { msg =$nick $iif(%a == 1,$ct $+ Você,$cc $+ $dados(%p,Info,Nick)) $iif(%a == 1,não,$ct $+ não) possui o pokémon selecionado. | return }
    if ($basestat(%c,etype)) {
      tokenize 58 $rental.pk(%c)
      msg =$nick $ct $+ Exibindo informações de $cc $+ $1 $+ $ct $+ :
      var %rib = $dados(%p,%c,Ribbon)
      msg =$nick $chr(160) $ct $+ ID: $cc $+ Rental $ct $+ / Level: $cc $+ $2 $ct $+ / Item: $cc $+ $iif($8,$8,Nenhum)
      msg =$nick $chr(160) $ct $+ Stats: HP $cc $+ $9 $ct $+ ATK $cc $+ $10 $ct $+ DEF $cc $+ $11 $ct $+ SPD $cc $+ $12 $ct $+ SATK $cc $+ $13 $ct $+ SDEF $cc $+ $14
      msg =$nick $chr(160) $ct $+ Nature: $cc $+ $3 $ct $+ / Shiny: $cc $+ $iif($5 == ON,Sim,Não) $ct $+ / Sexo: $cc $+ $iif($4 == Male,12Macho,$iif($4 == Female,13Fêmea,14N/A)) $ct $+ / Trait: $cc $+ $6
      msg =$nick $chr(160) $ct $+ Loyalty: $loyalty($7)
      var %x = 1
      while (%x <= 4) {
        var %move = $ [ $+ [ $calc(%x + 16) ] ], %power = $read(pkp\moveslist.txt, s, %move), %type = $gettok(%power,1,58), %acc = $gettok(%power,3,58), %power = $gettok(%power,2,58)
        if (%move == Hidden Power) { var %power = $gettok($25,2,59), %type = $gettok($25,1,59) }
        msg =$nick $chr(160) $ct $+ Move $chr(35) $+ %x $+ : $+ $cc $iif(!%move,-,$arrange(%move,160,12) $ct $+ $chr(91) $+ Power: $+ $cc $iif(!%power,$arrange(-,160,3).center,$arrange(%power,160,3).right) $ct $+ Acc: $+ $cc $iif(!%acc,$arrange(-,160,4).center,$iif(%acc isnum,$arrange(%acc,160,3).right $+ $chr(37),$arrange(%acc,160,4).right)) $ct $+ Type: $+ $cc $iif(!%type,$arrange(-,160,8).center,$arrange(%type,160,8).center) $+ $ct $+ $chr(93))
        inc %x
      }
      msg =$nick $ct $+ Fim da exibição.
    }
    else { msg =$nick $ct $+ Você cometeu um erro na utilização deste comando. Procure informações utilizando o comando ' $+ $cc $+ .Ajuda $+ $ct $+ '. | return }
  }
  else {
    if (%a) || ((!%a) && ($dados(%p,Info,Perfil,6))) { var %r = $chr(40) $+ $cc $+ $iif($top.pos(%p),$top.pos(%p),?) $+ $ct $+ º no ' $+ $cc $+ .Top $+ $ct $+ ' $+ $chr(41) } | else { var %r = 0 }
    msg =$nick $ct $+ Dados de $cc $+ $dados(%p,Info,Nick) $+ $iif(%r,$chr(32) $+ $ct $+ %r,$+ $ct $+) $+ :
    msg =$nick $ct $+ Pokémon: $rental.view.pokes(%p)
    var %r = $getmoney($dados(%p,Dados,BP))
    msg =$nick $ct $+ Battle Points ( $+ $cc $+ BP $+ $ct $+ ): $cc $+ $iif(%r,%r,Nenhum)
    var %r = $dados(%p,Rental,Victory)
    msg =$nick $ct $+ Vitórias: $cc $+ $iif(%r,%r,Nenhuma) $ct $+ / Recorde: $cc $+ $iif($dados(%p,Historico,Rental),$dados(%p,Historico,Rental),Nenhum)
    msg =$nick $ct $+ Fim da exibição de dados.
  }
}

alias rental.view.pokes {
  var %p = $1
  if ($dados(%p,Rental,Battle) == 1) && (!$dados(%p,Rental,Team)) { var %team = %rental. [ $+ [ %p ] ] }
  else { var %team = $dados(%p,Rental,Team) }
  var %x = 1, %r = 0
  while ($gettok(%team,%x,32)) {
    var %pk = $rental.pk($gettok(%team,%x,32))
    if (%r) { var %r = %r $ct $+ $gettok(%pk,1,58) $+ $ct $+ ( $+ $iif($gettok(%pk,4,58) == Male,12M,$iif($gettok(%pk,4,58) == Female,13F,14N/A)) $+ $iif($gettok(%pk,5,58) == ON,04+,$+) $+ $ct $+ )/ $+ $cc $+ $gettok(%pk,2,58) }
    else { var %r = $ct $+ $gettok(%pk,1,58) $+ $ct $+ ( $+ $iif($gettok(%pk,4,58) == Male,12M,$iif($gettok(%pk,4,58) == Female,13F,14N/A)) $+ $iif($gettok(%pk,5,58) == ON,04+,$+) $+ $ct $+ )/ $+ $cc $+ $gettok(%pk,2,58) }
    inc %x
  }
  return %r
}

alias is_rental {
  if (%rental. [ $+ [ $1 ] ]) || ($v([ [ B. ] $+ [ $checknickid($1).ID ] $+ [ .Rental ] ])) { return $true }
  else { return $false }
}

alias loyalty {
  var %l = $1

  if (%l < 6) { return Seu ódio é profundo e seu olhar, assustador. }
  elseif (%l < 60) { return Não está contente com sua companhia. Ele está com muita raiva. }
  elseif (%l < 94) { return Não parece que é bem tratado. Acho que está com raiva. }
  elseif (%l < 127) { return Você deveria tratá-lo melhor... }
  elseif (%l < 160) { return Ele é bem fofo... }
  elseif (%l < 200) { return Ele é seu amigo. Ele parece feliz. }
  elseif (%l < 250) { return Parece que ele realmente confia em você. }
  else { return Está muito feliz. Seu olhar sugere plena confiança e lealdade. }

}
alias in {
  var %text = $1, %word = $2, %chr = $3, %type = 1
  if (!%chr) { var %chr = 32 }
  if ($prop == count) { var %type = 0 }
  return $findtok(%text,%word,%type,%chr)
}

alias usual.type {
  var %team = $1-, %x = 1, %types, %res
  while ($gettok(%team,%x,32)) {
    var %pk = $gettok(%team,%x,32), %type = $basestat(%pk,type), %y = 1
    while ($gettok(%type,%y,32)) {
      var %now.type = $gettok(%type,%y,32)
      var %types = $addtok(%types,%now.type,32)
      if (%res == $null) { var %res = %now.type }
      else { var %res = %res %now.type }
      inc %y
    }
    inc %x
  }
  var %x = 1, %high = 0 | while ($gettok(%types,%x,32)) {
    var %type = $gettok(%types,%x,32)
    if ($findtok(%res,%type,0,32) > $gettok(%high,1,58)) { var %high = $findtok(%res,%type,0,32) $+ : $+ %type }
    elseif ($findtok(%res,%type,0,32) == $gettok(%high,1,58)) { var %high = $gettok(%high,1,58) $+ : $+ $addtok($gettok(%high,2,58),%type,32) }
    inc %x
  }

  if ($gettok($gettok(%high,2,58),0,32) > 1) { return $false }
  else { return $gettok(%high,2,58) }

}
alias rental.check.brain {
  var %brain = $readini(pkp\status.ini,Active,Brain), %nick = $1
  if ($gettok(%brain,1,58)) && (!$calc( ($dados(%nick,Rental,Victory) + 1) % 7 )) {
    var %brain = $dados($gettok(%brain,1,58),Info,Nick)
    if ($checknick(%brain) == Ok!) && (!$dados(%nick,Rental,Auto)) {
      if ($dados(%nick,Rental,Brain) == %brain) && ($is_rental(%brain)) { if ($checknick(%brain) == Ok!) { msg $+(=,%brain) $ct $+ Seu adversário $cc $+ $dados(%nick,Info,Nick) $ct $+ começará sua $cc $+ $ordinal($dados(%nick,Rental,Battle)).f $ct $+ batalha em breve. Fique atento! | return } }
      if ($checknickid(%brain) == Ok!) || (%confirm. [ $+ [ %brain ] ]) || ($v(Watch. [ $+ [ %brain ] ])) || ($is_rental(%brain)) { msg $+(=,%brain) $ct $+ Atenção, $cc $+ %brain $+ $ct $+ ! Há um adversário em potencial para você no $cc $+ Battle Rental $+ $ct $+ ! Se quiser enfrentá-lo, pare o que estiver fazendo e aguarde até que apareça um pedido de confirmação para a batalha. }
      else {
        unset %stand. [ $+ [ %brain ] ] | set %confirm. [ $+ [ %brain ] ] BRN: $+ $dados(%nick,Info,Nick)
        msg $+(=,%brain) $ct $+ Atenção, $cc $+ %brain $+ $ct $+ ! O treinador $cc $+ $dados(%nick,Info,Nick) $ct $+ está desafiando o $cc $+ Battle Rental $ct $+ e é seu adversário em potencial. Se quiser assumir o controle da batalha contra o $cc $+ Brain $+ $ct $+ , digite ' $+ $cc $+ .sim $+ $ct $+ '. Caso contrário, ' $+ $cc $+ .nao $+ $ct $+ '.
      }
    }
  }
}

; Rental Bonus List
; modificar a lista pra verificar diretamente no .ini... depois eu descubro como faz
alias rental.bonus {
  var %t = $dados($1,Rental,Team)
  set %bonus 0
  if $in(%t,Aipom) { inc %bonus 3 }
  if $in(%t,Ariados) { inc %bonus 3 }
  if $in(%t,Beautifly) { inc %bonus 3 }
  if $in(%t,Beedrill) { inc %bonus 3 }
  if $in(%t,Butterfree) { inc %bonus 3 }
  if $in(%t,Castform) { inc %bonus 3 }
  if $in(%t,Chimecho) { inc %bonus 3 }
  if $in(%t,Corsola) { inc %bonus 3 }
  if $in(%t,Crawdaunt) { inc %bonus 3 }
  if $in(%t,Delcatty) { inc %bonus 3 }
  if $in(%t,Delibird) { inc %bonus 3 }
  if $in(%t,Dewgong) { inc %bonus 3 }
  if $in(%t,Ditto) { inc %bonus 3 }
  if $in(%t,Dustox) { inc %bonus 3 }
  if $in(%t,Farfetch'd) { inc %bonus 3 }
  if $in(%t,Furret) { inc %bonus 3 }
  if $in(%t,Girafarig) { inc %bonus 3 }
  if $in(%t,Glalie) { inc %bonus 3 }
  if $in(%t,Huntail) { inc %bonus 3 }
  if $in(%t,Illumise) { inc %bonus 3 }
  if $in(%t,Kecleon) { inc %bonus 3 }
  if $in(%t,Ledian) { inc %bonus 3 }
  if $in(%t,Lickitung) { inc %bonus 3 }
  if $in(%t,Luvdisc) { inc %bonus 3 }
  if $in(%t,Magcargo) { inc %bonus 3 }
  if $in(%t,Masquerain) { inc %bonus 3 }
  if $in(%t,Mawile) { inc %bonus 3 }
  if $in(%t,Mightyena) { inc %bonus 3 }
  if $in(%t,Minun) { inc %bonus 3 }
  if $in(%t,Murkrow) { inc %bonus 3 }
  if $in(%t,Noctowl) { inc %bonus 3 }
  if $in(%t,Nosepass) { inc %bonus 3 }
  if $in(%t,Parasect) { inc %bonus 3 }
  if $in(%t,Pelipper) { inc %bonus 3 }
  if $in(%t,Pidgeot) { inc %bonus 3 }
  if $in(%t,Piloswine) { inc %bonus 3 }
  if $in(%t,Plusle) { inc %bonus 3 }
  if $in(%t,Raticate) { inc %bonus 3 }
  if $in(%t,Relicanth) { inc %bonus 3 }
  if $in(%t,Roselia) { inc %bonus 3 }
  if $in(%t,Seaking) { inc %bonus 3 }
  if $in(%t,Spinda) { inc %bonus 3 }
  if $in(%t,Sudowoodo) { inc %bonus 3 }
  if $in(%t,Sunflora) { inc %bonus 3 }
  if $in(%t,Swalot) { inc %bonus 3 }
  if $in(%t,Togetic) { inc %bonus 3 }
  if $in(%t,Torkoal) { inc %bonus 3 }
  if $in(%t,Tropius) { inc %bonus 3 }
  if $in(%t,Unown) { inc %bonus 3 }
  if $in(%t,Venomoth) { inc %bonus 3 }
  if $in(%t,Volbeat) { inc %bonus 3 }
  if $in(%t,Wailord) { inc %bonus 3 }
  if $in(%t,Whiscash) { inc %bonus 3 }
  if $in(%t,Wigglytuff) { inc %bonus 3 }
  if $in(%t,Absol) { inc %bonus 2 }
  if $in(%t,Aggron) { inc %bonus 2 }
  if $in(%t,Altaria) { inc %bonus 2 }
  if $in(%t,Ampharos) { inc %bonus 2 }
  if $in(%t,Arbok) { inc %bonus 2 }
  if $in(%t,Azumarill) { inc %bonus 2 }
  if $in(%t,Banette) { inc %bonus 2 }
  if $in(%t,Bellossom) { inc %bonus 2 }
  if $in(%t,Blastoise) { inc %bonus 2 }
  if $in(%t,Cacturne) { inc %bonus 2 }
  if $in(%t,Camerupt) { inc %bonus 2 }
  if $in(%t,Clefable) { inc %bonus 2 }
  if $in(%t,Cradily) { inc %bonus 2 }
  if $in(%t,Dunsparce) { inc %bonus 2 }
  if $in(%t,Electabuzz) { inc %bonus 2 }
  if $in(%t,Electrode) { inc %bonus 2 }
  if $in(%t,Exploud) { inc %bonus 2 }
  if $in(%t,Fearow) { inc %bonus 2 }
  if $in(%t,Feraligatr) { inc %bonus 2 }
  if $in(%t,Flareon) { inc %bonus 2 }
  if $in(%t,Gligar) { inc %bonus 2 }
  if $in(%t,Golduck) { inc %bonus 2 }
  if $in(%t,Golem) { inc %bonus 2 }
  if $in(%t,Gorebyss) { inc %bonus 2 }
  if $in(%t,Granbull) { inc %bonus 2 }
  if $in(%t,Grumpig) { inc %bonus 2 }
  if $in(%t,Hitmonchan) { inc %bonus 2 }
  if $in(%t,Hitmonlee) { inc %bonus 2 }
  if $in(%t,Hitmontop) { inc %bonus 2 }
  if $in(%t,Hypno) { inc %bonus 2 }
  if $in(%t,Kabutops) { inc %bonus 2 }
  if $in(%t,Kangaskhan) { inc %bonus 2 }
  if $in(%t,Kingler) { inc %bonus 2 }
  if $in(%t,Lanturn) { inc %bonus 2 }
  if $in(%t,Linoone) { inc %bonus 2 }
  if $in(%t,Lunatone) { inc %bonus 2 }
  if $in(%t,Magmar) { inc %bonus 2 }
  if $in(%t,Manectric) { inc %bonus 2 }
  if $in(%t,Mantine) { inc %bonus 2 }
  if $in(%t,Meganium) { inc %bonus 2 }
  if $in(%t,Misdreavus) { inc %bonus 2 }
  if $in(%t,Mr.Mime) { inc %bonus 2 }
  if $in(%t,Muk) { inc %bonus 2 }
  if $in(%t,Nidoking) { inc %bonus 2 }
  if $in(%t,Nidoqueen) { inc %bonus 2 }
  if $in(%t,Ninetales) { inc %bonus 2 }
  if $in(%t,Octillery) { inc %bonus 2 }
  if $in(%t,Omastar) { inc %bonus 2 }
  if $in(%t,Persian) { inc %bonus 2 }
  if $in(%t,Pinsir) { inc %bonus 2 }
  if $in(%t,Politoed) { inc %bonus 2 }
  if $in(%t,Poliwrath) { inc %bonus 2 }
  if $in(%t,Primeape) { inc %bonus 2 }
  if $in(%t,Quagsire) { inc %bonus 2 }
  if $in(%t,Qwilfish) { inc %bonus 2 }
  if $in(%t,Raichu) { inc %bonus 2 }
  if $in(%t,Rapidash) { inc %bonus 2 }
  if $in(%t,Sableye) { inc %bonus 2 }
  if $in(%t,Sandslash) { inc %bonus 2 }
  if $in(%t,Scyther) { inc %bonus 2 }
  if $in(%t,Seviper) { inc %bonus 2 }
  if $in(%t,Sharpedo) { inc %bonus 2 }
  if $in(%t,Shedinja) { inc %bonus 2 }
  if $in(%t,Shiftry) { inc %bonus 2 }
  if $in(%t,Shuckle) { inc %bonus 2 }
  if $in(%t,Slowking) { inc %bonus 2 }
  if $in(%t,Sneasel) { inc %bonus 2 }
  if $in(%t,Solrock) { inc %bonus 2 }
  if $in(%t,Stantler) { inc %bonus 2 }
  if $in(%t,Tangela) { inc %bonus 2 }
  if $in(%t,Tentacruel) { inc %bonus 2 }
  if $in(%t,Victreebel) { inc %bonus 2 }
  if $in(%t,Vileplume) { inc %bonus 2 }
  if $in(%t,Walrein) { inc %bonus 2 }
  if $in(%t,Xatu) { inc %bonus 2 }
  if $in(%t,Yanma) { inc %bonus 2 }
  if $in(%t,Alakazam) { inc %bonus }
  if $in(%t,Arcanine) { inc %bonus }
  if $in(%t,Armaldo) { inc %bonus }
  if $in(%t,Breloom) { inc %bonus }
  if $in(%t,Charizard) { inc %bonus }
  if $in(%t,Cloyster) { inc %bonus }
  if $in(%t,Crobat) { inc %bonus }
  if $in(%t,Dodrio) { inc %bonus }
  if $in(%t,Espeon) { inc %bonus }
  if $in(%t,Exeggutor) { inc %bonus }
  if $in(%t,Forretress) { inc %bonus }
  if $in(%t,Gardevoir) { inc %bonus }
  if $in(%t,Hariyama) { inc %bonus }
  if $in(%t,Houndoom) { inc %bonus }
  if $in(%t,Jumpluff) { inc %bonus }
  if $in(%t,Jynx) { inc %bonus }
  if $in(%t,Kingdra) { inc %bonus }
  if $in(%t,Lapras) { inc %bonus }
  if $in(%t,Machamp) { inc %bonus }
  if $in(%t,Marowak) { inc %bonus }
  if $in(%t,Miltank) { inc %bonus }
  if $in(%t,Ninjask) { inc %bonus }
  if $in(%t,Porygon2 }) { inc %bonus }
  if $in(%t,Rhydon) { inc %bonus }
  if $in(%t,Scizor) { inc %bonus }
  if $in(%t,Slowbro) { inc %bonus }
  if $in(%t,Smeargle) { inc %bonus }
  if $in(%t,Steelix) { inc %bonus }
  if $in(%t,Swellow) { inc %bonus }
  if $in(%t,Typhlosion) { inc %bonus }
  if $in(%t,Ursaring) { inc %bonus }
  if $in(%t,Venusaur) { inc %bonus }
  if $in(%t,Zangoose) { inc %bonus }
  if $in(%t,Celebi) { dec %bonus }
  if $in(%t,Deoxys) { dec %bonus }
  if $in(%t,Deoxys.F) { dec %bonus }
  if $in(%t,Deoxys.L) { dec %bonus }
  if $in(%t,Deoxys.E) { dec %bonus }
  if $in(%t,Groudon) { dec %bonus }
  if $in(%t,Ho-oh) { dec %bonus }
  if $in(%t,Jirachi) { dec %bonus }
  if $in(%t,Kyogre) { dec %bonus }
  if $in(%t,Latias) { dec %bonus }
  if $in(%t,Latios) { dec %bonus }
  if $in(%t,Lugia) { dec %bonus }
  if $in(%t,Mew) { dec %bonus }
  if $in(%t,Mewtwo) { dec %bonus }
  if $in(%t,Rayquaza) { dec %bonus }
  if $in(%t,Wobbuffet) { dec %bonus }
  return %bonus
}

alias SLP.clause {
  var %ID = $1, %n = $2
  if ($v($+(B.,%ID,.SLPClause))) {
    var %foe = $rvs(%n), %x = 1, %sleep = 0
    while ($rteam.n(%ID,%foe,%x)) {
      var %pk = $rteam.n(%ID,%foe,%x), %st = $gettok(%pk,16,58)
      if ($gettok(%st,1,59) == Sleep) && ($gettok(%st,4,59)) { inc %sleep }
      inc %x
    }
    if ($battle.team(%ID,%foe)) {
      var %foe = $battle.team(%ID,%foe).num, %x = 1
      while ($rteam.n(%ID,%foe,%x)) {
        var %pk = $rteam.n(%ID,%foe,%x), %st = $gettok(%pk,16,58)
        if ($gettok(%st,1,59) == Sleep) && ($gettok(%st,4,59)) { inc %sleep }
        inc %x
      }
    }
    if (%sleep >= $SLP.clause.max(%ID)) { return $true }
  }
  return $false
}

alias SLP.clause.max {
  var %ID = $1
  return 1
}

alias FRZ.clause {
  var %ID = $1, %n = $2
  if ($v($+(B.,%ID,.FRZClause))) {
    var %foe = $rvs(%n), %x = 1, %frozen = 0
    while ($rteam.n(%ID,%foe,%x)) {
      var %pk = $rteam.n(%ID,%foe,%x), %st = $gettok(%pk,16,58)
      if ($gettok(%st,1,59) == Frozen) { inc %frozen }
      inc %x
    }
    if ($battle.team(%ID,%foe)) {
      var %foe = $battle.team(%ID,%foe).num, %x = 1
      while ($rteam.n(%ID,%foe,%x)) {
        var %pk = $rteam.n(%ID,%foe,%x), %st = $gettok(%pk,16,58)
        if ($gettok(%st,1,59) == Frozen) { inc %frozen }
        inc %x
      }
    }
    if (%frozen >= $FRZ.clause.max(%ID)) { return $true }
  }
  return $false
}

alias FRZ.clause.max {
  var %ID = $1
  return 1
}
