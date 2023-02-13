Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C3693FF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBMItR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 03:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBMItO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 03:49:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E483C9;
        Mon, 13 Feb 2023 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676278152; x=1707814152;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KAwjNWKfwZLbbE6KInWg5vm/UVyZV8wU47/eph2XrPs=;
  b=W/wDDSoaOEQeFmJcb6gFFClczEmVleTdnkrK9olDSgVwBXPTj4NOQDpu
   1msZWixvnInIFMjJikVDAIAb8vGb7RyVxVJq7VlSoSkURAJKlP+s++nti
   1+v2O/hv3HDpF9ij+S9WG43gm/Uhmer/68+Wvkrx2Inqgbspk3xj0qzVn
   ZfizfrOV/GPqnien+l89S2EVje8qPFBHRzZ+nJmJ9GXzshvNdN5M4d5cH
   Bt/V+UQtl1aYzEufj8m6PoycdxGs70lmwvY0GjDAp6FvbFqchF6UizZPB
   MlcCtqLBhUiFarnRDux45z/G0CMtw1geFr0ZIsZJc1ozDMTSV/BnV1Aj5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310475827"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="310475827"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:49:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842694391"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842694391"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.207]) ([10.249.169.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:49:02 -0800
Message-ID: <041912b6-f13c-f83d-ce6b-f3a7ceb674ee@linux.intel.com>
Date:   Mon, 13 Feb 2023 16:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Content-Language: en-US
To:     Binbin Wu <binbin.wu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
 <0581875e-f0af-582e-82fb-62cf03ba39b2@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0581875e-f0af-582e-82fb-62cf03ba39b2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/13 11:09, Binbin Wu wrote:
> 
> On 2/9/2023 12:16 PM, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> To support nested translation in the userspace, it should check the
>> underlying hardware information for the capabilities.
>>
>> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>>   drivers/iommu/intel/iommu.h  |  1 +
>>   include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 59df7e42fd53..929f600cc350 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4760,8 +4760,26 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid)
>>       intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>   }
>> +static void *intel_iommu_hw_info(struct device *dev, u32 *length)
>> +{
>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +    struct intel_iommu *iommu = info->iommu;
>> +    struct iommu_device_info_vtd *vtd;
>> +
>> +    vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
>> +    if (!vtd)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    vtd->cap_reg = iommu->cap;
>> +    vtd->ecap_reg = iommu->ecap;
>> +    *length = sizeof(*vtd);
>> +
>> +    return vtd;
>> +}
>> +
>>   const struct iommu_ops intel_iommu_ops = {
>>       .capable        = intel_iommu_capable,
>> +    .hw_info        = intel_iommu_hw_info,
>>       .domain_alloc        = intel_iommu_domain_alloc,
>>       .probe_device        = intel_iommu_probe_device,
>>       .probe_finalize        = intel_iommu_probe_finalize,
>> @@ -4774,6 +4792,7 @@ const struct iommu_ops intel_iommu_ops = {
>>       .def_domain_type    = device_def_domain_type,
>>       .remove_dev_pasid    = intel_iommu_remove_dev_pasid,
>>       .pgsize_bitmap        = SZ_4K,
>> +    .driver_type        = IOMMU_DEVICE_DATA_INTEL_VTD,
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>       .page_response        = intel_svm_page_response,
>>   #endif
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 06e61e474856..2e70265d4ceb 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -22,6 +22,7 @@
>>   #include <linux/ioasid.h>
>>   #include <linux/bitfield.h>
>>   #include <linux/xarray.h>
>> +#include <uapi/linux/iommufd.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/iommu.h>
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 2309edb55028..fda75c8450ee 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -347,7 +347,28 @@ struct iommu_vfio_ioas {
>>   /**
>>    * enum iommu_device_data_type - IOMMU hardware Data types
>> + * @IOMMU_DEVICE_DATA_INTEL_VTD: Intel VT-d iommu data type
>>    */
>>   enum iommu_device_data_type {
>> +    IOMMU_DEVICE_DATA_INTEL_VTD = 1,
>> +};
>> +
>> +/**
>> + * struct iommu_device_info_vtd - Intel VT-d device info
>> + *
>> + * @flags: Must be set to 0
> 
> Could you add more description about the usage of flags here?

This is a Reserved 0 fields for other coming features.

Best regards,
baolu
