
from flask import jsonify, request
from prz import db
from prz.core.get_or_create import get_or_create_by_id, get_or_create_by_name
from prz.features.get_adoptable_pets import bp
from prz.features.get_adoptable_pets.query_helpers.home_page_query import home_page_query
from prz.models import Pet


@bp.route('/', methods=['GET'])
@bp.route('/adoptables', methods=['GET'])
def get_adoptables():
  """Returns a collection of adoptable pets."""
  query = home_page_query()
  data = Pet.to_category_list(query)
  return jsonify(data)


@bp.route('/adoptables', methods=['POST'])
def add_adoptables():
  """ Adds New Adoptable Pets. """

  data = request.get_json()
  if Pet.query.get(data['id']):
    return 'Already exists'

  pet = Pet()
  pet.from_json(data=data)
  db.session.add(pet)
  db.session.commit()
  return 'success'
