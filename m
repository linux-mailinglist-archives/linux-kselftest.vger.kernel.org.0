Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24546FFFEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 07:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjELFjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 01:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELFjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 01:39:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95B4202;
        Thu, 11 May 2023 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683869947; x=1715405947;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zC92a2N0m2Rf8NugNXwOSZnbIW4HBYFpSQTmsIkInWs=;
  b=FQiMZC/3AFfp9eIkwt5suXD0SrjGI6ml9tGK2dKdUQVf27PiRYTInWha
   8xP7HiEftoSJWAFo7oj2ZKsUHcE1QHhIppNU8vF44SRNove6GXuhOcErs
   SP86aK8IG9cMTOZ+A/9Su+pDChmpiw+YOASdRZzvuaxj0n2+a5o+eLtnB
   SC2uZl1piZfesss690XXV+iXgFAivUkzmKGNQeDt+XSnyKgWmwjyUnMON
   XWEYZH7/VV+zshIUEGyb3EMrWFImtxK/RCeRL+WJyloZ+WLt7mtR0yyBX
   pB2IaokNXOgldKNlELTBGKQ8b+I40UT3rurVAspfSQkUZozxeJV8odS/K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="350734479"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="350734479"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 22:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732893212"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="732893212"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 22:39:01 -0700
Message-ID: <6ab2d63e-4dcc-6562-9698-d23300c7d1ae@linux.intel.com>
Date:   Fri, 12 May 2023 13:38:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230511143024.19542-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/11/23 10:30 PM, Yi Liu wrote:
> Under nested IOMMU translation, userspace owns the stage-1 translation
> table (e.g. the stage-1 page table of Intel VT-d or the context table
> of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
> and needs to be compatiable with the underlying IOMMU hardware. Hence,
> userspace should know the IOMMU hardware capability before creating and
> configuring the stage-1 translation table to kernel.
> 
> This adds IOMMU_DEVICE_GET_HW_INFO to query the IOMMU hardware information
> for a given device. The returned data is vendor specific, userspace needs
> to decode it with the structure mapped by the @out_data_type field.
> 
> As only physical devices have IOMMU hardware, so this will return error
> if the given device is not a physical device.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 72 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>   drivers/iommu/iommufd/main.c            |  3 ++
>   include/uapi/linux/iommufd.h            | 37 +++++++++++++
>   4 files changed, 113 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 051bd8e99858..bc99d092de8f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -263,6 +263,78 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
>   
> +static int iommufd_zero_fill_user(u64 ptr, int bytes)
> +{
> +	int index = 0;
> +
> +	for (; index < bytes; index++) {
> +		if (put_user(0, (uint8_t __user *)u64_to_user_ptr(ptr + index)))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd = ucmd->cmd;
> +	unsigned int length = 0, data_len;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
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
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops->hw_info)
> +		goto done;

If the iommu driver doesn't provide a hw_info callback, it still
returns success?

> +
> +	/* driver has hw_info callback should have a unique hw_info_type */
> +	if (ops->hw_info_type == IOMMU_HW_INFO_TYPE_NONE) {
> +		pr_warn_ratelimited("iommu driver set an invalid type\n");
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	data = ops->hw_info(idev->dev, &data_len);
> +	if (IS_ERR(data)) {
> +		rc = PTR_ERR(data);
> +		goto out_err;
> +	}
> +
> +	length = min(cmd->data_len, data_len);
> +	if (copy_to_user(u64_to_user_ptr(cmd->data_ptr), data, length)) {
> +		rc = -EFAULT;
> +		goto out_err;
> +	}
> +
> +	/*
> +	 * Zero the trailing bytes if the user buffer is bigger than the
> +	 * data size kernel actually has.
> +	 */
> +	if (length < cmd->data_len) {
> +		rc = iommufd_zero_fill_user(cmd->data_ptr + length,
> +					    cmd->data_len - length);
> +		if (rc)
> +			goto out_err;
> +	}
> +
> +done:
> +	cmd->data_len = length;
> +	cmd->out_data_type = ops->hw_info_type;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_err:
> +	kfree(data);
> +	iommufd_put_object(&idev->obj);
> +	return rc;
> +}
> +
>   static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>   				   struct iommufd_hw_pagetable *hwpt)
>   {

Best regards,
baolu
