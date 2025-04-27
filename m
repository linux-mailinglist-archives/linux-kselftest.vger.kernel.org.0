Return-Path: <linux-kselftest+bounces-31727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512DA9DFFB
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 08:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D585A42F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE6241103;
	Sun, 27 Apr 2025 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiEDRoEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506718D656;
	Sun, 27 Apr 2025 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745736030; cv=none; b=iAfAkOHi45Rxvs+JDqg+ag2wFCtoTxn2OBEZCfHv+hd+krKPkqxQxUvBpn05UiZHa2fbB6LT50SCRm01x9lvM+xqNOtkWuZou0FVcEV+Tc4k4q+7hn8ssqAeTVmNr4X7+UHYKM73Mai8sVA9dF+Xp6Mpu2RVNwNC5iuJ4nf7MX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745736030; c=relaxed/simple;
	bh=jHRCYwqkDeGnsoQZjCZlk/VB00dZCE9Xt/gFt3+3Ekg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiYmO4sCXrXAGVnOP27J53IX2eM4QieHYmJTQbuLmTCxj/ajX2aTGIjIkHmnw1ddPjos1M1kABIVUQAUYWwCl4MlBGo8D1aEbHIbIOltxV0Hkm1W5J8AxjVBxtL7Gc7kt44O2XJWeh+LaObf96eRh7PJptRDt2GtIzfcBeVb+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiEDRoEE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745736029; x=1777272029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHRCYwqkDeGnsoQZjCZlk/VB00dZCE9Xt/gFt3+3Ekg=;
  b=HiEDRoEEJt68T4S/kASoKDSrb3P9E7jpXeLzE7/KWdyArGS6lN+MKLH+
   Rwy1++I15gldIUQZgEaWj3MdyeYZFD96NE3vG88ElOwTL/GmbRgiEo1sK
   FIPKLmndus56uqgPrxip3T2QlhVEw8bPi/zvceGHIQ/v8Sbk6mUyjyM26
   FwP6f2m8CxvNEAlgwWVHjBNG6YNhJAvDIOblEr0YsazxnAYodkw5CJBDM
   d2Ivy3mwVFpYYKNZU+FljIva/8WohXo4ac2FpK0+nqIUuI50wfQOOLuYM
   tbkJ1PAIlOTHLay1mgLpo+FIdvWSuHPlAoMUz8TiEBeg5UfzQ7B/8zzvP
   w==;
X-CSE-ConnectionGUID: aS3RV+bUSqSZoynbRgRdUw==
X-CSE-MsgGUID: dEEVvbR0RyezwjB/uFbPoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47430743"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="47430743"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:40:28 -0700
X-CSE-ConnectionGUID: WKkjJoVMRdmCZIfMb9eS0Q==
X-CSE-MsgGUID: wDOai0I1Qz+zMkODB65DXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="133731606"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:40:22 -0700
Message-ID: <43a93c81-3e7f-46cc-bf93-5e36cbf04b8f@linux.intel.com>
Date: Sun, 27 Apr 2025 14:36:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] iommufd/viommu: Allow driver-specific user data
 for a vIOMMU object
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
 <7031ae5ab6f625e73dbd51b074c2ff8a9923c731.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7031ae5ab6f625e73dbd51b074c2ff8a9923c731.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:57, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
> user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
> it in via the viommu_alloc iommu op.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

