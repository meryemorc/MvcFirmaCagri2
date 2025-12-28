
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/28/2025 21:00:28
-- Generated from EDMX file: C:\Users\msi-nb\OneDrive\Masaüstü\PROJELER\ntp proje\MvcFirmaCagri\Models\Entity\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [DbisTakip];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_TblCagriDetay_TblCagrilar]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblCagriDetay] DROP CONSTRAINT [FK_TblCagriDetay_TblCagrilar];
GO
IF OBJECT_ID(N'[dbo].[FK_TblCagrilar_TblFirmalar]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblCagrilar] DROP CONSTRAINT [FK_TblCagrilar_TblFirmalar];
GO
IF OBJECT_ID(N'[dbo].[FK_TblCagrilar_TblPersonel]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblCagrilar] DROP CONSTRAINT [FK_TblCagrilar_TblPersonel];
GO
IF OBJECT_ID(N'[dbo].[FK_TblGorevDetaylar_TblGorevler]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblGorevDetaylar] DROP CONSTRAINT [FK_TblGorevDetaylar_TblGorevler];
GO
IF OBJECT_ID(N'[dbo].[FK_TblGorevler_TblPersonel]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblGorevler] DROP CONSTRAINT [FK_TblGorevler_TblPersonel];
GO
IF OBJECT_ID(N'[dbo].[FK_TblGorevler_TblPersonel1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblGorevler] DROP CONSTRAINT [FK_TblGorevler_TblPersonel1];
GO
IF OBJECT_ID(N'[dbo].[FK_TblMesajlar_TblFirmalar]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblMesajlar] DROP CONSTRAINT [FK_TblMesajlar_TblFirmalar];
GO
IF OBJECT_ID(N'[dbo].[FK_TblMesajlar_TblFirmalar1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblMesajlar] DROP CONSTRAINT [FK_TblMesajlar_TblFirmalar1];
GO
IF OBJECT_ID(N'[dbo].[FK_TblPersonel_TblDepartmanlar]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TblPersonel] DROP CONSTRAINT [FK_TblPersonel_TblDepartmanlar];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[TblAdmin]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblAdmin];
GO
IF OBJECT_ID(N'[dbo].[TblCagriDetay]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblCagriDetay];
GO
IF OBJECT_ID(N'[dbo].[TblCagrilar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblCagrilar];
GO
IF OBJECT_ID(N'[dbo].[TblDepartmanlar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblDepartmanlar];
GO
IF OBJECT_ID(N'[dbo].[TblFirmalar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblFirmalar];
GO
IF OBJECT_ID(N'[dbo].[TblGorevDetaylar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblGorevDetaylar];
GO
IF OBJECT_ID(N'[dbo].[TblGorevler]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblGorevler];
GO
IF OBJECT_ID(N'[dbo].[TblMesajlar]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblMesajlar];
GO
IF OBJECT_ID(N'[dbo].[TblPersonel]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TblPersonel];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'TblAdmin'
CREATE TABLE [dbo].[TblAdmin] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Kullanici] nvarchar(10)  NULL,
    [Sifre] nvarchar(10)  NULL
);
GO

-- Creating table 'TblCagriDetay'
CREATE TABLE [dbo].[TblCagriDetay] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Cagri] int  NULL,
    [Aciklama] nvarchar(250)  NULL,
    [Tarih] datetime  NULL,
    [Saat] char(5)  NULL
);
GO

-- Creating table 'TblCagrilar'
CREATE TABLE [dbo].[TblCagrilar] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [CagrıFirma] int  NULL,
    [Konu] nvarchar(50)  NULL,
    [Aciklama] nvarchar(max)  NULL,
    [Durum] bit  NULL,
    [Tarih] datetime  NULL,
    [CagriPersonel] int  NULL
);
GO

-- Creating table 'TblDepartmanlar'
CREATE TABLE [dbo].[TblDepartmanlar] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Ad] nvarchar(30)  NULL
);
GO

-- Creating table 'TblFirmalar'
CREATE TABLE [dbo].[TblFirmalar] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Ad] nvarchar(30)  NULL,
    [Yetkili] nvarchar(30)  NULL,
    [Telefon] nvarchar(20)  NULL,
    [Mail] nvarchar(50)  NULL,
    [Sifre] nvarchar(20)  NULL,
    [Sektor] nvarchar(30)  NULL,
    [il] nvarchar(20)  NULL,
    [Adres] nvarchar(200)  NULL,
    [Gorsel] nvarchar(250)  NULL
);
GO

-- Creating table 'TblGorevDetaylar'
CREATE TABLE [dbo].[TblGorevDetaylar] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Gorev] int  NULL,
    [Aciklama] nvarchar(200)  NULL,
    [Tarih] datetime  NULL,
    [Saat] char(5)  NULL
);
GO

-- Creating table 'TblGorevler'
CREATE TABLE [dbo].[TblGorevler] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [GorevVeren] int  NULL,
    [GorevAlan] int  NULL,
    [Aciklama] nvarchar(500)  NULL,
    [Durum] bit  NULL,
    [Tarih] datetime  NULL
);
GO

-- Creating table 'TblMesajlar'
CREATE TABLE [dbo].[TblMesajlar] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Gonderen] int  NULL,
    [Alici] int  NULL,
    [Konu] nvarchar(20)  NULL,
    [Mesaj] nvarchar(max)  NULL,
    [Tarih] datetime  NULL,
    [Durum] bit  NULL
);
GO

-- Creating table 'TblPersonel'
CREATE TABLE [dbo].[TblPersonel] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Ad] nvarchar(30)  NULL,
    [Soyad] nvarchar(30)  NULL,
    [Mail] nvarchar(50)  NULL,
    [Telefon] nvarchar(20)  NULL,
    [Departman] int  NULL,
    [Durum] bit  NULL,
    [Sifre] nvarchar(10)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'TblAdmin'
ALTER TABLE [dbo].[TblAdmin]
ADD CONSTRAINT [PK_TblAdmin]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblCagriDetay'
ALTER TABLE [dbo].[TblCagriDetay]
ADD CONSTRAINT [PK_TblCagriDetay]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblCagrilar'
ALTER TABLE [dbo].[TblCagrilar]
ADD CONSTRAINT [PK_TblCagrilar]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblDepartmanlar'
ALTER TABLE [dbo].[TblDepartmanlar]
ADD CONSTRAINT [PK_TblDepartmanlar]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblFirmalar'
ALTER TABLE [dbo].[TblFirmalar]
ADD CONSTRAINT [PK_TblFirmalar]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblGorevDetaylar'
ALTER TABLE [dbo].[TblGorevDetaylar]
ADD CONSTRAINT [PK_TblGorevDetaylar]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblGorevler'
ALTER TABLE [dbo].[TblGorevler]
ADD CONSTRAINT [PK_TblGorevler]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblMesajlar'
ALTER TABLE [dbo].[TblMesajlar]
ADD CONSTRAINT [PK_TblMesajlar]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'TblPersonel'
ALTER TABLE [dbo].[TblPersonel]
ADD CONSTRAINT [PK_TblPersonel]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Cagri] in table 'TblCagriDetay'
ALTER TABLE [dbo].[TblCagriDetay]
ADD CONSTRAINT [FK_TblCagriDetay_TblCagrilar]
    FOREIGN KEY ([Cagri])
    REFERENCES [dbo].[TblCagrilar]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblCagriDetay_TblCagrilar'
CREATE INDEX [IX_FK_TblCagriDetay_TblCagrilar]
ON [dbo].[TblCagriDetay]
    ([Cagri]);
GO

-- Creating foreign key on [CagrıFirma] in table 'TblCagrilar'
ALTER TABLE [dbo].[TblCagrilar]
ADD CONSTRAINT [FK_TblCagrilar_TblFirmalar]
    FOREIGN KEY ([CagrıFirma])
    REFERENCES [dbo].[TblFirmalar]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblCagrilar_TblFirmalar'
CREATE INDEX [IX_FK_TblCagrilar_TblFirmalar]
ON [dbo].[TblCagrilar]
    ([CagrıFirma]);
GO

-- Creating foreign key on [CagriPersonel] in table 'TblCagrilar'
ALTER TABLE [dbo].[TblCagrilar]
ADD CONSTRAINT [FK_TblCagrilar_TblPersonel]
    FOREIGN KEY ([CagriPersonel])
    REFERENCES [dbo].[TblPersonel]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblCagrilar_TblPersonel'
CREATE INDEX [IX_FK_TblCagrilar_TblPersonel]
ON [dbo].[TblCagrilar]
    ([CagriPersonel]);
GO

-- Creating foreign key on [Departman] in table 'TblPersonel'
ALTER TABLE [dbo].[TblPersonel]
ADD CONSTRAINT [FK_TblPersonel_TblDepartmanlar]
    FOREIGN KEY ([Departman])
    REFERENCES [dbo].[TblDepartmanlar]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblPersonel_TblDepartmanlar'
CREATE INDEX [IX_FK_TblPersonel_TblDepartmanlar]
ON [dbo].[TblPersonel]
    ([Departman]);
GO

-- Creating foreign key on [Gonderen] in table 'TblMesajlar'
ALTER TABLE [dbo].[TblMesajlar]
ADD CONSTRAINT [FK_TblMesajlar_TblFirmalar]
    FOREIGN KEY ([Gonderen])
    REFERENCES [dbo].[TblFirmalar]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblMesajlar_TblFirmalar'
CREATE INDEX [IX_FK_TblMesajlar_TblFirmalar]
ON [dbo].[TblMesajlar]
    ([Gonderen]);
GO

-- Creating foreign key on [Alici] in table 'TblMesajlar'
ALTER TABLE [dbo].[TblMesajlar]
ADD CONSTRAINT [FK_TblMesajlar_TblFirmalar1]
    FOREIGN KEY ([Alici])
    REFERENCES [dbo].[TblFirmalar]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblMesajlar_TblFirmalar1'
CREATE INDEX [IX_FK_TblMesajlar_TblFirmalar1]
ON [dbo].[TblMesajlar]
    ([Alici]);
GO

-- Creating foreign key on [Gorev] in table 'TblGorevDetaylar'
ALTER TABLE [dbo].[TblGorevDetaylar]
ADD CONSTRAINT [FK_TblGorevDetaylar_TblGorevler]
    FOREIGN KEY ([Gorev])
    REFERENCES [dbo].[TblGorevler]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblGorevDetaylar_TblGorevler'
CREATE INDEX [IX_FK_TblGorevDetaylar_TblGorevler]
ON [dbo].[TblGorevDetaylar]
    ([Gorev]);
GO

-- Creating foreign key on [GorevVeren] in table 'TblGorevler'
ALTER TABLE [dbo].[TblGorevler]
ADD CONSTRAINT [FK_TblGorevler_TblPersonel]
    FOREIGN KEY ([GorevVeren])
    REFERENCES [dbo].[TblPersonel]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblGorevler_TblPersonel'
CREATE INDEX [IX_FK_TblGorevler_TblPersonel]
ON [dbo].[TblGorevler]
    ([GorevVeren]);
GO

-- Creating foreign key on [GorevAlan] in table 'TblGorevler'
ALTER TABLE [dbo].[TblGorevler]
ADD CONSTRAINT [FK_TblGorevler_TblPersonel1]
    FOREIGN KEY ([GorevAlan])
    REFERENCES [dbo].[TblPersonel]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TblGorevler_TblPersonel1'
CREATE INDEX [IX_FK_TblGorevler_TblPersonel1]
ON [dbo].[TblGorevler]
    ([GorevAlan]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------