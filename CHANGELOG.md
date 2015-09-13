0.5.0 (Sept 13, 2015)

* Add external dependency to check for color support
* Add ability to check for ansi string
* Add ability to extract colors from string
* Add eachline option to allow coloring of multiline strings
* Fix redefining inspect method

0.4.0 (November 22, 2014)

* Fix Delegator#respond_to method to correctly report existence of methods
* Add ability to #detach color combination for later reuse
* Add ability to nest styles with blocks

0.3.0 (November 8, 2014)

* Add ability to alias colors through #alias_color method
* Add ability to alias colors through the environment variable
* Improve performance of Pastel::Color styles and lookup methods
* Fix bug concerned with lack of escaping for nested styles

0.2.1 (October 13, 2014)

* Fix issue #1 with unitialize dependency

0.2.0 (October 12, 2014)

* Change gemspec to include equatable as dependency
* Add #supports? to Color to check for terminal color support
* Add ability to force color support through :enabled option
* Change Delegator to stop creating instances and improve performance
