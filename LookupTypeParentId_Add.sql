Alter table LookupType
Add LookupTypeParentId int
GO

ALTER view [dbo].[vw_LookupDetails]
as
select lt.LookupTypeParentId, lt.Id as LookupTypeId, lt.LookupTypeName as LookupType, l.Id as LookupId, l.LookupName as Lookup, l.Description as LookUpDescription
from LookUpType lt
join LookUp l on lt.Id = l.LookupTypeId
where lt.IsActive=1 and lt.IsDeleted=0 and l.IsActive=1 and l.IsDeleted=0
GO