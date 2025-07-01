Return-Path: <linux-kselftest+bounces-36182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B67AEF92D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E247E16DA5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37572273812;
	Tue,  1 Jul 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ22HQYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BC264FA0
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374278; cv=none; b=MF6fnT1rqGj3OYgHNXx6oW2qvEWeqVuG4xTHHldZ6g3NQgpfzz7b4UjUoOj5DAdc6eKZFSaaYHmd28XU193cbBJ3kYjob2+rTGTsN7tsQUW9+7G4e9e7ioxkAQaJ1aUebUJc3SD6hOXZCF269Al3RAJL3V3O1f/YrVQgKct4o+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374278; c=relaxed/simple;
	bh=UTZrlI9y+37r9TWwpMElUdLKen5fGKONWtUw6j0dYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIy8BX/y0zZOxjor1buv/gYaFtIMH+wUjeZ3e3UTBo81o+eSNnHgNgbguiFwFUe4YhGjRj+b5ar19v1oQQ92oZmyoot7dbLwE6cAboHD6CV9hqW/+Ra1rkAspGnkQ2zf3FivQQAKNW+hTq/7CqRTNQVr95rp89aZE271a9nM+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ22HQYO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so119005ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751374276; x=1751979076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPts6df6Q4890tqHCArh7YEtzYo+b0PlaNL9e95JEQ4=;
        b=aZ22HQYO2CqPeJ5vOwF6wf4CSqisVmIBvzHTgoCjmt0XbKMp4kwFYuz8OdHg8EPDW8
         7xnR/FJZlhYW+K0ywv5vA5Em26BUKdz+UJjtuMwYD3BtThUNfFqvYgxOM2QUrBqIst5Y
         36bhdgEzDZb0qHcDwSJG76Yov6n0hJ0MEj0MVbB4tjo7xwHce+1mkOr/qB2X7UGd+Ncf
         1wAvl8j0siGa2mztOi5hp9mLcUduWKa6/nrTjceFVyDF9akhAjNYkPg9BWEuV/uQY2Hs
         YFmlPLe++xvJ2f/C0d+fBSyqrCjYNHso4ZZh0UH1MHDrKDVEqxHuZxd0g0TOk8YPCcV/
         DoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374276; x=1751979076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPts6df6Q4890tqHCArh7YEtzYo+b0PlaNL9e95JEQ4=;
        b=ieFzMWfX0RAyOw/E8reamCWvMofaJbyRnYKPt/JKUvQEYGhNIepXJbCs07Dn53vOgy
         2PCv0BSGhy3HTe7noUNFgq4C5BD/Iia8eB51s0iths85cqskHIT4g1N79lxiUS4lxzXh
         qd5huLo3j4zyzRa/26s6S5dR1BlU5pQnA8c+RVXNe/kHqfi8Jd+gfongTW2TLXqZ599S
         3ZwXZ7bcX7LkpkpvLvqQ0rTJJXt1jI8VS/5cwGlqzXMxOB08/jSu/SbamXBc7GZhEaWW
         uzA7Pkxts7zbxenk3AJh1qQzIBQXY8bKTzs9aADd6vL4D03qE6FgV1AI5Z6QH2nqB6w7
         QcSw==
X-Forwarded-Encrypted: i=1; AJvYcCWkr6DTpVnktds6mnWNjQ1qjy5EEp8eG7bfPLsYIUKocQDkNWOewbyH3txBGO+tHIvvE54/ydDc0rpU1UmYLUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MEiNLrgp0+fldspIuqE8Ar6dcueW+VO8J9yoV+AL6+0DoMDO
	cJK5aVkcWdrqi3ENTaqpRmdofWAWvG1V6P4Pr3Vi3hkTQdGdeRxHozu1Cr648OL23Q==
X-Gm-Gg: ASbGncusEXs4/7QccfAGXN9ijfO0QwIjFSv1VwIZqLtOYwX9d580UUn+Nlov7MVi2vh
	InLT76QiYp2q26HtLTTZvNdPakrvK8WIitIS2oA9iIYTMUU47EeEQLz/y3zjSmXE7VHYkRngPLQ
	dKhsYd5QH0gpmN+MC/aq379aL5MBuGh1CbOHeWQCAFijgxYIixiIF0VXNnsuDtKRVrPKPOMjIah
	5j4QPnZI3ztaM7TJesmX4uGjW1kLUUCqRVaWogbJf++ppInI2jU+Ia4geWrVFbsqus8IeJ/nUeQ
	CqJvIApC6nNzJkn4YmS7ZZh8hM/x4Qw5+bbcNgFQEM/lVSQbFigEmoqsPm6aalF/rhN87/zZ/EC
	aZqe5BfopBmd66E8ViRRf
X-Google-Smtp-Source: AGHT+IGScnewrdwJXz5o2+pGS36a0Kxzmd5AqmLzt37Kv43BKh9NBBAVMo2i4U9SfF+orF6VioLZJQ==
X-Received: by 2002:a17:903:b07:b0:234:bfa1:da3e with SMTP id d9443c01a7336-23c5ff04d7cmr1891395ad.5.1751374275468;
        Tue, 01 Jul 2025 05:51:15 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ee760sm11194996b3a.155.2025.07.01.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:51:14 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:51:05 +0000
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
Subject: Re: [PATCH v7 03/28] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Message-ID: <aGPZuSKBSADLbwas@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:34PM -0700, Nicolin Chen wrote:
> Replace u32 to make it clear. No functional changes.
> 
> Also simplify the kdoc since the type itself is clear enough.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/intel/iommu.c                         | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 3 ++-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 04548b18df28..b87c2841e6bc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -563,8 +563,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>   * @capable: check capability
>   * @hw_info: report iommu hardware information. The data buffer returned by this
>   *           op is allocated in the iommu driver and freed by the caller after
> - *           use. The information type is one of enum iommu_hw_info_type defined
> - *           in include/uapi/linux/iommufd.h.
> + *           use.
>   * @domain_alloc: Do not use in new drivers
>   * @domain_alloc_identity: allocate an IDENTITY domain. Drivers should prefer to
>   *                         use identity_domain instead. This should only be used
> @@ -623,7 +622,8 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>   */
>  struct iommu_ops {
>  	bool (*capable)(struct device *dev, enum iommu_cap);
> -	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
> +	void *(*hw_info)(struct device *dev, u32 *length,
> +			 enum iommu_hw_info_type *type);
>  
>  	/* Domain allocation and freeing by the iommu driver */
>  #if IS_ENABLED(CONFIG_FSL_PAMU)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 9f59c95a254c..69bbe39e28de 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -7,7 +7,8 @@
>  
>  #include "arm-smmu-v3.h"
>  
> -void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
> +void *arm_smmu_hw_info(struct device *dev, u32 *length,
> +		       enum iommu_hw_info_type *type)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct iommu_hw_info_arm_smmuv3 *info;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7aa3932251b2..850f1a6f548c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4091,7 +4091,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>  	return ret;
>  }
>  
> -static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
> +static void *intel_iommu_hw_info(struct device *dev, u32 *length,
> +				 enum iommu_hw_info_type *type)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 74ca955a766e..7a9abe3f47d5 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -287,7 +287,8 @@ static struct iommu_domain mock_blocking_domain = {
>  	.ops = &mock_blocking_ops,
>  };
>  
> -static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
> +static void *mock_domain_hw_info(struct device *dev, u32 *length,
> +				 enum iommu_hw_info_type *type)
>  {
>  	struct iommu_test_hw_info *info;
>  

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 

