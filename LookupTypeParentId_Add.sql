IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'LookupTypeParentId'
          AND Object_ID = Object_ID(N'dbo.LookupType'))
BEGIN	
	Alter table LookupType
	Add LookupTypeParentId int
END
GO

ALTER view [dbo].[vw_LookupDetails]
as
select lt.LookupTypeParentId, lpt.LookupTypeName as LookupTypeParentName, lt.Id as LookupTypeId, lt.LookupTypeName as LookupType, l.Id as LookupId, l.LookupName as Lookup, l.Description as LookUpDescription
from LookUpType lt
join LookUp l on lt.Id = l.LookupTypeId
left join LookUpType lpt on lt.LookupTypeParentId = lpt.Id
where lt.IsActive=1 and lt.IsDeleted=0 and l.IsActive=1 and l.IsDeleted=0
GO