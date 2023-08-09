Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5647756EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjHIKQb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHIKQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 06:16:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FB1FDE;
        Wed,  9 Aug 2023 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691576189; x=1723112189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5cY00xplnCVKxo8zCQtJf9FxOjyPsmGsh03040yI1Y=;
  b=J4bRfPm9MCC48yYuVBHoNrXErukkMxyIeWfs0aB33Xu5F54Sz/FVDekI
   kSP0KrBMnGpevawsdFc3R3yNDhlIdedl9WODkqjIIvjXFtyIK72ye9q3X
   DA1IR2Ztgu9WSwCIquToxDCj2GHxUtxO06uyDz4GV+piZKsb8v7ZYGr7U
   ToQap4tlj53Iiii64ee9WZVwaKoMqqBhq5oAllGBYCBgPDxkHtqVtT1KX
   OY8g5bVwml9YWbEVjLGNlzrA8khQX+Lwx5sKPA7coXFsw8/6F+Sp607Oz
   wTGO9lU9gT1iyue2NiZkqr0ixyoAPcotSMzPz5Eay4opUoi5nLt9r4Mj3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="361212578"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361212578"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="978320803"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="978320803"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.171]) ([10.254.210.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:16:21 -0700
Message-ID: <aa455c36-83be-7757-7171-05460a459a2e@linux.intel.com>
Date:   Wed, 9 Aug 2023 18:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808153510.4170-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/8 23:35, Yi Liu wrote:
> +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
> +				unsigned int *length, u32 *type)
> +{
> +	const struct iommu_ops *ops;
> +	unsigned int data_len;
> +	void *data;
> +	int rc = 0;
> +
> +	ops = dev_iommu_ops(dev);
> +	if (!ops->hw_info) {
> +		*length = 0;
> +		*type = IOMMU_HW_INFO_TYPE_NONE;
> +		return 0;
> +	}
> +
> +	data = ops->hw_info(dev, &data_len, type);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	/*
> +	 * drivers that have hw_info callback should have a unique
> +	 * iommu_hw_info_type.
> +	 */
> +	if (WARN_ON_ONCE(*type == IOMMU_HW_INFO_TYPE_NONE)) {
> +		rc = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	*length = min(*length, data_len);
> +	if (copy_to_user(user_ptr, data, *length)) {

copy_to_user() returns the number of bytes that were successfully
copied, right?

If so, isn't it always failure case? Or I missed anything?

> +		rc = -EFAULT;
> +		goto err_free;

nit: this goto is unnecessary.

> +	}
> +
> +err_free:
> +	kfree(data);
> +	return rc;
> +}

Best regards,
baolu
