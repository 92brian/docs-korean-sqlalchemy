��    /      �                        !     :  �  M  �   �    �  �   �    �  y  �  �   f
    H    M  �  Y       7   7  n   o  7   �  -     �   D  /   (  ]   X  "   �  "   �     �  )        6  �   G  
   1  D   <  P  �  K   �  Q     h   p  o  �     I     `  �   i  �  ^  �     �   �  V   9  E  �  Y   �  �   0     �   �   �!  x  a"     �#     �#     $  �  $  �   �%    �&  �   �'    �(  y  �)  �   3+    ,    .  �  &/     �0  7   1  n   <1  7   �1  -   �1  �   2  /   �2  ]   %3  "   �3  "   �3     �3  )   �3     4  �   4  
   �4  D   	5  P  N5  K   �8  Q   �8  h   =9  o  �9     ;     -;  �   6;  �  +<  �   �=  �   x>  V   ?  E  ]?  Y   �@  �   �@    �A  �   �B   "GREATEST" function "UTC timestamp" function "false" expression :class:`~sqlalchemy.schema.DDLElement` - The root of all DDL expressions, like CREATE TABLE, ALTER TABLE, etc. Compilation of ``DDLElement`` subclasses is issued by a ``DDLCompiler`` instead of a ``SQLCompiler``. ``DDLElement`` also features ``Table`` and ``MetaData`` event hooks via the ``execute_at()`` method, allowing the construct to be invoked during CREATE TABLE and DROP TABLE sequences. :class:`~sqlalchemy.sql.expression.ClauseElement` - This is the root expression class. Any SQL expression can be derived from this base, and is probably the best choice for longer constructs such as specialized INSERT statements. :class:`~sqlalchemy.sql.expression.ColumnElement` - The root of all "column-like" elements. Anything that you'd place in the "columns" clause of a SELECT statement (as well as order by and group by) can derive from this - the object will automatically have Python "comparison" behavior. :class:`~sqlalchemy.sql.expression.ColumnElement` classes want to have a ``type`` member which is expression's return type.  This can be established at the instance level in the constructor, or at the class level if its generally constant:: :class:`~sqlalchemy.sql.expression.Executable` - This is a mixin which should be used with any expression class that represents a "standalone" SQL statement that can be passed directly to an ``execute()`` method.  It is already implicit within ``DDLElement`` and ``FunctionElement``. :class:`~sqlalchemy.sql.functions.FunctionElement` - This is a hybrid of a ``ColumnElement`` and a "from clause" like object, and represents a SQL function or stored procedure type of call. Since most databases support statements along the line of "SELECT FROM <some function>" ``FunctionElement`` adds in the ability to be used in the FROM clause of a ``select()`` construct:: A big part of using the compiler extension is subclassing SQLAlchemy expression constructs. To make this easier, the expression and schema packages feature a set of "bases" intended for common tasks. A synopsis is as follows: A function that works like "CURRENT_TIMESTAMP" except applies the appropriate conversions so that the time is in UTC time.   Timestamps are best stored in relational databases as UTC, without time zones.   UTC so that your database doesn't think time has gone backwards in the hour when daylight savings ends, without timezones because timezones are like character encodings - they're best applied only at the endpoints of an application (i.e. convert to UTC upon user input, re-apply desired timezone upon display). Above, ``MyColumn`` extends :class:`~sqlalchemy.sql.expression.ColumnClause`, the base expression element for named column objects. The ``compiles`` decorator registers itself with the ``MyColumn`` class so that it is invoked when the object is compiled to a string:: Above, we add an additional flag to the process step as called by :meth:`.SQLCompiler.process`, which is the ``literal_binds`` flag.  This indicates that any SQL expression which refers to a :class:`.BindParameter` object or other "literal" object such as those which refer to strings or integers should be rendered **in-place**, rather than being referred to as a bound parameter;  when emitting DDL, bound parameters are typically not supported. Changing Compilation of Types Changing the default compilation of existing constructs Compilers can also be made dialect-specific. The appropriate compiler will be invoked for the dialect in use:: Compiling sub-elements of a custom expression construct Cross Compiling between SQL and DDL compilers Currently a quick way to do this is to subclass :class:`.Executable`, then add the "autocommit" flag to the ``_execution_options`` dictionary (note this is a "frozen" dictionary which supplies a generative ``union()`` method):: Custom SQL Constructs and Compilation Extension DDL elements that subclass :class:`.DDLElement` already have the "autocommit" flag turned on. Dialect-specific compilation rules Enabling Autocommit on a Construct Example usage:: For PostgreSQL and Microsoft SQL Server:: Further Examples More succinctly, if the construct is truly similar to an INSERT, UPDATE, or DELETE, :class:`.UpdateBase` can be used, which already is a subclass of :class:`.Executable`, :class:`.ClauseElement` and includes the ``autocommit`` flag:: Produces:: Provides an API for creation of custom ClauseElements and compilers. Recall from the section :ref:`autocommit` that the :class:`.Engine`, when asked to execute a construct in the absence of a user-defined transaction, detects if the given construct represents DML or DDL, that is, a data modification or data definition statement, which requires (or may require, in the case of DDL) that the transaction generated by the DBAPI be committed (recall that DBAPI always has a transaction going on regardless of what SQLAlchemy does).   Checking for this is actually accomplished by checking for the "autocommit" execution option on the construct.    When building a construct like an INSERT derivation, a new DDL type, or perhaps a stored procedure that alters data, the "autocommit" option needs to be set in order for the statement to function with "connectionless" execution (as described in :ref:`dbengine_implicit`). Register a function as a compiler for a given :class:`.ClauseElement` type. Remove all custom compilers associated with a given :class:`.ClauseElement` type. Render a "false" constant expression, rendering as "0" on platforms that don't have a "false" constant:: SQL and DDL constructs are each compiled using different base compilers - ``SQLCompiler`` and ``DDLCompiler``.   A common need is to access the compilation rules of SQL expressions from within a DDL expression. The ``DDLCompiler`` includes an accessor ``sql_compiler`` for this reason, such as below where we generate a CHECK constraint that embeds a SQL expression:: Subclassing Guidelines Synopsis The "GREATEST" function is given any number of arguments and returns the one that is of the highest value - its equivalent to Python's ``max`` function.  A SQL standard version versus a CASE based version which only accommodates two arguments:: The ``compiler`` argument is the :class:`~sqlalchemy.engine.interfaces.Compiled` object in use. This object can be inspected for any information about the in-progress compilation, including ``compiler.dialect``, ``compiler.statement`` etc. The :class:`~sqlalchemy.sql.compiler.SQLCompiler` and :class:`~sqlalchemy.sql.compiler.DDLCompiler` both include a ``process()`` method which can be used for compilation of embedded attributes:: The above ``InsertFromSelect`` construct is only an example, this actual functionality is already available using the :meth:`.Insert.from_select` method. The above ``InsertFromSelect`` construct probably wants to have "autocommit" enabled.  See :ref:`enabling_compiled_autocommit` for this step. The above compiler will prefix all INSERT statements with "some prefix" when compiled. The compiler extension applies just as well to the existing constructs.  When overriding the compilation of a built in SQL construct, the @compiles decorator is invoked upon the appropriate class (be sure to use the class, i.e. ``Insert`` or ``Select``, instead of the creation function such as ``insert()`` or ``select()``). The second ``visit_alter_table`` will be invoked when any ``postgresql`` dialect is used. Usage involves the creation of one or more :class:`~sqlalchemy.sql.expression.ClauseElement` subclasses and one or more callables defining its compilation:: Within the new compilation function, to get at the "original" compilation routine, use the appropriate visit_XXX method - this because compiler.process() will call upon the overriding routine and cause an endless loop.   Such as, to add "prefix" to all insert statements:: ``compiler`` works for types, too, such as below where we implement the MS-SQL specific 'max' keyword for ``String``/``VARCHAR``:: Project-Id-Version: SQLAlchemy 1.3
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
 "GREATEST" function "UTC timestamp" function "false" expression :class:`~sqlalchemy.schema.DDLElement` - The root of all DDL expressions, like CREATE TABLE, ALTER TABLE, etc. Compilation of ``DDLElement`` subclasses is issued by a ``DDLCompiler`` instead of a ``SQLCompiler``. ``DDLElement`` also features ``Table`` and ``MetaData`` event hooks via the ``execute_at()`` method, allowing the construct to be invoked during CREATE TABLE and DROP TABLE sequences. :class:`~sqlalchemy.sql.expression.ClauseElement` - This is the root expression class. Any SQL expression can be derived from this base, and is probably the best choice for longer constructs such as specialized INSERT statements. :class:`~sqlalchemy.sql.expression.ColumnElement` - The root of all "column-like" elements. Anything that you'd place in the "columns" clause of a SELECT statement (as well as order by and group by) can derive from this - the object will automatically have Python "comparison" behavior. :class:`~sqlalchemy.sql.expression.ColumnElement` classes want to have a ``type`` member which is expression's return type.  This can be established at the instance level in the constructor, or at the class level if its generally constant:: :class:`~sqlalchemy.sql.expression.Executable` - This is a mixin which should be used with any expression class that represents a "standalone" SQL statement that can be passed directly to an ``execute()`` method.  It is already implicit within ``DDLElement`` and ``FunctionElement``. :class:`~sqlalchemy.sql.functions.FunctionElement` - This is a hybrid of a ``ColumnElement`` and a "from clause" like object, and represents a SQL function or stored procedure type of call. Since most databases support statements along the line of "SELECT FROM <some function>" ``FunctionElement`` adds in the ability to be used in the FROM clause of a ``select()`` construct:: A big part of using the compiler extension is subclassing SQLAlchemy expression constructs. To make this easier, the expression and schema packages feature a set of "bases" intended for common tasks. A synopsis is as follows: A function that works like "CURRENT_TIMESTAMP" except applies the appropriate conversions so that the time is in UTC time.   Timestamps are best stored in relational databases as UTC, without time zones.   UTC so that your database doesn't think time has gone backwards in the hour when daylight savings ends, without timezones because timezones are like character encodings - they're best applied only at the endpoints of an application (i.e. convert to UTC upon user input, re-apply desired timezone upon display). Above, ``MyColumn`` extends :class:`~sqlalchemy.sql.expression.ColumnClause`, the base expression element for named column objects. The ``compiles`` decorator registers itself with the ``MyColumn`` class so that it is invoked when the object is compiled to a string:: Above, we add an additional flag to the process step as called by :meth:`.SQLCompiler.process`, which is the ``literal_binds`` flag.  This indicates that any SQL expression which refers to a :class:`.BindParameter` object or other "literal" object such as those which refer to strings or integers should be rendered **in-place**, rather than being referred to as a bound parameter;  when emitting DDL, bound parameters are typically not supported. Changing Compilation of Types Changing the default compilation of existing constructs Compilers can also be made dialect-specific. The appropriate compiler will be invoked for the dialect in use:: Compiling sub-elements of a custom expression construct Cross Compiling between SQL and DDL compilers Currently a quick way to do this is to subclass :class:`.Executable`, then add the "autocommit" flag to the ``_execution_options`` dictionary (note this is a "frozen" dictionary which supplies a generative ``union()`` method):: Custom SQL Constructs and Compilation Extension DDL elements that subclass :class:`.DDLElement` already have the "autocommit" flag turned on. Dialect-specific compilation rules Enabling Autocommit on a Construct Example usage:: For PostgreSQL and Microsoft SQL Server:: Further Examples More succinctly, if the construct is truly similar to an INSERT, UPDATE, or DELETE, :class:`.UpdateBase` can be used, which already is a subclass of :class:`.Executable`, :class:`.ClauseElement` and includes the ``autocommit`` flag:: Produces:: Provides an API for creation of custom ClauseElements and compilers. Recall from the section :ref:`autocommit` that the :class:`.Engine`, when asked to execute a construct in the absence of a user-defined transaction, detects if the given construct represents DML or DDL, that is, a data modification or data definition statement, which requires (or may require, in the case of DDL) that the transaction generated by the DBAPI be committed (recall that DBAPI always has a transaction going on regardless of what SQLAlchemy does).   Checking for this is actually accomplished by checking for the "autocommit" execution option on the construct.    When building a construct like an INSERT derivation, a new DDL type, or perhaps a stored procedure that alters data, the "autocommit" option needs to be set in order for the statement to function with "connectionless" execution (as described in :ref:`dbengine_implicit`). Register a function as a compiler for a given :class:`.ClauseElement` type. Remove all custom compilers associated with a given :class:`.ClauseElement` type. Render a "false" constant expression, rendering as "0" on platforms that don't have a "false" constant:: SQL and DDL constructs are each compiled using different base compilers - ``SQLCompiler`` and ``DDLCompiler``.   A common need is to access the compilation rules of SQL expressions from within a DDL expression. The ``DDLCompiler`` includes an accessor ``sql_compiler`` for this reason, such as below where we generate a CHECK constraint that embeds a SQL expression:: Subclassing Guidelines Synopsis The "GREATEST" function is given any number of arguments and returns the one that is of the highest value - its equivalent to Python's ``max`` function.  A SQL standard version versus a CASE based version which only accommodates two arguments:: The ``compiler`` argument is the :class:`~sqlalchemy.engine.interfaces.Compiled` object in use. This object can be inspected for any information about the in-progress compilation, including ``compiler.dialect``, ``compiler.statement`` etc. The :class:`~sqlalchemy.sql.compiler.SQLCompiler` and :class:`~sqlalchemy.sql.compiler.DDLCompiler` both include a ``process()`` method which can be used for compilation of embedded attributes:: The above ``InsertFromSelect`` construct is only an example, this actual functionality is already available using the :meth:`.Insert.from_select` method. The above ``InsertFromSelect`` construct probably wants to have "autocommit" enabled.  See :ref:`enabling_compiled_autocommit` for this step. The above compiler will prefix all INSERT statements with "some prefix" when compiled. The compiler extension applies just as well to the existing constructs.  When overriding the compilation of a built in SQL construct, the @compiles decorator is invoked upon the appropriate class (be sure to use the class, i.e. ``Insert`` or ``Select``, instead of the creation function such as ``insert()`` or ``select()``). The second ``visit_alter_table`` will be invoked when any ``postgresql`` dialect is used. Usage involves the creation of one or more :class:`~sqlalchemy.sql.expression.ClauseElement` subclasses and one or more callables defining its compilation:: Within the new compilation function, to get at the "original" compilation routine, use the appropriate visit_XXX method - this because compiler.process() will call upon the overriding routine and cause an endless loop.   Such as, to add "prefix" to all insert statements:: ``compiler`` works for types, too, such as below where we implement the MS-SQL specific 'max' keyword for ``String``/``VARCHAR``:: 