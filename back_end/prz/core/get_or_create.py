from prz import db


def get_or_create_by_id(model, id):
  with db.session.no_autoflush:
    object = model.query.get(id)
  if not object:
    object = model(id=id)
  return object


def get_or_create_by_name(model, name):
  with db.session.no_autoflush:
    object = model.query.filter_by(name=name).one_or_none()
  if not object:
    object = model(name=name)
  return object
