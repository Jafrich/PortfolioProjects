/*

Cleaning Data in SQL Queries

*/

Select *
From [Portfolio Project 3]..[NashvilleHousing]

---------------------------------------------------------------------------
-- Standardize Date Format

Select SaleDateConverted, CONVERT(Date,SaleDate)
From [Portfolio Project 3]..NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT (Date,SaleDate)

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT (Date,SaleDate)

-------------------------------------------------------------------------------

-- Populate Property Address Data

Select *
From [Portfolio Project 3]..NashvilleHousing
-- Where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project 3]..NashvilleHousing A
JOIN [Portfolio Project 3]..NashvilleHousing B
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Portfolio Project 3]..NashvilleHousing A
JOIN [Portfolio Project 3]..NashvilleHousing B
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
Where a.PropertyAddress is null




-----------------------------------------------------------------------------

-- Breaking out address into Individual Columns (Address, City, State)

Select PropertyAddress
From [Portfolio Project 3]..NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From [Portfolio Project 3]..NashvilleHousing


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar (255);

Update NashvilleHousing
SET PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar (255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1 , LEN(PropertyAddress))

Select *

FROM [Portfolio Project 3]..NashvilleHousing




Select OwnerAddress
From [Portfolio Project 3]..NashvilleHousing

Select
PARSENAME(OwnerAddress, ',', '.') , 3)
,PARSENAME(OwnerAddress, ',', '.') , 2)
,PARSENAME(OwnerAddress, ',', '.') , 1)
FROM [Portfolio Project 3]..NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.') , 3)

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.') , 2)

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.') , 1)


Select *
FROM [Portfolio Project 3]..NashvilleHousing


----------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From [Portfolio Project 3]..NashvilleHousing
Group by SoldAsVacant
order by 2

ALTER TABLE [Portfolio Project 3]..NashvilleHousing
ALTER COLUMN SoldAsVacant VARCHAR(10)

Select SoldAsVacant
, CASE WHEN SoldAsVacant = '1' THEN 'YES'
	   WHEN SoldAsVacant = '0' THEN 'NO'
	   ELSE SoldAsVacant
	   END
From [Portfolio Project 3]..NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = '1' THEN 'YES'
	   WHEN SoldAsVacant = '0' THEN 'NO'
	   ELSE SoldAsVacant
	   END

-------------------------------------------------------------------------------------

-- Remove Duplicates 

WITH RowNumCTE As(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num


FROM [Portfolio Project 3]..NashvilleHousing
--Order by ParcelID
)
SELECT *
FROM RowNumCTE
Where row_num > 1
Order by PropertyAddress


----------------------------------------------------------------------------

-- Delete Unused Columns

Select *
FROM [Portfolio Project 3]..NashvilleHousing

ALTER TABLE [Portfolio Project 3]..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE  [Portfolio Project 3]..NashvilleHousing
DROP COLUMN SaleDate