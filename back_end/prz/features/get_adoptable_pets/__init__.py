from flask import Blueprint
bp = Blueprint('adoptable_pets', __name__)

from prz.features.get_adoptable_pets import adoptable_pets_routes