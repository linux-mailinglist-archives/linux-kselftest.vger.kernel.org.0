Return-Path: <linux-kselftest+bounces-23932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C26A01DE2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4BF7A1FEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171D15CD79;
	Mon,  6 Jan 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTv6qivf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8F78C6C;
	Mon,  6 Jan 2025 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131990; cv=none; b=lv7iOPZ2i7i5KGe82CshpZk+OeE3QuFIs01yrrmp+tEUY3r3DkNnUnbmHabIHih6P7HRQJu2v/dYv/8YWF0ivGHeQTRVDRjjkSA5voWAxFkF2F77Lx+yDQZ/5SIZUrDThqYSOfPzilBvbOTNVv3NYOEaXRS9dZhlhMnW6vQR5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131990; c=relaxed/simple;
	bh=WJ1lnQpnjzSENphJqAYllxPMKCggrwJ0HwxYTWlZgOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWWPvFH0NtbLD3USjB/CwC1+CnTOQwR04XUboaWCQZdoii2VhpvXke4aD7aS2DQy5yIkCfppX6TgVMjdoR1W1tHSbjHhRpSefZq8DnTKPf/GQWJ3FeZ1BShQSWbfzfBItGrB7bLTDj+y2hDygBEpxFvGOP4NOw75ilwOh/7jLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTv6qivf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131989; x=1767667989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WJ1lnQpnjzSENphJqAYllxPMKCggrwJ0HwxYTWlZgOE=;
  b=kTv6qivfCEJ3MzCCPhp9W+s3OOfC+xzOq+G8B4QRDX0GhA/AyrT5RPa4
   QC2Yab7Tx33Cz1chyUPWf+uoVEHTFsjTipPYqyU7hyETEvxUrIVi/FBPg
   16WYhVaFwpplFFrfN+i2c12rVXdKfU9QkEt5e8XdOeRxxc/TytYRbfCBx
   ws3FQn8BoKXWjjOnLlWxU3P+K1iHOZQS8oefigNsnn88ChixxKN4s6BtT
   1kZReikbYIgDPIpIlhqyFqEnA9EYMbTSqlFDUsCZIAZvSPyFE7cn+Mlf9
   Sv6hRD+IeWT1w3XKCh0rplCIkkb8KATKLeR7NODCXit/VWPpyExfLUFXe
   Q==;
X-CSE-ConnectionGUID: UahkN1oqSt2o0dHVU+swuQ==
X-CSE-MsgGUID: /D9j3vJqSCe20nk9FcuDww==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="36172787"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="36172787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:53:08 -0800
X-CSE-ConnectionGUID: EFOsIFRfSFiwDCSH/Pl2tA==
X-CSE-MsgGUID: 725LiNAKS8SO2bQgECxPQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="107172729"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:53:03 -0800
Message-ID: <4df4d3cc-4e70-42a6-92f6-58e51b5d1048@linux.intel.com>
Date: Mon, 6 Jan 2025 10:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
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
 <e29a931521365e7953cb993a61dadc72a53b66d9.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e29a931521365e7953cb993a61dadc72a53b66d9.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> to convert a struct device pointer (physical) to its virtual device ID for
> an event injection to the user space VM.
> 
> Again, this avoids exposing more core structures to the drivers, than the
> iommufd_viommu alone.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommufd.h        |  8 ++++++++
>   drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
>   2 files changed, 28 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

