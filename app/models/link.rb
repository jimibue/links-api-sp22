class Link < ApplicationRecord
    # username must be one of these values or it won't save to db
    students = %w(austink brendac jamesy katherine michaelc michealp randyc trinan sharayahh jessican joej )
    validates :username, inclusion: { in: students,
        message: "%{value} is not a valid username" }
end
