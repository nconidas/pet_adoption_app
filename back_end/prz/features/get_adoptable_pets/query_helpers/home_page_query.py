from sqlalchemy import and_
from prz.models import Pet
from prz import db


def home_page_query():
  filters = [Pet.status == 'ADOPTABLE']
  return db.session.query(Pet).filter(and_(*filters)).limit(100)
