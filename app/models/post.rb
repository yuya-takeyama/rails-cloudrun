class Post < Firestore
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :name, :string
  attribute :body, :string

  class << self
    def collection
      connection.col('posts')
    end

    def all
      collection.
        get.
        map { |post|
          Post.new(
            id: post.document_id,
            **post.fields,
          )
        }
    end

    def find(id)
      post = collection.
        doc(id).
        get
      Post.new(
        id: post.document_id,
        **post.fields,
      )
    end
  end

  def base_uri
    "/posts/#{id}"
  end

  def to_param
    id
  end

  def persisted?
    !!id
  end

  def save
    if persisted?
      self.class.collection.doc(id).update(**attributes.except('id'))
    else
      result = self.class.collection.add(**attributes.except('id'))
      self.id = result.document_id
      true
    end
  end

  def update(attributes)
    raise 'not persisted' unless persisted?

    self.attributes = attributes
    save
  end
end
