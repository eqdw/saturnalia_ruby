class Pair < ActiveRecord::Base
  belongs_to :person_one, class_name: "Person"
  belongs_to :person_two, class_name: "Person"

  def self.active
    Pair.where(active: true)
  end

  def self.create_with_exclusion!(opts)
    pair = Pair.create!(person_one: opts[:person_one], person_two: opts[:person_two], active: true)
    Exclusion.create!(person_one: opts[:person_one], person_two: opts[:person_two], reason: "Paired Before") unless pair.singleton?
  end

  validate :not_excluded
  validate :not_matched_with_self

  def not_excluded
    if Exclusion.pair_excluded?(person_one, person_two)
      errors.add(:base, "#{person_one.name} and #{person_two.name} are on the exclusion list")
    end
  end

  def not_matched_with_self
    if person_one.id == person_two.id
      errors.add(:base, "Tried to match #{person_one.name} with themself")
    end
  end

  def singleton?
    person_two.nil?
  end

  # Generates full set of pairings given existing people in the database
  def self.generate_candidate_pairs
    people = Person.all.to_a
    pairs = []

    while(people.length >= 2)
      candidates = people.sample(2)

      unless Exclusion.pair_excluded?(*candidates)
        candidates.each{|p| people.delete(p)}
        pairs << candidates.map(&:name)
      end
    end

    pairs << [people.first.name] unless people.empty?
    pairs
  end

  # Creates pairs from the passed in array
  def self.create_pairs(pairs)
    Pair.transaction do
      Pair.update_all(active: false)

      pairs.each do |people|
        people.map! { |p| Person.where(name: p).first }

        people << nil if people.length == 1

        Pair.create_with_exclusion!(person_one: people.first, person_two: people.last, active: true)
      end
    end
  end
end
