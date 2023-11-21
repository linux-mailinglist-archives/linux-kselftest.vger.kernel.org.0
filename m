Return-Path: <linux-kselftest+bounces-361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1787F2500
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 06:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9419C282886
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6B12B76;
	Tue, 21 Nov 2023 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg/eS22K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE65E8;
	Mon, 20 Nov 2023 21:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700543234; x=1732079234;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tA/vaGjjRiH/cKluNjWIBq0rgjGXDmLoZ5c27UMHYmM=;
  b=Qg/eS22K0IyvupnH5jRuvH1nK/JNC/iFG/Ev/7U008EyPJ63lJ+RWciq
   viYV6pdkjwhEClWmDK+A1VeWbOsYWx5W1xlMntwGKQrp5byILr9rACEBf
   7ccV08cM57ZB95bcLW1irYZWyVt7btRrwAGWYJvTh44XEnGDnqYw3a0Bn
   2q05KxKnUhsm4nAPmkejVrfbjnV+oHUvdSW49BB2vjmFSK3g2975VXcRh
   d+DzcxtL+OAmGg8p3HirCsToRZWlhtU8GN1eEXdlacaRqZKpxJ/zzPoqf
   wGKz6RgCZ/J7gjH9i6UOuJ4cC1NOYXX16DF1W0i6bGNWmYqGxYSJxxq2h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371937511"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371937511"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836946263"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="836946263"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 21:07:08 -0800
Message-ID: <e36e856a-8d4c-4cc2-a5db-cf00673a9bf7@linux.intel.com>
Date: Tue, 21 Nov 2023 13:02:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231117130717.19875-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/23 9:07 PM, Yi Liu wrote:
> In nested translation, the stage-1 page table is user-managed but cached
> by the IOMMU hardware, so an update on present page table entries in the
> stage-1 page table should be followed with a cache invalidation.
> 
> Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
> It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
> support multiple invalidation requests in one ioctl.
> 
> Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
> since all nested domains need that.
> 
> Co-developed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
>   drivers/iommu/iommufd/main.c            |  3 +++
>   include/uapi/linux/iommufd.h            | 35 +++++++++++++++++++++++++
>   4 files changed, 82 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 2abbeafdbd22..367459d92f69 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   		rc = -EINVAL;
>   		goto out_abort;
>   	}
> +	/* Driver is buggy by missing cache_invalidate_user in domain_ops */
> +	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> +		rc = -EINVAL;
> +		goto out_abort;
> +	}
>   	return hwpt_nested;

The WARN message here may cause kernel regression when users bisect
issues. Till this patch, there are no drivers support the
cache_invalidation_user callback yet.

Best regards,
baolu

