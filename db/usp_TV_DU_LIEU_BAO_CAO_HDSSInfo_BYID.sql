USE [E-INVOICE_BML_DATA]
GO

/****** Object:  StoredProcedure [dbo].[usp_TV_DU_LIEU_BAO_CAO_HDSSInfo_BYID]    Script Date: 2/24/2022 11:06:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Todo: 
------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_TV_DU_LIEU_BAO_CAO_HDSSInfo_BYID] 
	@ID int	,
	@PageIndex     INT,
	@PageSize       INT,
	@TotalRecord INT OUTPUT
AS
    WITH temp AS (	
	SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS STT,
	 [ID]
      ,[ID_BAO_CAO_HDSS]
      ,[MA_CQT_CAP]
      ,[KY_HIEU_MAU_HOA_DON]
      ,[KY_HIEU_HOA_DON]
      ,[SO_HOA_DON]
      ,[NGAY_LAP]
      ,[LOAI_AP_DUNG_HOA_DON_DIEN_TU]
      ,[TINH_CHAT_THONG_BAO]
      ,[LY_DO]
	FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_BAO_CAO_HDSS]
	WHERE [ID_BAO_CAO_HDSS]=@ID 
			     )    
    
    SELECT * FROM temp WHERE STT > (@PageIndex-1)*@PageSize AND STT <= (@PageIndex-1)*@PageSize + @PageSize
    
    SET @TotalRecord =(
					SELECT COUNT(*)
					FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_BAO_CAO_HDSS]
	WHERE [ID_BAO_CAO_HDSS]=@ID 
					)			
GO

