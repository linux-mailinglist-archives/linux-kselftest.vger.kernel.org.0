Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08ED6AFD1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 03:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCHC4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 21:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCHC4f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 21:56:35 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067ADA42C7;
        Tue,  7 Mar 2023 18:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678244192; x=1709780192;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=77QN2i2yZdUO/+6hL9TXXMuujJSXaX/G0JyFEyUwuBI=;
  b=JnKmbcc/DDP+SpPAG9scSBATM+0KuVNJTNQpM/ay3tyYuoVsuTDqroxu
   J2P1/SXWk/c7lOnsbGyI2yg6T3YRJhA8CCsFAi0SCjgJKtGNqlty5e567
   6ysM26fqGnpiJKEliNnMM4pIMjvboOoV+WUkk0MwythSI9H1+lrh3daI1
   0aMaHeK2rFqOVbvdzGX0XnchLu14O9ZeehFXbGX4JUlA6pqUGzHWNQhAG
   awRKNta8AOyTGNTX7GqxLVW+RC7AaNiMkxPS7XKoO4QssFb9QU66Xp6bT
   3U1RtF/bnq3iB+xI9Puw34eOZnvGDqqzZgF7bc5Zb/uV+yl+b5xe3Eb06
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336060472"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="336060472"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800598186"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="800598186"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2023 18:56:29 -0800
Message-ID: <b2a3ebf2-272d-2f4f-2489-253c4973a6db@linux.intel.com>
Date:   Wed, 8 Mar 2023 10:55:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 01/17] iommufd: Move isolated msi enforcement to
 iommufd_device_bind()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <1-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
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

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> With the recent rework this no longer needs to be done at domain
> attachment time, we know if the device is usable by iommufd when we bind
> it.
> 
> The value of msi_device_has_isolated_msi() is not allowed to change while
> a driver is bound.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index c6f4852a8a0c08..63b65cdfe97f29 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	if (!group)
>   		return ERR_PTR(-ENODEV);
>   
> +	/*
> +	 * For historical compat with VFIO the insecure interrupt path is
> +	 * allowed if the module parameter is set. Insecure means that a MemWr
> +	 * operation from the device (eg a simple DMA) cannot trigger an

Nit:

"... cannot trigger an ..." or "... can trigger an ..."?

> +	 * interrupt outside this iommufd context.
> +	 */
> +	if (!iommufd_selftest_is_mock_dev(dev) &&
> +	    !iommu_group_has_isolated_msi(group)) {
> +		if (!allow_unsafe_interrupts) {
> +			rc = -EPERM;
> +			goto out_group_put;
> +		}
> +
> +		dev_warn(
> +			dev,
> +			"MSI interrupts are not secure, they cannot be isolated by the platform. "
> +			"Check that platform features like interrupt remapping are enabled. "
> +			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
> +	}

Anyway,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
