Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005776B071F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHMcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 07:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCHMcJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 07:32:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE810BF39C;
        Wed,  8 Mar 2023 04:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678278728; x=1709814728;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aSwSnrnYtx5HfuCn7oLbNmhllLEiS3nEBps34Vf9AHM=;
  b=ntHAB7dOCStWHcaUWU3Y/IXPPpS+jtNg4VldXNttG8SDERABPFLzaS/k
   DyClkvQYNw3DayBW22Oi9TrOZsgwIEvHqlBw2xmnVF8LqeDRakyvgHdZD
   5CY+xaQtG36g0xQMc9SbIZPl6DPx3GbbCmt6dkEWsTg6w4glh+TmZJ3nS
   AUX/P+3wqcO/a64JghBHmG2cl4mXrcasbnDIHek7VlC+IZcGRAWoFn2Q3
   KzcKvMf4kUIp6npckO9Iv8zFV81b6nt0/Q0uBwcRFFftoUkubvKeZ/34/
   QitSqua93JcpA6AaA8OEMgWfTwXuAWGJGJBttFoYlMtF2Gr6QJ6JAtpHS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324452768"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="324452768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679322595"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="679322595"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:32:05 -0800
Message-ID: <9a047c7f-924d-0c8a-7055-fcbe7c84429b@linux.intel.com>
Date:   Wed, 8 Mar 2023 20:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> The driver facing API in the iommu core makes the reserved regions
> per-device. An algorithm in the core code consolidates the regions of all
> the devices in a group to return the group view.
> 
> To allow for devices to be hotplugged into the group iommufd would re-load
> the entire group's reserved regions for each device, just in case they
> changed.
> 
> Further iommufd already has to deal with duplicated/overlapping reserved
> regions as it must union all the groups together.
> 
> Thus simplify all of this to just use the device reserved regions
> interface directly from the iommu driver.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          |  5 ++---
>   drivers/iommu/iommufd/io_pagetable.c    | 25 ++++++++++---------------
>   drivers/iommu/iommufd/iommufd_private.h |  7 +++----
>   3 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index a4bf4c5826ded2..b546250dd1e226 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -310,9 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   		}
>   	}
>   
> -	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
> -						   idev->igroup->group,
> -						   &sw_msi_start);
> +	rc = iopt_table_enforce_dev_resv_regions(
> +		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index e0ae72b9e67f86..427f0cc0f07955 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -1162,24 +1162,21 @@ void iopt_remove_access(struct io_pagetable *iopt,
>   }
>   
>   /* Narrow the valid_iova_itree to include reserved ranges from a group. */
> -int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
> -					  struct device *device,
> -					  struct iommu_group *group,
> -					  phys_addr_t *sw_msi_start)
> +int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
> +					struct device *dev,
> +					phys_addr_t *sw_msi_start)
>   {
>   	struct iommu_resv_region *resv;
> -	struct iommu_resv_region *tmp;
> -	LIST_HEAD(group_resv_regions);
> +	LIST_HEAD(resv_regions);
>   	unsigned int num_hw_msi = 0;
>   	unsigned int num_sw_msi = 0;
>   	int rc;
>   
>   	down_write(&iopt->iova_rwsem);
> -	rc = iommu_get_group_resv_regions(group, &group_resv_regions);
> -	if (rc)
> -		goto out_unlock;
> +	/* FIXME: drivers allocate memory but there is no failure propogated */
> +	iommu_get_resv_regions(dev, &resv_regions);
>   
> -	list_for_each_entry(resv, &group_resv_regions, list) {
> +	list_for_each_entry(resv, &resv_regions, list) {
>   		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
>   			continue;
>   
> @@ -1191,7 +1188,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>   		}
>   
>   		rc = iopt_reserve_iova(iopt, resv->start,
> -				       resv->length - 1 + resv->start, device);
> +				       resv->length - 1 + resv->start, dev);
>   		if (rc)
>   			goto out_reserved;
>   	}
> @@ -1206,11 +1203,9 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>   	goto out_free_resv;
>   
>   out_reserved:
> -	__iopt_remove_reserved_iova(iopt, device);
> +	__iopt_remove_reserved_iova(iopt, dev);
>   out_free_resv:
> -	list_for_each_entry_safe(resv, tmp, &group_resv_regions, list)
> -		kfree(resv);
> -out_unlock:
> +	iommu_put_resv_regions(dev, &resv_regions);
>   	up_write(&iopt->iova_rwsem);
>   	return rc;
>   }
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2ff192777f27d3..22863759c3bfb0 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
>   			  struct iommu_domain *domain);
>   void iopt_table_remove_domain(struct io_pagetable *iopt,
>   			      struct iommu_domain *domain);
> -int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
> -					  struct device *device,
> -					  struct iommu_group *group,
> -					  phys_addr_t *sw_msi_start);
> +int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
> +					struct device *dev,
> +					phys_addr_t *sw_msi_start);
>   int iopt_set_allow_iova(struct io_pagetable *iopt,
>   			struct rb_root_cached *allowed_iova);
>   int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,

Perhaps a silly question. The reserved regions are enforced in IOVA when
a device is added to the igroup's device list. Should it be released
after the device is removed from the list?

This may not be appropriate because the devices may share some common
reserved regions, such as the IOMMU_RESV_MSI.

If that's the fact,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
