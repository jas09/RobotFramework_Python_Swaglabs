from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Products:

    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")
        self.selectedProducts = []

    @keyword
    def add_products_to_cart_and_checkout(self, productsList):
        BuiltIn().set_global_variable("${selectedProducts}",productsList)
        i = 1
        productTitles = self.seleniumLib.get_webelements("css:.inventory_item_name")
        for productTitle in productTitles:
            if productTitle.text in productsList:
                self.seleniumLib.click_button("xpath:(//*[@class='pricebar'])["+str(i)+"]/button")
            i = i + 1
        self.seleniumLib.click_element("xpath://a[@href='./cart.html']")