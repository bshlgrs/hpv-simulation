$PROBABILITIES = {
  # After a year, only 30% of people haven't recovered.
  # So P(!recovery_per_month) ** 12 == 0.7
  recovery_per_month: 1 - 0.3 ** (1.0/12),
  # I have no idea what these numbers should be
  infection_per_sex: 0.01,
  infection_per_unprotected_sex: 0.03,
  base_rate: 0.2
}

def with_probability(p)
  if Random.rand < p
    yield
  end
end

class Person
  attr_accessor :infected
  attr_reader :name, :gender

  def inspect
    "Person<#{name},#{gender},#{infected}>"
  end

  def end_of_month(verbose = false)
    if @infected
      with_probability($PROBABILITIES[:recovery_per_month]) do
        @infected = false
        puts "#{name} got better!" if verbose
      end
    end
  end

  def initialize(name, gender, infected)
    if infected == true || infected == false
      @infected = infected
    else
      @infected = Random.rand < infected
    end
    @name = name
    @gender = gender
  end

  def have_sex_with(other_person, condom, verbose = false)
    if self.infected
      p = condom ? $PROBABILITIES[:infection_per_sex] : $PROBABILITIES[:infection_per_unprotected_sex]
      with_probability(p) do
        other_person.infected = true
        puts "#{other_person.name} got HPV while having sex with #{self.name}" if verbose
      end
    end

    if other_person.infected
      p = condom ? $PROBABILITIES[:infection_per_sex] : $PROBABILITIES[:infection_per_unprotected_sex]
      with_probability(p) do
        self.infected = true
        puts "#{self.name} got HPV while having sex with #{other_person.name}" if verbose
      end
    end
  end

  def have_sex_with_stranger(condom, infection_probability = $PROBABILITIES[:base_rate])
    p = condom ? $PROBABILITIES[:infection_per_sex] : $PROBABILITIES[:infection_per_unprotected_sex]
    with_probability(infection_probability * p) do
      @infected = true
    end
  end
end

class Woman < Person
  def initialize(name, infected)
    super(name, :female, infected)
  end
end

class Man < Person
  def initialize(name, infected)
    super(name, :male, infected)
  end
end

class Simulation
  attr_reader :month

  def self.simulate(people)
    yield(self.new(people))
  end

  def initialize(people)
    @people = people
    @month = 0
  end

  def simulate_months(n, &prc)
    n.times { self.simulate_month(&prc) }
  end

  def simulate_month(verbose = false)
    puts "Month #{month}:" if verbose
    @month += 1

    yield

    @people.each(&:end_of_month)
    puts "" if verbose
  end

  def show_status
    puts "Here's everyone:"
    @people.each { |person| p person }
    puts ""
  end

  def infected_people
    @people.select { |x| x.infected }
  end
end
