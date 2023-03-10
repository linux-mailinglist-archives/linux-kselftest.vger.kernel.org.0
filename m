Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E16B34A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 04:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCJDRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 22:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJDRA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 22:17:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524717168;
        Thu,  9 Mar 2023 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678418219; x=1709954219;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSNaBVfIq9kLv/om+Bjsec0d/V6pSiTXsmDtJgsCZ3A=;
  b=UgtYSTYK+6XRxletN5MjkZ8APrXvpmeolHN0gWobU8x2rmm4N+GSSUDD
   BfHqOBNqGSQjonkIkaWGbDR/JgPNlqF8EtXPpXOv8UTAAnVzLEVM+3d01
   sL/lzBf00me4BfYz7BdKnqEJ3I7uxhMFRY+9qJANo0mQsjbEytDD/u/F0
   Su2cfeQzDencxlSYJnbXhphvm6HnN0Z9xj/jtUY1njeyM68Ou8xiesqPv
   hzPueqF/x/EEaKzikVuOgDvmiEOPic5Ptrv8MCJpFxw5v0K7Zc29xeaMw
   zubjLh+Ky7YkXwhN6vhclURD63dsTA4IkpFgOcLc8ClXfXUqr1EN/vOdF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320489134"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="320489134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 19:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="820884980"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="820884980"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 19:16:53 -0800
Message-ID: <8a8f35e7-b0c7-b9e3-3f9a-f7a427781799@linux.intel.com>
Date:   Fri, 10 Mar 2023 11:15:53 +0800
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
Subject: Re: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/9/23 4:09 PM, Yi Liu wrote:
> In nested translation, the stage-1 page table is user-managed and used
> by IOMMU hardware, so destroying mappings in the stage-1 page table should
> be followed with an IOTLB invalidation.

s/destroying mappings/update of any present page table entry/

> This adds IOMMU_HWPT_INVALIDATE for IOTLB invalidation.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c    | 56 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  9 ++++
>   drivers/iommu/iommufd/main.c            |  3 ++
>   include/uapi/linux/iommufd.h            | 27 ++++++++++++
>   4 files changed, 95 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 64e7cf7142e1..67facca98de1 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -284,3 +284,59 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(&idev->obj);
>   	return rc;
>   }
> +
> +/*
> + * size of page table type specific invalidate_info, indexed by
> + * enum iommu_hwpt_type.
> + */
> +static const size_t iommufd_hwpt_invalidate_info_size[] = {};
> +
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> +	struct iommufd_hw_pagetable *hwpt;
> +	u64 user_ptr;
> +	u32 user_data_len, klen;
> +	int rc = 0;
> +
> +	/*
> +	 * For a user-managed HWPT, type should not be IOMMU_HWPT_TYPE_DEFAULT.
> +	 * data_len should not exceed the size of iommufd_invalidate_buffer.
> +	 */
> +	if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT || !cmd->data_len ||
> +	    cmd->data_type >= ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))

"data_len should not exceed the size of iommufd_invalidate_buffer."

How is this checked?

> +		return -EOPNOTSUPP;
> +
> +	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt))
> +		return PTR_ERR(hwpt);
> +
> +	/* Do not allow any kernel-managed hw_pagetable */
> +	if (!hwpt->parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
> +	if (!klen) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	/*
> +	 * Copy the needed fields before reusing the ucmd buffer, this
> +	 * avoids memory allocation in this path.
> +	 */
> +	user_ptr = cmd->data_uptr;
> +	user_data_len = cmd->data_len;

Is it a valid case if "user_data_len < klen"?

> +
> +	rc = copy_struct_from_user(cmd, klen,
> +				   u64_to_user_ptr(user_ptr), user_data_len);
> +	if (rc)
> +		goto out_put_hwpt;
> +
> +	hwpt->domain->ops->cache_invalidate_user(hwpt->domain, cmd);
> +out_put_hwpt:
> +	iommufd_put_object(&hwpt->obj);
> +	return rc;
> +}
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 182c074eecdc..d879264d1acf 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -265,6 +265,7 @@ struct iommufd_hw_pagetable *
>   iommufd_hw_pagetable_detach(struct iommufd_device *idev);
>   void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
>   int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
>   
>   static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   					    struct iommufd_hw_pagetable *hwpt)
> @@ -276,6 +277,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   		refcount_dec(&hwpt->obj.users);
>   }
>   
> +static inline struct iommufd_hw_pagetable *
> +iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	return container_of(iommufd_get_object(ucmd->ictx, id,
> +					       IOMMUFD_OBJ_HW_PAGETABLE),
> +			    struct iommufd_hw_pagetable, obj);
> +}
> +
>   struct iommufd_group {
>   	struct kref ref;
>   	struct mutex lock;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 7ab1e2c638a1..2cf45f65b637 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -263,6 +263,7 @@ union ucmd_buffer {
>   	struct iommu_destroy destroy;
>   	struct iommu_hwpt_alloc hwpt;
>   	struct iommu_hw_info info;
> +	struct iommu_hwpt_invalidate cache;
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> @@ -298,6 +299,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 data_uptr),
>   	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
>   		 struct iommu_hw_info, __reserved),
> +	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
> +		 struct iommu_hwpt_invalidate, data_uptr),
>   	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
>   		 struct iommu_ioas_alloc, out_ioas_id),
>   	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 48781ff40a37..d0962c41f8d6 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -47,6 +47,7 @@ enum {
>   	IOMMUFD_CMD_VFIO_IOAS,
>   	IOMMUFD_CMD_HWPT_ALLOC,
>   	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
> +	IOMMUFD_CMD_HWPT_INVALIDATE,
>   };
>   
>   /**
> @@ -447,4 +448,30 @@ struct iommu_hw_info {
>   	__u32 __reserved;
>   };
>   #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
> +
> +/**
> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> + * @size: sizeof(struct iommu_hwpt_invalidate)
> + * @hwpt_id: HWPT ID of target hardware page table for the invalidation
> + * @data_type: One of enum iommu_hwpt_type
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
> + *
> + * Invalidate the iommu cache for user-managed page table. Modifications
> + * on user-managed page table should be followed with this operation to
> + * sync the IOTLB. This is only needed by user-managed hw_pagetables, so
> + * the @data_type should never be IOMMU_HWPT_TYPE_DEFAULT.
> + *
> + * +==============================+========================================+
> + * | @data_type                   |     Data structure in @data_uptr       |
> + * +------------------------------+----------------------------------------+
> + */
> +struct iommu_hwpt_invalidate {
> +	__u32 size;
> +	__u32 hwpt_id;
> +	__u32 data_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
> +};
> +#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
>   #endif

Best regards,
baolu
