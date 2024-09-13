Return-Path: <linux-kselftest+bounces-17914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA909776E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81B02860A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F951D2F79;
	Fri, 13 Sep 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSRq6AAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474784D2C
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194536; cv=none; b=VSCVOkm4eKKwkEYsVNxfDTwNW+pGmtvG4HUFAFtoBphTeott6zjFh1fAQI4JoVtl7u60lod0GD/m95tpzvcXQ6T0TCtlCfSFXZR9uod6pOmKjN50ibfbGeiLjuVTJiPq7P3qbRAo62ku41b4VvwcuzIKiza+jS9HzBRZGotTZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194536; c=relaxed/simple;
	bh=463ORfxaX+sWNPRR/Gn3Pqa1C7jNBzklmbOaLg/0UZQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QsfnEoZEv4LA1lh4GWJCiZLHRpDoL/AZxEl0bAyzXTwdHerIP7bUOcT2yGTnH2Rh4jDs6/HkpoIH43Kh+ARgQCKXBCdzI5MlPfoZl13v277Br6tDWhsBouMVMUdW0+Bj2IykL1wyEc7IL4+C1V18YDE+yWPBOiJBpKzkvUFSo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSRq6AAb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726194535; x=1757730535;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=463ORfxaX+sWNPRR/Gn3Pqa1C7jNBzklmbOaLg/0UZQ=;
  b=gSRq6AAbZ3/ifbKVnEDQblvhSquzywVFR1VEGXLaD+i9ClUZN1u1ttgl
   T5TwppCyJ0D16NKb40hSqqf2ysaxVyojJYpE1JhqYoFoBXKls4Jr1U4an
   FXTdPJG2KR7INMKptGg9uhop9UfQXpKY7uwcy4egMDm+VGs833GQNaXmc
   dzffl5oOsNnT+dhlZd162uHZAMZssuP7AkTJyVVbqKsoIenIEyOXEKHl7
   Dle9poJjmuaICmEl9RtA/Q+Fw7+tnagYzPEoLhoWTICVkdIslNN2yiUdj
   yxZ/ScsHbNp4S030cuvne+fjOgwQtftFF4HzGliWcZsb/OfCszb73e22t
   w==;
X-CSE-ConnectionGUID: 6viQBTIkTcm8EluCHTP6BQ==
X-CSE-MsgGUID: 3HnbHvy3StSPBjR9IBy6uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35751368"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="35751368"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:28:54 -0700
X-CSE-ConnectionGUID: 3l18HQVdR9KpjbKRQn9i/g==
X-CSE-MsgGUID: u8FsCK3VQbyx6jZzmiOScw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="68154052"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 12 Sep 2024 19:28:51 -0700
Message-ID: <71452c12-7339-4122-a7a3-64dd32ddba3b@linux.intel.com>
Date: Fri, 13 Sep 2024 10:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH 3/3] iommu: Add a wrapper for remove_dev_pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130653.11028-1-yi.l.liu@intel.com>
 <20240912130653.11028-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130653.11028-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:06 PM, Yi Liu wrote:
> The iommu drivers are on the way to drop the remove_dev_pasid op by
> extending the blocked_domain to support PASID. However, this cannot be
> done in one shot. So far, the Intel iommu and the ARM SMMUv3 driver have
> supported it, while the AMD iommu driver has not yet. During this
> transition, the IOMMU core needs to support both ways to destroy the
> attachment of device/PASID and domain.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)

This patch should be moved before the change in drivers. After all
drivers convert to use set blocking domain to pasid, the
remove_dev_pasid could be removed as the last step.

Thanks,
baolu

