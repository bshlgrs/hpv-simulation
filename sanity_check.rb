require "./simulator.rb"

woman_infected = 0

100000.times do
  man = Man.new("Henry", true)
  woman = Woman.new("Jill", false)

  people = [man, woman]

  finished = false

  Simulation.simulate(people) do |s|

    s.simulate_months(1) do
      (16 * 6).times do
        woman.have_sex_with(man, false)
        if woman.infected && !finished
          woman_infected += 1
          finished = true
        end
      end
    end
  end
end

prob = woman_infected / 100000.0

puts "that's a #{'%.4f' % (prob * 100)}% chance."
