require 'forwardable'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  extend Forwardable
  def_delegators :@todos, :shift, :pop, :size, :first, :last, :length
  def_delegator :@todos, :delete_at, :remove_at
  def_delegator :@todos, :[], :item_at

  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def to_s
    result = "---- #{title} ----\n"
    each { |todo| result = result + todo.to_s + "\n"}
    result
  end

  def add(list_item)
    @todos.push(Todo.new(list_item))
  end
  alias :<< :add

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    new_TodoList = TodoList.new(title)
    each { |todo| new_TodoList.add(todo) if yield(todo)}
    new_TodoList
  end

  def mark_done_at(index)
    @todos[index].done!
  end

  def mark_undone_at(index)
    @todos[index].undone!
  end

  def find_by_title(str)
    idx = @todos.find_index { |todo| todo.title == str } # lazy
    @todos[idx]
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(str)
    find_by_title(str) && find_by_title(str).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

binding.pry
