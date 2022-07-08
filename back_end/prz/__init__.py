from config import Config
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()


def create_app(config_class=Config):
  app = Flask(__name__, instance_relative_config=True)
  app.config.from_object(config_class)

  db.init_app(app)
  with app.app_context():
    db.create_all()
  migrate.init_app(app, db)

  from prz.features.get_adoptable_pets import bp as pet_bp
  app.register_blueprint(pet_bp)

  from prz.features.auth import bp as auth_bp
  app.register_blueprint(auth_bp)

  from prz import models

  return app
