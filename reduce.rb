def reduce(arr, accumulator = 0)
  counter = 0
  while counter < arr.length
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end
  accumulator
end
