from sqlalchemy import ForeignKey
from prz import db
import prz.core.enum_types as et
from prz.core.get_or_create import get_or_create_by_id, get_or_create_by_name
from prz.features.get_adoptable_pets.query_helpers.query_mixins import ConverterMixin, RandomizedHomePageMixin


breed_association_table = db.Table(
    'breed_association_table',
    db.Column('pet_id', ForeignKey('pet.id')),
    db.Column('breed_id', ForeignKey('breed.id'))
)

tag_association_table = db.Table(
    'tag_association_table',
    db.Column('pet_id', ForeignKey('pet.id')),
    db.Column('tag_id', ForeignKey('tag.id'))
)


class Breed(db.Model):
  """ Class for the different animal breeds. """

  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String(140), unique=True)
  pets = db.relationship(
      'Pet',
      secondary=breed_association_table,
      back_populates='breeds'
  )


class Pet(db.Model, ConverterMixin, RandomizedHomePageMixin):

  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String(140), index=True)
  organization_id = db.Column(db.String(140), ForeignKey('organization.id'))
  organization = db.relationship('Organization', back_populates='pet')
  breeds = db.relationship(
      'Breed',
      secondary=breed_association_table,
      back_populates='pets',
      lazy='dynamic'
  )
  tags = db.relationship(
      'Tag',
      secondary=tag_association_table,
      back_populates='pets',
      lazy='dynamic'
  )
  species = db.Column(db.Enum(et.SpeciesEnum))
  description = db.Column(db.String(1000))
  size = db.Column(db.Enum(et.SizeEnum))
  age = db.Column(db.Enum(et.AgeEnum))
  gender = db.Column(db.Enum(et.GenderEnum))
  coat = db.Column(db.Enum(et.CoatEnum))
  status = db.Column(db.Enum(et.StatusEnum))
  images = db.relationship('Image')
  spayed_nuetered = db.Column(db.Boolean)
  house_trained = db.Column(db.Boolean)
  declawed = db.Column(db.Boolean)
  special_needs = db.Column(db.Boolean)
  shots_current = db.Column(db.Boolean)
  contact_email = db.Column(db.String(120))
  contact_phone = db.Column(db.String(20))
  contact_address = db.Column(db.String(240))
  contact_city = db.Column(db.String(120))
  contact_state = db.Column(db.String(120))
  contact_postcode = db.Column(db.String(120))

  def to_dict(self):
    """ Converts the object into a dict.

    Returns:
        dict: A dict with column name key and column value value.
    """
    result = self._base_to_dict()
    # Add the relational attributes to the dict.
    if self.tags:
      result['tags'] = [tag.name for tag in self.tags.all()]
    if self.breeds:
      result['breeds'] = [breed.name for breed in self.breeds.all()]
    if self.organization:
      result['organization'] = self.organization.name
    if self.species:
      result['species'] = self.species.name

    return result

  def from_json(self, data):
    for field in self.__table__.columns:
      if not field.name in data:
        continue
      else:

        setattr(self, field.name, data[field.name])
    breeds = [get_or_create_by_name(Breed, name)
              for name in data['breeds']]
    setattr(self, 'breeds', breeds)
    self.tags = [get_or_create_by_name(Tag, name) for name in data['tags']]
    self.organization = get_or_create_by_id(
        Organization, data['organization_id'])


class Organization(db.Model):
  id = db.Column(db.String(140), primary_key=True)
  pet = db.relationship('Pet', back_populates='organization')
  name = db.Column(db.String(140), index=True)
  email = db.Column(db.String(120))
  phone = db.Column(db.String(20))
  address = db.Column(db.String(240))
  city = db.Column(db.String(120))
  state = db.Column(db.String(80))
  country = db.Column(db.String(80))
  postcode = db.Column(db.String(10))
  monday_hours = db.Column(db.String(50))
  tuesday_hours = db.Column(db.String(50))
  wednesday_hours = db.Column(db.String(50))
  thursday_hours = db.Column(db.String(50))
  friday_hours = db.Column(db.String(50))
  saturday_hours = db.Column(db.String(50))
  sunday_hours = db.Column(db.String(50))
  mission_statement = db.Column(db.String(1000))
  adoption_policy = db.Column(db.String(500))
  adoption_url = db.Column(db.String(500))

  url = db.Column(db.String(250))  # TODO(conidas) Is this the right size?


class Tag(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String(140), index=True, unique=True)
  pets = db.relationship(
      'Pet',
      secondary=tag_association_table,
      back_populates='tags'
  )


class Image(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  pet_id = db.Column(db.Integer, ForeignKey('pet.id'))
  # TODO(conidas) Is this the right size?
  url = db.Column(db.String(250), unique=True)
