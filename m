Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D459A6B07FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 14:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCHNH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 08:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCHNHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 08:07:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A4BD4E6;
        Wed,  8 Mar 2023 05:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678280749; x=1709816749;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gkWkXV9ETeuxYkdR2G8mzEdUCDCHpkb0t/igFlnbPN8=;
  b=WkAHDhcD7q0GN1uLesmpKv4k90LuyYWQNN1gNxXTosqGejJOii0ibRkm
   maRVxUJT0oVh41o8PiT/RdFxjVyllwGUfqeU01m+hQCDR+Er68/a6msfL
   cCzhEd5SZTlnX8Nus5UNkMmIPvChxni5LBYY5ll8E+HYF0B0y2anWORG/
   vplK+pyssPvzuD7Pdeg/t3/o2kDUZPEiJ2fqqDufLza748JwkcIHvMJ9m
   L6+3GLbeUL6AlSBlVsHq3hiP7VFKHg4TtYAgb/EHn6eytbV+o6NNFwxGc
   cmkY6VbyPSh496Ds5MOP096UgnFfDce34817T8UKTj5nT7UC6ZPs+AgTE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336161425"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="336161425"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709417838"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="709417838"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:04:49 -0800
Message-ID: <07b337da-e215-434b-b84f-8fadd07e3020@linux.intel.com>
Date:   Wed, 8 Mar 2023 21:04:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 09/17] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> Logically the HWPT should have the coherency set properly for the device
> that it is being created for when it is created.
> 
> This was happening implicitly if the immediate_attach was set because
> iommufd_hw_pagetable_attach() does it as the first thing.
> 
> Do it unconditionally so !immediate_attach works properly.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          | 20 +++++-------------
>   drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>   3 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index d6d5c2fcc33889..ddde14d6d1352c 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -293,21 +293,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
>   		return -EINVAL;
>   
> -	/*
> -	 * Try to upgrade the domain we have, it is an iommu driver bug to
> -	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> -	 * enforce_cache_coherency when there are no devices attached to the
> -	 * domain.
> -	 */
> -	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> -		if (hwpt->domain->ops->enforce_cache_coherency)
> -			hwpt->enforce_cache_coherency =
> -				hwpt->domain->ops->enforce_cache_coherency(
> -					hwpt->domain);
> -		if (!hwpt->enforce_cache_coherency) {
> -			WARN_ON(list_empty(&idev->igroup->device_list));
> -			return -EINVAL;
> -		}
> +	/* Try to upgrade the domain we have */
> +	if (idev->enforce_cache_coherency) {
> +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> +		if (rc)
> +			return rc;

As "HWPT should have the coherency set properly for the device that it
is being created for when it is created", is it an incompatible case if

	idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency

?

If so, why not,

	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency)
		return -EINVAL;

?

Best regards,
baolu

>   	}
>   
>   	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 566eba0cd9b917..2584f9038b29a2 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
>   	refcount_dec(&hwpt->ioas->obj.users);
>   }
>   
> +int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
> +{
> +	if (hwpt->enforce_cache_coherency)
> +		return 0;
> +
> +	if (hwpt->domain->ops->enforce_cache_coherency)
> +		hwpt->enforce_cache_coherency =
> +			hwpt->domain->ops->enforce_cache_coherency(
> +				hwpt->domain);
> +	if (!hwpt->enforce_cache_coherency)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>   /**
>    * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
>    * @ictx: iommufd context
> @@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   		goto out_abort;
>   	}
>   
> +	/*
> +	 * Set the coherency mode before we do iopt_table_add_domain() as some
> +	 * iommus have a per-PTE bit that controls it and need to decide before
> +	 * doing any maps. It is an iommu driver bug to report
> +	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
> +	 * a new domain.
> +	 */
> +	if (idev->enforce_cache_coherency) {
> +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> +		if (WARN_ON(rc))
> +			goto out_abort;
> +	}
> +
>   	mutex_lock(&idev->igroup->lock);
>   
>   	/*
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 8bf053f4d4a9ce..471a3fdff1e0b6 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
>   struct iommufd_hw_pagetable *
>   iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   			   struct iommufd_device *idev, bool immediate_attach);
> +int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
>   int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   				struct iommufd_device *idev);
>   struct iommufd_hw_pagetable *

