Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369DD693FEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBMIqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 03:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMIqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 03:46:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D6E38E;
        Mon, 13 Feb 2023 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676278013; x=1707814013;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hF+DxzbjbhKvEg/0pJMJc8Z+u7gnh4hyoeWzVaXXI2c=;
  b=HdEvOVaM31Mm91krP98lQhpq9aLZZ87UoiPdFbtoWSgP+fR1q3GsuCLj
   c//8dNoFckmq1OciU9JN9jyvGq30K7NLL21AaDNZGaFEduILCS6Ucorl8
   UMoOODxioMGpm5QEpIKZLZw+Pw929mWdQol91qYA4+4GVu0xbRmpSpMq/
   /RLwJcP8ybUPcluVMXaIJY0o1iebi4TKsP6modvElodT6K5lvNxT4Fr3N
   RUhOLGp61aEmFhIRmpifZcy3pUp7xxm7ZE/EBiMoykrgNmWVuZTqhfYJJ
   RYdx13m/y8WR7qXEP0JCkveuG2EPHaYy1XKpTyozcL8Kv/Q9wqyYCglwF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="328550186"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="328550186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:46:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="618578446"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="618578446"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.207]) ([10.249.169.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:46:46 -0800
Message-ID: <3da4035b-da17-94dc-a641-224676025285@linux.intel.com>
Date:   Mon, 13 Feb 2023 16:46:44 +0800
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
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To:     Binbin Wu <binbin.wu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
 <aa9ee0db-c9d9-9b3f-8f63-cbc76bb3ccdd@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aa9ee0db-c9d9-9b3f-8f63-cbc76bb3ccdd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/13 10:36, Binbin Wu wrote:
> 
> On 2/9/2023 12:16 PM, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Introduce a new iommu op get
> 
> get -> to get
> 
> 
>> the IOMMU hardware capabilities for iommufd.
>> This information will be used by any vIOMMU driver which is owned by
>> userspace.
>>
>> This op chooses to make the special parameters opaque to the core. This
>> suits the current usage model where accessing any of the IOMMU device
>> special parameters does require a userspace driver that matches the 
>> kernel
>> driver. If a need for common parameters, implemented similarly by several
>> drivers, arises then there is room in the design to grow a generic 
>> parameter
>> set as well. No warpper
> 
> warpper -> wrapper

Thanks, will update.

> 
>>   API is added as it is supposed to be used by
>> iommufd only.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   include/linux/iommu.h        | 8 ++++++++
>>   include/uapi/linux/iommufd.h | 6 ++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index cb586d054c57..97b398d19fd2 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -15,6 +15,7 @@
>>   #include <linux/of.h>
>>   #include <linux/ioasid.h>
>>   #include <uapi/linux/iommu.h>
>> +#include <uapi/linux/iommufd.h>
>>   #define IOMMU_READ    (1 << 0)
>>   #define IOMMU_WRITE    (1 << 1)
>> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>>   /**
>>    * struct iommu_ops - iommu ops and capabilities
>>    * @capable: check capability
>> + * @hw_info: IOMMU hardware capabilities. The type of the returned 
>> data is
>> + *           defined in include/uapi/linux/iommufd.h. The data buffer is
>> + *           allocated in the IOMMU driver and the caller should free it
>> + *           after use. Return the data buffer if success, or ERR_PTR on
>> + *          failure.
>>    * @domain_alloc: allocate iommu domain
>>    * @probe_device: Add device to iommu driver handling
>>    * @release_device: Remove device from iommu driver handling
>> @@ -252,6 +258,7 @@ struct iommu_iotlb_gather {
>>    */
>>   struct iommu_ops {
>>       bool (*capable)(struct device *dev, enum iommu_cap);
>> +    void *(*hw_info)(struct device *dev, u32 *length);
>>       /* Domain allocation and freeing by the iommu driver */
>>       struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
>> @@ -280,6 +287,7 @@ struct iommu_ops {
>>       void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
>>       const struct iommu_domain_ops *default_domain_ops;
>> +    enum iommu_device_data_type driver_type;
> 
> 
> How to understand the name "iommu_device_data_type"?

This is to tell userspace which type of IOMMU the returned information
comes from, Intel VT-d, ARM or others...

> Is it just refer to the driver types or it has a more generic meaning?

IOMMU driver sets this field to distinguish different IOMMU hardware.

Best regards,
baolu
