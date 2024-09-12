Return-Path: <linux-kselftest+bounces-17780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A798976021
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 06:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF90D285A82
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 04:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FB15C13F;
	Thu, 12 Sep 2024 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6HwQyLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329828F5;
	Thu, 12 Sep 2024 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116568; cv=none; b=bsVayV4+ENTXFZJKtgvSDvt26UwXbeJO5Ug3hhubWGI6DWz05v6urdRSQh6IwGOHGrd+qirVwVR8O8463mJ54MoOQ13DWMVawE3o6Wngxq2fMK0+dJIpV4BSWi6hNnU+7itnOAaHq27wgBuP+GX4M/kIaVPli7pg2rcY/KEM1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116568; c=relaxed/simple;
	bh=zNzFu5RANTqgQEFZ3q+RjpUP/gjte2/5W0pw3L558ww=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rFYSUhTQ2V5vkQ2yIFP4Zxs4JP3Npee+H1Q3eqP4CKwXN7oe4fLSzBiPL7SPHLg7LAmQ0k3p/h5bT4TJQTXD4+/+tBNGqR/Ec3a+8WdQdmQorb+lcFOqs2QOqmyfHNskPQTfFT63kGVROWQFRgjN2E8RR9Xm9qtgpRoAO9O3oU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6HwQyLJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726116567; x=1757652567;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zNzFu5RANTqgQEFZ3q+RjpUP/gjte2/5W0pw3L558ww=;
  b=L6HwQyLJ5S0aGzLd4sCPLrXLCyrwCxiM7YV3gvQudwvhlCiWW9ytWcmV
   R1SGc6vI8T0pP3Q9Dv0eK0KEliAYOl9phYdM+qYS0B8u01E88HqaUuSLA
   yGwlyiA6SDmEFNx5Zaho/SRcnM4eYUYibJBg68hJ/NVqajM8tfB7lX1o1
   BIUlRw+S4Iy3+STdslQAEPDYnGuKOEm3ACzPFfs3N9H+j/SFqCWa7hhCw
   58GQ0zO62nIXy0xfcXxVCpqh8XGtbC2w4AG06Cs3pjmL4/Nh6vqxAQ/GE
   yoF6kqtqHAJ447OhyEld5D6Lu2n52AWujA1qvCX3Zs4qayG5C+FuAFKrm
   Q==;
X-CSE-ConnectionGUID: QNFbgJDjT/KBOCBmeMZZ8w==
X-CSE-MsgGUID: kE6GBqjNT+OhB7I9NQU2eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24884244"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24884244"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 21:49:26 -0700
X-CSE-ConnectionGUID: s5nGQCotTcu1OBUAPG1HIA==
X-CSE-MsgGUID: /4HgxVooSYqGyqsGcyDwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="68373893"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2024 21:49:22 -0700
Message-ID: <cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com>
Date: Thu, 12 Sep 2024 12:45:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mdf@kernel.org" <mdf@kernel.org>, "mshavit@google.com"
 <mshavit@google.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "smostafa@google.com" <smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
To: Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
 <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZuIGxlUXIh7HL+dz@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZuIGxlUXIh7HL+dz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 5:08 AM, Nicolin Chen wrote:
> On Wed, Sep 11, 2024 at 08:17:23AM +0000, Tian, Kevin wrote:
> 
>>> My understanding of VMID is something like domain id in x86 arch's. Is
>>> my understanding correct?
>> yes
>>
>>> If a VMID for an S2 hwpt is valid on physical IOMMU A but has already
>>> been allocated for another purpose on physical IOMMU B, how can it be
>>> shared across both IOMMUs? Or the VMID is allocated globally?
>>>
>> I'm not sure that's a problem. The point is that each vIOMMU object
>> will get a VMID from the SMMU which it's associated to (assume
>> one vIOMMU cannot span multiple SMMU). Whether that VMID
>> is globally allocated or per-SMMU is the policy in the SMMU driver.
>>
>> It's the driver's responsibility to ensure not using a conflicting VMID
>> when creating an vIOMMU instance.
> It can happen to be the same VMID across all physical SMMUs, but
> not necessary to be the same, i.e. two SMMUs might have two VMIDs
> with different ID values, allocated from the their own VMID pools,
> since cache entries in their own TLB can be tagged with their own
> VMIDs.
> 
> Does domain id for intel-iommu have to be the same?

No. A paging domain may have different domain IDs on different IOMMUs
for Intel iommu driver.

> I recall there
> is only one iommu instance on intel chips at this moment?

No. There might be multiple iommu instances on a chip but they share a
common iommu driver ops.

Thanks,
baolu

