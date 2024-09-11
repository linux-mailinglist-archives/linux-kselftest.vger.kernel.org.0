Return-Path: <linux-kselftest+bounces-17728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1518974C71
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC8B25C0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795A15FD13;
	Wed, 11 Sep 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBnpahuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1115383D;
	Wed, 11 Sep 2024 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042754; cv=none; b=BQZqa2INxruSRaARg7Fe3ZgrOak/aPGylLPX+HLh0tOLj/KsGcEb6neAxzLxn4mptOKt2Lw37wClppSzHzcrDUnXEnTEiZEa1KhymYd35YPAytrYDC2CsZgdbMA7HlI1lN2w08DryCnO6hAQ7s4JGYohJF69vXJhvjBFaF6Kdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042754; c=relaxed/simple;
	bh=C/M/OlJkOy173Oq31V96XkHyPvV/Jp4PU2/AH6EcOCg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P3kEBlxA2bbaR3u81+NWsigbuNpI9cUeVv4G58Lbp9PwQQUtdeRKA5Mkxt0CAAfReQUTecfvEiDTc7dnVFVbK5XkNEnbhuUoOLwxLxXjdJBfV0767E1SwLPgZ9JUUc+4Z7Vvt0VpTAk8RE5N12ZIn80g+6J1oxHV0WwzOxqT15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBnpahuu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042752; x=1757578752;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C/M/OlJkOy173Oq31V96XkHyPvV/Jp4PU2/AH6EcOCg=;
  b=lBnpahuufyOhnE0I2nPcWzIuTJtsaeMmV57krKKYDpesF5LfYB/g3O/I
   YwfxKLZ5ROBnibRy0qUlBE7r+YTIAn1l3BrvUhBsx48X1KMHLacfHpRC7
   khzQKLpvWG49vr/3K1JBkrqMdcr1H2MuG/knexpDk5ZzDqfabfGs0+1Pf
   kHTs0+mmgEEG/506KH75WTKPxaJ8rSkhK8vJMk/Q4/WKIGKr614PQkiDF
   EVtZEiyhbj5SZdDMve+ykrMn7+f94vNJ6+s48P1QWfIlNigjDS/yZu09v
   HkXw+RlXCXx2zuE2PL1tKQ0h/IMP0IyIs2LR1dP5SFjj/514zpsKRgHrN
   g==;
X-CSE-ConnectionGUID: /bqd199PRZyETJSkD+xLnA==
X-CSE-MsgGUID: oymRyUbsQRG00Um3IXioYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="25023327"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="25023327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:19:11 -0700
X-CSE-ConnectionGUID: aICFU60vTDaH4pMBepREEQ==
X-CSE-MsgGUID: OEGGNQiHQVWbJL021rouaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="72275297"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:19:07 -0700
Message-ID: <46158923-046b-44e3-a67f-0964c53dd0b5@linux.intel.com>
Date: Wed, 11 Sep 2024 16:19:04 +0800
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
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
 <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 16:17, Tian, Kevin wrote:
>> If a VMID for an S2 hwpt is valid on physical IOMMU A but has already
>> been allocated for another purpose on physical IOMMU B, how can it be
>> shared across both IOMMUs? Or the VMID is allocated globally?
>>
> I'm not sure that's a problem. The point is that each vIOMMU object
> will get a VMID from the SMMU which it's associated to (assume
> one vIOMMU cannot span multiple SMMU). Whether that VMID
> is globally allocated or per-SMMU is the policy in the SMMU driver.
> 
> It's the driver's responsibility to ensure not using a conflicting VMID
> when creating an vIOMMU instance.

Make sense.

Thanks,
baolu

