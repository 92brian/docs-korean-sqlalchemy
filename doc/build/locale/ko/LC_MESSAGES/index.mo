��          �               �  I   �  W  �  �   ?  v   .  �   �  F   R  ~   �  �     9   �  )   �  (   #    L  -   �    �  %   
     3
     I
  �   Y
     H     X     q  �   �    B  x  S  B   �  �    �   �  |   �  �   C  R   �  y   ?  �   �  :   h  ,   �  0   �  �    )   �  !  �     �     �       �                  3  �   D    4   **All the Built In SQL:** :doc:`SQL Expression API <core/expression_api>` **Configuration Extensions:** :doc:`Declarative Extension <orm/extensions/declarative/index>` | :doc:`Association Proxy <orm/extensions/associationproxy>` | :doc:`Hybrid Attributes <orm/extensions/hybrid>` | :doc:`Automap <orm/extensions/automap>` | :doc:`Mutable Scalars <orm/extensions/mutable>` | :doc:`Indexable <orm/extensions/indexable>` **Core Basics:** :doc:`Overview <core/api_basics>` | :doc:`Runtime Inspection API <core/inspection>` | :doc:`Event System <core/event>` | :doc:`Core Event Interfaces <core/events>` | :doc:`Creating Custom SQL Constructs <core/compiler>` | **Datatypes:** :ref:`Overview <types_toplevel>` | :ref:`Building Custom Types <types_custom>` | :ref:`API <types_api>` **Engines, Connections, Pools:** :doc:`Engine Configuration <core/engines>` | :doc:`Connections, Transactions <core/connections>` | :doc:`Connection Pooling <core/pooling>` **Extending the ORM:** :doc:`ORM Events and Internals <orm/extending>` **ORM Configuration:** :doc:`Mapper Configuration <orm/mapper_config>` | :doc:`Relationship Configuration <orm/relationships>` **ORM Usage:** :doc:`Session Usage and Guidelines <orm/session>` | :doc:`Loading Objects <orm/loading_objects>` | :doc:`Cached Query Extension <orm/extensions/baked>` **Other:** :doc:`Introduction to Examples <orm/examples>` **Read this first:** :doc:`core/tutorial` **Read this first:** :doc:`orm/tutorial` **Schema Definition:** :doc:`Overview <core/schema>` | :ref:`Tables and Columns <metadata_describing_toplevel>` | :ref:`Database Introspection (Reflection) <metadata_reflection_toplevel>` | :ref:`Insert/Update Defaults <metadata_defaults_toplevel>` | :ref:`Constraints and Indexes <metadata_constraints_toplevel>` | :ref:`Using Data Definition Language (DDL) <metadata_ddl_toplevel>` :doc:`Index of all Dialects <dialects/index>` :doc:`Overview <intro>` | :ref:`Installation Guide <installation>` | :doc:`Frequently Asked Questions <faq/index>` | :doc:`Migration from 1.2 <changelog/migration_13>` | :doc:`Glossary <glossary>` | :doc:`Error Messages <errors>` | :doc:`Changelog catalog <changelog/index>` A high level view and getting set up. Dialect Documentation Getting Started Here, the Object Relational Mapper is introduced and fully described. If you want to work with higher-level SQL which is constructed automatically for you, as well as automated persistence of Python objects, proceed first to the tutorial. SQLAlchemy Core SQLAlchemy Documentation SQLAlchemy ORM The **dialect** is the system SQLAlchemy uses to communicate with various types of DBAPIs and databases. This section describes notes, options, and usage patterns regarding individual dialects. The breadth of SQLAlchemy's SQL rendering engine, DBAPI integration, transaction integration, and schema description services are documented here.  In contrast to the ORM's domain-centric mode of usage, the SQL Expression Language provides a schema-centric usage paradigm. Project-Id-Version: SQLAlchemy 1.3
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
 **SQL문 참조:** :doc:`SQL Expression API <core/expression_api>` **확장기능 설정법:** :doc:`선언형 (Declarative) 확장기능 <orm/extensions/declarative/index>` | :doc:`연관 대리자(AssociationProxy) <orm/extensions/associationproxy>` | :doc:`하이브리드 속성(Hybrid Attributes)<orm/extensions/hybrid>` | :doc:`자동맵(Automap) <orm/extensions/automap>` | :doc:`뮤터블 스칼라(Mutable Scalars) <orm/extensions/mutable>` | :doc:`인덱서블(Indexable) <orm/extensions/indexable>` **핵심 기본기능:** :doc:`개요 <core/api_basics>` | :doc:`런타임 검사 API <core/inspection>` | :doc:`이벤트 시스템 <core/event>` | :doc:`핵심 이벤트 인터페이스 <core/events>` | :doc:`사용자 SQL 생성  <core/compiler>` | **자료형:** :ref:`개요 <types_toplevel>` | :ref:`사용자 자료형 만들기 <types_custom>` | :ref:`API <types_api>` **엔진, 컨넥션, 풀링:** :doc:`Engine Configuration <core/engines>` | :doc:`컨넥션과 트랜잭션 <core/connections>` | :doc:`컨넥션 풀링 <core/pooling>` **ORM 기능 확장하기:**  :doc:`ORM 이벤트와 내부구조 <orm/extending>` **ORM 설정:** :doc:`매퍼(Mapper) 설정 <orm/mapper_config>` | :doc:`관계(Relationship) 설정 <orm/relationships>` **ORM 사용법:** :doc:`세션 사용법과 안내서 <orm/session>` | :doc:`객체 로딩 <orm/loading_objects>` | :doc:`쿼리 캐싱 확장기능  <orm/extensions/baked>` **기타:** :doc:`Introduction to Examples <orm/examples>` :doc:`core/tutorial`\ 를 먼저 읽을 것. :doc:`orm/tutorial` 문서를 먼저 읽을 것. **스키마 정의:** :doc:`개요 <core/schema>` | :ref:`컬럼과 테이블  <metadata_describing_toplevel>` | :ref:`데이터베이스 내부검사  <metadata_reflection_toplevel>` | :ref:`디폴트 삽입/갱신  <metadata_defaults_toplevel>` | :ref:`제약조건 및 인덱스  <metadata_constraints_toplevel>` | :ref:`데이터 정의 언어(DDL:Data Definition Language)  <metadata_ddl_toplevel>` `DB별 차이점 문서 <dialects/index>` :doc:`개요 <intro>` | :ref:`설치안내서 <installation>` | :doc:`자주 묻는 질문과 답 <faq/index>` | :doc:`1.2 버전에서 업그레이드 방법 <changelog/migration_13>` | :doc:`용어집 <glossary>` | :doc:`에러 메세지 <errors>` | :doc:`변동사항 <changelog/index>` 시작 문서 목록 DB별 차이점 문서화 시작하기 여기에서는 ORM(Object Relational Mapper)에 대해 소개한다. 만약 자동으로 만들어지는 고수준 SQL문으로 작업하고 파이썬 객체가 자동으로 영구저장되기를 바란다면 ORM 튜토리얼을 보라. SQL알케미 핵심 SQL알케미 문서 SQL알케미 ORM 다양한 종류의 DBAPI 및 데이터베이스와 통산하려면 시스템 SQL알케미의 데이터 별 API를 알고 있어야 한다. 이 절에서는 데이터베이스 사용에 대한 주의점, 옵션, 사용 패턴을 익힌다. SQL알케미의 SQL 렌더링 엔진, DBAPI 통합기능, 트랜잭션 통합기능, 스키마 서술 서비스 등을 설명한다. ORM이 사용자 중심이라면 SQL 표현언어(SQL Expression Language)는 스키마 중심의 사용 패러다임을 제공한다. 