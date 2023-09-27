Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE87AF83F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjI0CmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 22:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjI0CkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 22:40:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6DD1BC1;
        Tue, 26 Sep 2023 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695780492; x=1727316492;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jiTLn3Vg5DjW5KMS+3IRSYx4PUzUN/fR9h6uUPmnC/8=;
  b=AZrw6dH8U7x4Wo5ICcGz9XsZq8MRYfi2eCZxpRcFunSZou8NgiaJ9wIT
   eWBY/vvmEJ/QupUWNm8oam9zC1d8iNdAX8CvdqIZp2BM/D5z7nrWH5Lrw
   onLk2e4NzX/36ctYz62ScIDa3l5TUXKpYUoLwmeoSFOteCroRpRh2z5QX
   yZVMuCTJ2r1fxTbo60aU8HuOTGeplDlYk4+XOe7SYSqQiu60REF7VqJLJ
   9PTe1K0GLcwPEfBmbSJIKl7682pUHpm0pcV33Lg1prVvjsuHlq9yZMVa3
   euFLEFv3Sz48nJX8G3DqUGhRF90PJI0efPI6Fx/JjDpE9Ipk64lms4zLi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361963137"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361963137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="373163"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2023 19:07:35 -0700
Message-ID: <a5e18b46-cccc-a2f7-91ae-aa5c942cd887@linux.intel.com>
Date:   Wed, 27 Sep 2023 10:04:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 1/8] iommu: Introduce a replace API for device pasid
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-2-yi.l.liu@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230926092651.17041-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/23 5:26 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Provide a high-level API to allow replacements of one domain with
> another for specific pasid of a device. This is similar to
> iommu_group_replace_domain() and it is also expected to be used
> only by IOMMUFD.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu-priv.h |  2 ++
>   drivers/iommu/iommu.c      | 73 ++++++++++++++++++++++++++++++--------
>   2 files changed, 60 insertions(+), 15 deletions(-)
> 

[...]

> @@ -3433,8 +3443,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>    * The @domain must have been attached to @pasid of the @dev with
>    * iommu_attach_device_pasid().
>    */
> -void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> -			       ioasid_t pasid)
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)

Above change is irrelevant.

>   {
>   	struct iommu_group *group = iommu_group_get(dev);
>   
> @@ -3447,6 +3457,39 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
>   
> +/**
> + * iommu_replace_device_pasid - replace the domain that a pasid is attached to
> + * @domain: new IOMMU domain to replace with
> + * @dev: the physical device
> + * @pasid: pasid that will be attached to the new domain
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or an
> + * error. The pasid will roll back to use the old domain if failure. The
> + * caller could call iommu_detach_device_pasid() before free the old domain
> + * in order to avoid use-after-free case.

The comment does not match the actual behavior of the code. We need to
discuss and agree on which state the PASID should park in if replacing
the domain fails.

> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	int ret;
> +
> +	if (!domain)
> +		return -EINVAL;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	__iommu_remove_group_pasid(group, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	ret = __iommu_group_attach_pasid(domain, group, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
> +
>   /*
>    * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
>    * @dev: the queried device

Best regards,
baolu
