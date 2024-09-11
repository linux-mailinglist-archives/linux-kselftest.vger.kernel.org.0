Return-Path: <linux-kselftest+bounces-17723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D29974BD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1538B20550
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723713AD29;
	Wed, 11 Sep 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq34vW2h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945413A3F7;
	Wed, 11 Sep 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041068; cv=none; b=cX7LyZAayxSAt6CZIkGHLih4ewofHcOIw1mObeYXGnJlH3VBOuoyjoPInMPNGBvgOk1kpOGffo50FNXryRGqD6HpUKoqOlNCtXgluRDPIKbPAUCOX5EsKQeGabfOV422i1a8fo2Z3Tjk7yR5Kww1Il02qmp2XqT1dD4WrlrCR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041068; c=relaxed/simple;
	bh=M9fkehi060zC3DImk/9ShDxtYwI5FbQzctu+1KRlBI8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0MNgeiDuFETdc+LO8gRC+xvnOzmRoY082x5ymeeBq9o8ht6jeawc18MDgZevDAzu89wQmzC206hFwrlLdEhLo2DVGyxGBus23qxvOjyZVyPD5dVFsb9EPpmLSZ044URydYbyjQ7bGtxY83sZZFdTV74vhHRhjibQ2oQ0GsIhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq34vW2h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041067; x=1757577067;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9fkehi060zC3DImk/9ShDxtYwI5FbQzctu+1KRlBI8=;
  b=Uq34vW2h8VSCkk0u+4388hHLn2D6Q7hR+9kBq7rK8UW0kPc5vg5QaoPZ
   gK6sCxuSzIcgKUBHDG4lUAsnlfjIijHDxd8do5/HMJMGgkScpmcxm76JS
   wfs2LcdsCrJMrx8APcP4fs/e/B4XjiAGxsiH0lG/eE2fpwpR4cKgcZyPi
   hzzX/31PxPFRKcGyT0qleyn5PTQaPtQxe1GOacsjlyVCyY1/z1FYV7e88
   sV8fBLWZmIK2JpSoBEq2PiHJhX7Jajbabz5mFvQuCFIABik3jainYuIqY
   ygWzv9QrD2hV+eiXUlkcCYPBS9Rd6xNKx0eoB687bWDr8XjzujdowziyK
   w==;
X-CSE-ConnectionGUID: xisnIQS7QG+coeuEwxIDfQ==
X-CSE-MsgGUID: /I2CEtdKTLGYW1i8ORBeUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24761681"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24761681"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:51:06 -0700
X-CSE-ConnectionGUID: ajRXdtpPQNKqOYG+oecUHg==
X-CSE-MsgGUID: cFStQAe4QEW8m1wuEEJ7DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="66915156"
Received: from lizhiqua-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:51:01 -0700
Message-ID: <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
Date: Wed, 11 Sep 2024 15:50:59 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZuFEx7mp3v0/lY/g@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 15:20, Nicolin Chen wrote:
> On Wed, Sep 11, 2024 at 06:25:16AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>> Sent: Friday, September 6, 2024 2:22 AM
>>>
>>> On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
>>>> On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
>>>>> On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
>>>>>
>>>>>> +static int arm_smmu_viommu_cache_invalidate(struct
>>> iommufd_viommu *viommu,
>>>>>> +                                           struct iommu_user_data_array
>>> *array)
>>>>>> +{
>>>>>> +       struct iommu_domain *domain =
>>> iommufd_viommu_to_parent_domain(viommu);
>>>>>> +
>>>>>> +       return __arm_smmu_cache_invalidate_user(
>>>>>> +                       to_smmu_domain(domain), viommu, array);
>>>>> I'd like to have the viommu struct directly hold the VMID. The nested
>>>>> parent should be sharable between multiple viommus, it doesn't make
>>>>> any sense that it would hold the vmid.
>>>>>
>>>>> This is struggling because it is trying too hard to not have the
>>>>> driver allocate the viommu, and I think we should just go ahead and do
>>>>> that. Store the vmid, today copied from the nesting parent in the vmid
>>>>> private struct. No need for iommufd_viommu_to_parent_domain(), just
>>>>> rework the APIs to pass the vmid down not a domain.
>>>> OK. When I designed all this stuff, we still haven't made mind
>>>> about sharing the s2 domain, i.e. moving the VMID, which might
>>>> need a couple of more patches to achieve.
>>> Yes, many more patches, and don't try to do it now.. But we can copy
>>> the vmid from the s2 and place it in the viommu struct during
>>> allocation time.
>>>
>> does it assume that a viommu object cannot span multiple physical
>> IOMMUs so there is only one vmid per viommu?
> I think so. One the reasons of introducing vIOMMU is to maintain
> the shareability across physical IOMMUs at the s2 HWPT_PAGING.

My understanding of VMID is something like domain id in x86 arch's. Is
my understanding correct?

If a VMID for an S2 hwpt is valid on physical IOMMU A but has already
been allocated for another purpose on physical IOMMU B, how can it be
shared across both IOMMUs? Or the VMID is allocated globally?

Thanks,
baolu

