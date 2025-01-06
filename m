Return-Path: <linux-kselftest+bounces-23928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7716A01DD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEC13A3ED2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3C78F41;
	Mon,  6 Jan 2025 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpxDSCJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E87DDBB;
	Mon,  6 Jan 2025 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131864; cv=none; b=L8MHq+9vbmM8Rx3rlTgRvq7haN2iP7LVfqf4nNM/ftqt/tQcdYyLa/WmnjtYMBgWjddDyzpqxlAnnS2P5CG0EoJCeLSPp28zpOoLN0eZ78tSTiiNRiJwrYlS2KPtzS/EIslD01MRjgNftIIkv7IlrY608u2ymBgsPjGpq6+ytZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131864; c=relaxed/simple;
	bh=eB3a1yIL898tRGheJlkCWYWd7SxbOuy+3DIEeL0oQUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0QNxuO1iNiZ882yZbQMSaMMSvRC1+0+tZKLv2lCrqx27ED549X4Q4qTdA+Djl06uNy3ut1HD7w1D2FwYzasFont0SUOXi0cdTkcJhbMsava4D/j34iGx5VgU69LtlCQxU0NAiFNqDVAhhnrzbQ1qh0Tuv7tdxGxCkFo5VHhPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpxDSCJ/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131863; x=1767667863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eB3a1yIL898tRGheJlkCWYWd7SxbOuy+3DIEeL0oQUw=;
  b=NpxDSCJ/uH0tfQmd7Wo77QLMdeQwsvT8eCB/c1f1rGrt8R1HCW+W4YYi
   jstrsLAytO7V3ENF2WuQId2HPI5yjzzi6ej8Y232jvBl1po+Ew7iJClTf
   Ggt4tHiIFN/Q3Sf+qlvpPMmOvZvpIan4uHqNCT+ssO6zrdEDmX4QwkXRj
   EmAajwsClHmGgflD6qWDyvYfLZ/Gq5bkALQ9Rj+Yk5+777ui0CGiw2Any
   Em3AsIuj13On7Of8OeK0s5CtY+Fchzgb5Ze8Rs2dXGDSFLGPfcrJ5xU3h
   38VPk2aVgVNC/Kv5MZyj+gG5SvGineUfGovcf1EYAhKvg3KuJQ6HO/TAS
   Q==;
X-CSE-ConnectionGUID: jZdD+hrjRvOAw/WpaZsLag==
X-CSE-MsgGUID: nFF+s5F8TlmP/Zpko+1+2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="53690669"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="53690669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:51:02 -0800
X-CSE-ConnectionGUID: Voqol13QQymkWkN2Uz472g==
X-CSE-MsgGUID: bofiroglRWmtMULjORZ2WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125600122"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:50:57 -0800
Message-ID: <54b66ff2-cf9d-49c9-aa58-9051b2cd86e6@linux.intel.com>
Date: Mon, 6 Jan 2025 10:48:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] iommufd/fault: Move iommufd_fault_iopf_handler()
 to header
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
 <92a5599bddd915c049fabf4832ec8b0f0c1471c6.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <92a5599bddd915c049fabf4832ec8b0f0c1471c6.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> The new vEVENTQ object will need a similar function for drivers to report
> the vIOMMU related events. Split the common part out to a smaller helper,
> and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
> that in the driver.c file for drivers to use.
> 
> Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
> simple after all.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++++-
>   drivers/iommu/iommufd/fault.c           | 17 -----------------
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

