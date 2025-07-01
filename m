Return-Path: <linux-kselftest+bounces-36179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704AAEF890
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50978483D61
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90E2727E3;
	Tue,  1 Jul 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKbn0Nnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3378F26
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373054; cv=none; b=FCsLThwbFu8loKZY+VpaRpd7ItKlOnP44elL9RpPpR80IBs2d00tcaNxdEk3nnXgCT2f5nYzkUJNDblUrxcYRSVOlKTtGJkRtsabBmXDAX5yelz9bFAnF7WRTxGFgKfuZDuSanm/1KHMIQM9zuWPaovY6slqUD2rZyFO0Kf8v+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373054; c=relaxed/simple;
	bh=oNWtBTfARcQCwaHYGLs5aIj0PBvFVGGFyKJg1UjJTYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOAYgDIY0gFopnQXTLboc9lt+vg/PBH05ysrcBeepBD9G473x92/fR+oE76m1ykLQy+03OEhIHcwrWgikZhJUYcjuPC8QjHo6v8Fb2UHzRLzbKcw0oPc8KunV/p63YTyvyGH+ITiIgnf2GqUNJHRSm+JIgmT3HMe4FAjjX0ixKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKbn0Nnm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f270513bso137235ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751373052; x=1751977852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5G5J3LAQCME/FJ/aVZc/0ZWGlfQeuCDS4lOhsOKRFGs=;
        b=WKbn0NnmgkzxUsdcaqhQqraPMyrURXHKnri5ElSn1Vkd6BoqcdJ+BpbWZHRjOlYZzm
         NbP4xOICMR07Egga4/fajji1H5YeNz8LkRGRQVi97jr8gxwK03VAeI/v76ao5vcEth2/
         I7qCPu1lO+z90lkSnZD9P1Bq2LYvwRcu+Jt8/iNmhfKNQf4oQTo7RZ3Ppc0QvlX3n31u
         zd5zLWVizh5Ixst6JzcJxBp8j0nExn9Cnhgd9KuYQIpBsfjHvJF50X+gLlRo7wpe4x+B
         iuwMl6EycXVvvzBFEXVjcmCHNaGj/of7MPz3Bvvxz7M7DeNs0ch+lolEIsPjbZaLjtJl
         YtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373052; x=1751977852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G5J3LAQCME/FJ/aVZc/0ZWGlfQeuCDS4lOhsOKRFGs=;
        b=An/TaUzAoba0GCD4yI/ZMXgWkC/HGGBRE5Ho5Equ6BuZwEi8WmYsvZUPrU5K5GNR1B
         3rDySOwh7/S0rmZEX5Ln3w2wq+ys0XCe7Rln78Uktum6aMcmBRAHub282BrqxLRIEXSB
         Z0Jgm26wHTsHBRx2uNvoQvEh79dQM88Nsjc8Y3oKWclnJmZ9ZQDs/85XF0BX/HbjcZxg
         WPNIdoNuBQvUnvD0RZOTh+PSN/2cQatAW3eN8dbiuIZVkiPzusFIcrxpEq512jEUD7yF
         z35+4QOZkkrF/3zyjZk9WbU/YqrjWSXDlRjJGvR+HfTaLmJfkYmi6m0v84iXI3k0gpgV
         uaqA==
X-Forwarded-Encrypted: i=1; AJvYcCV42iVNVTRBhToUvemkRFT0iFOM0CgKCLFbjTL3YDLZi3tCZWphl/L3eRdPed7FhUXMTG/HE0kwc7GzE1BPSb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz18+dGi8irxUiwqb6TTlpwphU5Xc4BhpXWtu3VRwDoZKtTM63
	VfiA/94xbhggGP/AElZNtmimbgUOQNbwAsAAFO6P0b2SveW9/jxn9b7e0xPcFfGVXA==
X-Gm-Gg: ASbGnctF6INl15Ih8H/arruBgPbFX74uIrgtqlf00RIOiqzxMwjzo9yR1Pzm5XKyaqv
	b5JGX1JJEHKV6Z8HgYxjak93WbHVn1wviHc/Bru/X8oQqYXcrxsgd8OijgkeksjxhKjkl2KCmj5
	NDIkoDabYNmeX5KEzmx5zyqkGUKddbflAG4fSr5+eXucHbdLNaHg7/NXdP/KTCvvT1PgCnC8yCs
	ZAAAcc0xmmlzt9n1L4Z79OmNRMM18QWxt7YSGOp3wEwX2F3Ezj7aFsd8fv1mTfZUwiACXH0hy44
	Lc4s/4SqUuDFNEMP+P9D12WU9CEJzplbcxMqRwKqH9dtGtp3zhNadIdC7LGU+jNRBCj//NKbs+4
	l4LemN0bhvaegae+zOMXz
X-Google-Smtp-Source: AGHT+IGYS+ky70yGGbfgecWTu3WMn+4HvkqtKADO91HI0LqScQKuEGTHZn38lZjYqivfuwsxMW7HzQ==
X-Received: by 2002:a17:902:ce89:b0:235:f10a:ad0 with SMTP id d9443c01a7336-23c601a7645mr2227915ad.28.1751373051941;
        Tue, 01 Jul 2025 05:30:51 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm9319671a12.61.2025.07.01.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:30:51 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:30:42 +0000
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
Subject: Re: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Message-ID: <aGPU8qgfsa816eQ1@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:33PM -0700, Nicolin Chen wrote:
> The "id" is too genernal to get its meaning easily. Rename it explicitly to
> "virt_id" and update the kdocs for readability. No functional changes.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 7 ++++++-
>  drivers/iommu/iommufd/driver.c          | 2 +-
>  drivers/iommu/iommufd/viommu.c          | 4 ++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 4f5e8cd99c96..09f895638f68 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -634,7 +634,12 @@ struct iommufd_vdevice {
>  	struct iommufd_object obj;
>  	struct iommufd_viommu *viommu;
>  	struct device *dev;
> -	u64 id; /* per-vIOMMU virtual ID */
> +
> +	/*
> +	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
> +	 * AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
> +	 */
> +	u64 virt_id;
>  };
>  
>  #ifdef CONFIG_IOMMUFD_TEST
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 2fee399a148e..887719016804 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -30,7 +30,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>  	xa_lock(&viommu->vdevs);
>  	xa_for_each(&viommu->vdevs, index, vdev) {
>  		if (vdev->dev == dev) {
> -			*vdev_id = vdev->id;
> +			*vdev_id = vdev->virt_id;
>  			rc = 0;
>  			break;
>  		}
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 25ac08fbb52a..bc8796e6684e 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -111,7 +111,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
>  	struct iommufd_viommu *viommu = vdev->viommu;
>  
>  	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
> -	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> +	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
>  	refcount_dec(&viommu->obj.users);
>  	put_device(vdev->dev);
>  }
> @@ -150,7 +150,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  		goto out_put_idev;
>  	}
>  
> -	vdev->id = virt_id;
> +	vdev->virt_id = virt_id;
>  	vdev->dev = idev->dev;
>  	get_device(idev->dev);
>  	vdev->viommu = viommu;

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 

