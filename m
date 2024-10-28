Return-Path: <linux-kselftest+bounces-20782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20299B237F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAF281682
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ACA18593B;
	Mon, 28 Oct 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKB1hgJt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B78C11
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085866; cv=none; b=iNONy1CJPGlIszlCcZUVWZQlbdrsTppVd9jlsid+L1xal08W/iig8qKyk+iOun78j0FjpJNb0xia9NyWTuag27vX36Y1L0fLrEvQCXa3RZ2LdLMI5oev/xuuwP2sC7K1tXIvELE6mZ7hNEYV9Kz9HJ3HcfHnFNSmdmR5LPU3+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085866; c=relaxed/simple;
	bh=6/HcWulsp0sUfWKf/Rj2RN++KVB0uoFpXx1ouKtzxag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe7gl/w9x9CzP7IpiWlZjN/fyv2wME8D4d3SLfpHpAyGtXZLpbQf+o5MOPzQlfigxEPM1b9OFiWf4n9ja7DgTCvHS7KI59Zp97oDmQb+Nw9nNA6VDSDPip8RYXia8kuPhKnc6db8qjCJ58Wc6DZD9V5qx5cyXHVnPHL77oH8AH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKB1hgJt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so3864921e87.1
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730085862; x=1730690662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPB781Fw9J1BfJU7n/hLb4L32sFtxc+a4gofCEvfGmg=;
        b=zKB1hgJtCwO/cGOGSDWi5FjVhwDoQ47gnda9TcCMavTyErrGC3+V/SXE/xnoJHMXpL
         AwV2srd6DG+TXFRTFiRSpCe65bV5MX0sekA9N5a/YYEIA+7lotT3TasNohYLuVC2rYUl
         Zdi70ZC9xcJ5ml+n78y2b8Tbw466DMNtEnfzj0Ri6AJK1AXvxJ1MLtXGzs8n1w3M4STF
         6ebBEfe7G93lSlN8hZV4n5k9inERPWbn/tZClZvfEupbqzapeR1KZ0XcjROnF67ZHxeY
         70pDnCzY2qPs8GnzzPR+oEkdm3sz5ZT7F8Z35Lj7wL4loxYdBKf5tjbaIkBQuWlfFhJN
         pwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730085862; x=1730690662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPB781Fw9J1BfJU7n/hLb4L32sFtxc+a4gofCEvfGmg=;
        b=Hos5racAYSUz58PukhzpUk9Ff2M/v6bM/+9nxgoHXWEivMndcvr0mZD2iNJnu2faWG
         ksIA968EEtpZh5ZtAVkRXR46yndbOOVC/YwKoX/aGGnJrFVgCSK3bmRxH+JFBz6/5z5Q
         c8JTUoUUxqEs7ud6rL6mOK7h6S1GxA03qrdZ2DuB6Xd3x1m0iW30vICVyBDWf18eQTTg
         8dcWJBNakHTI8bx3r5rsOEg0QuocgOS7hb4KBrx7Fd4HSXn9Huz0QBeXVghD0wiyMI+v
         3NEk5Fnk6+Xb0Epfm5aXVbmlQ+xbTZXO5DediQT0w0wKGkKA9nFcaVM68xo8G/YFpejJ
         wTgw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Bpy6pOPyYHG3woekTbD+6e1SsMMWMeWULkgHZ0WXeeZL2fttoJ3lKSsz/Cxq1wcvhe+qTAIsMdzR9ksJNMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI/lCPcMSCKN0NZ1zoLq7/j+92SMs3CKtkFmq+1H0/dvqfe3X
	mmBH720aBnyB7TdRS6O/AefCmsdIPuyBGDR/EEuRJr97kAdIUsnGO8ablGccmduZ+pAxluqgXSS
	kJA97QYMAsvneBCLqOpiULI4vf3zCkBeXyW080Q==
X-Google-Smtp-Source: AGHT+IE3RYlMkjtpEmFCkSX9mMBH+mzTWtOwY6YLaPVzyehp5OXOXoK0z0ORaPfXJdTZ0CLfc2oO9l8aOUX21W6z4Ew=
X-Received: by 2002:a05:6512:3d16:b0:53a:423:6ea9 with SMTP id
 2adb3069b0e04-53b33e159a1mr2038562e87.13.1730085862110; Sun, 27 Oct 2024
 20:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729897352.git.nicolinc@nvidia.com> <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 11:24:10 +0800
Message-ID: <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Oct 2024 at 07:50, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
> that nesting parent HWPT to allocate a nested HWPT.
>
> Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
>
> Also, add an iommufd_hwpt_nested_alloc_for_viommu helper to allocate a
> nested HWPT for a vIOMMU object. Since a vIOMMU object holds the parent
> hwpt's refcount already, increase the refcount of the vIOMMU only.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  include/uapi/linux/iommufd.h            | 14 ++---
>  drivers/iommu/iommufd/hw_pagetable.c    | 71 ++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 9adf8d616796..8c9ab35eaea5 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -288,6 +288,7 @@ struct iommufd_hwpt_paging {
>  struct iommufd_hwpt_nested {
>         struct iommufd_hw_pagetable common;
>         struct iommufd_hwpt_paging *parent;
> +       struct iommufd_viommu *viommu;
>  };
>
>  static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 3d320d069654..717659b9fdce 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
>   * @size: sizeof(struct iommu_hwpt_alloc)
>   * @flags: Combination of enum iommufd_hwpt_alloc_flags
>   * @dev_id: The device to allocate this HWPT for
> - * @pt_id: The IOAS or HWPT to connect this HWPT to
> + * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
>   * @out_hwpt_id: The ID of the new HWPT
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
> @@ -449,11 +449,13 @@ enum iommu_hwpt_data_type {
>   * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
>   * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
>   *
> - * A user-managed nested HWPT will be created from a given parent HWPT via
> - * @pt_id, in which the parent HWPT must be allocated previously via the
> - * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
> - * must be set to a pre-defined type corresponding to an I/O page table
> - * type supported by the underlying IOMMU hardware.
> + * A user-managed nested HWPT will be created from a given vIOMMU (wrapping a
> + * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
> + * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
> + * case, the @data_type must be set to a pre-defined type corresponding to an
> + * I/O page table type supported by the underlying IOMMU hardware. The device
> + * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
> + * instance.
>   *
>   * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
>   * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index d06bf6e6c19f..1df5d40c93df 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -57,7 +57,10 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
>                 container_of(obj, struct iommufd_hwpt_nested, common.obj);
>
>         __iommufd_hwpt_destroy(&hwpt_nested->common);
> -       refcount_dec(&hwpt_nested->parent->common.obj.users);
> +       if (hwpt_nested->viommu)
> +               refcount_dec(&hwpt_nested->viommu->obj.users);
> +       else
> +               refcount_dec(&hwpt_nested->parent->common.obj.users);
>  }
>
>  void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
> @@ -260,6 +263,56 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>         return ERR_PTR(rc);
>  }
>
> +/**
> + * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
> + * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
> + * @user_data: user_data pointer. Must be valid
> + *
> + * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
> + * hw_pagetable.
> + */
> +static struct iommufd_hwpt_nested *
> +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> +                                const struct iommu_user_data *user_data)
> +{
> +       struct iommufd_hwpt_nested *hwpt_nested;
> +       struct iommufd_hw_pagetable *hwpt;
> +       int rc;
> +
> +       if (flags)
> +               return ERR_PTR(-EOPNOTSUPP);

This check should be removed.

When a user page fault is required, IOMMU_HWPT_FAULT_ID_VALID is set.
if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {

By the way, has qemu changed compared with v3?
I still got a hardware error in this version, in check

Thanks

