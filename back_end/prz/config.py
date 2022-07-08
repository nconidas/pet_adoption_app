from flask_sqlalchemy import SQLAlchemy
import os
import psycopg2
import sqlalchemy
from dotenv import load_dotenv

load_dotenv()


class Config:
  ANIMALS_PER_CATEGORY = 10
  SQLALCHEMY_TRACK_MODIFICATIONS = False

  PUBLIC_IP = os.getenv('PUBLIC_IP')
  DB_NAME = os.getenv('DB_NAME')
  DB_USERNAME = os.getenv('USER_NAME')
  DB_PASSWORD = os.getenv('DB_PASSWORD')
  PROJECT_ID = os.getenv('PROJECT_ID')
  INSTANCE_NAME = os.getenv('INSTANCE_NAME')
  SQLALCHEMY_DATABASE_URI = f"mysql+mysqldb://{DB_USERNAME}:{DB_PASSWORD}@{PUBLIC_IP}/{DB_NAME}?unix_socket=/cloudsql/{PROJECT_ID}:{INSTANCE_NAME}"
