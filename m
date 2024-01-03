Return-Path: <linux-kselftest+bounces-2603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFAE822758
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F6228400D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1F4A16;
	Wed,  3 Jan 2024 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5qYQCGY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D317984;
	Wed,  3 Jan 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704251189; x=1735787189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=54mZ8lt3FIE0at3u9CpLbmAD6Xka6IeZtdwSydhjovE=;
  b=J5qYQCGYYES4vGA0R3GOld6RKKdl+JukQRDUX8uAEnuiNkxxCbItz9k1
   agEdGzZRkqAKQNkNFm9Fih8lidhufh4q7qyM3BDEyZsdaGkg9Yw+0vvOD
   XDAwMEGq7bXBMRUiwtSzoRLrjCBXjrr/avvnl93UDAyA6KTu+OFoQYz1u
   9ijANgwqRdiY/mW+OXgC8Bsp2YE/sSfrGgExWZ3Fi3xtvR/d5zmbSf5bu
   XpitDnLUc6a4FtAA/PDB3ZZ/w8fpBMp6Q/28lHnrveNZIw5hxSF8K3xi7
   0m6FTeCkpXZnTKDCNkGHi62/QlvFEWDrYP/HYVRoSLYkvSH5AmY6M+sya
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10578496"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="10578496"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923403014"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="923403014"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.107]) ([10.254.210.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:06:22 -0800
Message-ID: <7486492a-d6ca-425d-9fbe-87107dbbecea@linux.intel.com>
Date: Wed, 3 Jan 2024 11:06:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, robin.murphy@arm.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com, j.granados@samsung.com
Subject: Re: [PATCH v10 10/10] iommu/vt-d: Add iotlb flush for nested domain
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
 <20240102143834.146165-11-yi.l.liu@intel.com>
 <20240102184422.GI50406@nvidia.com>
 <ae271e08-f390-4ce7-914c-63668a46bc4b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ae271e08-f390-4ce7-914c-63668a46bc4b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/3 9:33, Yi Liu wrote:
> On 2024/1/3 02:44, Jason Gunthorpe wrote:
>> On Tue, Jan 02, 2024 at 06:38:34AM -0800, Yi Liu wrote:
>>
>>> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64 
>>> addr,
>>> +                     unsigned long npages, bool ih, u32 *error)
>>> +{
>>> +    struct iommu_domain_info *info;
>>> +    unsigned long i;
>>> +    unsigned mask;
>>> +    u32 fault;
>>> +
>>> +    xa_for_each(&domain->iommu_array, i, info)
>>> +        qi_flush_piotlb(info->iommu,
>>> +                domain_id_iommu(domain, info->iommu),
>>> +                IOMMU_NO_PASID, addr, npages, ih, NULL);
>>
>> This locking on the xarray is messed up throughout the driver. There
>> could be a concurrent detach at this point which will free info and
>> UAF this.
> 
> hmmm, xa_for_each() takes and releases rcu lock, and according to the
> domain_detach_iommu(), info is freed after xa_erase(). For an existing
> info stored in xarray, xa_erase() should return after rcu lock is released.
> is it? Any idea? @Baolu

I once thought locking for xarray is self-contained. I need more thought
on this before taking further action.

Best regards,
baolu

