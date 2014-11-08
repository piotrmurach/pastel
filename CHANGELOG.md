0.3.0 (November 8, 2014)

* Add ability to alias colors through alias_color method
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
