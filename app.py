
from flask import Flask, redirect, render_template, request, abort, session
from flask_bcrypt import Bcrypt    
from dotenv import load_dotenv
import os
from models import db


app = Flask(__name__)
bcrypt = Bcrypt(app)                            # intialize instance to hash password
load_dotenv()                                   # loads infromation from .env file (personal to each user)

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('SQLALCHEMY_DATABASE_URI')        # sinks up database to the code
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

app.secret_key = os.getenve('SECRET_KEY')       # used to hash password

db.init_app(app)                                # intialize the database
