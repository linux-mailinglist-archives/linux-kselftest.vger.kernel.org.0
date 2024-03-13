Return-Path: <linux-kselftest+bounces-6291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FE187A1D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C7E1F22E2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB865D51B;
	Wed, 13 Mar 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnZbTn06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65AC13D;
	Wed, 13 Mar 2024 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299614; cv=none; b=X631Q6WorWqQbNu6+tM7MnnioderjIl5LsKuYAq05XzrB6krmQB1k9Imv2kB7Bf35W1LLz7AOawfXwadPO2fbZlp9KPMKjqNTd8zPnwYQO9WR16entO5jsI4ErWIUQJ6vx8ykFCVzyVs8wO3+CMp8AHAi1KfQsj08pCZbBOuXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299614; c=relaxed/simple;
	bh=n2YjBU/qs6IdWcXohPVlN+e053Y/IEgAwN4JCjsR9HI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEJ8y7xhpZIpmLmOm/RLfgxANrdes/Yh0URfByaTVQwBP4III58vbwvmYqhK7A1YYSm+TnYaoUdyWe9Ou1fR7VyNKazPOq/LLKgjmQ+O5NYsRFN2X38yimqz4W6XXJZG4GYxwwGhnMBGTb5kiWD2WQTXdfdvuYDMYRP/Qs6O9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnZbTn06; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710299613; x=1741835613;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2YjBU/qs6IdWcXohPVlN+e053Y/IEgAwN4JCjsR9HI=;
  b=cnZbTn06j9fL7Uc9GrbEFm46PaPp+4qm5ALIOwpIZqjEqeCU/AH7xvwM
   Dl6ehvlKNdtbMao3qoZXNLA4wX3VkDP53+60dVORsJhf8rcTTUmN/rVbG
   7WaBi8qgHk9ztiijbNvCutRreEy1Nh//UCMGWKyv9thd5b6cowX5iw0Tm
   wtkpHvVSQfdbaqeYgRWL9g2Dq+iv9yfiu9H0mus0uIf5yJRQeP+spO2/U
   O+p44Ak39/FpN32yWrhr9WQ5XYb8HgB97CVpKxCfJsC/Ymhp2BKtexbP7
   3v9LvUWffu7x+Wf4SO5wbvrHeYujLIHvrhNj9U4+NRN9VAttDHvt7cc3f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15598662"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15598662"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49197836"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.116]) ([10.254.214.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:13:26 -0700
Message-ID: <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
Date: Wed, 13 Mar 2024 11:13:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/12 11:07, Yi Liu wrote:
> On 2024/3/11 17:26, Tian, Kevin wrote:
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Sunday, March 10, 2024 9:06 PM
>>>
>>> On 2024/1/16 01:19, Jason Gunthorpe wrote:
>>>> On Sun, Nov 26, 2023 at 10:34:21PM -0800, Yi Liu wrote:
>>>>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>>> +                   struct device *dev, ioasid_t pasid)
>>>>> +{
>>>>> +    struct iommu_group *group = dev->iommu_group;
>>>>> +    struct iommu_domain *old_domain;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!domain)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (!group)
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    mutex_lock(&group->mutex);
>>>>> +    __iommu_remove_group_pasid(group, pasid);
>>>>
>>>> It is not replace if you do remove first.
>>>>
>>>> Replace must just call set_dev_pasid and nothing much else..
>>>
>>> Seems uneasy to do it so far. The VT-d driver needs to get the old 
>>> domain
>>> first in order to do replacement. However, VT-d driver does not track 
>>> the
>>> attached domains of pasids. It gets domain of a pasid
>>> by iommu_get_domain_for_dev_pasid(). Like
>>> intel_iommu_remove_dev_pasid)
>>> in link [1]. While the iommu layer exchanges the domain in the
>>> group->pasid_array before calling into VT-d driver. So when calling into
>>> VT-d driver, the domain got by iommu_get_domain_for_dev_pasid() is
>>> already
>>> the new domain. To solve it, we may need to let VT-d driver have its
>>> own tracking on the domains. How about your thoughts? @Jason, @Kevin,
>>> @Baoplu?
>>>
>>> [1]
>>> https://github.com/torvalds/linux/blob/master/drivers/iommu/intel/iommu
>>> .c#L4621C19-L4621C20
>>>
>>
>> Jason's point was that the core helper should directly call set_dev_pasid
>> and underlying iommu driver decides whether atomic replacement
>> can be implemented inside the callback. If you first remove in the core
>> then one can never implement a replace semantics.
> 
> yeah, I got Jason's point. I'm raising an open to make the set_dev_pasid
> callback to handle domain replacement. The existing intel iommu driver
> does not track attached domains for pasid. But it's needed to know the
> attached domain of a pasid and find the dev_pasid under the domain, hence
> be able to clean up the old attachment and do the new attachment. Existing
> code cannot work as I mentioned above. The group->pasid_xarray is updated
> before calling set_dev_pasid callback. This means the underlying iommu
> driver cannot get the old domain in the set_dev_pasid callback by the
> iommu_get_domain_for_dev_pasid() helper.
> 
> As above, I'm considering the possibility to track attached domains for
> pasid by an xarray in the struct device_domain_info. Hence, intel iommu
> driver could store/retrieve attached domain for pasids. If it's
> replacement, the set_dev_pasid callback could find the attached domain and
> the dev_pasid instance in the domain. Then be able to do detach and clean
> up the tracking structures (e.g. dev_pasid).

Maintaining the same data structure in both core and individual iommu
drivers seems to be duplicate effort. It appears that what you want here
is just to get the currently used domain in the set_dev_pasid path. Is
it possible to adjust the core code so that the pasid array is updated
after the driver's set_dev_pasid callback returns success?

Best regards,
baolu

