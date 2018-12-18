��    J      l              �  �   �  �   L    $  f   (     �  �   �     Q  �   j  �   (	  	  �	  �  �  �  �  �  &  �  "    �    �  �   �  !   �     �  "     V   3  �  �  "        0    M  �   g  '  �  y     .  �  F  �   �   "  �  �"  �   �'  n   U(  �  �(  .   �*  D  �*  s   8,     �,  "   �,  /   �,  *   -  �  C-  $   �.  �   �.  �   �/  C  q0  F   �1  8  �1  1   53  r  g3  �  �7  1  x9  G   �:    �:  q   �<  o   p=    �=  )   �>  �  ?  x   �@  �  wA  �   ]D  H   E    UE  1   gG     �G  �  �G    {I  �   �J  �   NK  �   �K  -   lL  x  �L  �   N  �   �N    zO  f   ~P     �P  �   �P     �Q  �   �Q  �   ~R  	  S  �  V  �  �W  �  |Z  �  x]    _    `  �   +a  !   (b     Jb  "   fb  V   �b  �  �b  "   cd     �d    �d  �   �f  '  Bg  y   jh  .  �h  F  j  �   Zk  �  Il  �   �p  n   �q  �  r  .   t  D  It  s   �u     v  "   v  /   >v  *   nv  �  �v  $   $x  �   Ix  �   �x  C  �y  F   {  8  R{  1   �|  r  �|  �  0�  1  ΂  G    �    H�  q   T�  o   Ɔ    6�  )   C�  �  m�  x   T�  �  ͊  �   ��  H   b�    ��  1   ��     �  �   �    ђ  �   �  �   ��  �   A�  -      - Added the :paramref:`.Operators.op.is_comparison` flag to assist in the creation of :func:`.relationship` constructs using custom operators. :func:`.relationship` can resolve ambiguity between foreign key targets on the basis of the ``foreign_keys`` argument alone; the :paramref:`~.relationship.primaryjoin` argument is no longer needed in this situation. :func:`.relationship` will normally create a join between two tables by examining the foreign key relationship between the two tables to determine which columns should be compared.  There are a variety of situations where this behavior needs to be customized. A classical mapping situation here is similar, where ``node_to_node`` can be joined to ``node.c.id``:: A complete example:: A rare scenario can arise when composite foreign keys are used, such that a single column may be the subject of more than one column referred to via foreign key constraint. Above, a query such as:: Above, for each matching primary key in "a", we will get the first ten "bs" as ordered by "b.id".   By partitioning on "a_id" we ensure that each "row number" is local to the parent "a_id". Above, if given an ``Element`` object with a path attribute of ``"/foo/bar2"``, we seek for a load of ``Element.descendants`` to look like:: Above, we specify the ``foreign_keys`` argument, which is a :class:`.Column` or list of :class:`.Column` objects which indicate those columns to be considered "foreign", or in other words, the columns that contain a value referring to a parent table. Loading the ``Customer.billing_address`` relationship from a ``Customer`` object will use the value present in ``billing_address_id`` in order to identify the row in ``Address`` to be loaded; similarly, ``shipping_address_id`` is used for the ``shipping_address`` relationship.   The linkage of the two columns also plays a role during persistence; the newly generated primary key of a just-inserted ``Address`` object will be copied into the appropriate foreign key column of an associated ``Customer`` object during a flush. Alternatively, we can define the :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments using strings, which is suitable in the case that our configuration does not have either the ``Node.id`` column object available yet or the ``node_to_node`` table perhaps isn't yet available. When referring to a plain :class:`.Table` object in a declarative string, we use the string name of the table as it is present in the :class:`.MetaData`:: An alternative syntax to the above is to use the :func:`.foreign` and :func:`.remote` :term:`annotations`, inline within the :paramref:`~.relationship.primaryjoin` expression. This syntax represents the annotations that :func:`.relationship` normally applies by itself to the join condition given the :paramref:`~.relationship.foreign_keys` and :paramref:`~.relationship.remote_side` arguments.  These functions may be more succinct when an explicit join condition is present, and additionally serve to mark exactly the column that is "foreign" or "remote" independent of whether that column is stated multiple times or within complex SQL expressions:: Another element of the primary join condition is how those columns considered "foreign" are determined.  Usually, some subset of :class:`.Column` objects will specify :class:`.ForeignKey`, or otherwise be part of a :class:`.ForeignKeyConstraint` that's relevant to the join condition. :func:`.relationship` looks to this foreign key status as it decides how it should load and persist data for this relationship.   However, the :paramref:`~.relationship.primaryjoin` argument can be used to create a join condition that doesn't involve any "schema" level foreign keys.  We can combine :paramref:`~.relationship.primaryjoin` along with :paramref:`~.relationship.foreign_keys` and :paramref:`~.relationship.remote_side` explicitly in order to establish such a join. Another interesting use case for non-primary mappers are situations where the relationship needs to join to a specialized SELECT of any form.   One scenario is when the use of a window function is desired, such as to limit how many rows should be returned for a relationship.  The example below illustrates a non-primary mapper relationship that will load the first ten items for each collection:: Another use case for relationships is the use of custom operators, such as PostgreSQL's "is contained within" ``<<`` operator when joining with types such as :class:`.postgresql.INET` and :class:`.postgresql.CIDR`. For custom operators we use the :meth:`.Operators.op` function:: Below illustrates a :func:`.relationship` with a simple join from ``A`` to ``B``, however the primaryjoin condition is augmented with two additional entities ``C`` and ``D``, which also must have rows that line up with the rows in both ``A`` and ``B`` simultaneously:: Below, a class ``HostEntry`` joins to itself, equating the string ``content`` column to the ``ip_address`` column, which is a PostgreSQL type called ``INET``. We need to use :func:`.cast` in order to cast one side of the join to the type of the other:: Building Query-Enabled Properties Composite "Secondary" Joins Configuring how Relationship Joins Consider a ``Customer`` class that contains two foreign keys to an ``Address`` class:: Consider an (admittedly complex) mapping such as the ``Magazine`` object, referred to both by the ``Writer`` object and the ``Article`` object using a composite primary key scheme that includes ``magazine_id`` for both; then to make ``Article`` refer to ``Writer`` as well, ``Article.magazine_id`` is involved in two separate relationships; ``Article.magazine`` and ``Article.writer``:: Creating Custom Foreign Conditions Handling Multiple Join Paths However, if we construct a :paramref:`~.relationship.primaryjoin` using this operator, :func:`.relationship` will still need more information.  This is because when it examines our primaryjoin condition, it specifically looks for operators used for **comparisons**, and this is typically a fixed list containing known comparison operators such as ``==``, ``<``, etc.   So for our custom operator to participate in this system, we need it to register as a comparison operator using the :paramref:`~.Operators.op.is_comparison` parameter:: However, this has the effect of ``Article.writer`` not taking ``Article.magazine_id`` into account when querying against ``Writer``: In more recent versions of SQLAlchemy, the :paramref:`~.relationship.secondary` parameter can be used in some of these cases in order to provide a composite target consisting of multiple tables.   Below is an example of such a join condition (requires version 0.9.2 at least to function as is):: In the above case, our non-primary mapper for ``B`` will emit for additional columns when we query; these can be ignored: In the above example, we provide all three of :paramref:`~.relationship.secondary`, :paramref:`~.relationship.primaryjoin`, and :paramref:`~.relationship.secondaryjoin`, in the declarative style referring to the named tables ``a``, ``b``, ``c``, ``d`` directly.  A query from ``A`` to ``D`` looks like: In the above example, we take advantage of being able to stuff multiple tables into a "secondary" container, so that we can join across many tables while still keeping things "simple" for :func:`.relationship`, in that there's just "one" table on both the "left" and the "right" side; the complexity is kept within the middle. In the example below, using the ``User`` class as well as an ``Address`` class which stores a street address,  we create a relationship ``boston_addresses`` which will only load those ``Address`` objects which specify a city of "Boston":: In the previous section, we illustrated a technique where we used :paramref:`~.relationship.secondary` in order to place additional tables within a join condition.   There is one complex join case where even this technique is not sufficient; when we seek to join from ``A`` to ``B``, making use of any number of ``C``, ``D``, etc. in between, however there are also join conditions between ``A`` and ``B`` *directly*.  In this case, the join from ``A`` to ``B`` may be difficult to express with just a complex :paramref:`~.relationship.primaryjoin` condition, as the intermediary tables may need special handling, and it is also not expressable with a :paramref:`~.relationship.secondary` object, since the ``A->secondary->B`` pattern does not support any references between ``A`` and ``B`` directly.  When this **extremely advanced** case arises, we can resort to creating a second mapping as a target for the relationship.  This is where we use :func:`.mapper` in order to make a mapping to a class that includes all the additional tables we need for this join. In order to produce this mapper as an "alternative" mapping for our class, we use the :paramref:`~.mapper.non_primary` flag. In this case, the message wants us to qualify each :func:`.relationship` by instructing for each one which foreign key column should be considered, and the appropriate form is as follows:: In this specific example, the list is not necessary in any case as there's only one :class:`.Column` we need:: Many to many relationships can be customized by one or both of :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` - the latter is significant for a relationship that specifies a many-to-many reference using the :paramref:`~.relationship.secondary` argument. A common situation which involves the usage of :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` is when establishing a many-to-many relationship from a class to itself, as shown below:: Non-relational Comparisons / Materialized Path Note that in both examples, the :paramref:`~.relationship.backref` keyword specifies a ``left_nodes`` backref - when :func:`.relationship` creates the second relationship in the reverse direction, it's smart enough to reverse the :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments. One of the most common situations to deal with is when there are more than one foreign key path between two tables. Overlapping Foreign Keys Relationship to Non Primary Mapper Row-Limited Relationships with Window Functions Self-Referential Many-to-Many Relationship Sometimes, when one seeks to build a :func:`.relationship` between two tables there is a need for more than just two or three tables to be involved in order to join them.  This is an area of :func:`.relationship` where one seeks to push the boundaries of what's possible, and often the ultimate solution to many of these exotic use cases needs to be hammered out on the SQLAlchemy mailing list. Specifying Alternate Join Conditions Such a mapping would ordinarily also include a "plain" relationship from "A" to "B", for persistence operations as well as when the full set of "B" objects per "A" is desired. Support has been added to allow a single-column comparison to itself within a primaryjoin condition, as well as for primaryjoin conditions that use :meth:`.ColumnOperators.like` as the comparison operator. Support is improved for allowing a :func:`.join()` construct to be used directly as the target of the :paramref:`~.relationship.secondary` argument, including support for joins, eager joins and lazy loading, as well as support within declarative to specify complex conditions such as joins involving class names as targets. The above mapping, when we attempt to use it, will produce the error:: The above message is pretty long.  There are many potential messages that :func:`.relationship` can return, which have been carefully tailored to detect a variety of common configurational issues; most will suggest the additional configuration that's needed to resolve the ambiguity or other missing information. The above relationship will produce a join like:: The custom criteria we use in a :paramref:`~.relationship.primaryjoin` is generally only significant when SQLAlchemy is rendering SQL in order to load or represent this relationship. That is, it's used in the SQL statement that's emitted in order to perform a per-attribute lazy load, or when a join is constructed at query time, such as via :meth:`.Query.join`, or via the eager "joined" or "subquery" styles of loading.   When in-memory objects are being manipulated, we can place any ``Address`` object we'd like into the ``boston_addresses`` collection, regardless of what the value of the ``.city`` attribute is.   The objects will remain present in the collection until the attribute is expired and re-loaded from the database where the criterion is applied.   When a flush occurs, the objects inside of ``boston_addresses`` will be flushed unconditionally, assigning value of the primary key ``user.id`` column onto the foreign-key-holding ``address.user_id`` column for each row.  The ``city`` criteria has no effect here, as the flush process only cares about synchronizing primary key values into referencing foreign key values. The default behavior of :func:`.relationship` when constructing a join is that it equates the value of primary key columns on one side to that of foreign-key-referring columns on the other. We can change this criterion to be anything we'd like using the :paramref:`~.relationship.primaryjoin` argument, as well as the :paramref:`~.relationship.secondaryjoin` argument in the case when a "secondary" table is used. Therefore, to get at all of #1, #2, and #3, we express the join condition as well as which columns to be written by combining :paramref:`~.relationship.primaryjoin` fully, along with either the :paramref:`~.relationship.foreign_keys` argument, or more succinctly by annotating with :func:`~.orm.foreign`:: This section features some new and experimental features of SQLAlchemy. Through careful use of :func:`.foreign` and :func:`.remote`, we can build a relationship that effectively produces a rudimentary materialized path system.   Essentially, when :func:`.foreign` and :func:`.remote` are on the *same* side of the comparison expression, the relationship is considered to be "one to many"; when they are on *different* sides, the relationship is considered to be "many to one".   For the comparison we'll use here, we'll be dealing with collections so we keep things configured as "one to many":: To get just #1 and #2, we could specify only ``Article.writer_id`` as the "foreign keys" for ``Article.writer``:: To solve this, we need to break out the behavior of ``Article`` to include all three of the following features: Using custom expressions means we can produce unorthodox join conditions that don't obey the usual primary/foreign key model.  One such example is the materialized path pattern, where we compare strings for overlapping path tokens in order to produce a tree structure. Using custom operators in join conditions Very ambitious custom join conditions may fail to be directly persistable, and in some cases may not even load correctly. To remove the persistence part of the equation, use the flag :paramref:`~.relationship.viewonly` on the :func:`~sqlalchemy.orm.relationship`, which establishes it as a read-only attribute (data written to the collection will be ignored on flush()). However, in extreme cases, consider using a regular Python property in conjunction with :class:`.Query` as follows: We can use the above ``partitioned_bs`` relationship with most of the loader strategies, such as :func:`.selectinload`:: What this refers to originates from the fact that ``Article.magazine_id`` is the subject of two different foreign key constraints; it refers to ``Magazine.id`` directly as a source column, but also refers to ``Writer.magazine_id`` as a source column in the context of the composite key to ``Writer``.   If we associate an ``Article`` with a particular ``Magazine``, but then associate the ``Article`` with a ``Writer`` that's  associated  with a *different* ``Magazine``, the ORM will overwrite ``Article.magazine_id`` non-deterministically, silently changing which magazine we refer towards; it may also attempt to place NULL into this columnn if we de-associate a ``Writer`` from an ``Article``.  The warning lets us know this is the case. When specifying ``foreign_keys`` with Declarative, we can also use string names to specify, however it is important that if using a list, the **list is part of the string**:: When the above mapping is configured, we will see this warning emitted:: Where above, SQLAlchemy can't know automatically which columns should connect to which for the ``right_nodes`` and ``left_nodes`` relationships.   The :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments establish how we'd like to join to the association table. In the Declarative form above, as we are declaring these conditions within the Python block that corresponds to the ``Node`` class, the ``id`` variable is available directly as the :class:`.Column` object we wish to join with. Where above, the "selectinload" query looks like: Will render as:: Within this string SQL expression, we made use of the :func:`.and_` conjunction construct to establish two distinct predicates for the join condition - joining both the ``User.id`` and ``Address.user_id`` columns to each other, as well as limiting rows in ``Address`` to just ``city='Boston'``.   When using Declarative, rudimentary SQL functions like :func:`.and_` are automatically available in the evaluated namespace of a string :func:`.relationship` argument. ``Article`` can write to ``Article.writer_id`` on behalf of data persisted in the  ``Article.writer`` relationship, but only the ``Writer.id`` column; the ``Writer.magazine_id`` column should not be written into ``Article.magazine_id`` as it ultimately is sourced from ``Magazine.id``. ``Article`` first and foremost writes to ``Article.magazine_id`` based on data persisted in the ``Article.magazine`` relationship only, that is a value copied from ``Magazine.id``. ``Article`` takes ``Article.magazine_id`` into account when loading ``Article.writer``, even though it *doesn't* write to it on behalf of this relationship. the ORM will attempt to warn when a column is used as the synchronization target from more than one relationship simultaneously. this section details an experimental feature. Project-Id-Version: SQLAlchemy 1.3
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
 - Added the :paramref:`.Operators.op.is_comparison` flag to assist in the creation of :func:`.relationship` constructs using custom operators. :func:`.relationship` can resolve ambiguity between foreign key targets on the basis of the ``foreign_keys`` argument alone; the :paramref:`~.relationship.primaryjoin` argument is no longer needed in this situation. :func:`.relationship` will normally create a join between two tables by examining the foreign key relationship between the two tables to determine which columns should be compared.  There are a variety of situations where this behavior needs to be customized. A classical mapping situation here is similar, where ``node_to_node`` can be joined to ``node.c.id``:: A complete example:: A rare scenario can arise when composite foreign keys are used, such that a single column may be the subject of more than one column referred to via foreign key constraint. Above, a query such as:: Above, for each matching primary key in "a", we will get the first ten "bs" as ordered by "b.id".   By partitioning on "a_id" we ensure that each "row number" is local to the parent "a_id". Above, if given an ``Element`` object with a path attribute of ``"/foo/bar2"``, we seek for a load of ``Element.descendants`` to look like:: Above, we specify the ``foreign_keys`` argument, which is a :class:`.Column` or list of :class:`.Column` objects which indicate those columns to be considered "foreign", or in other words, the columns that contain a value referring to a parent table. Loading the ``Customer.billing_address`` relationship from a ``Customer`` object will use the value present in ``billing_address_id`` in order to identify the row in ``Address`` to be loaded; similarly, ``shipping_address_id`` is used for the ``shipping_address`` relationship.   The linkage of the two columns also plays a role during persistence; the newly generated primary key of a just-inserted ``Address`` object will be copied into the appropriate foreign key column of an associated ``Customer`` object during a flush. Alternatively, we can define the :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments using strings, which is suitable in the case that our configuration does not have either the ``Node.id`` column object available yet or the ``node_to_node`` table perhaps isn't yet available. When referring to a plain :class:`.Table` object in a declarative string, we use the string name of the table as it is present in the :class:`.MetaData`:: An alternative syntax to the above is to use the :func:`.foreign` and :func:`.remote` :term:`annotations`, inline within the :paramref:`~.relationship.primaryjoin` expression. This syntax represents the annotations that :func:`.relationship` normally applies by itself to the join condition given the :paramref:`~.relationship.foreign_keys` and :paramref:`~.relationship.remote_side` arguments.  These functions may be more succinct when an explicit join condition is present, and additionally serve to mark exactly the column that is "foreign" or "remote" independent of whether that column is stated multiple times or within complex SQL expressions:: Another element of the primary join condition is how those columns considered "foreign" are determined.  Usually, some subset of :class:`.Column` objects will specify :class:`.ForeignKey`, or otherwise be part of a :class:`.ForeignKeyConstraint` that's relevant to the join condition. :func:`.relationship` looks to this foreign key status as it decides how it should load and persist data for this relationship.   However, the :paramref:`~.relationship.primaryjoin` argument can be used to create a join condition that doesn't involve any "schema" level foreign keys.  We can combine :paramref:`~.relationship.primaryjoin` along with :paramref:`~.relationship.foreign_keys` and :paramref:`~.relationship.remote_side` explicitly in order to establish such a join. Another interesting use case for non-primary mappers are situations where the relationship needs to join to a specialized SELECT of any form.   One scenario is when the use of a window function is desired, such as to limit how many rows should be returned for a relationship.  The example below illustrates a non-primary mapper relationship that will load the first ten items for each collection:: Another use case for relationships is the use of custom operators, such as PostgreSQL's "is contained within" ``<<`` operator when joining with types such as :class:`.postgresql.INET` and :class:`.postgresql.CIDR`. For custom operators we use the :meth:`.Operators.op` function:: Below illustrates a :func:`.relationship` with a simple join from ``A`` to ``B``, however the primaryjoin condition is augmented with two additional entities ``C`` and ``D``, which also must have rows that line up with the rows in both ``A`` and ``B`` simultaneously:: Below, a class ``HostEntry`` joins to itself, equating the string ``content`` column to the ``ip_address`` column, which is a PostgreSQL type called ``INET``. We need to use :func:`.cast` in order to cast one side of the join to the type of the other:: Building Query-Enabled Properties Composite "Secondary" Joins Configuring how Relationship Joins Consider a ``Customer`` class that contains two foreign keys to an ``Address`` class:: Consider an (admittedly complex) mapping such as the ``Magazine`` object, referred to both by the ``Writer`` object and the ``Article`` object using a composite primary key scheme that includes ``magazine_id`` for both; then to make ``Article`` refer to ``Writer`` as well, ``Article.magazine_id`` is involved in two separate relationships; ``Article.magazine`` and ``Article.writer``:: Creating Custom Foreign Conditions Handling Multiple Join Paths However, if we construct a :paramref:`~.relationship.primaryjoin` using this operator, :func:`.relationship` will still need more information.  This is because when it examines our primaryjoin condition, it specifically looks for operators used for **comparisons**, and this is typically a fixed list containing known comparison operators such as ``==``, ``<``, etc.   So for our custom operator to participate in this system, we need it to register as a comparison operator using the :paramref:`~.Operators.op.is_comparison` parameter:: However, this has the effect of ``Article.writer`` not taking ``Article.magazine_id`` into account when querying against ``Writer``: In more recent versions of SQLAlchemy, the :paramref:`~.relationship.secondary` parameter can be used in some of these cases in order to provide a composite target consisting of multiple tables.   Below is an example of such a join condition (requires version 0.9.2 at least to function as is):: In the above case, our non-primary mapper for ``B`` will emit for additional columns when we query; these can be ignored: In the above example, we provide all three of :paramref:`~.relationship.secondary`, :paramref:`~.relationship.primaryjoin`, and :paramref:`~.relationship.secondaryjoin`, in the declarative style referring to the named tables ``a``, ``b``, ``c``, ``d`` directly.  A query from ``A`` to ``D`` looks like: In the above example, we take advantage of being able to stuff multiple tables into a "secondary" container, so that we can join across many tables while still keeping things "simple" for :func:`.relationship`, in that there's just "one" table on both the "left" and the "right" side; the complexity is kept within the middle. In the example below, using the ``User`` class as well as an ``Address`` class which stores a street address,  we create a relationship ``boston_addresses`` which will only load those ``Address`` objects which specify a city of "Boston":: In the previous section, we illustrated a technique where we used :paramref:`~.relationship.secondary` in order to place additional tables within a join condition.   There is one complex join case where even this technique is not sufficient; when we seek to join from ``A`` to ``B``, making use of any number of ``C``, ``D``, etc. in between, however there are also join conditions between ``A`` and ``B`` *directly*.  In this case, the join from ``A`` to ``B`` may be difficult to express with just a complex :paramref:`~.relationship.primaryjoin` condition, as the intermediary tables may need special handling, and it is also not expressable with a :paramref:`~.relationship.secondary` object, since the ``A->secondary->B`` pattern does not support any references between ``A`` and ``B`` directly.  When this **extremely advanced** case arises, we can resort to creating a second mapping as a target for the relationship.  This is where we use :func:`.mapper` in order to make a mapping to a class that includes all the additional tables we need for this join. In order to produce this mapper as an "alternative" mapping for our class, we use the :paramref:`~.mapper.non_primary` flag. In this case, the message wants us to qualify each :func:`.relationship` by instructing for each one which foreign key column should be considered, and the appropriate form is as follows:: In this specific example, the list is not necessary in any case as there's only one :class:`.Column` we need:: Many to many relationships can be customized by one or both of :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` - the latter is significant for a relationship that specifies a many-to-many reference using the :paramref:`~.relationship.secondary` argument. A common situation which involves the usage of :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` is when establishing a many-to-many relationship from a class to itself, as shown below:: Non-relational Comparisons / Materialized Path Note that in both examples, the :paramref:`~.relationship.backref` keyword specifies a ``left_nodes`` backref - when :func:`.relationship` creates the second relationship in the reverse direction, it's smart enough to reverse the :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments. One of the most common situations to deal with is when there are more than one foreign key path between two tables. Overlapping Foreign Keys Relationship to Non Primary Mapper Row-Limited Relationships with Window Functions Self-Referential Many-to-Many Relationship Sometimes, when one seeks to build a :func:`.relationship` between two tables there is a need for more than just two or three tables to be involved in order to join them.  This is an area of :func:`.relationship` where one seeks to push the boundaries of what's possible, and often the ultimate solution to many of these exotic use cases needs to be hammered out on the SQLAlchemy mailing list. Specifying Alternate Join Conditions Such a mapping would ordinarily also include a "plain" relationship from "A" to "B", for persistence operations as well as when the full set of "B" objects per "A" is desired. Support has been added to allow a single-column comparison to itself within a primaryjoin condition, as well as for primaryjoin conditions that use :meth:`.ColumnOperators.like` as the comparison operator. Support is improved for allowing a :func:`.join()` construct to be used directly as the target of the :paramref:`~.relationship.secondary` argument, including support for joins, eager joins and lazy loading, as well as support within declarative to specify complex conditions such as joins involving class names as targets. The above mapping, when we attempt to use it, will produce the error:: The above message is pretty long.  There are many potential messages that :func:`.relationship` can return, which have been carefully tailored to detect a variety of common configurational issues; most will suggest the additional configuration that's needed to resolve the ambiguity or other missing information. The above relationship will produce a join like:: The custom criteria we use in a :paramref:`~.relationship.primaryjoin` is generally only significant when SQLAlchemy is rendering SQL in order to load or represent this relationship. That is, it's used in the SQL statement that's emitted in order to perform a per-attribute lazy load, or when a join is constructed at query time, such as via :meth:`.Query.join`, or via the eager "joined" or "subquery" styles of loading.   When in-memory objects are being manipulated, we can place any ``Address`` object we'd like into the ``boston_addresses`` collection, regardless of what the value of the ``.city`` attribute is.   The objects will remain present in the collection until the attribute is expired and re-loaded from the database where the criterion is applied.   When a flush occurs, the objects inside of ``boston_addresses`` will be flushed unconditionally, assigning value of the primary key ``user.id`` column onto the foreign-key-holding ``address.user_id`` column for each row.  The ``city`` criteria has no effect here, as the flush process only cares about synchronizing primary key values into referencing foreign key values. The default behavior of :func:`.relationship` when constructing a join is that it equates the value of primary key columns on one side to that of foreign-key-referring columns on the other. We can change this criterion to be anything we'd like using the :paramref:`~.relationship.primaryjoin` argument, as well as the :paramref:`~.relationship.secondaryjoin` argument in the case when a "secondary" table is used. Therefore, to get at all of #1, #2, and #3, we express the join condition as well as which columns to be written by combining :paramref:`~.relationship.primaryjoin` fully, along with either the :paramref:`~.relationship.foreign_keys` argument, or more succinctly by annotating with :func:`~.orm.foreign`:: This section features some new and experimental features of SQLAlchemy. Through careful use of :func:`.foreign` and :func:`.remote`, we can build a relationship that effectively produces a rudimentary materialized path system.   Essentially, when :func:`.foreign` and :func:`.remote` are on the *same* side of the comparison expression, the relationship is considered to be "one to many"; when they are on *different* sides, the relationship is considered to be "many to one".   For the comparison we'll use here, we'll be dealing with collections so we keep things configured as "one to many":: To get just #1 and #2, we could specify only ``Article.writer_id`` as the "foreign keys" for ``Article.writer``:: To solve this, we need to break out the behavior of ``Article`` to include all three of the following features: Using custom expressions means we can produce unorthodox join conditions that don't obey the usual primary/foreign key model.  One such example is the materialized path pattern, where we compare strings for overlapping path tokens in order to produce a tree structure. Using custom operators in join conditions Very ambitious custom join conditions may fail to be directly persistable, and in some cases may not even load correctly. To remove the persistence part of the equation, use the flag :paramref:`~.relationship.viewonly` on the :func:`~sqlalchemy.orm.relationship`, which establishes it as a read-only attribute (data written to the collection will be ignored on flush()). However, in extreme cases, consider using a regular Python property in conjunction with :class:`.Query` as follows: We can use the above ``partitioned_bs`` relationship with most of the loader strategies, such as :func:`.selectinload`:: What this refers to originates from the fact that ``Article.magazine_id`` is the subject of two different foreign key constraints; it refers to ``Magazine.id`` directly as a source column, but also refers to ``Writer.magazine_id`` as a source column in the context of the composite key to ``Writer``.   If we associate an ``Article`` with a particular ``Magazine``, but then associate the ``Article`` with a ``Writer`` that's  associated  with a *different* ``Magazine``, the ORM will overwrite ``Article.magazine_id`` non-deterministically, silently changing which magazine we refer towards; it may also attempt to place NULL into this columnn if we de-associate a ``Writer`` from an ``Article``.  The warning lets us know this is the case. When specifying ``foreign_keys`` with Declarative, we can also use string names to specify, however it is important that if using a list, the **list is part of the string**:: When the above mapping is configured, we will see this warning emitted:: Where above, SQLAlchemy can't know automatically which columns should connect to which for the ``right_nodes`` and ``left_nodes`` relationships.   The :paramref:`~.relationship.primaryjoin` and :paramref:`~.relationship.secondaryjoin` arguments establish how we'd like to join to the association table. In the Declarative form above, as we are declaring these conditions within the Python block that corresponds to the ``Node`` class, the ``id`` variable is available directly as the :class:`.Column` object we wish to join with. Where above, the "selectinload" query looks like: Will render as:: Within this string SQL expression, we made use of the :func:`.and_` conjunction construct to establish two distinct predicates for the join condition - joining both the ``User.id`` and ``Address.user_id`` columns to each other, as well as limiting rows in ``Address`` to just ``city='Boston'``.   When using Declarative, rudimentary SQL functions like :func:`.and_` are automatically available in the evaluated namespace of a string :func:`.relationship` argument. ``Article`` can write to ``Article.writer_id`` on behalf of data persisted in the  ``Article.writer`` relationship, but only the ``Writer.id`` column; the ``Writer.magazine_id`` column should not be written into ``Article.magazine_id`` as it ultimately is sourced from ``Magazine.id``. ``Article`` first and foremost writes to ``Article.magazine_id`` based on data persisted in the ``Article.magazine`` relationship only, that is a value copied from ``Magazine.id``. ``Article`` takes ``Article.magazine_id`` into account when loading ``Article.writer``, even though it *doesn't* write to it on behalf of this relationship. the ORM will attempt to warn when a column is used as the synchronization target from more than one relationship simultaneously. this section details an experimental feature. 