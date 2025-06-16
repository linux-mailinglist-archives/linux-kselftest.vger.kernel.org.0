Return-Path: <linux-kselftest+bounces-35053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E3ADA903
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06247162634
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD51EF0B9;
	Mon, 16 Jun 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDg+dkOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8B1DDC28;
	Mon, 16 Jun 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057965; cv=none; b=dClvq7TU9ZG8rFMNnkEPJSKRqmuifvI/YpA/ou00yHR8jve6GFjClXRnDOcKAIot7iQPvB/+UB385fhwlyAXvjwEsf3xXdZ5y9oYNq0XLZB15Bi9/rmCb764ZLOhA89MDzxUkZvXKzm6G+G/gfZVM5nyCJMAD3gGtlBkOjRlyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057965; c=relaxed/simple;
	bh=xacBKMgmFTMZBZEnYG/hW2BtKPaY7xU5btWyaSE3iwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci4VfOpwpuRKGb3idcLQazuARHsUwbsHmodtyREZN4rQI5P9Z32VBXo6owAD+5LFdFPzjsB4sfZPDTvczO3498WlOqdBgDQ5ZsGI+vAYmfZ5QvOx78rxDluUZPs9ftYPL+mldiXLE1v5XrTyUiHgPdlCM4JDKzvuQAE951gqWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDg+dkOh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750057965; x=1781593965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xacBKMgmFTMZBZEnYG/hW2BtKPaY7xU5btWyaSE3iwY=;
  b=CDg+dkOhbfqY7TtzNt12dHZ3ELBr6kszN7GmbxTuD/ShEPSHGIo2lsTp
   izH7WJvClOp43UkEspY8dLHCcRmQjyviggnebL7yFCdoBHj+lONWurh85
   2lUydU6xa8Ajida/0gMMAnOsbl+wQHDQYtNfWaNrVz/qrGX8Z9oJIP2hn
   pED3Mrd6MU3JHIblYpddgv5efy1lUFBAs08snjTUuVyIhJ8asJbNsaXxr
   XL6LZSlCTl//e9ilwAnLo1UYYVSb4HCNwRE+XL8VJoKohk3shel8NO9Q3
   /GnE5Ehh7kU5jgd27tDUZpPJS1jJ87pc5Z0pZUdPCkPg6bnimjeEMiVCH
   Q==;
X-CSE-ConnectionGUID: JVmGsGTPQmWsn9UmlKGuUw==
X-CSE-MsgGUID: MEfToax2RMqG5TA41DkGBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="55866585"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="55866585"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 00:12:44 -0700
X-CSE-ConnectionGUID: HjGOjZ05Sou9BY7TtQfcPA==
X-CSE-MsgGUID: /QmppINgRhqjZEZzCyDuPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148290800"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 00:12:37 -0700
Message-ID: <8b57d3fb-bc0c-4ab6-8a53-22d93718b422@linux.intel.com>
Date: Mon, 16 Jun 2025 15:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
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
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com, dwmw2@infradead.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/25 15:14, Nicolin Chen wrote:
> Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
> a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
>   - NVIDIA's Virtual Command Queue
>   - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers
> 
> Since this is introduced with NVIDIA's VCMDQs that access the guest memory
> in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
> that will create an access object to the queue memory in the IOAS, to avoid
> the mappings of the guest memory from being unmapped, during the life cycle
> of the HW queue object.
> 
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

