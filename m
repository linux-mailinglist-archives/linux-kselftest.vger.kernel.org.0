Return-Path: <linux-kselftest+bounces-31736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8CA9E066
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 09:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9117DA42
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC822459D1;
	Sun, 27 Apr 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ow5hOO3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635B10E0;
	Sun, 27 Apr 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745738790; cv=none; b=JuknIHekORO42Qr5LTrrYTWUueHVuVH2y5lpZk7aYZrhbrYkZ5/LZIw4FDLSzw4KFf9K4CfXzdliV1/N2kwTlAk7vNan8fVHye46HSZ+sBlrmsmka41Mx4QmxUG4HwcE36vEk9gLi8ajG727Y+ufhEpKKdDYXY+1+jFj3D8csxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745738790; c=relaxed/simple;
	bh=Jmn+u6fFBrsun9XakIeVgT39XGKP2ToxwISS/MEt76w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZ16HpEF3FsPMKyaTKZuGPS1TWlTSW6/kH+eDlYpYi6lpcQ+eqI1IBL6+Yx+99KlaeMRZNGqHLdFGK/KSnnZ3DtPoYEzFkcThEnEbAlfse8NQqSl4uK9SuHBUCXI6M0rL0nXuBAzdhn2fd3ZxVt4rYB97QEJuUk1Oe9F6WNhNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ow5hOO3d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745738789; x=1777274789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jmn+u6fFBrsun9XakIeVgT39XGKP2ToxwISS/MEt76w=;
  b=Ow5hOO3dYdPH0bm9AffH6yeAFD7CCB0RIYwBaD2sFblt8KuyX2XRiK8t
   M63DFWJ2N1cU7Gi4dOBQyCdq+sBMmrrDtO6U24dE5FVSUY2C43vHTadZq
   swYAasRJ6lecXN4KTQ+DdBmATuzBRoaLMirCjJK25DE1vU6ABw2IzHGht
   3DQBnyc04vtGl3oD+Zr9Qgj+EwQPb3HTAx16dowlH3JbZIbAQwiQkV0hx
   XWWpelvGb+iUpfckbXNdNS3AUV+SnnY3dh6QSCTodkglgTCvaeGIGFtF6
   MOBrgenJz10QDSIo59+a4G7CiMqKNEVGy9rxtG/jIv4/a3mfkJP9B86S3
   Q==;
X-CSE-ConnectionGUID: SkYzLka3Rden+VeSTREfmQ==
X-CSE-MsgGUID: EVpScRpuSgyfLGkk0neDug==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="58710628"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="58710628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 00:26:28 -0700
X-CSE-ConnectionGUID: tjr0bvpUSgWfm/XawVYnrA==
X-CSE-MsgGUID: OXjYL/GnT9ykpQQNpcmQ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="164217471"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 00:26:22 -0700
Message-ID: <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
Date: Sun, 27 Apr 2025 15:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
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
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> The new vCMDQ object will be added for HW to access the guest memory for a
> HW-accelerated virtualization feature. It needs to ensure the guest memory
> pages are pinned when HW accesses them and they are contiguous in physical
> address space.
> 
> This is very like the existing iommufd_access_pin_pages() that outputs the
> pinned page list for the caller to test its contiguity.
> 
> Move those code from iommufd_access_pin/unpin_pages() and related function
> for a pair of iopt helpers that can be shared with the vCMDQ allocator. As
> the vCMDQ allocator will be a user-space triggered ioctl function, WARN_ON
> would not be a good fit in the new iopt_unpin_pages(), thus change them to
> use WARN_ON_ONCE instead.

I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
with kernel call traces in the kernel messages, which might lead users
to believe that something serious has happened in the kernel.

> 
> Rename check_area_prot() to align with the existing iopt_area helpers, and
> inline it to the header since iommufd_access_rw() still uses it.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.h    |   8 ++
>   drivers/iommu/iommufd/iommufd_private.h |   6 ++
>   drivers/iommu/iommufd/device.c          | 117 ++----------------------
>   drivers/iommu/iommufd/io_pagetable.c    |  95 +++++++++++++++++++
>   4 files changed, 117 insertions(+), 109 deletions(-)

Thanks,
baolu

