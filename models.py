from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()                               # intializes the database

# todo: remake the schema (mySQL file) into sqlalchemy

# # example:
# class Userprofile(db.Model):
#     user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
#     user_name = db.Column(db.String(255), nullable=False, unique=True)
#     user_password = db.Column(db.String(255), nullable=False)

#     # print out userinformation
#     def __repr__(self):
#         return f'userprofile({self.user_id}, {self.user_name}, {self.user_password})'