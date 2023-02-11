Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C20692DF4
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 04:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBKDiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 22:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKDiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 22:38:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADA33452;
        Fri, 10 Feb 2023 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676086691; x=1707622691;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fjfJYgr9l7FY6AeaHSqoSGiUSdbIvnX9HseUvyVfHkU=;
  b=FPyNJJMHgUe6XDbYFCq1eu0DOaQHWw8tAUfHEgruGJNZKCHfGwqYArA6
   KjuakIBY38BMbFfmAnzTm7ozcAMc+os3duwv+a+YMuyZHRyoZldPI6ULF
   T8J3vGERpc2fqMwS8ysekynLX3JZueXYK6Kd//QRh07nyf7YS0D1wFQZc
   QRqjm2G0YMapwXwo02QDrEst1+vlikvPr+XA9FhY6JG9SERqHEklH366+
   F8qGN8DnR/RqvzklrOIanCDnnLOFH+DjIl0mLRgiZ+mxv9mrTmP7pgEQy
   PhPzt3kRnJ6YCFCk+NGyK87pM7v5rDnt+TOIvYzzSBK7luzMRjBDCG+i8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="318597343"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="318597343"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:38:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="618087971"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="618087971"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:38:05 -0800
Message-ID: <b50ca15b-81fb-d8e6-90fd-210ab0916d31@linux.intel.com>
Date:   Sat, 11 Feb 2023 11:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
 <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/10 15:28, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>>   /**
>>    * struct iommu_ops - iommu ops and capabilities
>>    * @capable: check capability
>> + * @hw_info: IOMMU hardware capabilities. The type of the returned data
>> is
> 
> is it 'info' or 'capability'?
> 
>> + *           defined in include/uapi/linux/iommufd.h. The data buffer is
>> + *           allocated in the IOMMU driver and the caller should free it
>> + *           after use. Return the data buffer if success, or ERR_PTR on
>> + *	      failure.
>>    * @domain_alloc: allocate iommu domain
>>    * @probe_device: Add device to iommu driver handling
>>    * @release_device: Remove device from iommu driver handling
>> @@ -252,6 +258,7 @@ struct iommu_iotlb_gather {
>>    */
>>   struct iommu_ops {
>>   	bool (*capable)(struct device *dev, enum iommu_cap);
>> +	void *(*hw_info)(struct device *dev, u32 *length);
>>
>>   	/* Domain allocation and freeing by the iommu driver */
>>   	struct iommu_domain *(*domain_alloc)(unsigned
>> iommu_domain_type);
>> @@ -280,6 +287,7 @@ struct iommu_ops {
>>   	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
>>
>>   	const struct iommu_domain_ops *default_domain_ops;
>> +	enum iommu_device_data_type driver_type;
> 
> the enum is called 'device_data_type' while the field is called 'driver_type'.

The enum is named from uAPI's p-o-v and driver_type is from IOMMU's.

> btw this new field is not documented above.

Yes. Will do that.

Best regards,
baolu
