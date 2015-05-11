Shoes.app do

  line 100, 100, 100, 300, strokewidth: 5, stroke: green
  star 100, 100, 100, 80, 50, fill: pink, stroke: hotpink
  arc  100, 100, 50, 50, 0, PI, fill:darkmagenta
  oval 80, 80, 10, 10, fill:darkmagenta
  oval 110, 80, 10, 10, fill:darkmagenta
  para "Asher", left:70
  
  line 300, 100, 300, 300, strokewidth: 5, stroke: green
  star 300, 100, 100, 80, 50, fill: pink, stroke: magenta
  arc  300, 100, 50, 50, 0, PI, fill: deeppink
  oval 280, 80, 10, 10, fill: deeppink
  oval 310, 80, 10, 10, fill: deeppink
  para "Cora", left:270
  
  line 500, 100, 500, 300, strokewidth: 5, stroke: green
  star 500, 100, 100, 80, 50, fill: pink, stroke: navy
  arc  500, 100, 50, 50, 0, PI, fill: fuchsia
  oval 480, 80, 10, 10, fill: fuchsia
  oval 510, 80, 10, 10, fill: fuchsia
  para "Dada", left:470
  
  title "Happy Mother's Day!!!", width: 600, left: 70, top: 350
  para "press a key for a special message", left: 170, top: 400
  
  keypress do
    `say "happy mothers day" -v Vicki`
  end
end