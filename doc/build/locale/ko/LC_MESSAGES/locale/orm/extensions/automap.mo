��    e      D              l  s  m  �  �  �   }
  �   )     �  �   �  z   q  k   �     X  �  f    d  �  g  $   L  �   q  t     �   {  }   �  �   {  �   \  <   �  =  #  (  a     �  #   �  	   �  �   �  A  i     �  �   �  Z   �  �   �  �   �  U   =  -   �      �  �  �  �   g!  	  "  '  #  o  7$  �   �%  .  �&     �(  �  �(  �   �*     >+  
   X+  #   c+  Z  �+     �,     �,  m   -  p   �-  E   �-     =.     E.    c.  P  j/  ,  �1  H  �2  T  14     �5  ;   �5  �   �5  �  q6  �   k8  P  D9  �   �:  �   4;  �   <  {   �<  (   7=  ?  `=  @   �>    �>  $  �?  �   A     �A  W  �A  B   C  �   FC  �   D  �   �D     xE  �   �E  �   �F  Z  +G  ~   �H  L   I  #   RI  P   vI  D   �I  2   J  X   ?J  "   �J  �   �J  �   QK  )   3L  -   ]L  �  �L  x  N  s  �O  �  �P  �   �S  �   GT     �T  �   U  z   �U  k   
V     vV  �  �V    �Y  �  �Z  $   j\  �   �\  t   $]  �   �]  }   ^  �   �^  �   z_  <   `  =  A`  (  a     �b  #   �b  	   �b  �   �b  A  �c     �d  �   �d  Z   �e  �   f  �   �f  U   [g  -   �g      �g  �   h  �   �j  	  #k  '  -l  o  Um  �   �n  .  �o     �q  �  �q  �   �s     \t  
   vt  #   �t  Z  �t      v     v  m   6v  p   �v  E   w     [w     cw    �w  P  �x  ,  �z  H  |  T  O}     �~  ;   �~  �      �  �  �   ��  P  b�  �   ��  �   R�  �   .�  {   م  (   U�  ?  ~�  @   ��    ��  $  �  �   2�     ��  W  Ɋ  B   !�  �   d�  �   #�  �   ��     ��  �   �  �   ��  Z  I�  ~   ��  L   #�  #   p�  P   ��  D   �  2   *�  X   ]�  "   ��  �   ٓ  �   o�  )   Q�  -   {�  �  ��   - automap will detect non-nullable foreign key constraints when producing a one-to-many relationship and establish a default cascade of ``all, delete-orphan`` if so; additionally, if the constraint specifies :paramref:`.ForeignKeyConstraint.ondelete` of ``CASCADE`` for non-nullable or ``SET NULL`` for nullable columns, the ``passive_deletes=True`` option is also added. :mod:`.sqlalchemy.ext.automap` is tasked with producing mapped classes and relationship names based on a schema, which means it has decision points in how these names are determined.  These three decision points are provided using functions which can be passed to the :meth:`.AutomapBase.prepare` method, and are known as :func:`.classname_for_table`, :func:`.name_for_scalar_relationship`, and :func:`.name_for_collection_relationship`.  Any or all of these functions are provided as in the example below, where we use a "camel case" scheme for class names and a "pluralizer" for collection names using the `Inflect <https://pypi.python.org/pypi/inflect>`_ package:: :mod:`.sqlalchemy.ext.automap` will generate many-to-many relationships, e.g. those which contain a ``secondary`` argument.  The process for producing these is as follows: :mod:`.sqlalchemy.ext.automap` will not generate any relationships between two classes that are in an inheritance relationship.   That is, with two classes given as follows:: :ref:`automap_toplevel` A given :class:`.Table` is examined for :class:`.ForeignKeyConstraint` objects, before any mapped class has been assigned to it. A given :class:`.Table`, known to be mapped to a particular class, is examined for :class:`.ForeignKeyConstraint` objects. A new subclassable :class:`.AutomapBase` is typically instantated using the :func:`.automap_base` function. API Reference Above, calling :meth:`.AutomapBase.prepare` while passing along the :paramref:`.AutomapBase.prepare.reflect` parameter indicates that the :meth:`.MetaData.reflect` method will be called on this declarative base classes' :class:`.MetaData` collection; then, each **viable** :class:`.Table` within the :class:`.MetaData` will get a new mapped class generated automatically.  The :class:`.ForeignKeyConstraint` objects which link the various tables together will be used to produce new, bidirectional :func:`.relationship` objects between classes.   The classes and relationships follow along a default naming scheme that we can customize.  At this point, our basic mapping consisting of related ``User`` and ``Address`` classes is ready to use in the traditional way. Above, given mostly complete ``User`` and ``Address`` mappings, the :class:`.ForeignKey` which we defined on ``Address.user_id`` allowed a bidirectional relationship pair ``Address.user`` and ``User.address_collection`` to be generated on the mapped classes. Above, one of the more intricate details is that we illustrated overriding one of the :func:`.relationship` objects that automap would have created. To do this, we needed to make sure the names match up with what automap would normally generate, in that the relationship name would be ``User.address_collection`` and the name of the class referred to, from automap's perspective, is called ``address``, even though we are referring to it as ``Address`` within our usage of this class. Added :mod:`sqlalchemy.ext.automap`. All parameters other than ``declarative_base`` are keyword arguments that are passed directly to the :func:`.declarative.declarative_base` function. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.classname_for_table` parameter. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.name_for_collection_relationship` parameter. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.name_for_scalar_relationship` parameter. Alternatively, we can change the name on the column side.   The columns that are mapped can be modified using the technique described at :ref:`mapper_column_distinct_names`, by assigning the column explicitly to a new name:: An alternate implementation of this function can be specified using the :paramref:`.AutomapBase.prepare.generate_relationship` parameter. An instance of :class:`.util.Properties` containing classes. As noted previously, automap has no dependency on reflection, and can make use of any collection of :class:`.Table` objects within a :class:`.MetaData` collection.  From this, it follows that automap can also be used generate missing relationships given an otherwise complete model that fully defines table metadata:: As the :class:`.ForeignKeyConstraint` we are examining corresponds to a reference from the immediate mapped class,  the relationship will be set up as a many-to-one referring to the referred class; a corresponding one-to-many backref will be created on the referred class referring to this class. Automap Base class for an "automap" schema. Basic Use Below is an illustration of how to send :paramref:`.relationship.cascade` and :paramref:`.relationship.passive_deletes` options along to all one-to-many relationships:: By **viable**, we mean that for a table to be mapped, it must specify a primary key.  Additionally, if the table is detected as being a pure association table between two other tables, it will not be directly mapped and will instead be configured as a many-to-many table between the mappings for the two referring tables. Custom Relationship Arguments Define an extension to the :mod:`sqlalchemy.ext.declarative` system which automatically generates mapped classes and relationships from a database schema, typically though not necessarily one which is reflected. Extract mapped classes and relationships from the :class:`.MetaData` and perform mappings. From each :class:`.ForeignKeyConstraint`, the remote :class:`.Table` object present is matched up to the class to which it is to be mapped, if any, else it is skipped. From the above mapping, we would now have classes ``User`` and ``Address``, where the collection from ``User`` to ``Address`` is called ``User.addresses``:: Generate a :func:`.relationship` or :func:`.backref` on behalf of two mapped classes. Generating Mappings from an Existing MetaData Handling Simple Naming Conflicts If any of the columns that are part of the :class:`.ForeignKeyConstraint` are not nullable (e.g. ``nullable=False``), a :paramref:`~.relationship.cascade` keyword argument of ``all, delete-orphan`` will be added to the keyword arguments to be passed to the relationship or backref.  If the :class:`.ForeignKeyConstraint` reports that :paramref:`.ForeignKeyConstraint.ondelete` is set to ``CASCADE`` for a not null or ``SET NULL`` for a nullable set of columns, the option :paramref:`~.relationship.passive_deletes` flag is set to ``True`` in the set of relationship keyword arguments. Note that not all backends support reflection of ON DELETE. If mapped classes for both sides are located, a many-to-many bi-directional :func:`.relationship` / :func:`.backref` pair is created between the two classes. If the table contains two and exactly two :class:`.ForeignKeyConstraint` objects, and all columns within this table are members of these two :class:`.ForeignKeyConstraint` objects, the table is assumed to be a "secondary" table, and will **not be mapped directly**. In Python 2, the string used for the class name **must** be a non-Unicode object, e.g. a ``str()`` object.  The ``.name`` attribute of :class:`.Table` is typically a Python unicode subclass, so the ``str()`` function should be applied to this name, after accounting for any non-ASCII characters. In the case of naming conflicts during mapping, override any of :func:`.classname_for_table`, :func:`.name_for_scalar_relationship`, and :func:`.name_for_collection_relationship` as needed.  For example, if automap is attempting to name a many-to-one relationship the same as an existing column, an alternate convention can be conditionally selected.  Given a schema: In the usual case where no relationship is on either side, :meth:`.AutomapBase.prepare` produces a :func:`.relationship` on the "many-to-one" side and matches it to the other using the :paramref:`.relationship.backref` parameter. It is hoped that the :class:`.AutomapBase` system provides a quick and modernized solution to the problem that the very famous `SQLSoup <https://sqlsoup.readthedocs.io/en/latest/>`_ also tries to solve, that of generating a quick and rudimentary object model from an existing database on the fly.  By addressing the issue strictly at the mapper configuration level, and integrating fully with existing Declarative class techniques, :class:`.AutomapBase` seeks to provide a well-integrated approach to the issue of expediently auto-generating ad-hoc mappings. Many-to-Many relationships Note that this means automap will not generate *any* relationships for foreign keys that link from a subclass to a superclass.  If a mapping has actual relationships from subclass to superclass as well, those need to be explicit.  Below, as we have two separate foreign keys from ``Engineer`` to ``Employee``, we need to set up both the relationship we want as well as the ``inherit_condition``, as these are not things SQLAlchemy can guess:: Note that when subclassing :class:`.AutomapBase`, the :meth:`.AutomapBase.prepare` method is required; if not called, the classes we've declared are in an un-mapped state. Overriding Naming Schemes Parameters Produce a declarative automap base. Production of the :func:`.relationship` and optionally the :func:`.backref` is handed off to the :paramref:`.AutomapBase.prepare.generate_relationship` function, which can be supplied by the end-user in order to augment the arguments passed to :func:`.relationship` or :func:`.backref` or to make use of custom implementations of these functions. Relationship Detection Relationships with Inheritance Return the attribute name that should be used to refer from one class to another, for a collection reference. Return the attribute name that should be used to refer from one class to another, for a scalar object reference. Return the class name that should be used, given the name of a table. Returns Specifying Classes Explicitly The :class:`.AutomapBase` class can be compared to the "declarative base" class that is produced by the :func:`.declarative.declarative_base` function.  In practice, the :class:`.AutomapBase` class is always used as a mixin along with an actual declarative base. The :mod:`.sqlalchemy.ext.automap` extension allows classes to be defined explicitly, in a way similar to that of the :class:`.DeferredReflection` class. Classes that extend from :class:`.AutomapBase` act like regular declarative classes, but are not immediately mapped after their construction, and are instead mapped when we call :meth:`.AutomapBase.prepare`.  The :meth:`.AutomapBase.prepare` method will make use of the classes we've established based on the table name we use.  If our schema contains tables ``user`` and ``address``, we can define one or both of the classes to be used:: The :paramref:`.AutomapBase.prepare.generate_relationship` hook can be used to add parameters to relationships.  For most cases, we can make use of the existing :func:`.automap.generate_relationship` function to return the object, after augmenting the given keyword dictionary with our own arguments. The above schema will first automap the ``table_a`` table as a class named ``table_a``; it will then automap a relationship onto the class for ``table_b`` with the same name as this related class, e.g. ``table_a``.  This relationship name conflicts with the mapping column ``table_b.table_a``, and will emit an error on mapping. The classes are inspected for an existing mapped property matching these names.  If one is detected on one side, but none on the other side, :class:`.AutomapBase` attempts to create a relationship on the missing side, then uses the :paramref:`.relationship.back_populates` parameter in order to point the new relationship to the other side. The default implementation is:: The default implementation of this function is as follows:: The foreign key from ``Engineer`` to ``Employee`` is used not for a relationship, but to establish joined inheritance between the two classes. The names of the relationships are determined using the :paramref:`.AutomapBase.prepare.name_for_scalar_relationship` and :paramref:`.AutomapBase.prepare.name_for_collection_relationship` callable functions.  It is important to note that the default relationship naming derives the name from the **the actual class name**.  If you've given a particular class an explicit name by declaring it, or specified an alternate class naming scheme, that's the name from which the relationship name will be derived. The override logic for many-to-many works the same as that of one-to-many/ many-to-one; the :func:`.generate_relationship` function is called upon to generate the strucures and existing attributes will be maintained. The simplest usage is to reflect an existing database into a new model. We create a new :class:`.AutomapBase` class in a similar manner as to how we create a declarative base class, using :func:`.automap_base`. We then call :meth:`.AutomapBase.prepare` on the resulting base class, asking it to reflect the schema and produce mappings:: The two (or one, for self-referential) external tables to which the :class:`.Table` refers to are matched to the classes to which they will be mapped, if any. The vast majority of what automap accomplishes is the generation of :func:`.relationship` structures based on foreign keys.  The mechanism by which this works for many-to-one and one-to-many relationships is as follows: This function produces a new base class that is a product of the :class:`.AutomapBase` class as well a declarative base produced by :func:`.declarative.declarative_base`. This object behaves much like the ``.c`` collection on a table.  Classes are present under the name they were given, e.g.:: Using Automap with Explicit Declarations We can pass a pre-declared :class:`.MetaData` object to :func:`.automap_base`. This object can be constructed in any way, including programmatically, from a serialized file, or from itself being reflected using :meth:`.MetaData.reflect`.  Below we illustrate a combination of reflection and explicit table declaration:: We can resolve this conflict by using an underscore as follows:: When present in conjunction with the :paramref:`.AutomapBase.prepare.reflect` flag, is passed to :meth:`.MetaData.reflect` to indicate the primary schema where tables should be reflected from.  When omitted, the default schema in use by the database connection is used. When present in conjunction with the :paramref:`.AutomapBase.prepare.reflect` flag, is passed to :meth:`.MetaData.reflect` to indicate the primary schema where tables should be reflected from.  When omitted, the default schema in use by the database connection is used.  .. versionadded:: 1.1 a :func:`.relationship` or :func:`.backref` construct, as dictated by the :paramref:`.generate_relationship.return_fn` parameter. a string class name. a string class name.  .. note::     In Python 2, the string used for the class name **must** be a    non-Unicode object, e.g. a ``str()`` object.  The ``.name`` attribute    of :class:`.Table` is typically a Python unicode subclass, so the    ``str()`` function should be applied to this name, after accounting for    any non-ASCII characters. all additional keyword arguments are passed along to the function. an :class:`.Engine` or :class:`.Connection` with which to perform schema reflection, if specified. If the :paramref:`.AutomapBase.prepare.reflect` argument is False, this object is not used. an existing class produced by :func:`.declarative.declarative_base`.  When this is passed, the function no longer invokes :func:`.declarative.declarative_base` itself, and all other keyword arguments are ignored. callable function which will be used to actually generate :func:`.relationship` and :func:`.backref` constructs.  Defaults to :func:`.generate_relationship`. callable function which will be used to produce new class names, given a table name.  Defaults to :func:`.classname_for_table`. callable function which will be used to produce relationship names for collection-oriented relationships.  Defaults to :func:`.name_for_collection_relationship`. callable function which will be used to produce relationship names for scalar relationships.  Defaults to :func:`.name_for_scalar_relationship`. if True, the :meth:`.MetaData.reflect` method is called on the :class:`.MetaData` associated with this :class:`.AutomapBase`. The :class:`.Engine` passed via :paramref:`.AutomapBase.prepare.engine` will be used to perform the reflection if present; else, the :class:`.MetaData` should already be bound to some engine else the operation will fail. indicate the "direction" of the relationship; this will be one of :data:`.ONETOMANY`, :data:`.MANYTOONE`, :data:`.MANYTOMANY`. keyword arguments are passed along to :func:`.declarative.declarative_base`. string name of the :class:`.Table`. the "local" class to which this relationship or backref will be locally present. the "referred" class to which the relationship or backref refers to. the :class:`.AutomapBase` class doing the prepare. the :class:`.ForeignKeyConstraint` that is being inspected to produce this relationship. the :class:`.Table` object itself. the Python collection class that will be used when a new :func:`.relationship` object is created that represents a collection.  Defaults to ``list``. the attribute name to which this relationship is being assigned. If the value of :paramref:`.generate_relationship.return_fn` is the :func:`.backref` function, then this name is the name that is being assigned to the backref. the class to be mapped on the local side. the class to be mapped on the referring side. the function that is used by default to create the relationship.  This will be either :func:`.relationship` or :func:`.backref`.  The :func:`.backref` function's result will be used to produce a new :func:`.relationship` in a second step, so it is critical that user-defined implementations correctly differentiate between the two functions, if a custom relationship function is being used. Project-Id-Version: SQLAlchemy 1.3
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2018-12-18 16:18+0900
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ko
Language-Team: ko <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 - automap will detect non-nullable foreign key constraints when producing a one-to-many relationship and establish a default cascade of ``all, delete-orphan`` if so; additionally, if the constraint specifies :paramref:`.ForeignKeyConstraint.ondelete` of ``CASCADE`` for non-nullable or ``SET NULL`` for nullable columns, the ``passive_deletes=True`` option is also added. :mod:`.sqlalchemy.ext.automap` is tasked with producing mapped classes and relationship names based on a schema, which means it has decision points in how these names are determined.  These three decision points are provided using functions which can be passed to the :meth:`.AutomapBase.prepare` method, and are known as :func:`.classname_for_table`, :func:`.name_for_scalar_relationship`, and :func:`.name_for_collection_relationship`.  Any or all of these functions are provided as in the example below, where we use a "camel case" scheme for class names and a "pluralizer" for collection names using the `Inflect <https://pypi.python.org/pypi/inflect>`_ package:: :mod:`.sqlalchemy.ext.automap` will generate many-to-many relationships, e.g. those which contain a ``secondary`` argument.  The process for producing these is as follows: :mod:`.sqlalchemy.ext.automap` will not generate any relationships between two classes that are in an inheritance relationship.   That is, with two classes given as follows:: :ref:`automap_toplevel` A given :class:`.Table` is examined for :class:`.ForeignKeyConstraint` objects, before any mapped class has been assigned to it. A given :class:`.Table`, known to be mapped to a particular class, is examined for :class:`.ForeignKeyConstraint` objects. A new subclassable :class:`.AutomapBase` is typically instantated using the :func:`.automap_base` function. API Reference Above, calling :meth:`.AutomapBase.prepare` while passing along the :paramref:`.AutomapBase.prepare.reflect` parameter indicates that the :meth:`.MetaData.reflect` method will be called on this declarative base classes' :class:`.MetaData` collection; then, each **viable** :class:`.Table` within the :class:`.MetaData` will get a new mapped class generated automatically.  The :class:`.ForeignKeyConstraint` objects which link the various tables together will be used to produce new, bidirectional :func:`.relationship` objects between classes.   The classes and relationships follow along a default naming scheme that we can customize.  At this point, our basic mapping consisting of related ``User`` and ``Address`` classes is ready to use in the traditional way. Above, given mostly complete ``User`` and ``Address`` mappings, the :class:`.ForeignKey` which we defined on ``Address.user_id`` allowed a bidirectional relationship pair ``Address.user`` and ``User.address_collection`` to be generated on the mapped classes. Above, one of the more intricate details is that we illustrated overriding one of the :func:`.relationship` objects that automap would have created. To do this, we needed to make sure the names match up with what automap would normally generate, in that the relationship name would be ``User.address_collection`` and the name of the class referred to, from automap's perspective, is called ``address``, even though we are referring to it as ``Address`` within our usage of this class. Added :mod:`sqlalchemy.ext.automap`. All parameters other than ``declarative_base`` are keyword arguments that are passed directly to the :func:`.declarative.declarative_base` function. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.classname_for_table` parameter. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.name_for_collection_relationship` parameter. Alternate implementations can be specified using the :paramref:`.AutomapBase.prepare.name_for_scalar_relationship` parameter. Alternatively, we can change the name on the column side.   The columns that are mapped can be modified using the technique described at :ref:`mapper_column_distinct_names`, by assigning the column explicitly to a new name:: An alternate implementation of this function can be specified using the :paramref:`.AutomapBase.prepare.generate_relationship` parameter. An instance of :class:`.util.Properties` containing classes. As noted previously, automap has no dependency on reflection, and can make use of any collection of :class:`.Table` objects within a :class:`.MetaData` collection.  From this, it follows that automap can also be used generate missing relationships given an otherwise complete model that fully defines table metadata:: As the :class:`.ForeignKeyConstraint` we are examining corresponds to a reference from the immediate mapped class,  the relationship will be set up as a many-to-one referring to the referred class; a corresponding one-to-many backref will be created on the referred class referring to this class. Automap Base class for an "automap" schema. Basic Use Below is an illustration of how to send :paramref:`.relationship.cascade` and :paramref:`.relationship.passive_deletes` options along to all one-to-many relationships:: By **viable**, we mean that for a table to be mapped, it must specify a primary key.  Additionally, if the table is detected as being a pure association table between two other tables, it will not be directly mapped and will instead be configured as a many-to-many table between the mappings for the two referring tables. Custom Relationship Arguments Define an extension to the :mod:`sqlalchemy.ext.declarative` system which automatically generates mapped classes and relationships from a database schema, typically though not necessarily one which is reflected. Extract mapped classes and relationships from the :class:`.MetaData` and perform mappings. From each :class:`.ForeignKeyConstraint`, the remote :class:`.Table` object present is matched up to the class to which it is to be mapped, if any, else it is skipped. From the above mapping, we would now have classes ``User`` and ``Address``, where the collection from ``User`` to ``Address`` is called ``User.addresses``:: Generate a :func:`.relationship` or :func:`.backref` on behalf of two mapped classes. Generating Mappings from an Existing MetaData Handling Simple Naming Conflicts If any of the columns that are part of the :class:`.ForeignKeyConstraint` are not nullable (e.g. ``nullable=False``), a :paramref:`~.relationship.cascade` keyword argument of ``all, delete-orphan`` will be added to the keyword arguments to be passed to the relationship or backref.  If the :class:`.ForeignKeyConstraint` reports that :paramref:`.ForeignKeyConstraint.ondelete` is set to ``CASCADE`` for a not null or ``SET NULL`` for a nullable set of columns, the option :paramref:`~.relationship.passive_deletes` flag is set to ``True`` in the set of relationship keyword arguments. Note that not all backends support reflection of ON DELETE. If mapped classes for both sides are located, a many-to-many bi-directional :func:`.relationship` / :func:`.backref` pair is created between the two classes. If the table contains two and exactly two :class:`.ForeignKeyConstraint` objects, and all columns within this table are members of these two :class:`.ForeignKeyConstraint` objects, the table is assumed to be a "secondary" table, and will **not be mapped directly**. In Python 2, the string used for the class name **must** be a non-Unicode object, e.g. a ``str()`` object.  The ``.name`` attribute of :class:`.Table` is typically a Python unicode subclass, so the ``str()`` function should be applied to this name, after accounting for any non-ASCII characters. In the case of naming conflicts during mapping, override any of :func:`.classname_for_table`, :func:`.name_for_scalar_relationship`, and :func:`.name_for_collection_relationship` as needed.  For example, if automap is attempting to name a many-to-one relationship the same as an existing column, an alternate convention can be conditionally selected.  Given a schema: In the usual case where no relationship is on either side, :meth:`.AutomapBase.prepare` produces a :func:`.relationship` on the "many-to-one" side and matches it to the other using the :paramref:`.relationship.backref` parameter. It is hoped that the :class:`.AutomapBase` system provides a quick and modernized solution to the problem that the very famous `SQLSoup <https://sqlsoup.readthedocs.io/en/latest/>`_ also tries to solve, that of generating a quick and rudimentary object model from an existing database on the fly.  By addressing the issue strictly at the mapper configuration level, and integrating fully with existing Declarative class techniques, :class:`.AutomapBase` seeks to provide a well-integrated approach to the issue of expediently auto-generating ad-hoc mappings. Many-to-Many relationships Note that this means automap will not generate *any* relationships for foreign keys that link from a subclass to a superclass.  If a mapping has actual relationships from subclass to superclass as well, those need to be explicit.  Below, as we have two separate foreign keys from ``Engineer`` to ``Employee``, we need to set up both the relationship we want as well as the ``inherit_condition``, as these are not things SQLAlchemy can guess:: Note that when subclassing :class:`.AutomapBase`, the :meth:`.AutomapBase.prepare` method is required; if not called, the classes we've declared are in an un-mapped state. Overriding Naming Schemes Parameters Produce a declarative automap base. Production of the :func:`.relationship` and optionally the :func:`.backref` is handed off to the :paramref:`.AutomapBase.prepare.generate_relationship` function, which can be supplied by the end-user in order to augment the arguments passed to :func:`.relationship` or :func:`.backref` or to make use of custom implementations of these functions. Relationship Detection Relationships with Inheritance Return the attribute name that should be used to refer from one class to another, for a collection reference. Return the attribute name that should be used to refer from one class to another, for a scalar object reference. Return the class name that should be used, given the name of a table. Returns Specifying Classes Explicitly The :class:`.AutomapBase` class can be compared to the "declarative base" class that is produced by the :func:`.declarative.declarative_base` function.  In practice, the :class:`.AutomapBase` class is always used as a mixin along with an actual declarative base. The :mod:`.sqlalchemy.ext.automap` extension allows classes to be defined explicitly, in a way similar to that of the :class:`.DeferredReflection` class. Classes that extend from :class:`.AutomapBase` act like regular declarative classes, but are not immediately mapped after their construction, and are instead mapped when we call :meth:`.AutomapBase.prepare`.  The :meth:`.AutomapBase.prepare` method will make use of the classes we've established based on the table name we use.  If our schema contains tables ``user`` and ``address``, we can define one or both of the classes to be used:: The :paramref:`.AutomapBase.prepare.generate_relationship` hook can be used to add parameters to relationships.  For most cases, we can make use of the existing :func:`.automap.generate_relationship` function to return the object, after augmenting the given keyword dictionary with our own arguments. The above schema will first automap the ``table_a`` table as a class named ``table_a``; it will then automap a relationship onto the class for ``table_b`` with the same name as this related class, e.g. ``table_a``.  This relationship name conflicts with the mapping column ``table_b.table_a``, and will emit an error on mapping. The classes are inspected for an existing mapped property matching these names.  If one is detected on one side, but none on the other side, :class:`.AutomapBase` attempts to create a relationship on the missing side, then uses the :paramref:`.relationship.back_populates` parameter in order to point the new relationship to the other side. The default implementation is:: The default implementation of this function is as follows:: The foreign key from ``Engineer`` to ``Employee`` is used not for a relationship, but to establish joined inheritance between the two classes. The names of the relationships are determined using the :paramref:`.AutomapBase.prepare.name_for_scalar_relationship` and :paramref:`.AutomapBase.prepare.name_for_collection_relationship` callable functions.  It is important to note that the default relationship naming derives the name from the **the actual class name**.  If you've given a particular class an explicit name by declaring it, or specified an alternate class naming scheme, that's the name from which the relationship name will be derived. The override logic for many-to-many works the same as that of one-to-many/ many-to-one; the :func:`.generate_relationship` function is called upon to generate the strucures and existing attributes will be maintained. The simplest usage is to reflect an existing database into a new model. We create a new :class:`.AutomapBase` class in a similar manner as to how we create a declarative base class, using :func:`.automap_base`. We then call :meth:`.AutomapBase.prepare` on the resulting base class, asking it to reflect the schema and produce mappings:: The two (or one, for self-referential) external tables to which the :class:`.Table` refers to are matched to the classes to which they will be mapped, if any. The vast majority of what automap accomplishes is the generation of :func:`.relationship` structures based on foreign keys.  The mechanism by which this works for many-to-one and one-to-many relationships is as follows: This function produces a new base class that is a product of the :class:`.AutomapBase` class as well a declarative base produced by :func:`.declarative.declarative_base`. This object behaves much like the ``.c`` collection on a table.  Classes are present under the name they were given, e.g.:: Using Automap with Explicit Declarations We can pass a pre-declared :class:`.MetaData` object to :func:`.automap_base`. This object can be constructed in any way, including programmatically, from a serialized file, or from itself being reflected using :meth:`.MetaData.reflect`.  Below we illustrate a combination of reflection and explicit table declaration:: We can resolve this conflict by using an underscore as follows:: When present in conjunction with the :paramref:`.AutomapBase.prepare.reflect` flag, is passed to :meth:`.MetaData.reflect` to indicate the primary schema where tables should be reflected from.  When omitted, the default schema in use by the database connection is used. When present in conjunction with the :paramref:`.AutomapBase.prepare.reflect` flag, is passed to :meth:`.MetaData.reflect` to indicate the primary schema where tables should be reflected from.  When omitted, the default schema in use by the database connection is used.  .. versionadded:: 1.1 a :func:`.relationship` or :func:`.backref` construct, as dictated by the :paramref:`.generate_relationship.return_fn` parameter. a string class name. a string class name.  .. note::     In Python 2, the string used for the class name **must** be a    non-Unicode object, e.g. a ``str()`` object.  The ``.name`` attribute    of :class:`.Table` is typically a Python unicode subclass, so the    ``str()`` function should be applied to this name, after accounting for    any non-ASCII characters. all additional keyword arguments are passed along to the function. an :class:`.Engine` or :class:`.Connection` with which to perform schema reflection, if specified. If the :paramref:`.AutomapBase.prepare.reflect` argument is False, this object is not used. an existing class produced by :func:`.declarative.declarative_base`.  When this is passed, the function no longer invokes :func:`.declarative.declarative_base` itself, and all other keyword arguments are ignored. callable function which will be used to actually generate :func:`.relationship` and :func:`.backref` constructs.  Defaults to :func:`.generate_relationship`. callable function which will be used to produce new class names, given a table name.  Defaults to :func:`.classname_for_table`. callable function which will be used to produce relationship names for collection-oriented relationships.  Defaults to :func:`.name_for_collection_relationship`. callable function which will be used to produce relationship names for scalar relationships.  Defaults to :func:`.name_for_scalar_relationship`. if True, the :meth:`.MetaData.reflect` method is called on the :class:`.MetaData` associated with this :class:`.AutomapBase`. The :class:`.Engine` passed via :paramref:`.AutomapBase.prepare.engine` will be used to perform the reflection if present; else, the :class:`.MetaData` should already be bound to some engine else the operation will fail. indicate the "direction" of the relationship; this will be one of :data:`.ONETOMANY`, :data:`.MANYTOONE`, :data:`.MANYTOMANY`. keyword arguments are passed along to :func:`.declarative.declarative_base`. string name of the :class:`.Table`. the "local" class to which this relationship or backref will be locally present. the "referred" class to which the relationship or backref refers to. the :class:`.AutomapBase` class doing the prepare. the :class:`.ForeignKeyConstraint` that is being inspected to produce this relationship. the :class:`.Table` object itself. the Python collection class that will be used when a new :func:`.relationship` object is created that represents a collection.  Defaults to ``list``. the attribute name to which this relationship is being assigned. If the value of :paramref:`.generate_relationship.return_fn` is the :func:`.backref` function, then this name is the name that is being assigned to the backref. the class to be mapped on the local side. the class to be mapped on the referring side. the function that is used by default to create the relationship.  This will be either :func:`.relationship` or :func:`.backref`.  The :func:`.backref` function's result will be used to produce a new :func:`.relationship` in a second step, so it is critical that user-defined implementations correctly differentiate between the two functions, if a custom relationship function is being used. 