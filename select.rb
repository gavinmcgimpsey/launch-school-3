def select(arry)
  counter = 0
  selected = []
  while counter < arry.length
    elem = arry[counter]
    selected << elem if yield(elem)
    counter += 1
  end
  selected
end
