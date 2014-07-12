import os
import sys
from datetime import date, timedelta

from sqlalchemy import (
    Column,
    Index,
    Integer,
    Text,
    ForeignKey,
    String,
    Float,
    Date,
    Table
    )

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    backref,
    relationship
    )

from zope.sqlalchemy import ZopeTransactionExtension

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base()

class ProductHasFeature(Base):
    __tablename__ = 'product_has_feature'
    PRODUCT_ID = Column(Integer, ForeignKey('product.PID'), primary_key=True)
    FEATURE_ID = Column(Integer, ForeignKey('feature.FEATURE_ID'), primary_key=True)
    FEATURE_DISCRIPTION = Column(String(45))
    feature = relationship("Feature", backref="product_feature")

class OrderHasProduct(Base):
    __tablename__ = 'order_has_product'
    ORDER_ID = Column(Integer,  ForeignKey('order.ORDER_ID'), primary_key=True)
    PRODUCT_ID = Column(Integer, ForeignKey('product.PID'), primary_key=True)
    product = relationship("Product", backref="order_product")

user_has_role = Table('user_has_role', Base.metadata, 
    Column('user_UID', Integer, ForeignKey('user.UID')), 
    Column('role_ROLE_ID', Integer, ForeignKey('role.ROLE_ID'))
    )

class CartHasProduct(Base):
    __tablename__ = 'cart_has_product'
    cart_ID = Column(Integer, ForeignKey('cart.ID'), primary_key=True)
    PRODUCT_PID = Column(Integer, ForeignKey('product.PID'), primary_key=True)
    QUANTITY = Column(Integer)
    PRICE = Column(String(50))
    product_cart = relationship("Product", backref="cart_product")

class FeatureHasCategory(Base):
    __tablename__ = 'feature_has_category'
    FEATURE_ID = Column(Integer, ForeignKey('feature.FEATURE_ID'), primary_key=True)
    CATEGORY_CID = Column(Integer, ForeignKey('category.CID'), primary_key=True)

class User(Base):
    __tablename__ = 'user'
    UID = Column(Integer, primary_key=True)
    USER_NAME = Column(String(45))
    PASSWORD = Column(String(45))
    EMAIL_ID = Column(String(45))
    PHONE_NUMBER = Column(String(45))
    address_user = relationship("Address", backref="Address")
    role_user = relationship('Role', secondary=user_has_role, backref="Role")
    order_user = relationship('Order', backref='Order')
    review_user = relationship('Review', backref='Review')
    cart_user = relationship('Cart', backref='Cart')

    @classmethod
    def all_user(cls):
        return DBSession.query(User).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(User).filter(User.UID == id).first()

class Role(Base):
    __tablename__ = 'role'
    ROLE_ID = Column(Integer, primary_key=True)
    ROLE_NAME = Column(String(45))
    user_role = relationship('User', secondary=user_has_role, backref="User")

    @classmethod
    def all_role(cls):
        return DBSession.query(Role).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Role).filter(Role.ROLE_ID == id).first()


class Cart(Base):
    __tablename__ = 'cart'
    ID = Column(Integer, primary_key=True)
    TOTAL_COST = Column(Float)
    USER_ID = Column(Integer, ForeignKey('user.UID'))
    cart_product = relationship("CartHasProduct", backref="product")

class Complain(Base):
    __tablename__ = 'complain'
    COMPLAIN_ID = Column(Integer, primary_key=True)
    COMPLAIN_TEXT = Column(String(45))
    ORDER_ID = Column(Integer)

class Address_type(Base):
    __tablename__ = 'address_type'
    ADDRESS_TYPE_ID = Column(Integer, primary_key=True)
    TYPE = Column(String(45))

class Address(Base):
    __tablename__ = 'address'
    ADD_ID = Column(Integer, primary_key=True)
    LINE1 = Column(String(45))
    LINE2 = Column(String(45))
    LINE3 = Column(String(45))
    STREET = Column(String(45))
    CITY = Column(String(45))
    STATE = Column(String(45))
    ZIPCODE = Column(String(45))
    COUNTRY = Column(String(45))
    OTHER = Column(String(45))
    ADDRESS_TYPE_ID = Column(Integer, ForeignKey('address_type.ADDRESS_TYPE_ID'))
    user_UID = Column(Integer, ForeignKey('user.UID'))
    address_type = relationship('Address_type', backref='address_type')

    @classmethod
    def all_address(cls):
        return DBSession.query(Address).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Address).filter(Address.ADD_ID == id).first()

class Product(Base):
    __tablename__ = 'product'
    PID = Column(Integer, primary_key=True)
    PRICE = Column(Float)
    RELEASE_DATE = Column(Date)
    WARRANTY = Column(Date)
    QUANTITY = Column(Integer)
    BRAND_ID = Column(Integer, ForeignKey('brand.BRAND_ID'))   
    CATEGORY_CID = Column(Integer, ForeignKey('category.CID')) 
    PRODUCT_NAME = Column(String(45))
    product_feature = relationship("ProductHasFeature", backref="product")
    brand_product = relationship("Brand", backref="brand")
    category_product = relationship("Category", backref="category")


    @classmethod
    def all_product(cls):
        return DBSession.query(Product).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Product).filter(Product.PID == id).first()

    @classmethod
    def by_price(cls, price1, price2):
        ll = DBSession.query(Product).filter(Product.PRICE > price1, Product.PRICE < price2).all()
        return ll

    @classmethod
    def add(cls, product):
        DBSession.add(product)

    @classmethod
    def delete(cls, product):
        DBSession.delete(product)

class Order(Base):
    __tablename__ = 'order'
    ORDER_ID = Column(Integer, primary_key=True)
    PAYMENT_TYPE_ID = Column(Integer, ForeignKey('payment_type.PAYMENT_TYPE_ID'))
    SHIPPING_ADD_ID = Column(Integer)
    PAYMENT_ID = Column(Integer)
    USER_ID = Column(Integer, ForeignKey('user.UID')) 
    CART_ID = Column(Integer, ForeignKey('cart.ID'))
    ORDER_DATE = Column(Date)
    order_product = relationship("OrderHasProduct", backref="order")

    @classmethod
    def all_order(cls):
        return DBSession.query(Order).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Order).filter(Order.ORDER_ID == id).first()

    @classmethod
    def by_date_diff(cls, diff):
        sm_date = date.today() - timedelta(days=diff)
        bg_date = date.today()
        return DBSession.query(Order).filter(Order.ORDER_DATE.between(sm_date.strftime('%Y-%m-%d'), 
                                                                        bg_date.strftime('%Y-%m-%d'))).all()

    @classmethod
    def by_btwn_dates(cls, date1, date2):
        return DBSession.query(Order).filter(Order.DATE.between(date1, date2)).all()

    @classmethod
    def by_user_id(cls, UID):
        return DBSession.query(Order).filter(Order.USER_ID == UID).all()

class Feature(Base):
    __tablename__ = 'feature'
    FEATURE_ID = Column(Integer, primary_key=True)
    FEATURE_NAME = Column(String(45))
    
    @classmethod
    def all_feature(cls):
        return DBSession.query(Feature).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Feature).filter(Feature.FEATURE_ID == id).first()

    @classmethod
    def add(cls, feature):
        DBSession.add(feature)


class Payment(Base):
    __tablename__ = 'payment'
    PAYMENT_ID = Column(Integer, primary_key=True)
    BILLING_ADD_ID = Column(Integer, ForeignKey('address.ADD_ID'))
    AMOUNT_TO_BE_PAID = Column(Float)

    @classmethod
    def all_payment(cls):
        return DBSession.query(Payment).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Payment).filter(Payment.PAYMENT_ID == id).first()

class Brand(Base):
    __tablename__ = 'brand'
    BRAND_ID = Column(Integer, primary_key=True)
    BRAND_NAME = Column(String(45))

    @classmethod
    def all_brand(cls):
        return DBSession.query(Brand).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Brand).filter(Brand.BRAND_ID == id).first()

    @classmethod
    def add(cls, brand):
        DBSession.add(brand)

class Category(Base):
    __tablename__  = 'category'
    CID = Column(Integer, primary_key=True)
    CATEGORY_NAME = Column(String(45))
    product_category = relationship('Product', backref='product')

    @classmethod
    def all_category(cls):
        return DBSession.query(Category).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Category).filter(Category.CID == id).first()

class PaymentType(Base):
    __tablename__ = 'payment_type'
    PAYMENT_TYPE_ID = Column(Integer, primary_key=True)
    TYPE = Column(String(45))

    @classmethod
    def all_payment_type(cls):
        return DBSession.query(PaymentType).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(PaymentType).filter(PaymentType.PAYMENT_TYPE_ID == id).first()

class Status(Base):
    __tablename__ = 'status'
    ORDER_ID = Column(Integer, primary_key=True)
    LOCATION = Column(String(45))

    @classmethod
    def all_payment(cls):
        return DBSession.query(Status).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Status).filter(Status.ORDER_ID == id).first()

class Review(Base):
    __tablename__ = 'review'
    REVIEW_ID = Column(Integer, primary_key=True)
    RATING = Column(Integer)
    COMMENT = Column(String(45))
    PRODUCT_ID = Column(Integer, ForeignKey('product.PID'))
    USER_ID = Column(Integer, ForeignKey('user.UID'))
    REVIEW_DATE = Column(Date)

    @classmethod
    def all_review(cls):
        return DBSession.query(Review).all()

    @classmethod
    def by_id(cls, id):
        return DBSession.query(Review).filter(Review.REVIEW_ID == id).first()

    @classmethod
    def by_date_diff(cls, diff):
        sm_date = date.today() - timedelta(days=diff)
        bg_date = date.today()
        return DBSession.query(Review).filter(Review.REVIEW_DATE.between(sm_date.strftime('%Y-%m-%d'), 
                                                                        bg_date.strftime('%Y-%m-%d'))).all()

    @classmethod
    def by_btwn_dates(cls, date1, date2):
        return DBSession.query(Review).filter(Review.DATE.between(date1, date2)).all()

    @classmethod
    def by_user_id(cls, UID):
        return DBSession.query(Review).filter(Review.USER_ID == UID).all()