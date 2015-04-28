class Employee
  attr_reader :salary

  def initialize(options)
    @name, @title, @salary, @boss =
      options[:name], options[:title], options[:salary], options[:boss]
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize(options)
    @employees = []
    super
  end

  def bonus(multiplier)
    total_subordinate_wages * multiplier
  end

  def total_subordinate_wages
    @employees.inject(0) do |accumulator, employee|
      accumulator += employee.total_subordinate_wages if employee.is_a?(Manager)
      accumulator + employee.salary
    end
  end

  def add_employees(*employees)
    @employees += employees
  end
end



ned = Manager.new(name: "Ned", title: "Founder", salary: 1_000_000)
darren = Manager.new(name: "Darren", title: "TA Manager", salary: 78_000, boss: ned)
shawna = Employee.new(name: "Shawna", title: "TA", salary: 12_000, boss: darren)
david = Employee.new(name: "David", title: "TA", salary: 10_000, boss: darren)

ned.add_employees(darren)
darren.add_employees(shawna, david)

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)
