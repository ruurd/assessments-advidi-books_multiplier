# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Announcement
#
class Announcement < ActiveRecord::Base

  attr_accessible :starts_at,
                  :ends_before,
                  :locale,
                  :message,
                  :level

  validates_inclusion_of :level,
      in: %w(success info warning error),
      message: '%{value} must be success, info, warning or error'

  scope :current, where('starts_at <= now() AND now() < ends_before')
  scope :local, where('locale = ?', I18n.locale)

  def self.search(search)
    if search
      where('message LIKE :msg', msg: "%#{search}%")
    else
      scoped
    end
  end

end
