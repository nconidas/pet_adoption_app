import resource

_PETS_PER_CATEGORY = 10


class RandomizedHomePageMixin(object):
  @staticmethod
  def to_category_list(query):
    data, category = [], []
    resources = query.all()

    for i, item in enumerate(resources):
      category.append(item.to_dict())
      if i % _PETS_PER_CATEGORY == _PETS_PER_CATEGORY - 1:
        data.append({
            'items': category,
            'category': str(i // 10),
            '_meta': {},
            '_links': {}
        })
        category = []
    return data


class ConverterMixin(object):
  def _base_to_dict(self) -> dict:
    """ Creates a dict of the class' non relational attributes.

    Returns:
        dict: A dict with column name key and column value value.
    """

    _dict = {}
    for col in self.__table__.columns:
      _dict[col.name] = getattr(self, col.name)
    return _dict
