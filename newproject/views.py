from pyramid.response import FileResponse
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError
from cornice import Service

from .models import (
    DBSession,
    Product,
    Feature,
    User,
    Role,
    Order,
    Review,
    Brand,
    Category
    )


@view_config(route_name="index", renderer='static/index.html', http_cache=3600)
def index_view(request):
    return {}

user = Service(name='user', path='/user', description="User", cors_origins=('*',))
@user.get()
def get_user(request):
	"""Returns the list of all the users"""
	user_list = User.all_user()
	dict_users = [{"id": item.UID, "name": item.USER_NAME} for item in user_list]
	return dict_users

brand = Service(name='brand', path='/brand', description="brand", cors_origins=('*',))
@brand.get()
def get_brand(request):
	"""Returns the list of all the brands"""
	brand_list = Brand.all_brand()
	dict_brands = [{"id": item.BRAND_ID, "name": item.BRAND_NAME} for item in brand_list]
	return dict_brands
	
show_user = Service(name='user_with_given_ID', path='/user/{UID}', description="User")

@show_user.get()
def get_userID(request):
	"""Returns the users detail given UID"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					'ID': user.UID,
					'name':user.USER_NAME,
					'email':user.EMAIL_ID,
					'phone':user.PHONE_NUMBER,
					'address_IDs':[item.ADD_ID for item in user.address_user]
				}

user_role = Service(name='user_role', path='/user/{UID}/role', description="Users role listed")
@user_role.get()
def get_users_role(request):
	"""List all the roles of a particualr user"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					"name":user.USER_NAME,
					"roles": [[role.ROLE_ID, role.ROLE_NAME] for role in user.role_user]
				}

user_address = Service(name='user_service', path='/user/{UID}/address', description="User address list")
@user_address.get()
def get_user_addresses(request):
	"""List all addresses of a particualr user"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					"name": user.USER_NAME,
					"addresses": [
									{ 
										'add_id': address.ADD_ID,
										'address_type':address.ADDRESS_TYPE_ID,
										'address_type_name':address.address_type.TYPE,  
										'line1':address.LINE1, 
										'line2': address.LINE2, 
										'street':address.STREET,
										'city':address.CITY,
										'state':address.STATE,
										'zipcode':address.ZIPCODE,
										'country':address.COUNTRY
									} 
									for address in user.address_user
								]	
				}

user_list_shipping_addr = Service(name='user_shipping_addr', path='/user/{UID}/shipping_addr', description='Lists all addresses of a type for a user')
@user_list_shipping_addr.get()
def get_user_list_shipping_addr(request):
	"""List all the adresses of given type of a particualr user"""
	user = User.by_id(request.matchdict['UID'])
	address_type = 1
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					'name': user.USER_NAME,
					'addr_type': address_type,
					'shipping_addr_list': [item.ADD_ID for item in user.address_user if item.ADDRESS_TYPE_ID == address_type]
				}

user_list_billing_addr = Service(name='user_billing_addr', path='/user/{UID}/billing_addr', description='Lists all addresses of a type for a user')
@user_list_billing_addr.get()
def get_user_list_billing_addr(request):
	"""List all the adresses of given type of a particualr user"""
	user = User.by_id(request.matchdict['UID'])
	address_type = 2
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					'name': user.USER_NAME,
					'addr_type': address_type,
					'billing_addr_list': [item.ADD_ID for item in user.address_user if item.ADDRESS_TYPE_ID == address_type]
				}

user_order_list = Service(name='user_order_list', path='/user/{UID}/order', description="All the orders by user")
@user_order_list.get()
def get_user_order_list(request):
	"""List all the orders by UID"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					"name":user.USER_NAME,
					"orders": [{"order_id": order.ORDER_ID, "shipping_addr": order.SHIPPING_ADD_ID, "cart_id": order.CART_ID} for order in user.order_user]
				}

user_review_list = Service(name='user_review_list', path='/user/{UID}/review', description="All the orders by user")
@user_review_list.get()
def get_user_review_list(request):
	"""List all the reviews by UID"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					"name":user.USER_NAME,
					"reviews": [{
									"id": review.REVIEW_ID, 
									"rating": review.RATING, 
									"comment":review.COMMENT, 
									"product_id": review.PRODUCT_ID, 
									"review_id": review.USER_ID
								} for review in user.review_user]
				}		

user_cart_list = Service(name='user_cart_list', path='/user/{UID}/cart', description="user_cart_list")
@user_cart_list.get()
def get_user_cart_list(request):
	"""List all the cart of UID"""
	user = User.by_id(request.matchdict['UID'])
	if user == None:
		user_list = User.all_user()
		dict_users = [(item.UID, item.USER_NAME) for item in user_list]
		return dict(dict_users)
	else:
		return {
					"name":user.USER_NAME,
					"carts": [	{
									"Cart_id": cart.ID, 
									"total_cost": cart.TOTAL_COST, 
									"user_id": cart.USER_ID
								} 
								for cart in user.cart_user]
				}

roles = Service(name='roles', path='/role', description="roles")
@roles.get()
def roles_get(request):
	"""List of roles"""
	list_roles = Role.all_role()
	dict_roles = [(item.ROLE_ID, item.ROLE_NAME) for item in list_roles]
	return dict(dict_roles)

role = Service(name='role', path='/role/{role_id}', description='role')
@role.get()
def get_user_role(request):
	"""List user with given role_id"""
	role = Role.by_id(request.matchdict['role_id'])
	if role == None:
		role_list = Role.all_role()
		dict_roles = [(item.ROLE_ID, item.ROLE_NAME) for item in list_roles]
		return dict(dict_roles)
	else:
		return {
					"role_id": role.ROLE_ID,
					'role_name': role.ROLE_NAME,
					"users": [{user.UID: user.USER_NAME} for user in role.user_role]

				}

orders = Service(name='order', path='/order', description='order')
@orders.get()
def get_orders(request):
	"""List all the orders by all the users"""
	list_order = Order.all_order()
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order

orders_lastWeek = Service(name='orders_lastWeek', path='/order/lastweek', description='orders_lastWeek')
@orders_lastWeek.get()
def get_order_lastweek(request):
	list_order = Order.by_date_diff(7)
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order

orders_lastmonth = Service(name='orders_lastmonth', path='/order/lastmonth', description='orders_lastmonth')
@orders_lastmonth.get()
def get_order_lastmonth(request):
	list_order = Order.by_date_diff(30)
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order


orders_lastyear = Service(name='orders_lastyear', path='/order/lastyear', description='orders_lastyear')
@orders_lastyear.get()
def get_order_lastyear(request):
	list_order = Order.by_date_diff(365)
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order

order_btwn_dates = Service(name='order_btwn_dates', path='/order?from={date1}&to={date2}', description="order_btwn_dates")
@order_btwn_dates.get()
def get_order_btwn_dates(request):
	list_order = Order.by_btwn_dates(request.matchdict['date1'], request['date2'])
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order

order_by_user = Service(name='order_by_user', path='/order/user/{UID}', description='order_by_user')
@order_by_user.get()
def get_order_by_user(request):
	list_order = Order.by_user_id(request.matchdict['UID'])
	dict_order = [{	
					"order_id": item.ORDER_ID,	
					"user_id": item.USER_ID, 
					"cart_id":	item.CART_ID, 
					"payment_id": item.PAYMENT_ID
				  }
				for item in list_order]
	return dict_order

order_by_order_id = Service(name='order_by_order_id', path='/order/{order_id}')
@order_by_order_id.get()
def get_order_by_order_id(request):
	order = Order.by_id(request.matchdict['order_id'])
	dict_order = {
					"order_id": order.ORDER_ID,	
					"user_id": order.USER_ID, 
					"cart_id":	order.CART_ID, 
					"payment_id": order.PAYMENT_ID,
					"products": [product.PRODUCT_ID for product in order.order_product]
				  }
	return dict_order

review = Service(name='review', path='/review', description='review')
@review.get()
def get_review(request):
	list_review = Review.all_review()
	dict_review = [{
					 "review_id": item.REVIEW_ID,
					 "user_id": item.USER_ID,
					 "product_id": item.PRODUCT_ID,
					 "comment": item.COMMENT,	
					} 
					for item in list_review]
	return dict_review


review_lastWeek = Service(name='review_lastWeek', path='review/lastweek', description='review_lastWeek')
@review_lastWeek.get()
def get_review_lastweek(request):
	list_review = Review.by_date_diff(7)
	dict_review = [{	
					"review_id": item.REVIEW_ID,	
					"user_id": item.USER_ID, 
					"product_id":item.PRODUCT_ID, 
					"rating_id": item.RATING,
					"comment": item.COMMENT,
				  }
				for item in list_review ]
	return dict_review

reviews_lastmonth = Service(name='reviews_lastmonth', path='/review/lastmonth', description='reviews_lastmonth')
@reviews_lastmonth.get()
def get_review_lastmonth(request):
	list_review = Review.by_date_diff(30)
	dict_review = [{	
					"review_id": item.REVIEW_ID,	
					"user_id": item.USER_ID, 
					"product_id":item.PRODUCT_ID, 
					"rating_id": item.RATING,
					"comment": item.COMMENT,
				  }
				for item in list_review]
	return dict_review


reviews_lastyear = Service(name='reviews_lastyear', path='/review/lastyear', description='reviews_lastyear')
@reviews_lastyear.get()
def get_review_lastyear(request):
	list_review = Review.by_date_diff(365)
	dict_review = [{	
					"review_id": item.REVIEW_ID,	
					"user_id": item.USER_ID, 
					"product_id":item.PRODUCT_ID, 
					"rating_id": item.RATING,
					"comment": item.COMMENT,
				  }
				for item in list_review]
	return dict_review

review_btwn_dates = Service(name='review_btwn_dates', path='/review?from={date1}&to={date2}', description="review_btwn_dates")
@review_btwn_dates.get()
def get_review_btwn_dates(request):
	list_review = Review.by_btwn_dates(request.matchdict['date1'], request['date2'])
	dict_review = [{	
					"review_id": item.REVIEW_ID,	
					"user_id": item.USER_ID, 
					"product_id":item.PRODUCT_ID, 
					"rating_id": item.RATING,
					"comment": item.COMMENT,
				  }
				for item in list_review]
	return dict_review

review_by_user = Service(name='review_by_user', path='/review/user/{UID}', description='review_by_user')
@review_by_user.get()
def get_review_by_user(request):
	list_review = Review.by_user_id(request.matchdict['UID'])
	dict_review = [{	
					"review_id": item.REVIEW_ID,	
					"user_id": item.USER_ID, 
					"product_id":item.PRODUCT_ID, 
					"rating_id": item.RATING,
					"comment": item.COMMENT,
				  }
				for item in list_review]
	return dict_review

review_by_review_id = Service(name='review_by_review_id', path='/review/{review_id}')
@review_by_review_id.get()
def get_order_by_review_id(request):
	review = Review.by_id(request.matchdict['review_id'])
	dict_review = {
					"review_id": review.REVIEW_ID,	
					"user_id": review.USER_ID, 
					"product_id":review.PRODUCT_ID, 
					"rating_id": review.RATING,
					"comment": review.COMMENT,
				  }
	return dict_review

product_by_price = Service(name='product_by_price', path='/price+from={p1}&to={p2}', description='product_by_price')
@product_by_price.get()
def get_product_by_price(request):
	product_list = Product.by_price(float(request.matchdict['p1']), float(request.matchdict['p2']))
	product_dict = [{
						"id":item.PID, 
    					"name": item.PRODUCT_NAME, 
    					"price": item.PRICE, 
    					"brand_id": item.BRAND_ID,
    					"brand": item.brand_product.BRAND_NAME,
    					"warranty": item.WARRANTY,
    					"quantity": item.QUANTITY,
    					"release_date": item.RELEASE_DATE,
    					"category_id": item.CATEGORY_CID
					} for item in product_list]
	return product_dict


product = Service(name='product', path='/product', description="Product", cors_origins=('*',))
@product.get()
def get_products(request):
    """Returns list of all the products"""
    list_product = Product.all_product()
    dict_product = [{	
    					"id":item.PID, 
    					"name": item.PRODUCT_NAME, 
    					"price": item.PRICE, 
    					"brand_id": item.BRAND_ID,
    					"brand": item.brand_product.BRAND_NAME,
    					"warranty": item.WARRANTY,
    					"quantity": item.QUANTITY,
    					"release_date": item.RELEASE_DATE,
    					"category_id": item.CATEGORY_CID
    				} for item in list_product]
    return dict_product

add_product = Service(name='add_product', path='/add/product', description="add_Product", cors_origins=('*',))
@add_product.post()
def post_product(request):
	name = request.json_body['name']
	brand_id = request.json_body['brand_id']
	price = request.json_body['price']
	warranty = request.json_body['warranty']
	quantity = request.json_body['quantity']
	category_id = request.json_body['category']

	product = Product(PRICE=price, QUANTITY=quantity, BRAND_ID=brand_id, CATEGORY_CID=category_id, PRODUCT_NAME=name)
	print 'haaaaaaaaaaaaaaaaa', product
	Product.add(product)

add_brand = Service(name="add_brand", path="/add/brand", description="add_brand", cors_origins=('*',))
@add_brand.post()
def post_brand(request):
	print request.json_body
	name = request.json_body

	brand = Brand(BRAND_NAME=name['name'])
	Brand.add(brand)

add_category = Service(name="add_category", path="/add/category", description="add_category", cors_origins=('*',))
@add_category.post()
def post_category(request):
	print request.json_body
	name = request.json_body

	category = Category(CATEGORY_NAME=name['name'])
	Brand.add(category)


add_feature = Service(name="add_feature", path="/add/feature", description="add_feature", cors_origins=('*',))
@add_feature.post()
def post_feature(request):
	print request.json_body
	name = request.json_body

	feature = Feature(FEATURE_NAME=name['name'])
	Feature.add(feature)

edit_product = Service(name="edit_product", path="/edit/product/{product_id}", description='edit_product')
@edit_product.put()
def post_edit_product(request):
	product = Product.by_id(request.matchdict['product_id'])
	product.PRODUCT_NAME = request.json_body['name'].encode('utf-8')
	product.BRAND_ID = request.json_body['brand_id']
	product.PRICE = request.json_body['price']
	product.WARRANTY = request.json_body['warranty']
	product.QUANTITY = request.json_body['quantity']
	product.CATEGORY_CID = request.json_body['category']

	Product.add(product)

delete_product = Service(name="delete_product", path="/delete/product/{product_id}", description="delete_product")
@delete_product.delete()
def delete_product_1(request):
	product = Product.by_id(request.matchdict['product_id'])
	Product.delete(product)

single_product = Service(name='single_product', path='/product/{product_id}', description="Representation of single product")
@single_product.get()
def get_single_product(request):
	"""Returns the representation of requested product"""
	requested_product_id = request.matchdict['product_id']
	get_product_from_db = DBSession.query(Product).filter_by(PID=requested_product_id).all()
	return {
				'name': get_product_from_db[0].PRODUCT_NAME, 
				'release_date': get_product_from_db[0].RELEASE_DATE, 
				'warranty': get_product_from_db[0].WARRANTY,
				'quantity': get_product_from_db[0].QUANTITY,
				'price': get_product_from_db[0].PRICE,
			}

feature = Service(name='feature', path='/feature', description='feature', cors_origins=('*',))

@feature.get()
def get_feature(request):
	"""Return list of all the features"""
	list_feature = Feature.all_feature()
	dict_feature = [{"feature_id": item.FEATURE_ID, "feature_name": item.FEATURE_NAME} for item in list_feature]

	return dict_feature
 
category = Service(name='category', path='/category', description='category', cors_origins=('*',))

@category.get()
def get_category(request):
	"""Return list of all the categorys"""
	list_category = Category.all_category()
	dict_category = [{"id": item.CID, "name": item.CATEGORY_NAME} for item in list_category]

	return dict_category

product_with_category = Service(name='product_with_category', path='/category/{category_id}', description='category of product')
@product_with_category.get()
def get_product_with_category(request):
	"""List all the product with requestes category"""
	category_id = request.matchdict['category_id']
	category = Category.by_id(category_id)
	product_dict = [{
						"id":item.PID, 
    					"name": item.PRODUCT_NAME, 
    					"price": item.PRICE, 
    					"brand_id": item.BRAND_ID,
    					"brand": item.brand_product.BRAND_NAME,
    					"warranty": item.WARRANTY,
    					"quantity": item.QUANTITY,
    					"release_date": item.RELEASE_DATE,
    					"category_id": item.CATEGORY_CID,
    					"category_name": category.CATEGORY_NAME
	} for item in category.product_category]
	return product_dict
	
product_with_feature = Service(name='product_with_feature', path='/feature/{feature_id}', description='feature of product')

@product_with_feature.get()
def get_product_with_feature(request):
	"""List all the products with requested feature"""
	feature_id = request.matchdict['feature_id']
	feature = Feature.by_id(feature_id)
	product_dict = []
	for product_feature in feature.product_feature:
		item = product_feature.product
		product_dict.append({
										"id":item.PID, 
				    					"name": item.PRODUCT_NAME, 
				    					"price": item.PRICE, 
				    					"brand_id": item.BRAND_ID,
				    					"brand": item.brand_product.BRAND_NAME,
				    					"warranty": item.WARRANTY,
				    					"quantity": item.QUANTITY,
				    					"release_date": item.RELEASE_DATE,
				    					"category_id": item.CATEGORY_CID,
				    					"feature_name": product_feature.FEATURE_DISCRIPTION
									})
	return product_dict



