require "./simulator.rb"

woman1_infected = 0
woman2_and_woman1_infected = 0

50000.times do
  man1 = Man.new("man1", 0.5)
  man2 = Man.new("man2", 0.5)
  woman1 = Woman.new("woman1", 0.2)
  woman2 = Woman.new("woman2", 0)

  people = [man1, man2, woman1, woman2]

  Simulation.simulate(people) do |s|
    # In Febrary, I had protected sex with woman1 four times
    s.simulate_month do
      4.times do
        woman1.have_sex_with(man1, true)
      end
    end

    # In March through June, I had protected sex with woman2 five times per month
    # and man2 had sex with one stranger per month? (this doesn't change the result much)
    s.simulate_months(4) do
      5.times do
        woman2.have_sex_with(man1, true)
      end

      man2.have_sex_with_stranger(true)
    end

    # In July, man2 had protected sex with woman1 about seven times
    7.times do
      man2.have_sex_with(woman1, true)
    end

    # july through december, I had unprotected sex with woman1 about 4x a momth,
    # and woman2 6x a month
    s.simulate_months(6) do
      6.times do
        woman2.have_sex_with(man1, false)
      end

      4.times do
        woman1.have_sex_with(man1, false)
      end
    end

    # three months of me having sex with just woman1

    s.simulate_months(3) do
      6.times do
        woman1.have_sex_with(man1, false)
      end
    end

    infected_people = s.infected_people
    if infected_people.include? woman1
      woman1_infected += 1
      if infected_people.include? woman2
        woman2_and_woman1_infected += 1
      end
    end
  end
end

prob = 1.0 * woman2_and_woman1_infected / woman1_infected

puts "that's a #{'%.4f' % (prob * 100)}% chance that woman2 has it"
