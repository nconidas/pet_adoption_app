import unittest
from config import Config
from prz import create_app, db
from prz.models import Breed, Organization, Pet, Tag
from test_data.pet_dict import pet_dict, fixture_reader


class TestConfig(Config):
  TESTING = True
  SQLALCHEMY_DATABASE_URI = 'sqlite://'


class PetModelCase(unittest.TestCase):
  def setUp(self):
    self.app = create_app(TestConfig)
    self.app_context = self.app.app_context()
    self.app_context.push()
    db.create_all()

  def tearDown(self):
    db.session.remove()
    db.drop_all()
    self.app_context.pop()

  def test_pet_constructor(self):

    org = Organization(id='1')
    breeds = [Breed(name='lab'), Breed(name='gsd')]
    tags = [Tag(name='smart'), Tag(name='playful')]
    pet = Pet(name='fido', organization=org, breeds=breeds,
              tags=tags, size='LARGE')

    db.session.add(pet)
    db.session.commit()
    self.assertEqual(pet.name, 'fido')
    result = pet.breeds.all()
    result_breeds = [breed.name for breed in result]
    self.assertCountEqual(result_breeds, ['lab', 'gsd'])

  def test_to_dict(self):
    org = Organization(id='1')
    breeds = [Breed(name='lab'), Breed(name='gsd')]
    tags = [Tag(name='smart'), Tag(name='playful')]
    pet = Pet(name='fido', organization=org, breeds=breeds,
              tags=tags, size='LARGE')
    db.session.add(pet)
    db.session.commit()
    result = pet.to_dict()
    self.assertDictEqual(result, pet_dict)

  def test_from_json(self):
    org = Organization(id='1')
    breeds = [Breed(name='lab'), Breed(name='gsd')]
    tags = [Tag(name='smart'), Tag(name='playful')]
    pet = Pet(name='fido', organization=org, breeds=breeds,
              tags=tags, size='LARGE')

    data = fixture_reader("adoptable_pet.json")
    pet2 = Pet()
    pet2.from_json(data)
    db.session.add(pet)
    db.session.add(pet2)
    db.session.commit()


if __name__ == '__main__':
  unittest.main(verbosity=1)
