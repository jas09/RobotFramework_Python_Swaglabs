from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

from Products import Products


@library
class Overview(Products):
    def __init__(self):
        super().__init__()
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def verify_products_in_OverviewPage(self):
        selectedProducts = BuiltIn().get_variable_value("${selectedProducts}")
        overviewItems = self.seleniumLib.get_webelements("css:.inventory_item_name")
        overviewProductNames = [item.text for item in overviewItems]
        print(f"Cart items: {overviewProductNames}")
        print(f"Selected products: {selectedProducts}")
        missingItems = [product for product in selectedProducts if product not in overviewProductNames]
        extraItems = [product for product in overviewProductNames if product not in selectedProducts]

        if missingItems or extraItems:
            raise AssertionError(f"Overview page products verification failed.\nMissing: {missingItems}\nUnexpected: {extraItems}")
        else:
            print("✅ Overview page products verification successful. All products match.")