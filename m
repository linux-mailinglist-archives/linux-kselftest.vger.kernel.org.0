Return-Path: <linux-kselftest+bounces-36183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134EAEF94D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADFB480727
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297627466E;
	Tue,  1 Jul 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4Ru7rwo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B426B77D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374458; cv=none; b=hsQJ18EyRaooh6q+X5dWT9okLKCM5A/12vO4PX9o93xqOWAnP00WURhvU7AKaYgKjtPq4DnrR1GhKlixACA3nJTM3U7azBcPr28EEmEHHhbV7/fRVyibg5HslwQDP15bNQNbCxf8451PWGH6dxNlOzbhwlur0zl1cyKUWd5Xcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374458; c=relaxed/simple;
	bh=3gJtS77mHK7VTcYFcjrd5hF6WARIXk6d2X2+wZ3Hta4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWUFLCQuSK5RMJj9JVMv1bBUXKUmtOd/yDHZdovYcTeah0bwmzYASao7scWRJ33FGqjlcB+jgBbYbmi+wqXe+YYeEOA7bkwbV+g059WERrEvO7Cw4fYhxAS+7fgp/kYacbEZAgepLZZPvSNVZh1k7fbDvzSlN94ojRaxltW3HDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4Ru7rwo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso211015ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751374456; x=1751979256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L74aNTJbvTixP9x7JPOzIa2qX6+0XWisdXXC8NLNbk=;
        b=d4Ru7rwoQzfB3csNgghl+4OAHNVE8nwC/hAydeK7QGvo5WMiXQI3SSloC1IqOaWsLC
         YFc800xNEqvT0W1CmcvLe4ynmK6gDN2P2g0UrDDnWGOBSayFqeMNe/NC/nFdbkD9ptqS
         0MbOagxwj2+1T4l/RYc8KJyzsNlX1WVKeT6z/cBy+tdmOH3bQHuviNAb+tK+VFuwMhST
         xuimo4dGxLNb8OwJhQIkQDS8xsz+AEZq2ydUeJYjk9EpmkNgl/HZfQmGF8a0LUoLITRc
         5J3qH+Apx1jJGDbe0iqKl0UlZzRQ13w121sPIGh2fN6BKiW/rKvm11lONNbu83egHwvE
         cGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374456; x=1751979256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L74aNTJbvTixP9x7JPOzIa2qX6+0XWisdXXC8NLNbk=;
        b=X9l0s+tndqBQJYYBadGTiDwVXDJl1zbHwYNoxXcN+SGhvDR7Pj7wl6uT2AlvNMTkXx
         L7dWB4FvSCFjq6Ih67dP17sDetVqN7T989mth89pkOC7xzdLHJH+SijGvMBJFKy8r78L
         TZ0AXspkjruetZmSTyGnWqfpNFmackq8wLNguocEHjj/0aDdlIOG2Lwqsm5+VU155c63
         nOgCYZoPQ6l4gSlUb9i7K+bXhO2dsiEeLF0vZmW8nWK5ITBYhkjZJwa4kwEY1y4KwxJJ
         5jlDMa07A9PQVxWW++LAnBODwa0feF3rmLrYxBAuWcO9KhzbHWg27+RU2DQ9gWdauSkr
         u49w==
X-Forwarded-Encrypted: i=1; AJvYcCWfsF/MqFBD53hIjhFBcA/j2HWWUzTbi+39EVDCjQsr/zMtMpChESTlw5UJExpF3oosc8iQGLS85Y5jN2d7PuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uYm+j3+hVJRGOKJTTSu3n0cbCrDCrJPHzWdYFjYZgVBGTaC/
	3GhGYlHSfWjXd9UcBpAFJNhYPB3W3sg2re3Lsyz+/trs31SkFO3TiXDtMUS23Re+OQ==
X-Gm-Gg: ASbGncuGShIP7cjibae/HzzBehORlrMkSffe98hH7VowjDYI+NIbBCSLayNdx6xy4sx
	3ykn4FWDxOMlOCz9FD7mxlTTRZsy1ySEc+8QrpJFEePX1Dp7DqSAEy005nC8E40kn0gGdZxa4QU
	VPLRPUOOZM0L7D2iPebbpdpCz8r5ZI4nWbE0J3A++mq5p/JbB0COrUkt5LYkLzpFDmWOUZNapT5
	d74eRWmWwugPSh3AskF5vDQJk1+9z4p7FlmQ4LSbcUDXa89daU5sn1PSLYz0eRwEZ63odk0Tp/X
	oXG8b8i4cp8+HCUqLR3QjRFl7XPIuN82L0EpvTf1dZ2qe2v/7IVdJHS76WYI8BZJxq9lGfI6W/9
	HCImeqj9uCQbyxlJlSZuG
X-Google-Smtp-Source: AGHT+IFmb6IkHO5vc0UO9aOVGDXMpB2kmzp4LmZ2sU6rPiqzBx0SBn3BZ18jaHfT4NmGETFHxk/nSg==
X-Received: by 2002:a17:902:f688:b0:231:ed22:e230 with SMTP id d9443c01a7336-23c6010f25amr2110315ad.15.1751374455431;
        Tue, 01 Jul 2025 05:54:15 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm108535025ad.166.2025.07.01.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:54:13 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:54:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 19/28] iommu: Allow an input type in hw_info op
Message-ID: <aGPabX6M2REffzjY@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <d8c395d6956045fd1fa1349538d29e3b6f9fada8.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c395d6956045fd1fa1349538d29e3b6f9fada8.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:50PM -0700, Nicolin Chen wrote:
> The hw_info uAPI will support a bidirectional data_type field that can be
> used as an input field for user space to request for a specific info data.
> 
> To prepare for the uAPI update, change the iommu layer first:
>  - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
>    output its only (or firstly) supported type
>  - Update the kdoc accordingly
>  - Roll out the type validation in the existing drivers
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 3 ++-
>  include/uapi/linux/iommufd.h                        | 4 +++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
>  drivers/iommu/intel/iommu.c                         | 4 ++++
>  drivers/iommu/iommufd/device.c                      | 3 +++
>  drivers/iommu/iommufd/selftest.c                    | 4 ++++
>  6 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e06a0fbe4bc7..e8b59ef54e48 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -603,7 +603,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>   * @capable: check capability
>   * @hw_info: report iommu hardware information. The data buffer returned by this
>   *           op is allocated in the iommu driver and freed by the caller after
> - *           use.
> + *           use. @type can input a requested type and output a supported type.
> + *           Driver should reject an unsupported data @type input
>   * @domain_alloc: Do not use in new drivers
>   * @domain_alloc_identity: allocate an IDENTITY domain. Drivers should prefer to
>   *                         use identity_domain instead. This should only be used
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f091ea072c5f..6ad361ff9b06 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -593,13 +593,15 @@ struct iommu_hw_info_arm_smmuv3 {
>  
>  /**
>   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> - * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
> + * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
>   *                           info
> + * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
>   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
>   * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
>   */
>  enum iommu_hw_info_type {
>  	IOMMU_HW_INFO_TYPE_NONE = 0,
> +	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
>  	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
>  	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 170d69162848..eb9fe1f6311a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -15,6 +15,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
>  	u32 __iomem *base_idr;
>  	unsigned int i;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 850f1a6f548c..5f75faffca15 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4098,6 +4098,10 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
>  	struct intel_iommu *iommu = info->iommu;
>  	struct iommu_hw_info_vtd *vtd;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_INTEL_VTD)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
>  	if (!vtd)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 8f078fda795a..64a51993e6a1 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -1519,6 +1519,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	    cmd->__reserved[2])
>  		return -EOPNOTSUPP;
>  
> +	/* Clear the type field since drivers don't support a random input */
> +	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
> +
>  	idev = iommufd_get_device(ucmd, cmd->dev_id);
>  	if (IS_ERR(idev))
>  		return PTR_ERR(idev);
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 8b2c44b32530..a5dc36219a90 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -310,6 +310,10 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length,
>  {
>  	struct iommu_test_hw_info *info;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_SELFTEST)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return ERR_PTR(-ENOMEM);

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 

