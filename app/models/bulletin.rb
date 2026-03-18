# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  category_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state       :string
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_user_id      (user_id)
#

class Bulletin < ApplicationRecord
  include AASM

  aasm column: 'state', skip_validation_on_save: true do
    state :draft
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: %w[draft under_moderation rejected published], to: :archived
    end
  end

  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  before_create :set_state

  # validates :image, attached: true, content_type: %w[image/png image/jpg image/jpeg], size: { less_than: 5.megabytes }

  scope :search, lambda { |search|
    return if search.blank?

    where('LOWER(title) LIKE :q OR LOWER(description) LIKE :q', q: "%#{search}%")
  }

  scope :by_state, ->(state) { where(state: state) if state.present? }
  scope :by_user_id, ->(user_id) { where(user_id: user_id) if user_id.present? }

  def thumbnail
    image.variant(resize_to_fill: [200, 200]).processed
  rescue ActiveStorage::FileNotFoundError, Errno::ENOENT
    # Заглушка если с файлом что-то случилось
    fallback_image
  end

  private

  def fallback_image
    temp_file = Tempfile.new(['fallback', '.jpg'])
    temp_file.binmode

    Rails.root.join('test/fixtures/files/test.jpg').open('rb') do |source|
      temp_file.write(source.read)
    end

    temp_file.rewind

    image.attach(
      io: temp_file,
      filename: 'default_image.jpg',
      content_type: 'image/jpeg'
    )

    temp_file.close
    temp_file.unlink

    image.variant(resize_to_fill: [200, 200]).processed
  end

  def set_state
    self.state = 'draft' if state.nil?
  end
end
