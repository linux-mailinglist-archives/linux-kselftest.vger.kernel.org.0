Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726D6B25E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCINxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 08:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjCINwn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 08:52:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD619109;
        Thu,  9 Mar 2023 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678369940; x=1709905940;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ip+6Qn6pHtw8f5LnG0WQBpWF3slJzUO6nkNpuzd32f8=;
  b=mWih5aCxCmTumWemjlBVROPuPI/+Jgfg19d6G+fRvwpE6Sd6KtID5Blq
   O+WY+immxEh3jcQFklsFfM0/Cx14PPBa7Z+npqWYac0WqK+n5pqDbqJhW
   qvSiLNu527moe7Yo7KwR1FHDmBP24jyun3nYiS8hz/LWXOCY4wlvFAJr/
   Opyhyr8l2v087hB+dxfb2WcOj7wCjKuzoInCyGlm5XHT8sX34Af6P3djw
   sfV7nfX97auXAt8esitAHKMOIZxgCF4pYHO2DPhUTyFNQRdfo3hE07o4i
   2cd3+nV+nTMtNY5K6FW+WgBSGl5YG6WFv3JSzvMqEihKBlH4hKBW48JJQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338783674"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338783674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 05:50:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670731316"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="670731316"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.74]) ([10.254.210.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 05:50:20 -0800
Message-ID: <6c1b221e-df8d-4b82-10e5-aa3027819d45@linux.intel.com>
Date:   Thu, 9 Mar 2023 21:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-4-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309075358.571567-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/9 15:53, Yi Liu wrote:
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
>   drivers/iommu/iommufd/device.c          | 74 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>   drivers/iommu/iommufd/main.c            |  3 +
>   include/uapi/linux/iommufd.h            | 40 +++++++++++++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index c10e02f6a0be..6948539488a5 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -257,6 +257,80 @@ struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_ictx, IOMMUFD);
>   
> +static int iommufd_zero_fill_user(u64 ptr, int bytes)
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
> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd = ucmd->cmd;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	void *data;
> +	unsigned int length, data_len;
> +	int rc;

Reverse christmas tree order for declarations.

> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops || !ops->hw_info) {

dev_iommu_ops() will never return a NULL.

Need below check

	dev->iommu && dev->iommu->iommu_dev

before dev_iommu_ops(). Perhaps something like below?

	if (!dev->iommu || !dev->iommu->iommu_dev)
		return -EINVAL;

	ops = dev_iommu_ops(idev->dev);
	if (!ops->hw_info)
		return -ENODEV;

> +		rc = -EOPNOTSUPP;
> +		goto out_put;
> +	}
> +
> +	/* driver has hw_info callback should have a unique driver_type */
> +	if (WARN_ON(ops->driver_type == IOMMU_HW_INFO_TYPE_DEFAULT)) {

If so, perhaps IOMMU_HW_INFO_TYPE_INVALID is more readable?

I'm not sure if a calltrace is really necessary here. If not, perhaps,

	if (ops->driver_type == IOMMU_HW_INFO_TYPE_DEFAULT) {
		pr_warn_ratelimited("iommu driver set an invalid type\n");
		rc = -ENODEV;
		goto out_put;
	}

> +		rc = -EOPNOTSUPP;
> +		goto out_put;
> +	}
> +
> +	data = ops->hw_info(idev->dev, &data_len);
> +	if (IS_ERR(data)) {
> +		rc = PTR_ERR(data);
> +		goto out_put;
> +	}
> +
> +	length = min(cmd->data_len, data_len);
> +	if (copy_to_user(u64_to_user_ptr(cmd->data_ptr), data, length)) {
> +		rc = -EFAULT;
> +		goto out_free_data;
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
> +			goto out_free_data;
> +	}
> +
> +	cmd->out_data_type = ops->driver_type;
> +	cmd->data_len = length;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_free_data:
> +	kfree(data);
> +out_put:
> +	iommufd_put_object(&idev->obj);
> +	return rc;
> +}
> +
>   static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>   				   struct iommufd_hw_pagetable *hwpt)
>   {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index b18f843ad6a4..05b5ad66f716 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -307,6 +307,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
>   }
>   
>   void iommufd_device_destroy(struct iommufd_object *obj);
> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd);
>   
>   struct iommufd_access {
>   	struct iommufd_object obj;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 694da191e4b1..f079c0bda46b 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -262,6 +262,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
>   union ucmd_buffer {
>   	struct iommu_destroy destroy;
>   	struct iommu_hwpt_alloc hwpt;
> +	struct iommu_hw_info info;
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> @@ -295,6 +296,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
>   	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
>   		 __reserved),
> +	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
> +		 struct iommu_hw_info, __reserved),
>   	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
>   		 struct iommu_ioas_alloc, out_ioas_id),
>   	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 955cbef640da..4ac525897b82 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -46,6 +46,7 @@ enum {
>   	IOMMUFD_CMD_OPTION,
>   	IOMMUFD_CMD_VFIO_IOAS,
>   	IOMMUFD_CMD_HWPT_ALLOC,
> +	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
>   };
>   
>   /**
> @@ -377,4 +378,43 @@ struct iommu_hwpt_alloc {
>   enum iommu_hw_info_type {
>   	IOMMU_HW_INFO_TYPE_DEFAULT,
>   };
> +
> +/**
> + * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
> + * @size: sizeof(struct iommu_hw_info)
> + * @flags: Must be 0
> + * @dev_id: The device being attached to the iommufd
> + * @data_len: Input the length of the user buffer in bytes. Output the
> + *            length of data filled to the user buffer.
> + * @data_ptr: Pointer to the type specific structure
> + * @out_data_type: Output the iommu hardware info type, it is one of
> + *                 enum iommu_hw_info_type.
> + * @__reserved: Must be 0
> + *
> + * Query the hardware iommu information for given device which has been
> + * bound to iommufd. @data_len is the size of the buffer which captures
> + * iommu type specific data and the data will be filled. Trailing bytes
> + * are zeroed if the user buffer is larger than the data kernel has.
> + *
> + * The type specific data would be used to sync capability between the
> + * vIOMMU and the hardware IOMMU. e.g. nested translation requires to
> + * check the hardware IOMMU capability, since a stage-1 translation table
> + * is owned by user but used by hardware IOMMU.
> + *
> + * The @out_data_type will be filled if the ioctl succeeds. It would
> + * be used to decode the data filled in the buffer pointed by @data_ptr.
> + *
> + * This is only available for the physical devices bound to iommufd as
> + * only physical devices can have hardware IOMMU.
> + */
> +struct iommu_hw_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 data_len;
> +	__aligned_u64 data_ptr;
> +	__u32 out_data_type;
> +	__u32 __reserved;
> +};
> +#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
>   #endif

Other look good to me.

Best regards,
baolu
