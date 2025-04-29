Return-Path: <linux-kselftest+bounces-31943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1761AA398A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9BA173574
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB326A098;
	Tue, 29 Apr 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3WWJR3K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F62222A2
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962582; cv=none; b=Yphdn82959gCrSQibQ8jBiGpCe1DU9YPARHjPSE/Tk21UDQbtTqlW44ess26Cg3hD8ISs0Qjofu16CoBMfzdAae1wSmUQHh0Mwk//TlwTYF2KzL8F6KlaW/BGEN3kBFHxEhqAlmu4OMt6Wp7nEQPqnq3Yfp4miEtx73WKnWbbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962582; c=relaxed/simple;
	bh=pjG0WRYPmuFXgp5l4sOIxBPQ0JCTtzB9fn/bSzP4aws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phXdd4iT58CNkCGW3DcrM+3psP6Pk7KYcKE+YhRYlxbP6ZlA5iveLmJgSQxJXwOGrjhaO/tIRyFJAGCpdY7QvIiR1w2WKa1XmNb+yDuQbE+hOKenuaL21FSIZ86xCOOizHGlGNV0kjNR1Fk5+Yq6vQCJEqhoD/DEReo8BSWFzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3WWJR3K; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso80855ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745962580; x=1746567380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFHhD4L18F4DbheB1ANr+oLMK0ky8CpJtw12v2WCTVo=;
        b=h3WWJR3KHXoQt4F4HvEAoj3cZePfCxVWD/1YrVTrrUx/6XLQ9Mj7T3CWXVaterMCIj
         o+f91xIgBixGEZC0C2r87PY8UA+jmJlZQW3xeRXM4TO5H96RLlP53C4ymC5tcnVJx/AK
         Z0YLKoHsCSfPw9vVkrM4v6TAQJSZDfAFSVOdTCNJiHJh8DJhbsmVYktXfPSzQ8FJKXeq
         tKglu6tzlyfieyouUrDXeUN5vwvw9kMuDkkesc4LD236DRTL2VF6s//yFAI5aWU69dj5
         cV6eg5KvtCKcF2F0k0dsiYHjKNMCS94HgphR5j7jqp7SYEBtP34vX5T0QrO13H9lZ4Ja
         6scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962580; x=1746567380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFHhD4L18F4DbheB1ANr+oLMK0ky8CpJtw12v2WCTVo=;
        b=xHBeiCcYEqtUEagDJEX9QLcw9UZMPiZYzSrvl6sb3Ukpvj0ajIryh8G9iAhAeX2edn
         fk1OfwsZgt2BCSUpVGHQOd88ZQmVk6E/+cQY5mWdxZbS9ABHHIql66SXMZc8p+RqHDHV
         fFy2Wx9LNAucQwF5zwK554eCXSeIGmy+rAmQ79WynlI1Exnbafcf1rlEsSj1Bo7Zbj7J
         l1NAEwHT49Z5B+PXb8n8bVT3DDPc2IXnAe7eYVfkJXpN3uC5FYqTCyiq0nMyqp7OQWnJ
         iHLIJ7dThrOwv1wrBfnFns40Bf+nvzRNcBQQwX2CfDGBAOqru+NvZdzhD6cxAVi+C4kN
         dvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOHcgkkWvfk6TJF59Pm5GFJOzehfeDcv1hhNXF/45HwZnQYQHzUq3a9mvMPsTElm0blBXI7AYDqYwioxaBp4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4Js5b7P/ZAPmgAl03BBm7wJAFDUuk+ChNYAHAcZiKYZXPFw4
	0lzKP94bSyFkrp/rYwM9UPtaIySrQ4mHdD+1DyNDElnfm88f8aLxRmj8BG0G3Q==
X-Gm-Gg: ASbGncuWBZg8mtwwZ+GdKHaCIA8gjkpcURlkhrJuBRTjDsGmsix8qxyproXxqrVxY84
	daGktJOLPzFZkEHvn0F6OUjBzDT5SpfftlWfnKURvJniyhqUgbErqIK7nSYmiwM1m3mYLavYul4
	obevDep2dybhE3KRrMTXGlNvdQ3g42Bi4h2o4HQiAbMaR2YZXZti6aaFzzjKWFX6e3cB3WK5gRo
	l4xMXlyTw0Tz+W0AQxKzBW3eU/AxCNhJTwZUgudOXOmS5n5HIiyQ4ZKiA66wsKhvWzVibe3Yoz4
	jqnE0z9ssnEc6J0DAWRv/Hg9ulLzyMRnttNheAFUFgt5y3GzN1Eafvm8Ee2wiI3vpgSche1M
X-Google-Smtp-Source: AGHT+IHMqNgjircjCmAkmKl5VbBskPIbU47nTYxADS2hK6tD9L6Ge4YAR4USLtbPpDWqfiuVVAQ0lQ==
X-Received: by 2002:a17:903:144f:b0:21f:3f5c:d24c with SMTP id d9443c01a7336-22df3dda537mr1044155ad.0.1745962580224;
        Tue, 29 Apr 2025 14:36:20 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76d34sm108297185ad.39.2025.04.29.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:36:19 -0700 (PDT)
Date: Tue, 29 Apr 2025 21:36:09 +0000
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 16/22] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl
 op
Message-ID: <aBFGSRGcIsCDU1Zj@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <73b1fc34b07f2ac42d542dd996c7119ae5f8939c.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b1fc34b07f2ac42d542dd996c7119ae5f8939c.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:11PM -0700, Nicolin Chen wrote:
> An impl driver might support its own vIOMMU object, as tegra241-cmdqv will
> add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
> 
> Add a vsmmu_alloc op to give impl a try, upon failure fallback to standard
> vsmmu allocation for IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewd-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6b8f0d20dac3..a5835af72417 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -16,6 +16,7 @@
>  #include <linux/sizes.h>
>  
>  struct arm_smmu_device;
> +struct arm_smmu_domain;
>  
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
> @@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
>  	int (*init_structures)(struct arm_smmu_device *smmu);
>  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +	struct arm_vsmmu *(*vsmmu_alloc)(
> +		struct arm_smmu_device *smmu,
> +		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
> +		unsigned int viommu_type,
> +		const struct iommu_user_data *user_data);
>  };
>  
>  /* An SMMUv3 instance */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 66855cae775e..a8a78131702d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
> -	struct arm_vsmmu *vsmmu;
> -
> -	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> -		return ERR_PTR(-EOPNOTSUPP);
> +	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);
>  
>  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> -				     &arm_vsmmu_ops);
> +	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> +		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> +			master->smmu, s2_parent, ictx, viommu_type, user_data);
> +	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> +		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +			return ERR_PTR(-EOPNOTSUPP);
> +		/* Fallback to standard SMMUv3 type if viommu_type matches */
> +		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> +					     &arm_vsmmu_ops);
> +	}
>  	if (IS_ERR(vsmmu))
>  		return ERR_CAST(vsmmu);
>  
> -- 
> 2.43.0
> 

