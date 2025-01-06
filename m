Return-Path: <linux-kselftest+bounces-23931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF17A01DDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C3318852DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D91126BF9;
	Mon,  6 Jan 2025 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esKguS4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB2224D4;
	Mon,  6 Jan 2025 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131963; cv=none; b=uy8wSAtiRfG4IaL73tq+7TKJzo9sM6g/34WlcYBAc9zjhzo0+UHfNJ0ls7t4FMOiKg6qTTQlg8mIoQ4R/Rga8Mu5+WlMZaJoDRYqykFjX/4pVUabao3TeTX4UnS4MNBI0CnJ7BEmeb4+VrN5xmJLTBI3fWPYRe6AWOu1mS2UvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131963; c=relaxed/simple;
	bh=YlzyZ5VRctbcN5/cUfhWSOqbXSF88B8tOI+3HQdqnUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efyP9thl5Qc98EOS6RiK2jertcJKMJF0YyfjVAtHObNqUhWurRRYcf9DWfsPkAgSYAoSBM7KN1xeb23pNds7Ao3NAPlx7cQOB3Y+1Su9mTDPdajc4oH0krhNMDQJjzvqGjm/7rY9cWCrpygcsWps4njnQ8HIwMaNWhivmIYM3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esKguS4I; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131962; x=1767667962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YlzyZ5VRctbcN5/cUfhWSOqbXSF88B8tOI+3HQdqnUQ=;
  b=esKguS4IGyyUBgDpIkRgt9SnLDYQRz0H56sEAHpJ864Qx4lMpl5lEyDd
   AJWfhEo6J8NBjQIMwX+XGYmOCA7AHtHBJf7jfIK1irz/xQTWUABvgYs7h
   FeQXv/fvz7ciXzAxrN6s5/Wsr0zd0TA0hBeNqUeUrKw8Sboqt/JETG3qN
   mwVs9R7khO5/NvqMM12F9DDj+g2o7HFI0uwi0/pP+/IvsMttLA/7DJYJ7
   b8TZbqv5Wyc3Y0oePHQ/oZCl2LwwQGinBSFhus5kIHQPwm7rtl4sKxWhm
   72asNJAQwC6VBTGBVodTLYv/UrDrCVVam6lUcLJDJAbmPJdoRsTCBs0at
   w==;
X-CSE-ConnectionGUID: r0uqZ33jQ32sw3dGfz63gA==
X-CSE-MsgGUID: OqINFr5ZQ9OR7Z4KHQ20kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="35575011"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="35575011"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:52:41 -0800
X-CSE-ConnectionGUID: M3d25IsrRq+MSMFKSrI+gA==
X-CSE-MsgGUID: fVeYsa7nREWJXtqMK1sngA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103191699"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:52:36 -0800
Message-ID: <ef45763a-f64f-4efd-b3a2-f019bd791e94@linux.intel.com>
Date: Mon, 6 Jan 2025 10:50:31 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <d0edfde78e75b6941589392e618f6d43b3f10e6b.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d0edfde78e75b6941589392e618f6d43b3f10e6b.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
> provides user space (VMM) another FD to read the vIOMMU Events.
> 
> Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
> vIOMMU can only have one single vEVENTQ per type.
> 
> Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |  58 +++++++++++
>   include/linux/iommufd.h                 |   3 +
>   include/uapi/linux/iommufd.h            |  31 ++++++
>   drivers/iommu/iommufd/eventq.c          | 129 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/main.c            |   7 ++
>   drivers/iommu/iommufd/viommu.c          |   2 +
>   6 files changed, 230 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

