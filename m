Return-Path: <linux-kselftest+bounces-23930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06AA01DDA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3B188521C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E66F13A250;
	Mon,  6 Jan 2025 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjbD3kaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7723A0;
	Mon,  6 Jan 2025 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131920; cv=none; b=CvW14jk5fzqz4KQkhiqcpghrrhhpoofzfkUtFmts/SMJEssdmx3LXdoDTtyMDSCGCYkjV61Frr3bKd02QHjQS44v15W9ysj6F8NBPMsGop+oj/eGsaElGkWa1Wjrpcur3qrPuHbRNsd0FnU+myPllJTNRTHvgshekU6nadBNhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131920; c=relaxed/simple;
	bh=yg92nUqhJzU5b5Z5WgjE9KWWIe4THP7jzmQyZfctNpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaPbx5PXpqAMd/y8XuYJgC5lGNI+aiAfZrHmrqN0Z0dWVzXyYW+77J6BnioV/udRtKYuVlkqi+sKFXw6HGJVqBEUHBu2ZnQTL1ynOmxkezNyxwSgwx9WqoclGSuxgcuYtcGhOtrI8NG/DjZYC0SE1tnWm61Z3UAj3B4RjpZK6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjbD3kaE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131919; x=1767667919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yg92nUqhJzU5b5Z5WgjE9KWWIe4THP7jzmQyZfctNpI=;
  b=hjbD3kaE/dtLC4UlWUiB2FtiB/8B5z4r7tb3ouDz1u8YOg93G6ZAQ6ir
   aMX5F8gpYvgZF/w1v7iBl2YHjR+oo3fehvWL7DbhaxG7X3YHZGzGp561/
   I+LTSk/phISIhyxZQk+YJdoGTszIzdRJBXcRV2IKu9LUH3KA1HzZbDVd/
   NXFbBknpNXOGNugLbdDZyp3Jx+mKLcGlsmQBKrmZuRLQc3uha4USr2r/c
   rHyBpeadzUgDKJiIvNl5o+dCY2SvL4qkEBi6PXkQaMCSjCTOA9yjpqJq/
   JrK0GoVyCTajj5Lf5gQH72KUkJpcHHJVkSUbxre9MJ5VPmoQUMVhLFlbR
   A==;
X-CSE-ConnectionGUID: /AjEwQmjRSuFuIoC1MUZeQ==
X-CSE-MsgGUID: 7ztijGihQE+Xog8PMfll/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="35574989"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="35574989"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:51:58 -0800
X-CSE-ConnectionGUID: uz74PbeKRJCEdbLuqgEM9A==
X-CSE-MsgGUID: JMNX9CZzRaWjqBlMZHYLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103191593"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:51:53 -0800
Message-ID: <e59cbded-6f76-4533-8368-1d0f13a54c95@linux.intel.com>
Date: Mon, 6 Jan 2025 10:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] iommufd: Rename fault.c to eventq.c
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
 <de1a507d2393edc25395242d1c9b704a36f02296.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <de1a507d2393edc25395242d1c9b704a36f02296.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> Rename the file, aligning with the new eventq object.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/Makefile              | 2 +-
>   drivers/iommu/iommufd/{fault.c => eventq.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

