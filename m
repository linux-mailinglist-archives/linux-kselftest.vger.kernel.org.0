Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181577A9601
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjIUQ5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjIUQ5W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 12:57:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD1CD1;
        Thu, 21 Sep 2023 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315398; x=1726851398;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=di5mpgdL3ZYPjG1RlMEW/pRlAICty+pOXRnLRRLTIco=;
  b=daO0sh/gw+2Eod/nVAK1d5Py8qPqnkzWhfXH+7YFkg3hTo9dr5Xi6yzO
   CdwyQIsR2nL5krhYIlrKRRJRLPmGXwOQiLrky00R9i8sHApUZG535MUBb
   ONL7ZCMDf4AWYv/wktp/exXVDzpWjEqX4xSbo7BSKzt28lF8pN12iQXZJ
   EX0VbxsvFV5kzCELvlQbadCDeeNEDAHBq61QaWr5xc3FQ1RjFBWbk19ta
   q6dJbeKm5M6OcqwgJUcHIyZJ16HtjZbxqDFY69PnGXNoW2kbhP3CYTZzM
   iWDPwTZzhBHHwzZHcZXteLNIt7Mu1VMqMQxbaNUW4NfWehNnigJCb3oYF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360769961"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360769961"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750386212"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="750386212"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.213]) ([10.254.213.213])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:33:41 -0700
Message-ID: <e493c62d-8f10-17c8-f660-dbae19c481a4@linux.intel.com>
Date:   Thu, 21 Sep 2023 21:33:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v5 07/11] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-8-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921075431.125239-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/21 15:54, Yi Liu wrote:
> This adds the data structure for flushing iotlb for the nested domain
> allocated with IOMMU_HWPT_TYPE_VTD_S1 type.
> 
> This only supports invalidating IOTLB, but no for device-TLB as device-TLB
> invalidation will be covered automatically in the IOTLB invalidation if the
> underlying IOMMU driver has enabled ATS for the affected device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   include/uapi/linux/iommufd.h | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 18a502e206c3..3050efbceb57 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -510,6 +510,40 @@ struct iommu_hw_info {
>   };
>   #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
>   
> +/**
> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
> + *                                           stage-1 cache invalidation
> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
> + *                           leaf PTE caching needs to be invalidated
> + *                           and other paging structure caches can be
> + *                           preserved.
> + */
> +enum iommu_hwpt_vtd_s1_invalidate_flags {
> +	IOMMU_VTD_QI_FLAGS_LEAF = 1 << 0,
> +};
> +
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> + * @addr: The start address of the addresses to be invalidated.

Is there an alignment requirement for @addr? If so, is 4K alignment
sufficient? Perhaps we need to document it here so that user space can
calculate the @addr correctly.

> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 cache
> + * invalidation under nested translation. Userspace uses this structure to
> + * tell host about the impacted caches after modifying the stage-1 page table.
> + *
> + * Invalidating all the caches related to the page table by setting @addr
> + * to be 0 and @npages to be __aligned_u64(-1).
> + */
> +struct iommu_hwpt_vtd_s1_invalidate {
> +	__aligned_u64 addr;
> +	__aligned_u64 npages;
> +	__u32 flags;
> +	__u32 __reserved;
> +};
> +
>   /**
>    * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>    * @size: sizeof(struct iommu_hwpt_invalidate)

Best regards,
baolu
