class Exclusion < ActiveRecord::Base
  belongs_to :person_one, class_name: "Person"
  belongs_to :person_two, class_name: "Person"

  validate :not_matched_with_self

  def not_matched_with_self
    if person_one.id == person_two.id
      errors.add(:base, "Tried to match #{person_one.name} with themself")
    end
  end

  def self.pair_excluded?(p1, p2)
    [
      self.where(person_one: p1, person_two: p2).first,
      self.where(person_one: p2, person_two: p1).first
    ].compact.length > 0
  end
end
