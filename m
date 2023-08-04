Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FC76F756
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjHDB7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHDB7Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:59:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0834486;
        Thu,  3 Aug 2023 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691114362; x=1722650362;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qPJ6wVTEhN0Xm5LsPItjDidUz03aXajdt1tgXSztyNE=;
  b=Urw/NBYIZsRUPwPPGIoRxnyqCx1roihO8l5FVm+QPa2XB9NDj1X4SFhQ
   ooFj/tmZY9+pcHkKghV8VE84O9a5p3gGp7Ly7cv/1oq9Y1vafmbNOr+oZ
   KeMb1Lus43koE0qnpLxAFgn8yiNSjdxC7He6By9uij8k79pvKQsjg5pA8
   RCYlaKl65hEIZXIjcYW3K6njWslWgKZPL1mNlAfeNnhzfTrqPOYF7mScA
   T3O1V9S+zL/PoQxcerPl0j12cibFvkRW/IYeLqHprFplw/SbeuUVb1rdK
   0ODpp2pUnFSLSVLg3oCkYiDJjEqx0rnNIOIw0BrWg9A/fCpgPv1d5AK15
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349633842"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="349633842"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 18:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723455022"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="723455022"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.88]) ([10.254.210.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 18:59:14 -0700
Message-ID: <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
Date:   Fri, 4 Aug 2023 09:59:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230803143144.200945-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/3 22:31, Yi Liu wrote:
> Under nested IOMMU translation, userspace owns the stage-1 translation
> table (e.g. the stage-1 page table of Intel VT-d or the context table
> of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
> and need to be compatiable with the underlying IOMMU hardware. Hence,

                  compatible

> userspace should know the IOMMU hardware capability before creating and
> configuring the stage-1 translation table to kernel.
> 
> This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
> (a.k.a capability) for a given device. The returned data is vendor specific,
> userspace needs to decode it with the structure mapped by the @out_data_type
> field.
> 
> As only physical devices have IOMMU hardware, so this will return error
> if the given device is not a physical device.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/main.c | 79 ++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/iommufd.h | 36 ++++++++++++++++
>   2 files changed, 115 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 94c498b8fdf6..a0302bcaa97c 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -17,6 +17,7 @@
>   #include <linux/bug.h>
>   #include <uapi/linux/iommufd.h>
>   #include <linux/iommufd.h>
> +#include "../iommu-priv.h"
>   
>   #include "io_pagetable.h"
>   #include "iommufd_private.h"
> @@ -177,6 +178,81 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
>   	return 0;
>   }
>   
> +static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
> +{
> +	int index = 0;
> +
> +	for (; index < bytes; index++) {
> +		if (put_user(0, (uint8_t __user *)(ptr + index)))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	u32 hw_info_type = IOMMU_HW_INFO_TYPE_NONE;
> +	struct iommu_hw_info *cmd = ucmd->cmd;
> +	unsigned int length = 0, data_len;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	void __user *user_ptr;
> +	void *data = NULL;
> +	int rc = 0;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	user_ptr = u64_to_user_ptr(cmd->data_ptr);
> +
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops->hw_info)
> +		goto done;
> +
> +	data = ops->hw_info(idev->dev, &data_len, &hw_info_type);
> +	if (IS_ERR(data)) {
> +		rc = PTR_ERR(data);
> +		goto out_err;

Can kfree() handle a ERR_PTR input? I am afraid not,

/**
  * kfree - free previously allocated memory
  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
  *
  * If @object is NULL, no operation is performed.
  */
void kfree(const void *object)
{
         struct folio *folio;
         struct slab *slab;
         struct kmem_cache *s;

         trace_kfree(_RET_IP_, object);

         if (unlikely(ZERO_OR_NULL_PTR(object)))
                 return;

So, perhaps we should add

	data = NULL;

before
	goto out_err;

?

> +	}
> +
> +	/* driver has hw_info callback should have a unique hw_info_type */
> +	if (WARN_ON_ONCE(hw_info_type == IOMMU_HW_INFO_TYPE_NONE)) {
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	length = min(cmd->data_len, data_len);
> +	if (copy_to_user(user_ptr, data, length)) {
> +		rc = -EFAULT;
> +		goto out_err;
> +	}
> +
> +done:
> +	/*
> +	 * Zero the trailing bytes if the user buffer is bigger than the
> +	 * data size kernel actually has.
> +	 */
> +	if (length < cmd->data_len) {
> +		rc = iommufd_zero_fill_user(user_ptr + length,
> +					    cmd->data_len - length);
> +		if (rc)
> +			goto out_err;
> +	}
> +
> +	cmd->data_len = length;
> +	cmd->out_data_type = hw_info_type;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_err:
> +	kfree(data);
> +	iommufd_put_object(&idev->obj);
> +	return rc;
> +}
> +

Others look good to me, feel free to add:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

after above are addressed.

Best regards,
baolu
