USE [E-INVOICE_BML_DATA]
GO

/****** Object:  StoredProcedure [dbo].[usp_TV_DU_LIEU_TRA_CUU_DU_LIEU_BANG_TONG_HOP_BYID]    Script Date: 2/24/2022 11:07:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Todo: 
------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_TV_DU_LIEU_TRA_CUU_DU_LIEU_BANG_TONG_HOP_BYID] 
	@ID int	,
	@PageIndex     INT,
	@PageSize       INT,
	@TotalRecord INT OUTPUT
AS
    WITH temp AS (	
	SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS STT,
	 [ID]
      ,[ID_TRA_CUU_DLBTH]
      ,[KY_HIEU_MAU_HOA_DON]
      ,[KY_HIEU_HOA_DON]
      ,[SO_HOA_DON]
      ,[NGAY_LAP]
	  ,[CDATE]
	  ,[LDATE]
	  ,[CUSER] 
	  ,[LUSER]
	  ,[TONG_TIEN_THANH_TOAN_BANG_CHU]
      ,[TEN_NGUOI_MUA]
      ,[MA_SO_THUE_NGUOI_MUA]
      ,[MA_KHACH_HANG]
      ,[MA_HANG_HOA_DICH_VU]
      ,[TEN_HANG_HOA_DICH_VU]
      ,[DON_VI_TINH]
      ,[SO_LUONG]
      ,[TONG_GIA_TRI_HANG_HOA_CHUA_THUE]
      ,[THUE_SUAT]
      ,[TONG_TIEN_THUE]
      ,[TONG_TIEN_THANH_TOAN]
      ,[TRANG_THAI]
      ,[LOAI_HOA_DON_LIEN_QUAN]
      ,[KY_HIEU_MAU_HOA_DON_LIEN_QUAN]
      ,[KY_HIEU_HOA_DON_LIEN_QUAN]
      ,[SO_HOA_DON_LIEN_QUAN]
      ,[LOAI_KY_DU_LIEU_DIEU_CHINH]
      ,[KY_DU_LIEU_DIEU_CHINH]
      ,[SO_THONG_BAO]
      ,[NGAY_THONG_BAO]
      ,[GHI_CHU]
	FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_TRA_CUU_DU_LIEU_BANG_TONG_HOP]
	WHERE [ID_TRA_CUU_DLBTH]=@ID 
			     )    
    
    SELECT * FROM temp WHERE STT > (@PageIndex-1)*@PageSize AND STT <= (@PageIndex-1)*@PageSize + @PageSize
    
    SET @TotalRecord =(
					SELECT COUNT(*)
					FROM [E-INVOICE_BML_DATA].[dbo].[TV_DU_LIEU_TRA_CUU_DU_LIEU_BANG_TONG_HOP]
	WHERE [ID_TRA_CUU_DLBTH]=@ID 
					)			
GO

