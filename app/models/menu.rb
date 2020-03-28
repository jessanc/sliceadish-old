require 'date'
class Menu < ActiveRecord::Base
    has_many :menu_items
    has_many :dishes, through: :menu_items

    validates :end_date, presence: true, uniqueness: true
    validate :date_validations
    

    private
    def end_date_after_start_date
        return if end_date.blank? || start_date.blank?

        if end_date < start_date
        errors.add(:end_date, "must be after the start date")
        end
    end

    def date_validations
        return if end_date.blank? || start_date.blank?
         if end_date < start_date
            errors.add(:end_date, "must be after the start date")
        end
        if !end_date.friday?
            errors.add(:end_date, "must be a friday")
        end
    end
end
