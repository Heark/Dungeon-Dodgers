
=begin  
		Bazaar System by Heark
		GameJolt Addon
=end
$refund = 0.75
module Bazaar
	def self.stringToArray(aString)
		return aString.tr('[]','').split(',').map{|e|e.to_i}
	end

	$Bazaar_Items = []
	$Bazaar_Items_array = stringToArray($bazaar_items.to_s)
	$Bazaar_Weapons = []
	$Bazaar_Weapons_array = stringToArray($bazaar_weapons.to_s)
	$Bazaar_Armors = []
	$Bazaar_Armors_array = stringToArray($bazaar_armors.to_s)
	def self.SellItem(id)
		$bazaar_items = GameJolt.get_server("bazaar_items")
		$Bazaar_Items_array = stringToArray($bazaar_items.to_s)
		$Bazaar_Items_array.push(id)
		GameJolt.send_server("bazaar_items", $Bazaar_Items_array.to_s)
		puts "Successfully sent to Bazaar!"
		$game_party.lose_item($data_items[id], 1)
		amount = $data_items[id].price * $refund
		$game_party.gain_gold(amount)
	end
	def self.SellWeapon(id)
		$bazaar_weapons = GameJolt.get_server("bazaar_weapons")
		$Bazaar_Weapons_array = stringToArray($bazaar_weapons.to_s)
		$Bazaar_Weapons_array.push(id)
		GameJolt.send_server("bazaar_weapons", $Bazaar_Weapons_array.to_s)
		puts "Successfully sent to Bazaar!"
		$game_party.lose_item($data_weapons[id], 1)
		amount = $data_weapons[id].price * $refund
		$game_party.gain_gold(amount)  
	end
	def self.SellArmor(id)
		$bazaar_armors = GameJolt.get_server("bazaar_armors")
		$Bazaar_Armors_array = stringToArray($bazaar_armors.to_s)
		$Bazaar_Armors_array.push(id)
		GameJolt.send_server("bazaar_armors", $Bazaar_Armors_array.to_s)
		puts "Successfully sent to Bazaar!"
		$game_party.lose_item($data_armors[id], 1)
		amount = $data_armors[id].price * $refund
		$game_party.gain_gold(amount)  
	end

	def self.ItemsShop()
		$bazaar_items = GameJolt.get_server("bazaar_items")
		$Bazaar_Items_array.each do |i|
			instance_variable_set("@Array_#{i}", Array.new) 
			instance_variable_get("@Array_#{i}").push(0)
			instance_variable_get("@Array_#{i}").push($data_items[i].id)
			instance_variable_get("@Array_#{i}").push(0)
			$Bazaar_Items.push(instance_variable_get("@Array_#{i}"))
		end
		SceneManager.call(Scene_Shop)
		SceneManager.scene.prepare($Bazaar_Items, true)
	end


	def self.WeaponsShop()
		$bazaar_weapons = GameJolt.get_server("bazaar_weapons")
		$Bazaar_Weapons_array.each do |i|
			instance_variable_set("@W_Array_#{i}", Array.new) 
			instance_variable_get("@W_Array_#{i}").push(1)
			instance_variable_get("@W_Array_#{i}").push($data_weapons[i].id)
			instance_variable_get("@W_Array_#{i}").push(0)
			Bazaar_Items.push(instance_variable_get("@W_Array_#{i}"))
		end
		SceneManager.call(Scene_Shop)
		SceneManager.scene.prepare($Bazaar_Weapons, true)
	end
	def self.ArmorShop()
		$bazaar_armors = GameJolt.get_server("bazaar_armors")
		$Bazaar_Armors_array.each do |i|
			instance_variable_set("@A_Array_#{i}", Array.new) 
			instance_variable_get("@A_Array_#{i}").push(2)
			instance_variable_get("@A_Array_#{i}").push($data_armors[i].id)
			instance_variable_get("@A_Array_#{i}").push(0)
			Bazaar_Armors.push(instance_variable_get("@A_Array_#{i}"))
		end
		SceneManager.call(Scene_Shop)
		SceneManager.scene.prepare($Bazaar_Armors, true)
	end
end
