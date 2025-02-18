/*==============================================================*/
/* Nom de SGBD :  Microsoft SQL Server 2016                     */
/* Date de cr?ation :  09/11/2018 09:53:50                      */
/*==============================================================*/

use Papyrus

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMMANDE') and o.name = 'FK_COMMANDE_ETRE_CDER_FOURNISS')
alter table COMMANDE
   drop constraint FK_COMMANDE_ETRE_CDER_FOURNISS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LIGNE') and o.name = 'FK_LIGNE_LIGNE_PRODUIT')
alter table LIGNE
   drop constraint FK_LIGNE_LIGNE_PRODUIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LIGNE') and o.name = 'FK_LIGNE_LIGNE2_COMMANDE')
alter table LIGNE
   drop constraint FK_LIGNE_LIGNE2_COMMANDE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENDRE') and o.name = 'FK_VENDRE_VENDRE_PRODUIT')
alter table VENDRE
   drop constraint FK_VENDRE_VENDRE_PRODUIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENDRE') and o.name = 'FK_VENDRE_VENDRE2_FOURNISS')
alter table VENDRE
   drop constraint FK_VENDRE_VENDRE2_FOURNISS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMMANDE')
            and   name  = 'ETRE_CDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMMANDE.ETRE_CDER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMMANDE')
            and   type = 'U')
   drop table COMMANDE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FOURNISSEUR')
            and   type = 'U')
   drop table FOURNISSEUR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LIGNE')
            and   name  = 'LIGNE2_FK'
            and   indid > 0
            and   indid < 255)
   drop index LIGNE.LIGNE2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LIGNE')
            and   name  = 'LIGNE_FK'
            and   indid > 0
            and   indid < 255)
   drop index LIGNE.LIGNE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LIGNE')
            and   type = 'U')
   drop table LIGNE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUIT')
            and   type = 'U')
   drop table PRODUIT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VENDRE')
            and   name  = 'VENDRE2_FK'
            and   indid > 0
            and   indid < 255)
   drop index VENDRE.VENDRE2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VENDRE')
            and   name  = 'VENDRE_FK'
            and   indid > 0
            and   indid < 255)
   drop index VENDRE.VENDRE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VENDRE')
            and   type = 'U')
   drop table VENDRE
go

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE (
   NUMCOM               int                  not null,
   NUMFOU               int                  not null,
   DATECOM              datetime             null,
   OBSCOM               varchar(35)          null,
   constraint PK_COMMANDE primary key (NUMCOM)
)
go

/*==============================================================*/
/* Index : ETRE_CDER_FK                                         */
/*==============================================================*/




create nonclustered index ETRE_CDER_FK on COMMANDE (NUMFOU ASC)
go

/*==============================================================*/
/* Table : FOURNISSEUR                                          */
/*==============================================================*/
create table FOURNISSEUR (
   NUMFOU               int                  not null,
   NOMFOU               varchar(35)          null,
   RUEFOU               varchar(35)          null,
   POSFOU               char(5)              null,
   VILFOU               varchar(30)          null,
   CONFOU               varchar(15)          null,
   SATISF               int                  null,
   constraint PK_FOURNISSEUR primary key (NUMFOU)
)
go

/*==============================================================*/
/* Table : LIGNE                                                */
/*==============================================================*/
create table LIGNE (
   CODART               varchar(4)           not null,
   NUMCOM               int                  not null,
   NUMLIG               int                  null,
   QTECDE               int                  null,
   PRIUNI               money                null,
   QTELIV               int                  null,
   DERLIV               datetime             null,
   constraint PK_LIGNE primary key (CODART, NUMCOM)
)
go

/*==============================================================*/
/* Index : LIGNE_FK                                             */
/*==============================================================*/




create nonclustered index LIGNE_FK on LIGNE (CODART ASC)
go

/*==============================================================*/
/* Index : LIGNE2_FK                                            */
/*==============================================================*/




create nonclustered index LIGNE2_FK on LIGNE (NUMCOM ASC)
go

/*==============================================================*/
/* Table : PRODUIT                                              */
/*==============================================================*/
create table PRODUIT (
   CODART               varchar(4)           not null,
   LIBART               varchar(35)          null,
   STKALE               int                  null,
   STKPHY               int                  null,
   QTEANN               int                  null,
   UNIMES               varchar(5)           null,
   constraint PK_PRODUIT primary key (CODART)
)
go

/*==============================================================*/
/* Table : VENDRE                                               */
/*==============================================================*/
create table VENDRE (
   CODART               varchar(4)           not null,
   NUMFOU               int                  not null,
   QTE1                 int                  null,
   QTE2                 int                  null,
   QTE3                 int                  null,
   PRIX1                money                null,
   PRIX2                money                null,
   PRIX3                money                null,
   DELLIV               int                  null,
   constraint PK_VENDRE primary key (CODART, NUMFOU)
)
go

/*==============================================================*/
/* Index : VENDRE_FK                                            */
/*==============================================================*/




create nonclustered index VENDRE_FK on VENDRE (CODART ASC)
go

/*==============================================================*/
/* Index : VENDRE2_FK                                           */
/*==============================================================*/




create nonclustered index VENDRE2_FK on VENDRE (NUMFOU ASC)
go

alter table COMMANDE
   add constraint FK_COMMANDE_ETRE_CDER_FOURNISS foreign key (NUMFOU)
      references FOURNISSEUR (NUMFOU)
go

alter table LIGNE
   add constraint FK_LIGNE_LIGNE_PRODUIT foreign key (CODART)
      references PRODUIT (CODART)
go

alter table LIGNE
   add constraint FK_LIGNE_LIGNE2_COMMANDE foreign key (NUMCOM)
      references COMMANDE (NUMCOM)
go

alter table VENDRE
   add constraint FK_VENDRE_VENDRE_PRODUIT foreign key (CODART)
      references PRODUIT (CODART)
go

alter table VENDRE
   add constraint FK_VENDRE_VENDRE2_FOURNISS foreign key (NUMFOU)
      references FOURNISSEUR (NUMFOU)
go

