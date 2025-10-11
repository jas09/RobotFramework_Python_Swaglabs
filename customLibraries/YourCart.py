from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn

from Products import Products


@library
class YourCart(Products):
    def __init__(self):
        super().__init__()
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def verify_products_in_yourCart(self):
        selectedProducts = BuiltIn().get_variable_value("${selectedProducts}")
        cartItems = self.seleniumLib.get_webelements("css:.inventory_item_name")
        cartProductNames = [item.text for item in cartItems]
        print(f"Cart items: {cartProductNames}")
        print(f"Selected products: {selectedProducts}")
        missingItems = [product for product in selectedProducts if product not in cartProductNames]
        extraItems = [product for product in cartProductNames if product not in selectedProducts]

        if missingItems or extraItems:
            raise AssertionError(f"Cart verification failed.\nMissing: {missingItems}\nUnexpected: {extraItems}")
        else:
            print("✅ Cart verification successful. All products match.")





