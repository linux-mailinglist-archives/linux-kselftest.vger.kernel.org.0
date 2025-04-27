Return-Path: <linux-kselftest+bounces-31735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F9A9E019
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 09:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3027F3BBB22
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62E2417D4;
	Sun, 27 Apr 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiuJCj6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DD1CAA4;
	Sun, 27 Apr 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745737199; cv=none; b=HQgNFqFVWobKKU1BYhjjEWkFIQC/6/z1RCIiPjLlnwx5jS5pHBWoEind7YNpPrybH14Z4JZYyhchTlRRdJSurnOw9nfVzvY34rMxhoo3WW+uyebVFlOcAHa+PL3sv5c0exl4VP2SKjECUunFm3foiIaPHJydHSJt+fL/F9p1rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745737199; c=relaxed/simple;
	bh=WPVNiPXysA+ZKbcBuVxOUqy7B0r28vdmFSIesJvE8b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLbKQrx67SoIDSBdOVlcGo0luYt3ruX+cC+y4eJtRKB02/hIJAtfTOAroC8mAT4SjI8XxLK6J5mkU4Bfb4Wd9idDhxkoCvvqMrJx4qE5SWryoAGH2GaO/zUYP+ZJHeLDHmUb0foZw4/gX/99k3ntSmKgfJA4w+uNKKGuV9GtObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiuJCj6s; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745737197; x=1777273197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WPVNiPXysA+ZKbcBuVxOUqy7B0r28vdmFSIesJvE8b0=;
  b=IiuJCj6sUEdUdqrXmghiZw5SNqOZF8xqpg5/DwJ89XH4mR42KWCOGlws
   R9Z+4yF4mFTBsHvzQXDRtcxFXwNJ4lor9cSrswJyh6/np+zSLsao0wZNE
   MgvvlAX8X4mKkLVafjFI5GGrQHLdydUF7mxGeR0pAomd/WlP7kSplt6j5
   JPS8HoLT49IGjEVD9sO57qrQOWy4OSAL/TCASwtFYotlZkKUnvXcnpRrM
   XhbJepYa26l7bW4X8sZqGklMqXuvv76U5oj9eefo5c4Gu3oCxPMZh8ot8
   FH9gtV0+097gpSs7ayfjSeMVBsf/UJv7SoEFtFxKXE7m1QcC/lVPRbb4s
   w==;
X-CSE-ConnectionGUID: HkDl3RIyTlmjIwFnB7sf+g==
X-CSE-MsgGUID: BFEFsiaZRwOxoqNxwc1Tjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47230524"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="47230524"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:59:56 -0700
X-CSE-ConnectionGUID: d1ZTnjH0RQyh27Uc3LKjrw==
X-CSE-MsgGUID: v/r5yexURzibspAZ8Nkryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="138394240"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:59:49 -0700
Message-ID: <9737606f-d3af-4c20-b1ce-7c705a7c8590@linux.intel.com>
Date: Sun, 27 Apr 2025 14:55:40 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/22] iommufd: Add iommufd_struct_destroy to revert
 iommufd_viommu_alloc
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
 <3d8c60fe9f1cdaecd59ce3e395eb6ca029ca8ded.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3d8c60fe9f1cdaecd59ce3e395eb6ca029ca8ded.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
> if it encounters an internal error after the allocation. So, there needs a
> destroy helper for drivers to use.

A brief explanation or a small code snippet illustrating a typical
allocation and potential abort scenario would be helpful.

> Move iommufd_object_abort() to the driver.c file and the public header, to
> introduce common iommufd_struct_destroy() helper that will abort all kinds
> of driver structures, not confined to iommufd_viommu but also the new ones
> being added in the future.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

