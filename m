Return-Path: <linux-kselftest+bounces-35063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F9ADAF1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553021888FB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95942E7F06;
	Mon, 16 Jun 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5903fB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCE257458;
	Mon, 16 Jun 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074846; cv=none; b=R0G7ITLjVDd7HzRPSythM4rO8odsZh4fsRr72S+2Pe/NCq5Zld6muMBrft/1Zmd+eRb4xeNTMhfDjbhHuFveWwH4Db3+tkJApdATnAwGDKPEpQenosZ3OyO0EnUydu75aXyZnn1U14SJM6wk+LcHuGUqbzi9tu2Vrkm5tdloMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074846; c=relaxed/simple;
	bh=pP5MfHtYu2fbe1zYj4J2fUs/FbilXaL/PP8TBCvNC0M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dpYnmMfMuDhJNW8H7bc6Oz61H8l33vknSA59WM61/NXslKVFtKGpOcuPoQdLhtWMvGNeQhNS5Cb/RdcaAfJtgz4ADhoruoXrGZjKUX2x/klFXIqlGOGafuSK8jHKNv1xwx7vTtq/D1hgMVTLG0iex+mcIc3UTRG6WzNmaoz47xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5903fB9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750074845; x=1781610845;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pP5MfHtYu2fbe1zYj4J2fUs/FbilXaL/PP8TBCvNC0M=;
  b=i5903fB9KuaaEwiiQ4KR7DWzBwiGVwC2ZKVj7QGIV3nyh/KCbjP/YA0s
   +NCjLtXmTvq2JfjF212Wd8ldqsIw4v/g4WE2lyWxFxt78Q5s6dBang1H7
   qjzMQpzbnmzgVcQ3bbxBjgm+mcbOeLMkvj0/IXfmG9dFNVs7A/CfYrZHi
   Jj2t/V6qYOdRymg3kMIzAXRbkGC1zFX8XA6aHAMi6Huxhoi1Ggt6UMgub
   O7AZ/Xz4yBdn4rhktFZfEaFYUVhE/wPj8ufuA7VNWiiV5in62DlW2YR/u
   Vfqnh10Rf76CyqLyteopH5/lnFBjCi0dS98tWe8NdASAVPZvd5qQi0GdB
   g==;
X-CSE-ConnectionGUID: nKZytmuSTL6n/pZDnVN8Kg==
X-CSE-MsgGUID: zxNuT4DhSWqTA6Zpum7UTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51323310"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51323310"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:54:04 -0700
X-CSE-ConnectionGUID: 9avOGMS9Tx6HGo/PK5JOTQ==
X-CSE-MsgGUID: ascvokOsSvasnbq8CTB7dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148824249"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:53:58 -0700
Message-ID: <b60267c2-df8c-4833-a299-62f29004fb6e@linux.intel.com>
Date: Mon, 16 Jun 2025 19:53:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, bagasdotme@gmail.com, robin.murphy@arm.com,
 joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
 jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
 vasant.hegde@amd.com, dwmw2@infradead.org
Subject: Re: [PATCH v6 16/25] iommu: Allow an input type in hw_info op
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <2dc47d6016bf5f6ad6062ad7d84c7220b789b429.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2dc47d6016bf5f6ad6062ad7d84c7220b789b429.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/2025 3:14 PM, Nicolin Chen wrote:
> The hw_info uAPI will support a bidirectional data_type field that can be
> used as an input field for user space to request for a specific info data.
> 
> To prepare for the uAPI update, change the iommu layer first:
>   - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
>     output its only (or firstly) supported type
>   - Update the kdoc accordingly
>   - Roll out the type validation in the existing drivers
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

