USE [E-INVOICE_BML_DATA]
GO

/****** Object:  StoredProcedure [dbo].[usp_TV_DU_LIEU_BAO_CAO_BANG_TONG_HOP_BYID]    Script Date: 2/24/2022 11:06:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Todo: 
------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_TV_DU_LIEU_BAO_CAO_BANG_TONG_HOP_BYID] 
	@ID int	,
	@PageIndex     INT,
	@PageSize       INT,
	@TotalRecord INT OUTPUT
AS
    WITH temp AS (	
	SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS STT,
		[ID]
      ,[ID_BAO_CAO_HD_CT_DV]
      ,[SO_HOA_DON]
      ,[NGAY_LAP]
      ,[TEN_NGUOI_MUA]
      ,[MA_SO_THUE_NGUOI_MUA]
      ,[DOANH_THU_CHUA_THUE]
      ,[THUE_GTGT]
      ,[GHI_CHU]
	FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_BAO_CAO_BANG_TONG_HOP]
	WHERE [ID_BAO_CAO_HD_CT_DV]=@ID 
			     )    
    
    SELECT * FROM temp WHERE STT > (@PageIndex-1)*@PageSize AND STT <= (@PageIndex-1)*@PageSize + @PageSize
    
    SET @TotalRecord =(
					SELECT COUNT(*)
					FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_BAO_CAO_BANG_TONG_HOP]
	WHERE [ID_BAO_CAO_HD_CT_DV]=@ID 
					)			
GO

