USE [E-INVOICE_BML_DATA]
GO

/****** Object:  StoredProcedure [dbo].[usp_TV_BC_HOA_DON_CHUNG_TU_DICH_VU_BAN_RAInfoGetList]    Script Date: 2/24/2022 11:05:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Todo: 
------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_TV_BC_HOA_DON_CHUNG_TU_DICH_VU_BAN_RAInfoGetList]
    @_TU_NGAY_BAO_CAO datetime,
	@_DEN_NGAY_BAO_CAO datetime,
	@PageIndex     INT,
	@PageSize       INT,
	@TotalRecord INT OUTPUT
AS
    WITH temp AS (	
	SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS STT,
	ID,
	NGUOI_THUC_HIEN,
	THOI_GIAN_THUC_HIEN AS NGAY_HOA_DON,
	TU_NGAY_BAO_CAO,
	DEN_NGAY_BAO_CAO,
	TRANG_THAI_BC
	FROM [E-INVOICE_BML_DATA].[dbo].[TV_BAO_CAO_HD_CT_DV] AS BCTH
    where 
	BCTH.THOI_GIAN_THUC_HIEN >= @_TU_NGAY_BAO_CAO
	AND BCTH.THOI_GIAN_THUC_HIEN <= @_DEN_NGAY_BAO_CAO
			     )    
    
    SELECT * FROM temp WHERE STT > (@PageIndex-1)*@PageSize AND STT <= (@PageIndex-1)*@PageSize + @PageSize
    
    SET @TotalRecord =(
					SELECT COUNT(*)
					FROM [TV_BAO_CAO_HD_CT_DV] AS BCTH			
					WHERE BCTH.THOI_GIAN_THUC_HIEN >= @_TU_NGAY_BAO_CAO
					AND BCTH.THOI_GIAN_THUC_HIEN <= @_DEN_NGAY_BAO_CAO
					)			
GO

