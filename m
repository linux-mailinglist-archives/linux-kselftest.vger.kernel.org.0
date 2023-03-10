Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425D96B34D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 04:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCJDbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 22:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJDbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 22:31:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8B108231;
        Thu,  9 Mar 2023 19:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678419069; x=1709955069;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4j90Fp5tAHlmvDvWO8QQ5maK/YTpz6A1VQay0a/wx4I=;
  b=U2fe7Rcwl23ZjFFsE1KEDEph6+pmhtc0J5oelbpTI4rJAcI0RkhN7pNw
   45Zft8183OBn0D8/tJOXrlKS3xbdYFfjPi3T7GHYzSPN/2cnmQwbp8vKi
   VxIZj8rMhEt8EVR11OEmMZq5EcAGyRw+W/c++ygZlEuBVoqhmO3kYlFvD
   pArY7YpLEtWz7VngUbLf3E+mvN7Y1LXRHKkCQ9x1sh2aL0ioY5bEMpQau
   E19DRkAnuLzukF/Bg7HmmR1uN+212l0rm5nTZRP7FE/EyCEAZXL6sh5hx
   fWjpfMsNou2LAvY0hLLiM3fY/mHS4+EqviIDk0/RT5rOlVt5N3AAl9/9s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336654294"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="336654294"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 19:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923514875"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="923514875"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2023 19:31:04 -0800
Message-ID: <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
Date:   Fri, 10 Mar 2023 11:30:04 +0800
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
Subject: Re: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-9-yi.l.liu@intel.com>
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
> This provides a way for userspace to probe the supported hwpt data
> types by kernel. Currently, kernel only supports IOMMU_HWPT_TYPE_DEFAULT,
> new types would be added per vendor drivers' extension.
> 
> Userspace that wants to allocate hw_pagetable with user data should check
> this. While for the allocation without user data, no need for it. It is
> supported by default.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          |  1 +
>   drivers/iommu/iommufd/hw_pagetable.c    | 18 +++++++++++++++---
>   drivers/iommu/iommufd/iommufd_private.h |  2 ++
>   drivers/iommu/iommufd/main.c            |  2 +-
>   include/uapi/linux/iommufd.h            |  8 ++++++++
>   5 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 19cd6df46c6a..0328071dcac1 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -322,6 +322,7 @@ int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
>   
>   	cmd->out_data_type = ops->driver_type;
>   	cmd->data_len = length;
> +	cmd->out_hwpt_type_bitmap = iommufd_hwpt_type_bitmaps[ops->driver_type];
>   
>   	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>   
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 67facca98de1..160712256c64 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -173,6 +173,14 @@ static const size_t iommufd_hwpt_alloc_data_size[] = {
>   	[IOMMU_HWPT_TYPE_DEFAULT] = 0,
>   };
>   
> +/*
> + * bitmaps of supported hwpt types of by underlying iommu, indexed
> + * by ops->driver_type which is one of enum iommu_hw_info_type.
> + */
> +const u64 iommufd_hwpt_type_bitmaps[] =  {
> +	[IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
> +};

I am a bit confused here. Why do you need this array? What I read is
that you want to convert ops->driver_type to a bit position in
cmd->out_hwpt_type_bitmap.

Am I getting it right?

If so, why not just
	cmd->out_hwpt_type_bitmap = BIT_ULL(ops->driver_type);

?	

Best regards,
baolu
