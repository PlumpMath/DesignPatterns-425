class Employee

   attr_reader :name, :title
   attr_reader :salary
   
   def initialize(name, title, salary, payroll)
      @name = name
      @title = title
      @salary = salary
      @payroll = payroll
   end
   
   def salary=(new_salary)
      @salary = new_salary
      @payroll.update(self)
   end
   
end


class Payroll
   
   def update(changed_employee)
      puts "Cut a new check for #{changed_employee.name}"
      puts "Their salary is now #{changed_employee.salary}"
   end
   
end
