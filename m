Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930D6B340F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCJCME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 21:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCJCMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 21:12:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1019110462A;
        Thu,  9 Mar 2023 18:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678414322; x=1709950322;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TA76+X6Otimiwp2K+IV8a+AGL8NgZEQqynp7zdfzDSs=;
  b=L6DA6BvmbE5T8Z3EKFVqgJnbBGQkRWFBaS61ZXY4uNVxPYlJ8uBli3c6
   53VKUayavKvBNhanp/T1wovDtzlYThWZzFq1CytzRkQ2z4o4nyxNRbYpj
   IDr/ikiAxxrSbejq97gbwGhq/BC5e3ADzsmPDT+0ruA7Kp5Ukqk2pyb6i
   jyMV2REZJ/qPr+3f1W9G7wfgE0BPRGRMRQjYs0xhPzzsaZZxhcC7XTdz6
   E4ynY7zl+CnzZrloOYYNQiKnz1IIeFh+Ruk0RJhm6gnbdZiEYmqGeg6m2
   bVoNzU3hEXzUMpHROW4saFb/m3TU6myIfrytXpPuL6VDDymvjeoxUqA1X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336642841"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="336642841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923497234"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="923497234"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2023 18:11:56 -0800
Message-ID: <21c95149-6acb-e330-acaa-390309269a21@linux.intel.com>
Date:   Fri, 10 Mar 2023 10:10:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-5-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-5-yi.l.liu@intel.com>
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

On 3/9/23 4:09 PM, Yi Liu wrote:
> Nested translation has stage-1 and stage-2 page tables. A stage-1 page
> table is managed by user space, and it needs to work with a stage-2 page
> table, which is a parent hwpt for the stage-1 hwpt.
> 
> iommu core already supports accepting parent iommu_domain and user_data
> to allocate an iommu_domain. This makes iommufd_hw_pagetable_alloc() to
> accept the parent hwpt and user_data, and relays them to iommu core, to
> prepare for supporting hw_pagetable allocation with user_data.
> 
> Also, add a parent pointer in struct iommufd_hw_pagetable for taking and
> releasing its refcount.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          |  2 +-
>   drivers/iommu/iommufd/hw_pagetable.c    | 28 ++++++++++++++++++++++---
>   drivers/iommu/iommufd/iommufd_private.h |  5 ++++-
>   3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5c352807d946..19cd6df46c6a 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -558,7 +558,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
>   	}
>   
>   	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
> -					  immediate_attach);
> +					  NULL, NULL, immediate_attach);
>   	if (IS_ERR(hwpt)) {
>   		destroy_hwpt = ERR_CAST(hwpt);
>   		goto out_unlock;
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 84b4a11e62f8..16e92a1c150b 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -24,6 +24,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
>   	if (hwpt->domain)
>   		iommu_domain_free(hwpt->domain);
>   
> +	if (hwpt->parent)
> +		refcount_dec(&hwpt->parent->obj.users);
>   	refcount_dec(&hwpt->ioas->obj.users);
>   }
>   
> @@ -46,6 +48,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>    * @ictx: iommufd context
>    * @ioas: IOAS to associate the domain with
>    * @idev: Device to get an iommu_domain for
> + * @parent: Optional parent HWPT to associate with the domain with
> + * @user_data: Optional user_data pointer
>    * @immediate_attach: True if idev should be attached to the hwpt
>    *
>    * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
> @@ -54,14 +58,20 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>    */
>   struct iommufd_hw_pagetable *
>   iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> -			   struct iommufd_device *idev, bool immediate_attach)
> +			   struct iommufd_device *idev,
> +			   struct iommufd_hw_pagetable *parent,
> +			   void *user_data, bool immediate_attach)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	struct iommu_domain *parent_domain = NULL;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
>   
>   	lockdep_assert_held(&ioas->mutex);
>   
> +	if (parent && !ops->domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);

My understanding here is that we are checking whether domain_alloc_user
is required. It seems that as long as the caller inputs a valid
user_data or parent, domain_alloc_user is required. If so,

	if ((user_data || parent) && !ops->domain_alloc_user)
		return ERR_PTR(-EOPNOTSUPP);

Best regards,
baolu
