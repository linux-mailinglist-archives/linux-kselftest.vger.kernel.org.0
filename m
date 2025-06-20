Return-Path: <linux-kselftest+bounces-35400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BFAE11D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244A119E161E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B71DE4E7;
	Fri, 20 Jun 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoGnXy/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3401C862C
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390354; cv=none; b=tabOLMX4rwbgl5rFNHoNUOCmpUEuvnMKCc3VtDBfk7v8weoiXnCrXmLz9IAFbattbkGvGwFpekLR2UWlCMl9/SDnTyjAtrfNVgyrUBUjm69uVnM1z+aCS78nAHbgBSEKr/k478OBMMbFnHDZarn7RMf1QJhBbSIhLVBV21ooeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390354; c=relaxed/simple;
	bh=9Hg5pobEE7M3tPGS8XdU/oGbneOqIPiRWFR/3Cld4kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRObwhVv+Yjcf4PVpWcWtXzqNsp0LU02nZe4IMVze9/gYXanNJR2VwIfmTU1BU3jYSItiripEqkHcVTQpiEcJd9z3fIsIcvu0IsxiwuEnrihuF9s/XPJJ79KOSki2Mh0cNysv+ZSIPojR0F1qWEMa4FmZA5s1q4mLd8yQIVmH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoGnXy/A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ca5eba8cso244785ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750390352; x=1750995152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qa/VDd/mSdDHpuvSCZ3/ODd1JXeFiiam1MgWlPeSiGs=;
        b=AoGnXy/AZbTUnAiISuR6WY4TdSv0KCdP51xnuZwgl0WKBl6MsF3POltmch5BtyqMwO
         FwlVPQJz+ibakQaIKbNccY5TrGBl3L+vePiIWy8XJb/Pfs9N8JSIwi+7q7LeBAbiKm2N
         9edG8wsPF5uOalZI7FPS2HPwjGOuQE17a14pxzQA5tMWNmJjm5N+oTUGRW2cqzkh5yky
         yioB7FAaIZWH8SunlNbK2Nmv2X1NEK/BRNffTu+vRnS3OvCjNG5r5no4ZVm6L7G01Kl4
         SC7pKoxN/abeH/BFqZy8KsNjgNGRqpoKxTQR1K5soXhxQilNZttiYWcqvKekWfUx/nyq
         hnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750390352; x=1750995152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa/VDd/mSdDHpuvSCZ3/ODd1JXeFiiam1MgWlPeSiGs=;
        b=MNpHOKGUG4e9zKUO5NsXFtq8PkQ2j091lLCHuas87xJhC2oblOXFl6vgEa1Ix5Xmud
         /hfd/A/k8fjTta7j3e6zvQNiEOO9LFXdKXItg4de8TOZYh2/BbbgwC7qarLEHQbUsPwE
         MYAevfH4mdXHR+lZkENu0p+iFiX61XwlYoCvxWtcmrje6XtPda2DT8N5NTTi43IZZQ/D
         97992v/OSOIE90OF4sYiI8WGtzaM0yq+njV11rwR50cm03h+muDnYzgLq7aDjXdOZ7L0
         f/pFkUSjo2cQtpWwgWnpf6DCvVgx8B6qAbm2njqfhAEXOvbGhEKAPjgiaxSDKM7X03ph
         5Ugw==
X-Forwarded-Encrypted: i=1; AJvYcCX2XJuOwGY4bJbtD2tyjquxW0KqQBkxReIvQap4ohG7aXOMH1F0729+46UVi3hVK9rlgzTB/4Kh1GUkYAR544w=@vger.kernel.org
X-Gm-Message-State: AOJu0YystUdMFE6BOpUsorkLmoceipNe5h1gB3xzJQ36XyHEV6lqem8W
	62wyjwrU6R2RnHWJsGBIvjUws9GR5lLIRdP5p7QxSrGzcSAKhLuFvHE9fA57SmJx9A==
X-Gm-Gg: ASbGncs0gYM6J6JSYFYC2lBGwGbChjF48aVHdlWFVJp62f5W/2CqKSRvOL5oGxi/iB3
	xDDEnKRtwfMz6yFu75QR00bvhZMo53faUmwCZXLLPHmCq1TYAJL/LgItCBBN8SJSsgAe1QmDdx0
	8fmOriVn8+A/VHivsIsMe6Fmv05S1zi+vcr84fVBVVoKmy0WVszaXnwsDmXyrmiuFAM6BgFHOxI
	H2DHvgPW4WcNFJFx1j38QEYRLp4ToGwf/iUaLypei/NVqoZOmwUoufmq+i0X7d2GP58OfLtpKyB
	hYT1r5LGrN+aj33g6pRauLJz6AxKUXWAOv7Gf1FbzvG1sQoaGq2SHIIIGm1cLqlylm88hh0+KDZ
	YwQf6sB60fRZV9c+nY3R243h+UAOJmtI=
X-Google-Smtp-Source: AGHT+IERsl+HTUr1rqxITuYHKylDMvSd/CxPtRuNjbrAMl+KyO4xPzytclG3wi1xtC95QCov1vt9OA==
X-Received: by 2002:a17:903:1667:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-237cc9fd3d7mr4672645ad.14.1750390351828;
        Thu, 19 Jun 2025 20:32:31 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ce860sm6966175ad.65.2025.06.19.20.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:32:31 -0700 (PDT)
Date: Fri, 20 Jun 2025 03:32:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 20/25] iommu/arm-smmu-v3-iommufd: Add hw_info to
 impl_ops
Message-ID: <aFTWQ4v6aZABpzeV@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <f36b5e42bac83d0cdf5773cad1c3a44c3eaed396.1749884998.git.nicolinc@nvidia.com>
 <aFP4zHIVT6epJeLb@google.com>
 <20250619185325.GB17127@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619185325.GB17127@nvidia.com>

On Thu, Jun 19, 2025 at 03:53:25PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 19, 2025 at 11:47:24AM +0000, Pranjal Shrivastava wrote:
> > I'm not sure if I get this right.. if the user (while porting a VMM or
> > something) mistakenly passes *type == IOMMU_HW_INFO_TYPE_INTEL_VTD here,
> > they'll get impl-specific info?
> 
> It should call the impl hw_info which should fail?
> 
> +static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
> +				    u32 *type)
> +{
> +	if (*type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV)
> +		return ERR_PTR(-EOPNOTSUPP);
> 
> If impl ops is null/etc then it fails:
> 
> +             if (!impl_ops || !impl_ops->hw_info)
> +                     return ERR_PTR(-EOPNOTSUPP);
> 
> Where does IOMMU_HW_INFO_TYPE_INTEL_VTD return something?
> 

I mean, the check in the driver (for e.g. arm-smmu-v3) is:

 if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
     *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)

     // call impl_ops

My point is that in-case someone passed INTEL_VTD type, we would end up
calling impl_ops->hw_info and then the impl_ops->hw_info shall check for
the type to return -EOPNOTSUPP. Either we should clearly mention that
each impl_op implementing hw_info *must* add another type and check for
it OR we could have sub-types for implementations extending a main type
somehow?


> > I agree in that case the impl-specific
> > driver needs to check the type, but shouldn't we simply return from here
> > itself if the type isn't arm-smmu-v3?
> 
> Then how do you return IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV?
> 

The current version is just fine with a doc string mentioning type
checks within impl_ops->hw_info OR we could have sub-types for
implementations extending some architectural IOMMU. 

I'm just trying to avoid weird bug reports in the future because some
impl didn't check for their type.

> Jason

Thanks
Praan

