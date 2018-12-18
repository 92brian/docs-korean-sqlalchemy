��          �               �   �   �      �     �      `  ,  &   �  .   �  �   �    �  P  �  �   �  ;  �	  �  �
  x  �  �        �     �      `  4  &   �  .   �  �   �    �  P  �  �   �  ;  �  �  �   :func:`.orm.reconstructor` is a shortcut into a larger system of "instance level" events, which can be subscribed to using the event API - see :class:`.InstanceEvents` for the full API description of these events. :meth:`.InstanceEvents.load` :ref:`mapping_constructors` Above, when ``obj = MyMappedClass()`` is executed, the ``__init__`` constructor is invoked normally and the ``data`` argument is required.  When instances are loaded during a :class:`~sqlalchemy.orm.query.Query` operation as in ``query(MyMappedClass).one()``, ``init_on_load`` is called. Any method may be tagged as the :func:`.orm.reconstructor`, even the ``__init__`` method itself.    It is invoked after all immediate column-level attributes are loaded as well as after eagerly-loaded scalar relationships.  Eagerly loaded collections may be only partially populated or not populated at all, depending on the kind of eager loading used. Constructors and Object Initialization Decorate a method as the 'reconstructor' hook. Designates a method as the "reconstructor", an ``__init__``-like method that will be called by the ORM after the instance has been loaded from the database or otherwise reconstituted. If you need to do some setup on database-loaded instances before they're ready to use, there is an event hook known as :meth:`.InstanceEvents.load` which can achieve this; it is also available via a class-specific decorator called :func:`.orm.reconstructor`.   When using :func:`.orm.reconstructor`, the mapper will invoke the decorated method with no arguments every time it loads or reconstructs an instance of the class. This is useful for recreating transient properties that are normally assigned in ``__init__``:: Mapping imposes no restrictions or requirements on the constructor (``__init__``) method for the class. You are free to require any arguments for the function that you wish, assign attributes to the instance that are unknown to the ORM, and generally do anything else you would normally do when writing a constructor for a Python class. ORM state changes made to objects at this stage will not be recorded for the next flush operation, so the activity within a reconstructor should be conservative. The SQLAlchemy ORM does not call ``__init__`` when recreating objects from database rows. The ORM's process is somewhat akin to the Python standard library's ``pickle`` module, invoking the low level ``__new__`` method and then quietly restoring attributes directly on the instance rather than calling ``__init__``. The reconstructor will be invoked with no arguments.  Scalar (non-collection) database-mapped attributes of the instance will be available for use within the function.  Eagerly-loaded collections are generally not yet available and will usually only contain the first element.  ORM state changes made to objects at this stage will not be recorded for the next flush() operation, so the activity within a reconstructor should be conservative. Project-Id-Version: SQLAlchemy 1.3
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
 :func:`.orm.reconstructor` is a shortcut into a larger system of "instance level" events, which can be subscribed to using the event API - see :class:`.InstanceEvents` for the full API description of these events. :meth:`.InstanceEvents.load` :ref:`mapping_constructors` Above, when ``obj = MyMappedClass()`` is executed, the ``__init__`` constructor is invoked normally and the ``data`` argument is required.  When instances are loaded during a :class:`~sqlalchemy.orm.query.Query` operation as in ``query(MyMappedClass).one()``, ``init_on_load`` is called. Any method may be tagged as the :func:`.orm.reconstructor`, even the ``__init__`` method itself.    It is invoked after all immediate column-level attributes are loaded as well as after eagerly-loaded scalar relationships.  Eagerly loaded collections may be only partially populated or not populated at all, depending on the kind of eager loading used. Constructors and Object Initialization Decorate a method as the 'reconstructor' hook. Designates a method as the "reconstructor", an ``__init__``-like method that will be called by the ORM after the instance has been loaded from the database or otherwise reconstituted. If you need to do some setup on database-loaded instances before they're ready to use, there is an event hook known as :meth:`.InstanceEvents.load` which can achieve this; it is also available via a class-specific decorator called :func:`.orm.reconstructor`.   When using :func:`.orm.reconstructor`, the mapper will invoke the decorated method with no arguments every time it loads or reconstructs an instance of the class. This is useful for recreating transient properties that are normally assigned in ``__init__``:: Mapping imposes no restrictions or requirements on the constructor (``__init__``) method for the class. You are free to require any arguments for the function that you wish, assign attributes to the instance that are unknown to the ORM, and generally do anything else you would normally do when writing a constructor for a Python class. ORM state changes made to objects at this stage will not be recorded for the next flush operation, so the activity within a reconstructor should be conservative. The SQLAlchemy ORM does not call ``__init__`` when recreating objects from database rows. The ORM's process is somewhat akin to the Python standard library's ``pickle`` module, invoking the low level ``__new__`` method and then quietly restoring attributes directly on the instance rather than calling ``__init__``. The reconstructor will be invoked with no arguments.  Scalar (non-collection) database-mapped attributes of the instance will be available for use within the function.  Eagerly-loaded collections are generally not yet available and will usually only contain the first element.  ORM state changes made to objects at this stage will not be recorded for the next flush() operation, so the activity within a reconstructor should be conservative. 