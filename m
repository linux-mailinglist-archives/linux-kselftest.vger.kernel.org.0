Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233E6B343B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 03:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCJC0X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 21:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCJC0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 21:26:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30888101F05;
        Thu,  9 Mar 2023 18:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678415176; x=1709951176;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CD1d1U+N1i6cnQufApycxVSTkneYwho3CgsJUOqtjos=;
  b=Bt2lNkmuddl8hN/1HFPj4mAfEaDBCrYXuMakRM88sgeoLGAvCMlZpww1
   w4cOMleGPmkOy17iP82aqSybwSkrr8NCNeec7DBX6qbgSn1+uHd63resV
   ro7lIyC26Y/bhhRIFJGFf+shX8+Zl7CTGn3WQ7u+YCdaLmK68P33uVqRX
   97xT/6BGq608/jRdiSQKR1tPf0mSqB0dnl8AvZVqdXddngmi33x/ZmQ9c
   Mw/SC0bTs1RnWCz5rEABeoRQrR93aJY7JBB18Lpu/Jye5CnWmBb4frTqh
   vpKXcmZE8L6NvXIPSq8RW1d940w3OqUYRstjMIASjYK/m004IEFmGS1Wu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336645215"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="336645215"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="787841336"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="787841336"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 18:26:10 -0800
Message-ID: <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
Date:   Fri, 10 Mar 2023 10:25:10 +0800
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
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-6-yi.l.liu@intel.com>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> A user-managed hw_pagetable does not need to get populated, since it is
> managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
> calls into a helper, where the hwpt pointer will be redirected to its
> hwpt->parent if it's available.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 16e92a1c150b..6e45ec0a66fa 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>   	return 0;
>   }
>   
> +static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
> +{
> +	int rc;
> +
> +	if (hwpt->parent)
> +		hwpt = hwpt->parent;
> +
> +	if (!list_empty(&hwpt->hwpt_item))
> +		return 0;

What is above check for? Is it "the hwpt has already been inserted into
the hwpt list of its ioas in another place"?

If so, is it possible that hwpt will be deleted from the list even when
this user hwpt is still linked to the ioas?

> +
> +	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> +	if (rc)
> +		return rc;
> +	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> +	return 0;
> +}
> +
>   /**
>    * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
>    * @ictx: iommufd context
> @@ -131,10 +148,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   			goto out_unlock;
>   	}
>   
> -	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> +	rc = iommufd_hw_pagetable_link_ioas(hwpt);
>   	if (rc)
>   		goto out_detach;
> -	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
>   
>   	mutex_unlock(&idev->igroup->lock);
>   	return hwpt;

Best regards,
baolu
