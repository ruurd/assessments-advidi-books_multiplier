# encoding: UTF-8
# ===========================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
# ===========================================================================
# Application controller
#
module ApplicationHelper
  # Determine the bootstrap css class id from the flash level
  # @param [Symbol] level The level of the flash message
  # @return the id of the css class
  def flash_class(level)
    case level
    when :notice then
      'success'
    when :alert then
      'warning'
    when :error then
      'error'
    else
      'info'
    end
  end

  # Return a gender sign
  # @param gender Male if {mM} otherwise female
  # @return gender sign character
  def gendersign(gender)
    if gender == 'M' || gender == 'm'
      '&#9794;'
    else
      '&#9792;'
    end
  end

  # Return a checkmark character
  def checkmark(yesplease)
    yesplease ? '&#10004;' : ''
  end

  def language_name(loc)
    t("languages.#{loc}")
  end

  # Build a sortable header
  # @param column the column that must be sortable
  # @param title the title of the column
  # @return a sortable column header
  def thsortable(column, title = nil)
    title ||= column.titleize
    css_class = nil
    css_class = "current #{sort_direction}" if column == sort_column
    if column == sort_column && sort_direction == 'asc'
      direction = 'desc'
    else
      direction = 'asc'
    end
    content_tag(:th, class: css_class) do
      link_to title, { sort: column, direction: direction }
    end
  end

  # Build a sortable tab
  # @param column the column that must be sortable
  # @param title the title of the column
  # @return a sortable tab
  def tabsortable(tab, column, title = nil)
    title ||= column.titleize
    css_class = 'sortable'
    css_class = "sortable current #{sort_direction}" if column == sort_column
    if column == sort_column && sort_direction == 'asc'
      direction = 'desc'
    else
      direction = 'asc'
    end
    link_to title,
            { tab: tab, sort: column, direction: direction },
            { class: css_class }
  end
end

