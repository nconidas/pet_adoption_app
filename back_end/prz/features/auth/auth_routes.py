from prz.features.auth import bp


@bp.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    """ Get a User. """
    pass


@bp.route('/users/<int:id>', methods=['POST'])
def create_user(id):
    """ Create a new User. """
    pass


@bp.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    """ Modify an existing user. """
    pass


@bp.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    """ Delete an existing user. """
    pass
