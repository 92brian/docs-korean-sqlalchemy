��    '      T              �     �     �     �     �  $   �  �   "  9  �       �   #  �   �  �   �  �   M  �   �  b   r     �     �  a  	  M   h
  �   �
  �   �  �   |  N  H  ~   �  
     8  !  9   Z  j   �  �   �     �    �  X  �  m   !  �   �  q        �  �   �  (   A  1   j  x  �          2     N     i  $   �  �   �  9  _     �  �   �  �   B  �     �   �  �   j  b   �     ]     q  a  �  M   �   �   >!  �   ,"  �   #  N  �#  ~   %  
   �%  8  �%  9   �&  j   '  �   �'     +(    G(  X  P)  m   �*  �   +  q   �+    ,  �   -  (   �-  1   �-   :meth:`.Session.bind_mapper` :meth:`.Session.bind_table` :paramref:`.Session.binds` :ref:`session_partitioning` :ref:`session_transaction_isolation` A :class:`.ClauseElement` (i.e. :func:`~.sql.expression.select`, :func:`~.sql.expression.text`, etc.) which will be used to locate a bind, if a bind cannot otherwise be identified. A :class:`.ClauseElement` (i.e. :func:`~.sql.expression.select`, :func:`~.sql.expression.text`, etc.).  If the ``mapper`` argument is not present or could not produce a bind, the given expression construct will be searched for a bound element, typically a :class:`.Table` associated with bound :class:`.MetaData`. API Documentation Additional keyword arguments are sent to :meth:`get_bind()`, allowing additional arguments to be passed to custom implementations of :meth:`get_bind`. Alternatively, if this :class:`.Session` is configured with ``autocommit=True``, an ad-hoc :class:`.Connection` is returned using :meth:`.Engine.contextual_connect` on the underlying :class:`.Engine`. Ambiguity in multi-bind or unbound :class:`.Session` objects can be resolved through any of the optional keyword arguments.   This ultimately makes usage of the :meth:`.get_bind` method for resolution. Defines a rudimental 'horizontal sharding' system which allows a Session to distribute queries and persistence operations across multiple databases. For a multiply-bound or unbound :class:`.Session`, the ``mapper`` or ``clause`` arguments are used to determine the appropriate bind to return. For a usage example, see the :ref:`examples_sharding` example included in the source distribution. Horizontal Sharding Horizontal sharding support. If this :class:`.Session` is configured with ``autocommit=False``, either the :class:`.Connection` corresponding to the current transaction is returned, or if no transaction is in progress, a new one is begun and the :class:`.Connection` returned (note that no transactional state is established with the DBAPI until the first SQL statement is emitted). No bind can be found, :exc:`~sqlalchemy.exc.UnboundExecutionError` is raised. Note that the "mapper" argument is usually present when :meth:`.Session.get_bind` is called via an ORM operation such as a :meth:`.Session.query`, each individual INSERT/UPDATE/DELETE operation within a :meth:`.Session.flush`, call, etc. Note that the :meth:`.Session.get_bind` method can be overridden on a user-defined subclass of :class:`.Session` to provide any kind of bind resolution scheme.  See the example at :ref:`session_custom_partitioning`. Optional :class:`.Engine` to be used as the bind.  If this engine is already involved in an ongoing transaction, that connection will be used.  This argument takes precedence over ``mapper``, ``clause``. Optional :func:`.mapper` mapped class or instance of :class:`.Mapper`.   The bind can be derived from a :class:`.Mapper` first by consulting the "binds" map associated with this :class:`.Session`, and secondly by consulting the :class:`.MetaData` associated with the :class:`.Table` to which the :class:`.Mapper` is mapped for a bind. Optional :func:`.mapper` mapped class, used to identify the appropriate bind.  This argument takes precedence over ``clause``. Parameters Passed to :meth:`.Engine.connect`, indicating the :class:`.Connection` should be considered "single use", automatically closing when the first result set is closed.  This flag only has an effect if this :class:`.Session` is configured with ``autocommit=True`` and does not already have a transaction in progress. Return a "bind" to which this :class:`.Session` is bound. Return a :class:`.Connection` object corresponding to this :class:`.Session` object's transactional state. The "bind" is usually an instance of :class:`.Engine`, except in the case where the :class:`.Session` has been explicitly bound directly to a :class:`.Connection`. The order of resolution is: a dictionary of execution options that will be passed to :meth:`.Connection.execution_options`, **when the connection is first procured only**.   If the connection is already present within the :class:`.Session`, a warning is emitted and the arguments are ignored. a dictionary of execution options that will be passed to :meth:`.Connection.execution_options`, **when the connection is first procured only**.   If the connection is already present within the :class:`.Session`, a warning is emitted and the arguments are ignored.  .. versionadded:: 0.9.9  .. seealso::     :ref:`session_transaction_isolation` all subsequent operations with the returned query will be against the single shard regardless of other state. if clause given and session.binds is present, locate a bind based on :class:`.Table` objects found in the given clause present in session.binds. if clause given, attempt to return a bind linked to the :class:`.MetaData` ultimately associated with the clause. if mapper given and session.binds is present, locate a bind based first on the mapper in use, then on the mapped class in use, then on any base classes that are present in the ``__mro__`` of the mapped class, from more specific superclasses to more general. if mapper given, attempt to return a bind linked to the :class:`.MetaData` ultimately associated with the :class:`.Table` or other selectable to which the mapper is mapped. if session.bind is present, return that. return a new query, limited to a single shard ID. Project-Id-Version: SQLAlchemy 1.3
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
 :meth:`.Session.bind_mapper` :meth:`.Session.bind_table` :paramref:`.Session.binds` :ref:`session_partitioning` :ref:`session_transaction_isolation` A :class:`.ClauseElement` (i.e. :func:`~.sql.expression.select`, :func:`~.sql.expression.text`, etc.) which will be used to locate a bind, if a bind cannot otherwise be identified. A :class:`.ClauseElement` (i.e. :func:`~.sql.expression.select`, :func:`~.sql.expression.text`, etc.).  If the ``mapper`` argument is not present or could not produce a bind, the given expression construct will be searched for a bound element, typically a :class:`.Table` associated with bound :class:`.MetaData`. API Documentation Additional keyword arguments are sent to :meth:`get_bind()`, allowing additional arguments to be passed to custom implementations of :meth:`get_bind`. Alternatively, if this :class:`.Session` is configured with ``autocommit=True``, an ad-hoc :class:`.Connection` is returned using :meth:`.Engine.contextual_connect` on the underlying :class:`.Engine`. Ambiguity in multi-bind or unbound :class:`.Session` objects can be resolved through any of the optional keyword arguments.   This ultimately makes usage of the :meth:`.get_bind` method for resolution. Defines a rudimental 'horizontal sharding' system which allows a Session to distribute queries and persistence operations across multiple databases. For a multiply-bound or unbound :class:`.Session`, the ``mapper`` or ``clause`` arguments are used to determine the appropriate bind to return. For a usage example, see the :ref:`examples_sharding` example included in the source distribution. Horizontal Sharding Horizontal sharding support. If this :class:`.Session` is configured with ``autocommit=False``, either the :class:`.Connection` corresponding to the current transaction is returned, or if no transaction is in progress, a new one is begun and the :class:`.Connection` returned (note that no transactional state is established with the DBAPI until the first SQL statement is emitted). No bind can be found, :exc:`~sqlalchemy.exc.UnboundExecutionError` is raised. Note that the "mapper" argument is usually present when :meth:`.Session.get_bind` is called via an ORM operation such as a :meth:`.Session.query`, each individual INSERT/UPDATE/DELETE operation within a :meth:`.Session.flush`, call, etc. Note that the :meth:`.Session.get_bind` method can be overridden on a user-defined subclass of :class:`.Session` to provide any kind of bind resolution scheme.  See the example at :ref:`session_custom_partitioning`. Optional :class:`.Engine` to be used as the bind.  If this engine is already involved in an ongoing transaction, that connection will be used.  This argument takes precedence over ``mapper``, ``clause``. Optional :func:`.mapper` mapped class or instance of :class:`.Mapper`.   The bind can be derived from a :class:`.Mapper` first by consulting the "binds" map associated with this :class:`.Session`, and secondly by consulting the :class:`.MetaData` associated with the :class:`.Table` to which the :class:`.Mapper` is mapped for a bind. Optional :func:`.mapper` mapped class, used to identify the appropriate bind.  This argument takes precedence over ``clause``. Parameters Passed to :meth:`.Engine.connect`, indicating the :class:`.Connection` should be considered "single use", automatically closing when the first result set is closed.  This flag only has an effect if this :class:`.Session` is configured with ``autocommit=True`` and does not already have a transaction in progress. Return a "bind" to which this :class:`.Session` is bound. Return a :class:`.Connection` object corresponding to this :class:`.Session` object's transactional state. The "bind" is usually an instance of :class:`.Engine`, except in the case where the :class:`.Session` has been explicitly bound directly to a :class:`.Connection`. The order of resolution is: a dictionary of execution options that will be passed to :meth:`.Connection.execution_options`, **when the connection is first procured only**.   If the connection is already present within the :class:`.Session`, a warning is emitted and the arguments are ignored. a dictionary of execution options that will be passed to :meth:`.Connection.execution_options`, **when the connection is first procured only**.   If the connection is already present within the :class:`.Session`, a warning is emitted and the arguments are ignored.  .. versionadded:: 0.9.9  .. seealso::     :ref:`session_transaction_isolation` all subsequent operations with the returned query will be against the single shard regardless of other state. if clause given and session.binds is present, locate a bind based on :class:`.Table` objects found in the given clause present in session.binds. if clause given, attempt to return a bind linked to the :class:`.MetaData` ultimately associated with the clause. if mapper given and session.binds is present, locate a bind based first on the mapper in use, then on the mapped class in use, then on any base classes that are present in the ``__mro__`` of the mapped class, from more specific superclasses to more general. if mapper given, attempt to return a bind linked to the :class:`.MetaData` ultimately associated with the :class:`.Table` or other selectable to which the mapper is mapped. if session.bind is present, return that. return a new query, limited to a single shard ID. 