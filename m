Return-Path: <linux-kselftest+bounces-31748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA878A9E63D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 04:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C951775AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02811684B0;
	Mon, 28 Apr 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ7W2R1M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411478F51;
	Mon, 28 Apr 2025 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745807194; cv=none; b=g85uiFUpeywBfZfHOrIltqDWFpmHNSiW3HS9VbZIRYAT2/fdB8jYeWb6a81x+vmovZPeD/NuhEp6kgNV4LmoPgCxbdGtWvPYEEXtH8jhslolojx2LoM7VuUcxpj3Sa58YCqt833BJLqs8AAtujjVGxd1iRggweiyiQoJYJfWUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745807194; c=relaxed/simple;
	bh=9o6ImY5Xhg/iIM1ggLLapPernE+0oRf+mt/tMBdeno8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3FZlfRkzM9P/0xZJF2BesvpjSosGwbsU4F/NIhWokKTnECaxWFr4epC/5uY3vQEwcb6dY7vUvM3PurLSVXKkd4BifOTAMySgU1C/NlvXs4CxYPjMDNRsRmsPu+u0bhWvKI/a6K3Kl+aBo1CFg/ceZiQrvMRBaN7V0LWSjUs2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ7W2R1M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745807193; x=1777343193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9o6ImY5Xhg/iIM1ggLLapPernE+0oRf+mt/tMBdeno8=;
  b=YJ7W2R1MjuRJt8Ic6e1cpfuoSLgczl3SOdeHSDrWOFY6vzgBKc24wj1J
   nRQA05GB2Juy0HJN5zlQPCD1fCluSMdMtIa4s7hQIRVZnFEsEiy6hnGZl
   n/OTxxgurB3CnBOGDDlWaathopS4chZ2EN9gDGPmQkPltb00zR5bfupH5
   vxW8NuVWZmQ+UN5rvqVHr/tq1iX9miLLJKfsLyWEJOIY48DDD+gTS1H2H
   xcUzyVwfM7bk9R2XxOGvlrgrpZuYGcVYYfyC7BrtUaqDixc/vec8wvF+i
   yrYpDrO3GS3+7DZhL5OPzAXXxqtLdR1wH4WnW9lR2OwvnJKw7zfNSVvmJ
   g==;
X-CSE-ConnectionGUID: 3NAFNt6fS/er8ncgqqQWbA==
X-CSE-MsgGUID: y9+8i0zbSranr7uMsN4Zbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="64919028"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="64919028"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 19:26:32 -0700
X-CSE-ConnectionGUID: G2C/+PsgREWc8VydJw7YEA==
X-CSE-MsgGUID: tr8P1+CuTbep0lh7HWgq6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133362707"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 19:26:20 -0700
Message-ID: <bfb7dd4a-0597-4b6c-ba53-1e4ee3b733b0@linux.intel.com>
Date: Mon, 28 Apr 2025 10:22:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
> features to user space VMs. Its hardware has a strict rule when mapping
> and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
> mappings in ascending order and unmappings in descending order.
> 
> The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
> allocation handler, however it can't do the same for an unmapping since
> the destroy op returns void.

The key point is that unmapping happens during object destroy. These
depend/undepend helpers ensure a vCMDQ is not destroyed (and therefore
unmapped) before any vCMDQs that depend on it. Do I get it right?

> 
> Add iommufd_vcmdq_depend/undepend() for-driver helpers, allowing LVCMDQ
> allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
> to refcount_dec().
> 
> This is a bit of compromise, because a driver might end up with abusing
> the API that deadlocks the objects. So restrict the API to a dependency
> between two driver-allocated objects of the same type, as iommufd would
> unlikely build any core-level dependency in this case.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

... if that's right,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

