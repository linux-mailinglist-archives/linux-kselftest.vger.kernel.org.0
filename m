Return-Path: <linux-kselftest+bounces-19312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CA995CBD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F651C215BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41515380B;
	Wed,  9 Oct 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd9FN0uc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3714389F
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436175; cv=none; b=kLPUqhnYMMwQeDsxMbwm/PjeZNZHdpWmNBEw14bl9dU7hL/8/Ge3guj70aLmss+9QZrNttP2hD/HgDGmNDapJxYBUSHvuJoZkoqttHPekDwr1M4k8qiGpGmu8G5kzZheH8uD4+qDn9Vg55JQhapZrN09kbPeBbanPjtcKKjR3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436175; c=relaxed/simple;
	bh=Uv3ph2Jbb71RnVGQn6CQgpcPAjQBngBYdLG0ZjCTVAM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qTvTjA8Dhgz+zHe+S+vxbfpyLW70wIdsP+zGur/mDeAfRSt/eB1JZJWxdpQ1VlOfizQlkoodKlDkUxmsrakHA4G8Nv5UsFTk68I9rSYVQUKQGSRhbkN7uw5dO5TzJmV6fI7N36oxyXjN5rCHDcQGEjxfzeuKXB2rN4fU4t7GSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd9FN0uc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728436174; x=1759972174;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uv3ph2Jbb71RnVGQn6CQgpcPAjQBngBYdLG0ZjCTVAM=;
  b=hd9FN0uciDdeAUfsaAABIOVzYJ685ePc4/TfuJ4jGUnlIognlDQxQTsk
   hUYz2b2VNCTrxYfcDdS9AMvc7BjG1xMtlGJBzve/7pq3evsnI55FwI8UU
   jE0NDL/CT+LRwEbaQF/+6L3u++RjolpIOeM/8F7Dd2wf9RKFkBOz3wSbr
   hrzlkd1eLUh3RSTtEtiX9eVW7Kxr8KTz3Ja2lypWAjZ9AMGFcJspK0Vnt
   VbQyF1GAC2dXQIP5NXycxrYHAif6zttAcCugmK64kwXq6CWHEqmWaWBkl
   Dytt0JkuOL/41wlFlHtY3dUrOCmmcn1BwEmP3Ha0CH2qpdAN4dUIZQ8Y7
   g==;
X-CSE-ConnectionGUID: JRoEUe2tSLSkgQifBNew/A==
X-CSE-MsgGUID: Qsis5Hm6RdGNdHz8C6LR0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="39093019"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="39093019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:09:30 -0700
X-CSE-ConnectionGUID: g1QmcFj6T+m8eR+E/mZ5mA==
X-CSE-MsgGUID: w0G7lixHR36IJkASZuyVTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="99414093"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:09:27 -0700
Message-ID: <50824ceb-71c4-4b1b-95ba-291461d647b6@linux.intel.com>
Date: Wed, 9 Oct 2024 09:09:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
 <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
 <BN9PR11MB5276AF2CB65A36369CF10A008C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AF2CB65A36369CF10A008C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/30 15:19, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, September 13, 2024 10:17 AM
>>
>> On 9/13/24 9:35 AM, Baolu Lu wrote:
>>> On 9/12/24 9:04 PM, Yi Liu wrote:
>>>> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t
>>>> pasid,
>>>> +                     struct iommu_domain *domain)
>>>> +{
>>>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>> +    struct intel_iommu *iommu = info->iommu;
>>>> +
>>>>        intel_pasid_tear_down_entry(iommu, dev, pasid,
>>>>                        INTEL_PASID_TEARDOWN_DRAIN_PRQ);
>>>> +    if (domain->type == IOMMU_DOMAIN_IDENTITY)
>>>> +        return;
>>>
>>> The static identity domain is not capable of handling page requests.
>>> Therefore there is no need to drain PRQ for an identity domain removal.
>>>
>>> So it probably should be something like this:
>>>
>>>       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>>>           intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>>>           return;
>>>       }
>>>
>>>       intel_pasid_tear_down_entry(iommu, dev, pasid,
>>>                                       INTEL_PASID_TEARDOWN_DRAIN_PRQ);
>>
>> Just revisited this. It seems that we just need to drain PRQ if the
>> attached domain is iopf-capable. Therefore, how about making it like
>> this?
>>
>> 	unsigned int flags = 0;
>>
>> 	if (domain->iopf_handler)
>> 		flags |= INTEL_PASID_TEARDOWN_DRAIN_PRQ;
>>
>> 	intel_pasid_tear_down_entry(iommu, dev, pasid, flags);
>>
>> 	/* Identity domain has no meta data for pasid. */
>> 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>> 		return;
>>
> 
> this is the right thing to do, but also suggesting a bug in existing
> code. intel_pasid_tear_down_entry() is not just for PRQ drain.
> It's also about iotlb/devtlb invalidation. From device p.o.v it
> has no idea about the translation mode in the IOMMU side and
> always caches the valid mappings in devtlb when ATS is enabled.

Yes. You are right.

intel_pasid_tear_down_entry() takes care of iotlb/devtlb invalidation.
So it's fine as long as intel_pasid_tear_down_entry() is called for the
IDENTITY domain path, right?

> Existing code skips all those housekeeping for identify domain
> by early return before intel_pasid_tear_down_entry(). We need
> a separate fix for it before this series?

Existing code doesn't skip intel_pasid_tear_down_entry().

         if (domain->type == IOMMU_DOMAIN_IDENTITY) {
                 intel_pasid_tear_down_entry(iommu, dev, pasid, false);
                 return;
         }

Or anything I overlooked?

Thanks,
baolu

