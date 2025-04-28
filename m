Return-Path: <linux-kselftest+bounces-31746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D1A9E5A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 03:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96A5189850F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE04823DE;
	Mon, 28 Apr 2025 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mrs5LmCD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520FBA34;
	Mon, 28 Apr 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745802822; cv=none; b=DTYU/Yydfu+PFkvQm4N5HP4gKmLn/kCvsiE/khw/Y/UskvFcgFF6kcc2EGFmL1pl06qw5e8L8fFulmUP93yocmEPgnarLnjaz3hKA7QwRzFmvsR/ey3KQCsSSxaLtc7v0duoW90aYYjqvTNuuC+TWv3mMOhH3KHm2d41kwvuaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745802822; c=relaxed/simple;
	bh=SzVEkDhgS3lNLKaxMmkzixB0NkfENpwp720ZSDFOdIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8i4JEtZuzK7q/kK3c5wxAgB3LK+NMv0MgR7CwGNuj44GU/7yha1lRIN/C+mP0KfDGNgal0ayqqu6dweMubl9V8UOfDPIAPs556Ne2UP+dxG/cdVsnU8ONQ02gf2TZA4gcAuTNfrb8eZhUPQ4tmMhJhLbej1KHZZRl8yPaH5jtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mrs5LmCD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745802821; x=1777338821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SzVEkDhgS3lNLKaxMmkzixB0NkfENpwp720ZSDFOdIQ=;
  b=Mrs5LmCDBZV51VbYkQuIrvFI9VEMIBpM3KQAnNgf1I+Gs9PqRy6yGa0Z
   BGxrAAYoptSQHCO6Da3XOzZlRDOXldiP8ozlt4kuu9z4F6I0MdxFaA0LG
   0xMLgdCgnEFwL5uKp9zlbxQiRKVMdOBM00IbvHFl4lzop8nhQ/b5FQASO
   xm8o3Z8npaIUmQf0pVtgkY0YqPQEDOWxjjKNCePPMdLwlDwpoRXymILIr
   RGRrcXD/1/LG+XtkxXczOWr4FtolyqnfI64p8y1wD4738xWXGxn5V0DQs
   5YcrkIcfkdwjwPULfdelI6nxtEGWtSOTPclQJc+bHe+/K16vv/6JaxobE
   Q==;
X-CSE-ConnectionGUID: Vw8OCtMdSs6wmIstyIePEw==
X-CSE-MsgGUID: umwdTVxgQbOejdHAge0+wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47469189"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="47469189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:13:34 -0700
X-CSE-ConnectionGUID: kCEJNONXT+mMJ2UwL1Mdjw==
X-CSE-MsgGUID: 1gUHhF4hT5y9Cgd2z9Awrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133265254"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:13:29 -0700
Message-ID: <28e513ec-4d8b-4967-a241-d6f63d533050@linux.intel.com>
Date: Mon, 28 Apr 2025 09:09:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure, representing
> a command queue type of physical HW passed to a user space VM. This vCMDQ
> object, is a subset of vIOMMU resources of a physical IOMMU's, such as:
>   - NVIDIA's virtual command queue
>   - AMD vIOMMU's command buffer
> 
> Inroduce a struct iommufd_vcmdq and its allocator iommufd_vcmdq_alloc().
> Also add a pair of viommu ops for iommufd to forward user space ioctls to
> IOMMU drivers.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

with a small nit below ...

> ---
>   include/linux/iommufd.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index ef0d3c4765cf..e91381aaec5a 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -37,6 +37,7 @@ enum iommufd_object_type {
>   	IOMMUFD_OBJ_VIOMMU,
>   	IOMMUFD_OBJ_VDEVICE,
>   	IOMMUFD_OBJ_VEVENTQ,
> +	IOMMUFD_OBJ_VCMDQ,
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOMMUFD_OBJ_SELFTEST,
>   #endif
> @@ -112,6 +113,14 @@ struct iommufd_vdevice {
>   	u64 id; /* per-vIOMMU virtual ID */
>   };
>   
> +struct iommufd_vcmdq {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_viommu *viommu;
> +	dma_addr_t addr;

It's better to add a comment to state that @addr is a guest physical
address. Or not?

> +	size_t length;
> +};

Thanks,
baolu

