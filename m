Return-Path: <linux-kselftest+bounces-35629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16467AE4849
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A936818868F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C975286433;
	Mon, 23 Jun 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKkhY7Ta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B583276023
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691646; cv=none; b=qmXBRQIyQLyNclzkkyg9tHsAc6B5+ytJkB11IYRpeOUaRRxYujEapSNaeVAfVQmn2pwhbtqlzDtklQFouegoLyLGwggBKuJzYVeJSjO2jELlMBqBJ9JfA1xKQCItKqAuE3ZgDb2uBTiMHUTms4C/NrHAoezctU67S+LuQ52xLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691646; c=relaxed/simple;
	bh=T97FIRu7KTdXAKAuE2uiR/N85Qp0pQvg5x4paRRjBE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr+++J6gstwyS7yjNeElarlcN33p2mk5v4OJ9TXAiweCkmufKM/IZ0OlaAq0+2hPwM52tIMt07wEwbvySvag8DUyN4MEw4pol/IZDTJmkK/tZtdhI8Scl7u9Mpw4tAF7sZ0yzbVAT5eIv6xhmqnf7f4oZZclV0GJUiKNIHHRe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKkhY7Ta; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e389599fso345275ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750691644; x=1751296444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQjNcvHYakrNgjIQGLE/wyS2yfZF4798fujbYGUPWpc=;
        b=VKkhY7Ta928BptYCHJVYvcLh5d5S42bzKA+iRJ+oEn0vaAOt9h0TsdKx0TVjsG5sH4
         Z4q93H89iMYgYf0aYTsAgCNfxEn9VdxmzIGv5nStyrSyPIKbxJo9juXqmMMNq7ECHFDx
         B8JomsblSvNpl/fEvJo6R4/YPa9gv3aZKDa1EMjVHvRE+O9+BIZhlH/xK/wIzNWS/YSZ
         u5O5ucng1O3F0A9odAfGrmPgdSFcRgmoE3vaSf9skQt3uezUoJ5cU1m8WFQM9WRytk3B
         +hYacxGBwtbMioE5B0mmYlJdkMqV/80MQguGEMxtequZg9ItcVJDvF+AGxR7FFvPz+ij
         jIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691644; x=1751296444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQjNcvHYakrNgjIQGLE/wyS2yfZF4798fujbYGUPWpc=;
        b=SaEdyVQtIlhpMkd3q1SNtFp2ngDJNdlNyvl+2IhYzr10LpJXFLVwiEo8O8mZZHUy7U
         Q1MfhdY4wDolAsh/SCtRK5v1W+zzDISzzo69uS3cAeCEnjKGxAWnhfgHyBX3ApI4Q8JJ
         Dcc0nVL7oVQvlErrHJPEbChbcxhLoS03rjkMFt9SQggBkD/GprANlqmbvXFeLSGdjkcs
         Vgj3yRLnkNZ6DG7lyCkpXsFLQjgE5kF5BkviDQtvhkjaMMZATkuFAvd5gJnJkk7KyAl6
         n82n8qtNH3ERuZZFHjlUxRvy3SzkKRTxCi6y0NVASO3zhXsZja5c5KcKEGRoHRme2FER
         jZnA==
X-Forwarded-Encrypted: i=1; AJvYcCVQfjcM+b8wshabNhiw+T38dH7qxpnHu0+Pdomx0SnURqXNNLccQqMzJ+aJBNTAQT4newTySFnEYZb5kVAh0Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXQXebHJRk1ZmAU1GuKm/asqt5yt4puUsFPqpp+adAh6qPYsD
	iifsdrp/1ppwph0C5ttsxljp8kfkh71eJgwjg44VK3xGhbvGQSVF6W02hV3Ei4Jo4w==
X-Gm-Gg: ASbGncuvPXzAMwGHC43A+XsEOgt7KP1zerMYBP8RO8zOBkCVkqpZkYpjqr6TosvWaeW
	1xEFHucHtG/Lal5lDScIMr2PGHhVyDJ7lS7IfzK38iBrUR/EFFmVlMDiHQETx4tBABgUHODBr11
	EoTgMMOFAfHsZAG96svqFXgynaYsjQqYx0RAMwmLgvhw1ajlFPbEEww+3tZTdLAyEtsP22zWY2+
	pd/2rkGt1Svof3n4l/QtWbdr/FExPDLBBHxFITa7sitwxeZV6a9bvd8Hne/iPVjPEHMN9V2tHhE
	KPzIuFj7PvnLJrxfIyjZ8jLhrMvTFTmTF3U9gwl8WzAtXFD6yovrkIJge8NfoBqbLQD44CIowAH
	aEwEvK8/uwJ3wAQR2Ea1e99qLOexjOGQ=
X-Google-Smtp-Source: AGHT+IFjZuHSmjWz3mlyiiORGjulfaekm2TrngIFHZiE0ZqJkNGQDEFi3n1LBmgMIlW05C9z3Da4aQ==
X-Received: by 2002:a17:902:e951:b0:224:6c8:8d84 with SMTP id d9443c01a7336-237e478a96fmr4808555ad.4.1750691643222;
        Mon, 23 Jun 2025 08:14:03 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e6fbsm11004566a91.14.2025.06.23.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:14:02 -0700 (PDT)
Date: Mon, 23 Jun 2025 15:13:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 20/25] iommu/arm-smmu-v3-iommufd: Add hw_info to
 impl_ops
Message-ID: <aFlvLw0SHgYiA614@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <f36b5e42bac83d0cdf5773cad1c3a44c3eaed396.1749884998.git.nicolinc@nvidia.com>
 <aFP4zHIVT6epJeLb@google.com>
 <20250619185325.GB17127@nvidia.com>
 <aFTWQ4v6aZABpzeV@google.com>
 <aFZE+MhTOCvbkKbH@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFZE+MhTOCvbkKbH@nvidia.com>

On Fri, Jun 20, 2025 at 10:36:56PM -0700, Nicolin Chen wrote:
> On Fri, Jun 20, 2025 at 03:32:19AM +0000, Pranjal Shrivastava wrote:
> > My point is that in-case someone passed INTEL_VTD type, we would end up
> > calling impl_ops->hw_info and then the impl_ops->hw_info shall check for
> > the type to return -EOPNOTSUPP. Either we should clearly mention that
> > each impl_op implementing hw_info *must* add another type and check for
> > it
> 
> Let's add this:
> 
> @@ -721,6 +721,11 @@ struct arm_smmu_impl_ops {
>         int (*init_structures)(struct arm_smmu_device *smmu);
>         struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>                 struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +       /*
> +        * An implementation should define its own type other than the default
> +        * IOMMU_HW_INFO_TYPE_ARM_SMMUV3. And it must validate the input @type
> +        * to return its own structure.
> +        */
>         void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length, u32 *type);
>         const size_t vsmmu_size;
>         const enum iommu_viommu_type vsmmu_type;
> 
> And I found that we could have another patch changing "u32 *type"
> to "enum iommufd_hw_info_flags *type" to avoid some duplications
> in the kdocs.
> 

Yea, that sounds good. Thanks!

> Thanks
> Nicolin

