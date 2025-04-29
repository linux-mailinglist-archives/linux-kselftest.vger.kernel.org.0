Return-Path: <linux-kselftest+bounces-31856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29244AA02F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3633284259A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACD2777E9;
	Tue, 29 Apr 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI/X3kqA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A79127510D;
	Tue, 29 Apr 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907351; cv=none; b=R8y9aSoIs/U7uCmU5Rc7cTMnLyK1MECUm9CZagYj3zsRHlURY0XpZeSFg7Mqa0PWmKWPEWag4aZUzeKLS3iN98jFptsdPKEEvQJJXncgONCTMfwtM7KPqHPcInYqApUSNbvBufK0YwfAPl6r2saM8171kHa/vGf9w3wgdogwqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907351; c=relaxed/simple;
	bh=ntheU5Y/cslp1UNyIwy6sjeZIMak9TTFnECtsJY2pH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3tuJoPKS9wMbGEFK4ks+rQYpS3F51mqrvL37V4CtW/YGeLpV4lYWlnlMmQYkBl4/oDVCayvg4bY+VuckiUjiOtH7Dizc4EQ9I254L590fVdCqBezax4JQl+vyRpIN37850S3mNOGJNmBTrtPO9zLvenwLzmnngEhB497gO3jWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI/X3kqA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745907350; x=1777443350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ntheU5Y/cslp1UNyIwy6sjeZIMak9TTFnECtsJY2pH0=;
  b=KI/X3kqASu8HQ6F7s5VleKu4Yv+XirTK+zxuDw5WR7xkFoGFDw6KMo/S
   yQJ1Tf8kr3JEMmxWraU2ffidLbHtth0UHlCvXx52YJ+BI3vmAn/iR709m
   H3rHSAKbzVti19cUYdttFFrfGGMe4b9yJymEBcv7384GT26xCBDr3FpUJ
   i8cmYIEP5DA+CzgxM55FFCw65b9IRRR8Da0m39cEYMcZOPqQoCubhKllO
   5MZouYtG/mjUuQ8uygHVDjG2+0ha1Kj9ivTiypsUg42Www4+3iQHne4Dw
   n5Gz/8iT0L1S6y3iBPdNb4iVRMm+rxu+H7MplWdXfxqRAnfD8Ze+mQL+v
   A==;
X-CSE-ConnectionGUID: lW8X7Rj3Q8SX9c5ndvOXiA==
X-CSE-MsgGUID: a2csLORSRUu3mJCRTJvJgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58888017"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="58888017"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 23:15:50 -0700
X-CSE-ConnectionGUID: hL/PpME8Qz2SjoN3Tm+rlQ==
X-CSE-MsgGUID: k0NPyEOXRYmpI9s1uLRPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="134687731"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 23:15:44 -0700
Message-ID: <8af1a3c7-d5e6-46ca-a946-5d349e843ed6@linux.intel.com>
Date: Tue, 29 Apr 2025 14:11:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <dcfd9bfc-44db-4fd8-a49c-0c96c68f6b88@linux.intel.com>
 <aA/P02wgX27/EjBS@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aA/P02wgX27/EjBS@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 02:58, Nicolin Chen wrote:
> On Mon, Apr 28, 2025 at 09:32:04AM +0800, Baolu Lu wrote:
>> On 4/26/25 13:58, Nicolin Chen wrote:
>>> +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
>>> +{
>>> +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
>>> +	struct iommufd_viommu *viommu;
>>> +	struct iommufd_vcmdq *vcmdq;
>>> +	struct page **pages;
>>> +	int max_npages, i;
>>> +	dma_addr_t end;
>>> +	int rc;
>>> +
>>> +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
>> I don't follow the check of 'cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT'
>> here. My understanding is that it states that "other values of type are
>> not supported". If so, shouldn't it be,
>>
>> 	if (cmd->flags || cmd->type != IOMMU_VCMDQ_TYPE_DEFAULT)
>>
>> ?
> No. Only other (new) types will be supported. We have this:
> "* @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use"
> which means driver should define a new type.
> 
> We have the same DEFAULT type in vIOMMU/vEVENTQ allocators by
> the way.

Okay, thanks for the explanation.

The iommu driver's callback will return a failure if the type is not
supported. Then it's fine.

Thanks,
baolu

