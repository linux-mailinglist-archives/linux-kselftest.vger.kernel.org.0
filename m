Return-Path: <linux-kselftest+bounces-18432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B17987CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D559281136
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48F166F0C;
	Fri, 27 Sep 2024 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0sAoPfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874123A1A8;
	Fri, 27 Sep 2024 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403005; cv=none; b=bU4CMPD+n4DZ5XBa6XDaEYT8vezDsyUTOg6jX3/jXrcTLlJedf2wAx1/qmmsiyxvdNMH1g4XsMhbkOMuq5s29e052jKg183XENLNFJFd+GueiHwerFdDZAEqNWN6TNEAAAR6OZ42tYh50BHhKUfuvDXkxZetfcsoKxFkyHD3I9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403005; c=relaxed/simple;
	bh=hxwzEUSAu4nppCQkrodBnYJTu2L6SXlL2T8Cbgq8CtA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jlG8kgBQVDqkaIHzk5vLkePTkTgev3h/JknanUwykeHg9vDCq0C5wHNOcGuxH7cfIJMcOxZFE5X5VQc5tIX+Qgl3L/V5mQtw4T0ZgHxqOG/qdW4YiSRAPFhvOqrE9JYM2XaY27xHT1FRY0/OJkglLjzm9p8TpZ3uwxZdEiaBPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0sAoPfF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727403004; x=1758939004;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hxwzEUSAu4nppCQkrodBnYJTu2L6SXlL2T8Cbgq8CtA=;
  b=F0sAoPfFitS4wC9lwaNk0dca9PByc26VTDRj4iUrR6n4bu5FSfrzf0/+
   QLGJYtthRNo27AlcLiqYlG0cBUcXpIjl8rBXojuPbREFcwD3TfOr3Bmmc
   gmj0DxBkCy72DGcLuNTmqWLdEqY0y0VgSxvmIdfysKJMFC05j1M2ewSA+
   916Hugsz+Qt9/fExg2jOw2UNMytTAsiBntJ/7OP+i894ALEVJqh5LY7bu
   S8+9uyz6zxphqPDEC6ivs45dVaIzL768BeaIOnjtn7ijq56SC8bMo0cBY
   RG+nzk6Yq0Plv7+N5DIeKweCXzI3IyZ0+gXL7qEeHV4fkaYHNpQ8HZ2Kx
   w==;
X-CSE-ConnectionGUID: kMiewlXbTuys7hPvy6oAFA==
X-CSE-MsgGUID: 4H9hku4GRUWcZkPVNkNMsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37102251"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37102251"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 19:10:03 -0700
X-CSE-ConnectionGUID: AfvG0hxfSWGrhLa2PUJ7vg==
X-CSE-MsgGUID: 7pKaXJYUSAGUzgVX+TeqiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72032686"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 26 Sep 2024 19:09:58 -0700
Message-ID: <05a6b098-8197-4ae6-af80-6dcc16c9f29f@linux.intel.com>
Date: Fri, 27 Sep 2024 10:05:35 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
To: Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 4:03 AM, Nicolin Chen wrote:
> On Thu, Sep 26, 2024 at 04:47:02PM +0800, Yi Liu wrote:
>> On 2024/9/26 02:55, Nicolin Chen wrote:
>>> On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
>>>> Hi Nic,
>>>>
>>>> On 2024/8/28 00:59, Nicolin Chen wrote:
>>>>> This series introduces a new VIOMMU infrastructure and related ioctls.
>>>>>
>>>>> IOMMUFD has been using the HWPT infrastructure for all cases, including a
>>>>> nested IO page table support. Yet, there're limitations for an HWPT-based
>>>>> structure to support some advanced HW-accelerated features, such as CMDQV
>>>>> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
>>>>> environment, it is not straightforward for nested HWPTs to share the same
>>>>> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
>>>> could you elaborate a bit for the last sentence in the above paragraph?
>>> Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
>>> domain across IOMMU instances, we'd have to make sure that VMID
>>> is available on all IOMMU instances. There comes the limitation
>>> and potential resource starving, so not ideal.
>> got it.
>>
>>> Baolu told me that Intel may have the same: different domain IDs
>>> on different IOMMUs; multiple IOMMU instances on one chip:
>>> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
>>> So, I think we are having the same situation here.
>> yes, it's called iommu unit or dmar. A typical Intel server can have
>> multiple iommu units. But like Baolu mentioned in that thread, the intel
>> iommu driver maintains separate domain ID spaces for iommu units, which
>> means a given iommu domain has different DIDs when associated with
>> different iommu units. So intel side is not suffering from this so far.
> An ARM SMMU has its own VMID pool as well. The suffering comes
> from associating VMIDs to one shared parent S2 domain.
> 
> Does a DID per S1 nested domain or parent S2? If it is per S2,
> I think the same suffering applies when we share the S2 across
> IOMMU instances?

It's per S1 nested domain in current VT-d design. It's simple but lacks
sharing of DID within a VM. We probably will change this later.

Thanks,
baolu

