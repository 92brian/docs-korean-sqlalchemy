��    0      �                �      �  |        �     �  �  �  Y  u	  �   �
  [   �  d     z   ~  �   �  y  �  �  �  O  �    L  �  R  �   "       �   ,  *  $    O  �  n  �  �  �   �  �   �   $  Z!  Z   #  �   �#  r   �$  W  %  �  g'  �  �)  �  �+  �  �-  �   &/  �   �/    �0  �   �1  D  �2  �  4     �5     �5     �5     �5     �5     �5  x  �5  �  `7    <9  |   N:     �:     �:  �  �:  Y  �=  �   ?  [    @  d   \@  z   �@  �   <A  y  �A  �  ?C  O  ?E    �G  �  �I  �   eK     XL  �   oL  *  gM    �N  �  �P  �  @R  �   %T  �   U  $  �U  Z   �W  �   X  r   �X  W  RY  �  �[  �  >^  �  �_  �  �a  �   ic  �   &d    e  �   
f  D  	g  �  Nh     �i     �i     j     	j     j     j   A database level ``ON DELETE`` cascade is configured effectively on the **many-to-one** side of the relationship; that is, we configure it relative to the ``FOREIGN KEY`` constraint that is the "many" side of a relationship.  At the ORM level, **this direction is reversed**. SQLAlchemy handles the deletion of "child" objects relative to a "parent" from the "parent" side, which means that ``delete`` and ``delete-orphan`` cascade are configured on the **one-to-many** side. Alternatively, if our ``User.addresses`` relationship does *not* have ``delete`` cascade, SQLAlchemy's default behavior is to instead de-associate ``address1`` and ``address2`` from ``user1`` by setting their foreign key reference to ``NULL``.  Using a mapping as follows:: Cascade behavior is configured using the :paramref:`~.relationship.cascade` option on :func:`~sqlalchemy.orm.relationship`:: Cascades Controlling Cascade on Backrefs Database level ``ON DELETE`` cascade is **vastly more efficient** than that of SQLAlchemy.  The database can chain a series of cascade operations across many relationships at once; e.g. if row A is deleted, all the related rows in table B can be deleted, and all the C rows related to each of those B rows, and on and on, all within the scope of a single DELETE statement.  SQLAlchemy on the other hand, in order to support the cascading delete operation fully, has to individually load each related collection in order to target all rows that then may have further related collections.  That is, SQLAlchemy isn't sophisticated enough to emit a DELETE for all those related rows at once within this context. Database level foreign keys with no ``ON DELETE`` setting are often used to **prevent** a parent row from being removed, as it would necessarily leave an unhandled related row present.  If this behavior is desired in a one-to-many relationship, SQLAlchemy's default behavior of setting a foreign key to ``NULL`` can be caught in one of two ways: If an ``Order`` is already in the session, and is assigned to the ``order`` attribute of an ``Item``, the backref appends the ``Item`` to the ``items`` collection of that ``Order``, resulting in the ``save-update`` cascade taking place:: If using the above mapping, we have a ``User`` object and two related ``Address`` objects:: If we add ``user1`` to a :class:`.Session`, it will also add ``address1``, ``address2`` implicitly:: If we mark ``user1`` for deletion, after the flush operation proceeds, ``address1`` and ``address2`` will also be deleted: It is important to note the differences between the ORM and the relational database's notion of "cascade" as well as how they integrate: Mappers support the concept of configurable :term:`cascade` behavior on :func:`~sqlalchemy.orm.relationship` constructs.  This refers to how operations performed on a "parent" object relative to a particular :class:`.Session` should be propagated to items referred to by that relationship (e.g. "child" objects), and is affected by the :paramref:`.relationship.cascade` option. One case where ``save-update`` cascade does sometimes get in the way is in that it takes place in both directions for bi-directional relationships, e.g. backrefs, meaning that the association of a child object with a particular parent can have the effect of the parent object being implicitly associated with that child object's :class:`.Session`; this pattern, as well as how to modify its behavior using the :paramref:`~.relationship.cascade_backrefs` flag, is discussed in the section :ref:`backref_cascade`. SQLAlchemy doesn't **need** to be this sophisticated, as we instead provide smooth integration with the database's own ``ON DELETE`` functionality, by using the :paramref:`~.relationship.passive_deletes` option in conjunction with properly configured foreign key constraints.   Under this behavior, SQLAlchemy only emits DELETE for those rows that are already locally present in the :class:`.Session`; for any collections that are unloaded, it leaves them to the database to handle, rather than emitting a SELECT for them.  The section :ref:`passive_deletes` provides an example of this use. SQLAlchemy's notion of cascading behavior on relationships, as well as the options to configure them, are primarily derived from the similar feature in the Hibernate ORM; Hibernate refers to "cascade" in a few places such as in `Example: Parent/Child <https://docs.jboss.org/hibernate/orm/3.3/reference/en-US/html/example-parentchild.html>`_. If cascades are confusing, we'll refer to their conclusion, stating "The sections we have just covered can be a bit confusing. However, in practice, it all works out nicely." So above, the assignment of ``i1.order = o1`` will append ``i1`` to the ``items`` collection of ``o1``, but will not add ``i1`` to the session.   You can, of course, :meth:`~.Session.add` ``i1`` to the session at a later point.   This option may be helpful for situations where an object needs to be kept out of a session until it's construction is completed, but still needs to be given associations to objects which are already persistent in the target session. The :ref:`cascade_save_update` cascade by default takes place on attribute change events emitted from backrefs.  This is probably a confusing statement more easily described through demonstration; it means that, given a mapping such as this:: The Origins of Cascade The ``delete`` cascade indicates that when a "parent" object is marked for deletion, its related "child" objects should also be marked for deletion.   If for example we we have a relationship ``User.addresses`` with ``delete`` cascade configured:: The ``save-update`` cascade is on by default, and is typically taken for granted; it simplifies code by allowing a single call to :meth:`.Session.add` to register an entire structure of objects within that :class:`.Session` at once.   While it can be disabled, there is usually not a need to do so. The behavior of SQLAlchemy's "delete" cascade has a lot of overlap with the ``ON DELETE CASCADE`` feature of a database foreign key, as well as with that of the ``ON DELETE SET NULL`` foreign key setting when "delete" cascade is not specified.   Database level "ON DELETE" cascades are specific to the "FOREIGN KEY" construct of the relational database; SQLAlchemy allows configuration of these schema-level constructs at the :term:`DDL` level using options on :class:`.ForeignKeyConstraint` which are described at :ref:`on_update_on_delete`. The default behavior of cascade is limited to cascades of the so-called :ref:`cascade_save_update` and :ref:`cascade_merge` settings. The typical "alternative" setting for cascade is to add the :ref:`cascade_delete` and :ref:`cascade_delete_orphan` options; these settings are appropriate for related objects which only exist as long as they are attached to their parent, and are otherwise deleted. The default value of :paramref:`~.relationship.cascade` is ``save-update, merge``. The typical alternative setting for this parameter is either ``all`` or more commonly ``all, delete-orphan``.  The ``all`` symbol is a synonym for ``save-update, merge, refresh-expire, expunge, delete``, and using it in conjunction with ``delete-orphan`` indicates that the child object should follow along with its parent in all cases, and be deleted once it is no longer associated with that parent. The easiest and most common is just to set the foreign-key-holding column to ``NOT NULL`` at the database schema level.  An attempt by SQLAlchemy to set the column to NULL will fail with a simple NOT NULL constraint exception. The list of available values which can be specified for the :paramref:`~.relationship.cascade` parameter are described in the following subsections. The other, more special case way is to set the :paramref:`~.relationship.passive_deletes` flag to the string ``"all"``.  This has the effect of entirely disabling SQLAlchemy's behavior of setting the foreign key column to NULL, and a DELETE will be emitted for the parent row without any affect on the child row, even if the child row is present in memory. This may be desirable in the case when database-level foreign key triggers, either special ``ON DELETE`` settings or otherwise, need to be activated in all cases when a parent row is deleted. This behavior can be disabled using the :paramref:`~.relationship.cascade_backrefs` flag:: To set cascades on a backref, the same flag can be used with the :func:`~.sqlalchemy.orm.backref` function, which ultimately feeds its arguments back into :func:`~sqlalchemy.orm.relationship`:: Upon deletion of a parent ``User`` object, the rows in ``address`` are not deleted, but are instead de-associated: When using a :func:`.relationship` that also includes a many-to-many table using the :paramref:`~.relationship.secondary` option, SQLAlchemy's delete cascade handles the rows in this many-to-many table automatically. Just like, as described in :ref:`relationships_many_to_many_deletion`, the addition or removal of an object from a many-to-many collection results in the INSERT or DELETE of a row in the many-to-many table, the ``delete`` cascade, when activated as the result of a parent object delete operation, will DELETE not just the row in the "child" table but also in the many-to-many table. While database-level ``ON DELETE`` functionality works only on the "many" side of a relationship, SQLAlchemy's "delete" cascade has **limited** ability to operate in the *reverse* direction as well, meaning it can be configured on the "many" side to delete an object on the "one" side when the reference on the "many" side is deleted.  However this can easily result in constraint violations if there are other objects referring to this "one" side from the "many", so it typically is only useful when a relationship is in fact a "one to one".  The :paramref:`~.relationship.single_parent` flag should be used to establish an in-Python assertion for this case. ``delete-orphan`` cascade adds behavior to the ``delete`` cascade, such that a child object will be marked for deletion when it is de-associated from the parent, not just when the parent is marked for deletion.   This is a common feature when dealing with a related object that is "owned" by its parent, with a NOT NULL foreign key, so that removal of the item from the parent collection results in its deletion. ``delete-orphan`` cascade implies that each child object can only have one parent at a time, so is configured in the vast majority of cases on a one-to-many relationship.   Setting it on a many-to-one or many-to-many relationship is more awkward; for this use case, SQLAlchemy requires that the :func:`~sqlalchemy.orm.relationship` be configured with the :paramref:`~.relationship.single_parent` argument, establishes Python-side validation that ensures the object is associated with only one parent at a time. ``delete`` cascade is more often than not used in conjunction with :ref:`cascade_delete_orphan` cascade, which will emit a DELETE for the related row if the "child" object is deassociated from the parent.  The combination of ``delete`` and ``delete-orphan`` cascade covers both situations where SQLAlchemy has to decide between setting a foreign key column to NULL versus deleting the row entirely. ``expunge`` cascade indicates that when the parent object is removed from the :class:`.Session` using :meth:`.Session.expunge`, the operation should be propagated down to referred objects. ``merge`` cascade indicates that the :meth:`.Session.merge` operation should be propagated from a parent that's the subject of the :meth:`.Session.merge` call down to referred objects. This cascade is also on by default. ``refresh-expire`` is an uncommon option, indicating that the :meth:`.Session.expire` operation should be propagated from a parent down to referred objects.   When using :meth:`.Session.refresh`, the referred objects are expired only, but not actually refreshed. ``save-update`` cascade also affects attribute operations for objects that are already present in a :class:`.Session`.  If we add a third object, ``address3`` to the ``user1.addresses`` collection, it becomes part of the state of that :class:`.Session`:: ``save-update`` cascade indicates that when an object is placed into a :class:`.Session` via :meth:`.Session.add`, all the objects associated with it via this :func:`.relationship` should also be added to that same :class:`.Session`.  Suppose we have an object ``user1`` with two related objects ``address1``, ``address2``:: ``save-update`` has the possibly surprising behavior which is that persistent objects which were *removed* from a collection or in some cases a scalar attribute may also be pulled into the :class:`.Session` of a parent object; this is so that the flush process may handle that related object appropriately. This case can usually only arise if an object is removed from one :class:`.Session` and added to another:: delete delete-orphan expunge merge refresh-expire save-update Project-Id-Version: SQLAlchemy 1.3
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
 A database level ``ON DELETE`` cascade is configured effectively on the **many-to-one** side of the relationship; that is, we configure it relative to the ``FOREIGN KEY`` constraint that is the "many" side of a relationship.  At the ORM level, **this direction is reversed**. SQLAlchemy handles the deletion of "child" objects relative to a "parent" from the "parent" side, which means that ``delete`` and ``delete-orphan`` cascade are configured on the **one-to-many** side. Alternatively, if our ``User.addresses`` relationship does *not* have ``delete`` cascade, SQLAlchemy's default behavior is to instead de-associate ``address1`` and ``address2`` from ``user1`` by setting their foreign key reference to ``NULL``.  Using a mapping as follows:: Cascade behavior is configured using the :paramref:`~.relationship.cascade` option on :func:`~sqlalchemy.orm.relationship`:: Cascades Controlling Cascade on Backrefs Database level ``ON DELETE`` cascade is **vastly more efficient** than that of SQLAlchemy.  The database can chain a series of cascade operations across many relationships at once; e.g. if row A is deleted, all the related rows in table B can be deleted, and all the C rows related to each of those B rows, and on and on, all within the scope of a single DELETE statement.  SQLAlchemy on the other hand, in order to support the cascading delete operation fully, has to individually load each related collection in order to target all rows that then may have further related collections.  That is, SQLAlchemy isn't sophisticated enough to emit a DELETE for all those related rows at once within this context. Database level foreign keys with no ``ON DELETE`` setting are often used to **prevent** a parent row from being removed, as it would necessarily leave an unhandled related row present.  If this behavior is desired in a one-to-many relationship, SQLAlchemy's default behavior of setting a foreign key to ``NULL`` can be caught in one of two ways: If an ``Order`` is already in the session, and is assigned to the ``order`` attribute of an ``Item``, the backref appends the ``Item`` to the ``items`` collection of that ``Order``, resulting in the ``save-update`` cascade taking place:: If using the above mapping, we have a ``User`` object and two related ``Address`` objects:: If we add ``user1`` to a :class:`.Session`, it will also add ``address1``, ``address2`` implicitly:: If we mark ``user1`` for deletion, after the flush operation proceeds, ``address1`` and ``address2`` will also be deleted: It is important to note the differences between the ORM and the relational database's notion of "cascade" as well as how they integrate: Mappers support the concept of configurable :term:`cascade` behavior on :func:`~sqlalchemy.orm.relationship` constructs.  This refers to how operations performed on a "parent" object relative to a particular :class:`.Session` should be propagated to items referred to by that relationship (e.g. "child" objects), and is affected by the :paramref:`.relationship.cascade` option. One case where ``save-update`` cascade does sometimes get in the way is in that it takes place in both directions for bi-directional relationships, e.g. backrefs, meaning that the association of a child object with a particular parent can have the effect of the parent object being implicitly associated with that child object's :class:`.Session`; this pattern, as well as how to modify its behavior using the :paramref:`~.relationship.cascade_backrefs` flag, is discussed in the section :ref:`backref_cascade`. SQLAlchemy doesn't **need** to be this sophisticated, as we instead provide smooth integration with the database's own ``ON DELETE`` functionality, by using the :paramref:`~.relationship.passive_deletes` option in conjunction with properly configured foreign key constraints.   Under this behavior, SQLAlchemy only emits DELETE for those rows that are already locally present in the :class:`.Session`; for any collections that are unloaded, it leaves them to the database to handle, rather than emitting a SELECT for them.  The section :ref:`passive_deletes` provides an example of this use. SQLAlchemy's notion of cascading behavior on relationships, as well as the options to configure them, are primarily derived from the similar feature in the Hibernate ORM; Hibernate refers to "cascade" in a few places such as in `Example: Parent/Child <https://docs.jboss.org/hibernate/orm/3.3/reference/en-US/html/example-parentchild.html>`_. If cascades are confusing, we'll refer to their conclusion, stating "The sections we have just covered can be a bit confusing. However, in practice, it all works out nicely." So above, the assignment of ``i1.order = o1`` will append ``i1`` to the ``items`` collection of ``o1``, but will not add ``i1`` to the session.   You can, of course, :meth:`~.Session.add` ``i1`` to the session at a later point.   This option may be helpful for situations where an object needs to be kept out of a session until it's construction is completed, but still needs to be given associations to objects which are already persistent in the target session. The :ref:`cascade_save_update` cascade by default takes place on attribute change events emitted from backrefs.  This is probably a confusing statement more easily described through demonstration; it means that, given a mapping such as this:: The Origins of Cascade The ``delete`` cascade indicates that when a "parent" object is marked for deletion, its related "child" objects should also be marked for deletion.   If for example we we have a relationship ``User.addresses`` with ``delete`` cascade configured:: The ``save-update`` cascade is on by default, and is typically taken for granted; it simplifies code by allowing a single call to :meth:`.Session.add` to register an entire structure of objects within that :class:`.Session` at once.   While it can be disabled, there is usually not a need to do so. The behavior of SQLAlchemy's "delete" cascade has a lot of overlap with the ``ON DELETE CASCADE`` feature of a database foreign key, as well as with that of the ``ON DELETE SET NULL`` foreign key setting when "delete" cascade is not specified.   Database level "ON DELETE" cascades are specific to the "FOREIGN KEY" construct of the relational database; SQLAlchemy allows configuration of these schema-level constructs at the :term:`DDL` level using options on :class:`.ForeignKeyConstraint` which are described at :ref:`on_update_on_delete`. The default behavior of cascade is limited to cascades of the so-called :ref:`cascade_save_update` and :ref:`cascade_merge` settings. The typical "alternative" setting for cascade is to add the :ref:`cascade_delete` and :ref:`cascade_delete_orphan` options; these settings are appropriate for related objects which only exist as long as they are attached to their parent, and are otherwise deleted. The default value of :paramref:`~.relationship.cascade` is ``save-update, merge``. The typical alternative setting for this parameter is either ``all`` or more commonly ``all, delete-orphan``.  The ``all`` symbol is a synonym for ``save-update, merge, refresh-expire, expunge, delete``, and using it in conjunction with ``delete-orphan`` indicates that the child object should follow along with its parent in all cases, and be deleted once it is no longer associated with that parent. The easiest and most common is just to set the foreign-key-holding column to ``NOT NULL`` at the database schema level.  An attempt by SQLAlchemy to set the column to NULL will fail with a simple NOT NULL constraint exception. The list of available values which can be specified for the :paramref:`~.relationship.cascade` parameter are described in the following subsections. The other, more special case way is to set the :paramref:`~.relationship.passive_deletes` flag to the string ``"all"``.  This has the effect of entirely disabling SQLAlchemy's behavior of setting the foreign key column to NULL, and a DELETE will be emitted for the parent row without any affect on the child row, even if the child row is present in memory. This may be desirable in the case when database-level foreign key triggers, either special ``ON DELETE`` settings or otherwise, need to be activated in all cases when a parent row is deleted. This behavior can be disabled using the :paramref:`~.relationship.cascade_backrefs` flag:: To set cascades on a backref, the same flag can be used with the :func:`~.sqlalchemy.orm.backref` function, which ultimately feeds its arguments back into :func:`~sqlalchemy.orm.relationship`:: Upon deletion of a parent ``User`` object, the rows in ``address`` are not deleted, but are instead de-associated: When using a :func:`.relationship` that also includes a many-to-many table using the :paramref:`~.relationship.secondary` option, SQLAlchemy's delete cascade handles the rows in this many-to-many table automatically. Just like, as described in :ref:`relationships_many_to_many_deletion`, the addition or removal of an object from a many-to-many collection results in the INSERT or DELETE of a row in the many-to-many table, the ``delete`` cascade, when activated as the result of a parent object delete operation, will DELETE not just the row in the "child" table but also in the many-to-many table. While database-level ``ON DELETE`` functionality works only on the "many" side of a relationship, SQLAlchemy's "delete" cascade has **limited** ability to operate in the *reverse* direction as well, meaning it can be configured on the "many" side to delete an object on the "one" side when the reference on the "many" side is deleted.  However this can easily result in constraint violations if there are other objects referring to this "one" side from the "many", so it typically is only useful when a relationship is in fact a "one to one".  The :paramref:`~.relationship.single_parent` flag should be used to establish an in-Python assertion for this case. ``delete-orphan`` cascade adds behavior to the ``delete`` cascade, such that a child object will be marked for deletion when it is de-associated from the parent, not just when the parent is marked for deletion.   This is a common feature when dealing with a related object that is "owned" by its parent, with a NOT NULL foreign key, so that removal of the item from the parent collection results in its deletion. ``delete-orphan`` cascade implies that each child object can only have one parent at a time, so is configured in the vast majority of cases on a one-to-many relationship.   Setting it on a many-to-one or many-to-many relationship is more awkward; for this use case, SQLAlchemy requires that the :func:`~sqlalchemy.orm.relationship` be configured with the :paramref:`~.relationship.single_parent` argument, establishes Python-side validation that ensures the object is associated with only one parent at a time. ``delete`` cascade is more often than not used in conjunction with :ref:`cascade_delete_orphan` cascade, which will emit a DELETE for the related row if the "child" object is deassociated from the parent.  The combination of ``delete`` and ``delete-orphan`` cascade covers both situations where SQLAlchemy has to decide between setting a foreign key column to NULL versus deleting the row entirely. ``expunge`` cascade indicates that when the parent object is removed from the :class:`.Session` using :meth:`.Session.expunge`, the operation should be propagated down to referred objects. ``merge`` cascade indicates that the :meth:`.Session.merge` operation should be propagated from a parent that's the subject of the :meth:`.Session.merge` call down to referred objects. This cascade is also on by default. ``refresh-expire`` is an uncommon option, indicating that the :meth:`.Session.expire` operation should be propagated from a parent down to referred objects.   When using :meth:`.Session.refresh`, the referred objects are expired only, but not actually refreshed. ``save-update`` cascade also affects attribute operations for objects that are already present in a :class:`.Session`.  If we add a third object, ``address3`` to the ``user1.addresses`` collection, it becomes part of the state of that :class:`.Session`:: ``save-update`` cascade indicates that when an object is placed into a :class:`.Session` via :meth:`.Session.add`, all the objects associated with it via this :func:`.relationship` should also be added to that same :class:`.Session`.  Suppose we have an object ``user1`` with two related objects ``address1``, ``address2``:: ``save-update`` has the possibly surprising behavior which is that persistent objects which were *removed* from a collection or in some cases a scalar attribute may also be pulled into the :class:`.Session` of a parent object; this is so that the flush process may handle that related object appropriately. This case can usually only arise if an object is removed from one :class:`.Session` and added to another:: delete delete-orphan expunge merge refresh-expire save-update 