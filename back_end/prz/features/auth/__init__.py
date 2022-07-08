from flask import Blueprint
bp = Blueprint('api', __name__)
from prz.features.auth import auth_routes
