��    :      �              �     �  �   �     a  M   |     �     �     �  �     >   �  �   �  D   �     �     �  �        �     �     �  '   �  Z    �   a	     �	      
  V   
  �   ]
  
   &  �   1  t   �  W   /  F   �  P   �  �     e   �  �        �     �  
   �  .   �  �   �  T   �  �     2   �  �  �  `   �  r   "  �  �  p     �   �  J   C  �   �  W  �  �   �  �   �  �   $  @   �  �   �     �  b   �  x       �  �   �     9  M   T     �     �     �  �   �  >   �   �   �   D   n!     �!     �!  �   �!     {"     �"     �"  '   �"  Z  �"  �   9$     �$     �$  V   �$  �   5%  
   �%  �   	&  t   �&  W   '  F   _'  P   �'  �   �'  e   �(  �   �(     t)     �)  
   �)  .   �)  �   �)  T   �*  �   �*  2   t+  �  �+  `   �-  r   �-  �  m.  p   �0  �   f1  J   2  �   f2  W  a3  �   �4  �   d5  �   �5  @   �6  �   �6     �7  b   �7   :func:`.orm.defer` :func:`.orm.deferred` attributes which are marked with a "group" can be undeferred using :func:`.orm.undefer_group`, sending in the group name:: :func:`.orm.undefer_group` :func:`.orm.undefer_group` is now specific to a particiular entity load path. :func:`.orm.undefer` :ref:`deferred` :ref:`mapper_query_expression` A :class:`.Load` object that is present on a certain path can have :meth:`.Load.defer` called multiple times, each will operate on the same parent entity:: A result from the above bundle will return dictionary values:: An arbitrary set of columns can be selected as "load only" columns, which will be loaded while deferring all other columns on a given entity, using :func:`.orm.load_only`:: Apply an ad-hoc SQL expression to a "deferred expression" attribute. Attribute to be deferred. Attribute to be undeferred. Classical mappings as always place the usage of :func:`.orm.deferred` in the ``properties`` dictionary against the table-bound :class:`.Column`:: Column Bundles Column Deferral API Deferred Column Loading Deferred Loading with Multiple Entities Deferred columns can be associated with a "group" name, so that they load together when any of them are first accessed.  The example below defines a mapping with a ``photos`` deferred group.  When one ``.photo`` is accessed, all three photos will be loaded in one SELECT statement. The ``.excerpt`` will be loaded separately when it is accessed:: Deprecated; this option supports the old 0.8 style of specifying a path as a series of attributes, which is now superseded by the method-chained style. E.g.:: E.g:: Example - given a class ``User``, load only the ``name`` and ``fullname`` attributes:: Example - given a relationship ``User.addresses -> Address``, specify subquery loading for the ``User.addresses`` collection, but on each ``Address`` object load only the ``email_address`` attribute:: Examples:: For a :class:`.Query` that has multiple entities, the lead entity can be specifically referred to using the :class:`.Load` constructor:: In the case where the loading style of parent relationships should be left unchanged, use :func:`.orm.defaultload`:: Indicate a column-based mapped attribute that by default will not load unless accessed. Indicate an attribute that populates from a query-time SQL expression. Indicate that columns within the given deferred group name should be undeferred. Indicate that for a particular entity, only the given list of column-based attribute names should be loaded; all others will be deferred. Indicate that the given column-oriented attribute should be deferred, e.g. not loaded until accessed. Indicate that the given column-oriented attribute should be undeferred, e.g. specified within the SELECT statement of the entity as a whole. Load Only Cols Loading Columns Parameters SQL expression to be applied to the attribute. The :class:`.Bundle` construct is also integrated into the behavior of :func:`.composite`, where it is used to return composite attributes as objects when queried as individual attributes. The :class:`.Bundle` may be used to query for groups of columns under one namespace. The ``proc()`` callable passed to the ``create_row_processor()`` method of custom :class:`.Bundle` classes now accepts only a single "row" argument. The bundle allows columns to be grouped together:: The bundle can be subclassed to provide custom behaviors when results are fetched.  The method :meth:`.Bundle.create_row_processor` is given the :class:`.Query` and a set of "row processor" functions at query execution time; these processor functions when given a result row will return the individual attribute value, which can then be adapted into any kind of return data structure.  Below illustrates replacing the usual :class:`.KeyedTuple` return structure with a straight Python dictionary:: The column being undeferred is typically set up on the mapping as a :func:`.deferred` attribute. The columns being undeferred are set up on the mapping as :func:`.deferred` attributes and include a "group" name. This feature allows particular columns of a table be loaded only upon direct access, instead of when the entity is queried using :class:`.Query`.  This feature is useful when one wants to avoid loading a large text or binary field into memory when it's not needed. Individual columns can be lazy loaded by themselves or placed into groups that lazy-load together, using the :func:`.orm.deferred` function to mark them as "deferred". In the example below, we define a mapping that will load each of ``.excerpt`` and ``.photo`` in separate, individual-row SELECT statements when each attribute is first referenced on the individual object instance:: This function is part of the :class:`.Load` interface and supports both method-chained and standalone operation. This option is used in conjunction with the :func:`.orm.query_expression` mapper-level construct that indicates an attribute which should be the target of an ad-hoc SQL expression. This section presents additional options regarding the loading of columns. To specify a deferred load of an attribute on a related class, the path can be specified one token at a time, specifying the loading style for each link along the chain.  To leave the loading style for a link unchanged, use :func:`.orm.defaultload`:: To specify column deferral options along the path of various relationships, the options support chaining, where the loading style of each relationship is specified first, then is chained to the deferral options.  Such as, to load ``Book`` instances, then joined-eager-load the ``Author``, then apply deferral options to the ``Author`` entity:: To specify column deferral options within a :class:`.Query` that loads multiple types of entity, the :class:`.Load` object can specify which parent entity to start with:: To undefer a group of attributes on a related entity, the path can be spelled out using relationship loader options, such as :func:`.orm.defaultload`:: You can defer or undefer columns at the :class:`~sqlalchemy.orm.query.Query` level using options, including :func:`.orm.defer` and :func:`.orm.undefer`:: additional keyword arguments passed to :class:`.ColumnProperty`. columns to be mapped.  This is typically a single :class:`.Column` object, however a collection is supported in order to support multiple columns mapped under the same attribute. e.g.:: support for :class:`.Load` and other options which allow for better targeting of deferral options. Project-Id-Version: SQLAlchemy 1.3
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2019-02-21 14:32+0900
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ko
Language-Team: ko <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 :func:`.orm.defer` :func:`.orm.deferred` attributes which are marked with a "group" can be undeferred using :func:`.orm.undefer_group`, sending in the group name:: :func:`.orm.undefer_group` :func:`.orm.undefer_group` is now specific to a particiular entity load path. :func:`.orm.undefer` :ref:`deferred` :ref:`mapper_query_expression` A :class:`.Load` object that is present on a certain path can have :meth:`.Load.defer` called multiple times, each will operate on the same parent entity:: A result from the above bundle will return dictionary values:: An arbitrary set of columns can be selected as "load only" columns, which will be loaded while deferring all other columns on a given entity, using :func:`.orm.load_only`:: Apply an ad-hoc SQL expression to a "deferred expression" attribute. Attribute to be deferred. Attribute to be undeferred. Classical mappings as always place the usage of :func:`.orm.deferred` in the ``properties`` dictionary against the table-bound :class:`.Column`:: Column Bundles Column Deferral API Deferred Column Loading Deferred Loading with Multiple Entities Deferred columns can be associated with a "group" name, so that they load together when any of them are first accessed.  The example below defines a mapping with a ``photos`` deferred group.  When one ``.photo`` is accessed, all three photos will be loaded in one SELECT statement. The ``.excerpt`` will be loaded separately when it is accessed:: Deprecated; this option supports the old 0.8 style of specifying a path as a series of attributes, which is now superseded by the method-chained style. E.g.:: E.g:: Example - given a class ``User``, load only the ``name`` and ``fullname`` attributes:: Example - given a relationship ``User.addresses -> Address``, specify subquery loading for the ``User.addresses`` collection, but on each ``Address`` object load only the ``email_address`` attribute:: Examples:: For a :class:`.Query` that has multiple entities, the lead entity can be specifically referred to using the :class:`.Load` constructor:: In the case where the loading style of parent relationships should be left unchanged, use :func:`.orm.defaultload`:: Indicate a column-based mapped attribute that by default will not load unless accessed. Indicate an attribute that populates from a query-time SQL expression. Indicate that columns within the given deferred group name should be undeferred. Indicate that for a particular entity, only the given list of column-based attribute names should be loaded; all others will be deferred. Indicate that the given column-oriented attribute should be deferred, e.g. not loaded until accessed. Indicate that the given column-oriented attribute should be undeferred, e.g. specified within the SELECT statement of the entity as a whole. Load Only Cols Loading Columns Parameters SQL expression to be applied to the attribute. The :class:`.Bundle` construct is also integrated into the behavior of :func:`.composite`, where it is used to return composite attributes as objects when queried as individual attributes. The :class:`.Bundle` may be used to query for groups of columns under one namespace. The ``proc()`` callable passed to the ``create_row_processor()`` method of custom :class:`.Bundle` classes now accepts only a single "row" argument. The bundle allows columns to be grouped together:: The bundle can be subclassed to provide custom behaviors when results are fetched.  The method :meth:`.Bundle.create_row_processor` is given the :class:`.Query` and a set of "row processor" functions at query execution time; these processor functions when given a result row will return the individual attribute value, which can then be adapted into any kind of return data structure.  Below illustrates replacing the usual :class:`.KeyedTuple` return structure with a straight Python dictionary:: The column being undeferred is typically set up on the mapping as a :func:`.deferred` attribute. The columns being undeferred are set up on the mapping as :func:`.deferred` attributes and include a "group" name. This feature allows particular columns of a table be loaded only upon direct access, instead of when the entity is queried using :class:`.Query`.  This feature is useful when one wants to avoid loading a large text or binary field into memory when it's not needed. Individual columns can be lazy loaded by themselves or placed into groups that lazy-load together, using the :func:`.orm.deferred` function to mark them as "deferred". In the example below, we define a mapping that will load each of ``.excerpt`` and ``.photo`` in separate, individual-row SELECT statements when each attribute is first referenced on the individual object instance:: This function is part of the :class:`.Load` interface and supports both method-chained and standalone operation. This option is used in conjunction with the :func:`.orm.query_expression` mapper-level construct that indicates an attribute which should be the target of an ad-hoc SQL expression. This section presents additional options regarding the loading of columns. To specify a deferred load of an attribute on a related class, the path can be specified one token at a time, specifying the loading style for each link along the chain.  To leave the loading style for a link unchanged, use :func:`.orm.defaultload`:: To specify column deferral options along the path of various relationships, the options support chaining, where the loading style of each relationship is specified first, then is chained to the deferral options.  Such as, to load ``Book`` instances, then joined-eager-load the ``Author``, then apply deferral options to the ``Author`` entity:: To specify column deferral options within a :class:`.Query` that loads multiple types of entity, the :class:`.Load` object can specify which parent entity to start with:: To undefer a group of attributes on a related entity, the path can be spelled out using relationship loader options, such as :func:`.orm.defaultload`:: You can defer or undefer columns at the :class:`~sqlalchemy.orm.query.Query` level using options, including :func:`.orm.defer` and :func:`.orm.undefer`:: additional keyword arguments passed to :class:`.ColumnProperty`. columns to be mapped.  This is typically a single :class:`.Column` object, however a collection is supported in order to support multiple columns mapped under the same attribute. e.g.:: support for :class:`.Load` and other options which allow for better targeting of deferral options. 