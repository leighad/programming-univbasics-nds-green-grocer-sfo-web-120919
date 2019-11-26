def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  i = 0 
  while i < collection.length do
    if collection[i][:item] == name 
      #check collection to be sure how to reference!
      return collection[i]
    end
  i += 1
  end
  nil
end  

def consolidate_cart(cart)
  # REMEMBER: Returns a new Array that represents the cart. Don't merely change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  whole_cart = []
  i = 0 
  while i < cart.length do
    cart_item = find_item_by_name_in_collection(cart[i][:item], whole_cart)
    
    if cart_item != nil 
      cart_item[:count] += 1 
    else
      cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
    whole_cart << cart_item
    end
  
  i += 1
  end
whole_cart
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
i = 0 
while i < coupons.length do
  
  cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  coupon_item = "#{coupons[i][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(coupon_item, cart)
  
  if cart_item && cart_item[:count] >= coupons[i][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[i][:num]
      cart_item[i] -= coupons[i][:num]
    else
      cart_item_with_coupon = {
        :item => coupon_item,
        :price => coupons[i][:cost] / coupons[i][:num],
        :count => coupons[i][:num],
        :clearance => cart_item[:clearance]
      }
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[i][:num]
    end
  end
  i += 1 
end 
cart
end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.2)).round(2)
    end
    i += 1 
  end
  cart
end

def checkout(cart, coupons)
  #  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have some irritated customers!
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0 
  i = 0 
  while i < final_cart.length do 
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1 
  end
  
  if total > 100
    total -= (total * 0.10).round(2)
  end
  
 total 
end





