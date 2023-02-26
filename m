Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD76A2D42
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 04:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBZDVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Feb 2023 22:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZDVx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Feb 2023 22:21:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DB11175;
        Sat, 25 Feb 2023 19:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677381712; x=1708917712;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Ub4xNplwsCdyqlJn5ofe69te68wyHVta6/prD6UN/E=;
  b=CzG0Xwtiq1agfQmq+W49BY71UilMOh0KixOWidzB90q8xkLVmJ8yArvS
   oEuXfeOUV7jGU0TiTop1U9FvZSfBdQxQzrwam7T4QPK3SiUNNG16WU1rr
   /tYcfIwGN8rFSE25H56hN2LtaQURUMWX1XgkL5t/V727/WY8+YBKDYlND
   XHuHUBF+/EFNwGPhTqR9aRHaxHu6OHt8ikgNCiyiPspoJrr3v5E+EYbz2
   beK5+PIpYCiDBy/sCMxG7nieG2xomX+pQ9bVfOI7LVYrZyyO2Gr9z60N0
   3dJMi/BZ1byjpfUSQEBsXWOpxETTCjCN7Sh0rQ9cgLs/4j5z+qnjUL3Gq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="314105491"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="314105491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 19:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="623161119"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="623161119"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2023 19:21:50 -0800
Message-ID: <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
Date:   Sun, 26 Feb 2023 11:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> +/**
> + * iommufd_device_attach - Connect a device to an iommu_domain
> + * @idev: device to attach
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID

"Output the hwpt ID" only happens when the caller input an IOAS object
and an auto domain was selected or created for the device.

Do I understand it right?

> + *
> + * This connects the device to an iommu_domain, either automatically or manually
> + * selected. Once this completes the device could do DMA.
> + *
> + * The caller should return the resulting pt_id back to userspace.
> + * This function is undone by calling iommufd_device_detach().
> + */
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	int rc;
> +
> +	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
> +	 * to destroy a device with an attachment.
> +	 */
> +	refcount_inc(&idev->obj.users);
> +	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>   
> +/**
> + * iommufd_device_replace - Change the device's iommu_domain
> + * @idev: device to change
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID

If my above understanding is correct, then replace will never output a
hwpt id as it only happens after a successful attach.

> + *
> + * This is the same as:
> + *   iommufd_device_detach();
> + *   iommufd_device_attach()
> + * If it fails then no change is made to the attachment. The iommu driver may
> + * implement this so there is no disruption in translation. This can only be
> + * called if iommufd_device_attach() has already succeeded.
> + */
> +int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	return iommufd_device_change_pt(idev, pt_id,
> +					&iommufd_device_do_replace);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);

Best regards,
baolu
