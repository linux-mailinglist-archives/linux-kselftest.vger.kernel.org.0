Return-Path: <linux-kselftest+bounces-20363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C29B9A9732
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DD71C21B91
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052013A87C;
	Tue, 22 Oct 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrXdjWA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA913A416;
	Tue, 22 Oct 2024 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568462; cv=none; b=pQoLhQKWE6tEAkjUiRHmsIF10xk8TvtTpl/3PFL588J9+u7jeXRbxUr+y6XruUtCQztn3kfojX0Cp4dQwGVE3slNaIhtYQR1x+mWMy3vFBDrAlHFpb4jqO+of0051HPKJBL/cCVveugZ/oBoJg7IF9eUw64CT3P0DriRmj1m+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568462; c=relaxed/simple;
	bh=oZ/sHu2Aj21HZjujmiwtCdiSKjniswQaqv0Y3l/OwzA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OJD6En+FT9j0lv+rvyLq2Vl4KkWObPcn9RS2I1LmWqYfdsSD/tmqp3lfnR3LJvcYnz/FqZ7NPdJweE2f+x9if69nbPyPH3bxu8vgCGn87t7O9lSy61kKfXiP2s29B7WgG1HhXFdAb769MMd5kuE83C/cRqUkjF7wwyAutvklsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrXdjWA+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729568460; x=1761104460;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZ/sHu2Aj21HZjujmiwtCdiSKjniswQaqv0Y3l/OwzA=;
  b=jrXdjWA+frD16UZaP6COLG+CMM5yaJ+aEHIJR058MjUb6EUl5HUHRcJ1
   fYTWxwV5OnxwD0oGsD5Dr0oxMCvuAuJMIxbbmCh5D3TV+oCMG4mV2pKVV
   yq+E46PNtchTz8/TL+YMSGkoWzkzaJHF5KcN5pYS66940wC3SCv5Lm0JR
   xAAFtRgmH/njbYMmRWNoLzIENlmb9shQXc17yHjOaDagsPcCN81atxd41
   f7FUylczkYMTTliPuQK3fqufnh303dpEXWeo7s5g1U+nuHDhkO1D9E1wV
   Bq/L3mJcRXaNLX8+6+OR3oYinua6d8+RhZwY6Vt/QZa572dhP3iLXceA6
   g==;
X-CSE-ConnectionGUID: 3FTThUABSYOhAfBaV3ktfA==
X-CSE-MsgGUID: ehBU+kmJR+SQlzldYmOWFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="54486093"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="54486093"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 20:40:19 -0700
X-CSE-ConnectionGUID: 47iCjRLnQHCXnCoWQay3Jw==
X-CSE-MsgGUID: Qxh8VIPkRp+3Cb9ZbOBmLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84802562"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 20:40:14 -0700
Message-ID: <1886d618-5539-4108-96c7-afebb65b2c80@linux.intel.com>
Date: Tue, 22 Oct 2024 11:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, aik@amd.com,
 zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 02/14] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <2404ee8d2bd97e7b8c4c45b24cf52b157fb0b635.1729555967.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2404ee8d2bd97e7b8c4c45b24cf52b157fb0b635.1729555967.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 8:20, Nicolin Chen wrote:
> Introduce a new ioctl to allocate a vDEVICE object. Since a vDEVICE object
> is a connection of an iommufd_iommufd object and an iommufd_viommu object,

nit:

:s/iommufd_iommufd/iommufd_device/g

or not?

> require both as the ioctl inputs and take refcounts in the ioctl handler.
> 
> Add to the vIOMMU object a "vdevs" xarray, indexed by a per-vIOMMU virtual
> device ID, which can be:
>   - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
>   - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
>   - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table
> 
> Then, let the idev structure hold the allocated vdev pointer with a proper
> locking protection.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |  12 +++
>   include/linux/iommufd.h                 |   2 +
>   include/uapi/linux/iommufd.h            |  26 ++++++
>   drivers/iommu/iommufd/device.c          |  11 +++
>   drivers/iommu/iommufd/main.c            |   7 ++
>   drivers/iommu/iommufd/viommu.c          | 108 ++++++++++++++++++++++++
>   6 files changed, 166 insertions(+)

Thanks,
baolu

