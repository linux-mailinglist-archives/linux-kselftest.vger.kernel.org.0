Return-Path: <linux-kselftest+bounces-17908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A49776C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C03B1C24164
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCC4A15;
	Fri, 13 Sep 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcMzam2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C129AF
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193746; cv=none; b=E1ceoTLREKYSt2O/w0KBG2Aok18ZA7YLQ9RI9Rtb4tdmBcusfUHkJzu7yoah9mFV0OrbJlc1gzBwl74jn4O3PZQlalR+cJfdGe8X70dd8sMri7UAlO0wawroWT5evNtvtSyIeuHRKhsRhhUj3I6jsSrAyWaHsfTzhK89gZIJECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193746; c=relaxed/simple;
	bh=EZ1ZWf3HFGrqpZuOSge3UCh9v/JlK9Q9pPrz8P3c/hQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hAIz5fzwjXa/q9C2q2aXzDrDyaUeu6ktiN5giSARUhyVJUJZbl66VP7b5RQRy5bY29E9FeuGnyZiXFUoUXnTorvDIF3d1YyCL7uRzcfKtGoJVl7Z6M/La+FVhuffw+a02pgHSAXHVXv2q/25GoRdzdgpR99ChR5RkswmmcCMG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcMzam2i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726193743; x=1757729743;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EZ1ZWf3HFGrqpZuOSge3UCh9v/JlK9Q9pPrz8P3c/hQ=;
  b=JcMzam2iuDUxG9KQBZcAPUF134kxX+yTtnQWBsqZ1mizJstvz9WpQN/H
   RDkPytoB+H1Sv0o5INIf8qoaamKhpmyAUCQmpxpBHT1DsBb8tSDXRJkyu
   vZKIi6T28ESKsZc2MazBmHMr7TseMvwReUPi8f1zMEvOxMFd12axlzD+S
   mi9AME5jFRPpVd36on2o3rwDnn6q1ss566d2P51bU3kZUc/paLbxD4eTu
   qibChINs1AmhCLfkePWojTXjDp6d4P8gpFY/y+tnO5vCs9YXFQvL9d9CG
   GfX/nvomVnrbPo+qLXThqQAV1XPimdea1CdBQNvGwrtymEog8fPMisYrX
   g==;
X-CSE-ConnectionGUID: dZaOcuUlRsOm9xWDVupZsw==
X-CSE-MsgGUID: Pjh/QqilTR27pcboSQzciA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28976359"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="28976359"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:15:42 -0700
X-CSE-ConnectionGUID: J2pOJcNMSK2Jez2jLDoGfw==
X-CSE-MsgGUID: JuOmGkevQlW+ne0g+PVHWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72256205"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 12 Sep 2024 19:15:38 -0700
Message-ID: <841a6de1-b7b1-4424-a73a-a7400db33299@linux.intel.com>
Date: Fri, 13 Sep 2024 10:11:32 +0800
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
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:04 PM, Yi Liu wrote:
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index b51fc268dc84..ceb9c5274a39 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -236,8 +236,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
>   }
>   
> +/*
> + * Not all PASID entry destroy requires PRQ drain as it can be handled in
> + * the remove_dev_pasid path. Caller should be clear about it and set the
> + * @flags properly.
> + */
>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> -				 u32 pasid, bool fault_ignore)
> +				 u32 pasid, u32 flags)

As a generic opt-in bit flags, why not using 'unsigned int'?

Thanks,
baolu

