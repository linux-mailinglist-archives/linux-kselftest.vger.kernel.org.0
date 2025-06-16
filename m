Return-Path: <linux-kselftest+bounces-35050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1233ADA8AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F6416B9B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B871E5B69;
	Mon, 16 Jun 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyYWaqXu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832B1DD0D4;
	Mon, 16 Jun 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056917; cv=none; b=ZK6tJtH/Pp7ldyh6VgwI+AXinc8ecQ+QKQQFTuFIaom5DDpHpnZAJUnYF//vhcMla+fCWgATogoLn6VZB7PujZyeoLNDg5MYYTYlerHN2/D87qpWoE0B2sZzLlfnhhWd/oR2rEEMxi5TRwwufRCDfiIX/nHKG6Wxl3zxx/MGoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056917; c=relaxed/simple;
	bh=JzhPaAJq3SE1ySzHxtViTC3KuZDIosj/LQ8YKkF7X1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHHD3S8XKanIIplen56GJWwOB7S5RrCYV/QUzJXLuF6tv5rjALUcsWvBkWMF9+Iz/zSYnK8+XOmJQ8b8PrOUphbOnNitbchhW90ZPJdtX/7KwGPUZi+PONySBNS2bi03LDSpJfpOl3xVwH8pzfkxUlN11PWQBcE1Q/4uT2Vl584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyYWaqXu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750056916; x=1781592916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JzhPaAJq3SE1ySzHxtViTC3KuZDIosj/LQ8YKkF7X1Q=;
  b=cyYWaqXuzxQGoEnk6FkXdDDj6qA2SvmAUQ8BqdrJJrlwKUBQwRyGsgZb
   qg+4uDMw8daZyiAWzuuyNJNU9bJNLHjImemojOuPIJBnI61IBJSxy+R+s
   AeZc7mmmhIBb99FIjg17Iudw2esSOx0mkkmuvl/RxZe3d4McU5yvu62sI
   jVqOQC0Kjt3ii4F0M1Dg4aB7R64HIXQZcOdaZY6SWGzGGkrQg5/133ADv
   JjVAh4jqRBBcfjJioCoA5ke+m18yy8rTKZNAhZ8QyGDL8MIUZjRzyzB+3
   cB6r1oZ2JqflzsM3sHrJCrFSY9KTp0dSifPqD2Gl/g0C2wKF0slqo3jqI
   g==;
X-CSE-ConnectionGUID: iMKpV/ppRhafhABIDZU6Qg==
X-CSE-MsgGUID: h5rV8wUgTG+hA6QjQEb8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74720822"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="74720822"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:55:15 -0700
X-CSE-ConnectionGUID: eWT5UpgTTxO6CbYgUZWzxg==
X-CSE-MsgGUID: xOYLWIvfQEeVOE3EP2VS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="149298915"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:55:09 -0700
Message-ID: <b9a7ae65-edc6-46e9-bea0-163a51459884@linux.intel.com>
Date: Mon, 16 Jun 2025 14:54:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
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
 <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
 <aE+976F9zPsjtfry@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aE+976F9zPsjtfry@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/25 14:47, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 02:12:04PM +0800, Baolu Lu wrote:
>> On 6/14/25 15:14, Nicolin Chen wrote:
>>> +	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
>>> +	    !viommu->ops->hw_queue_init_phys) {
>>> +		rc = -EOPNOTSUPP;
>>> +		goto out_put_viommu;
>>> +	}
> Hmm, here it does abort when !viommu->ops->hw_queue_init_phys ..
> 
>>> +	/*
>>> +	 * FIXME once ops->hw_queue_init is introduced, this should check "if
>>> +	 * ops->hw_queue_init_phys". And "access" should be initialized to NULL.
>>> +	 */
>> I just don't follow here. Up until now, only viommu->ops->
>> hw_queue_init_phys has been added, which means the current code only
>> supports hardware queues that access guest memory using physical
>> addresses. The access object is not needed for the other type of
>> hardware queue that uses guest IOVA.
>>
>> So, why not just abort here if ops->hw_queue_init_phys is not supported
>> by the IOMMU driver?
> .. so, it already does.
> 
>> Leave other logics to the patches that introduce
>> ops->hw_queue_init? I guess that would make this patch more readible.
> The patch is doing in the way to support the hw_queue_init_phys
> case only. It is just adding some extra FIXMEs as the guideline
> for the future patch adding hw_queue_init op.
> 
> I personally don't feel these are confusing. Maybe you can help
> point out what specific wording feels odd here? Maybe "FIXME"s
> should be "TODO"s?

Oh, I probably misunderstood the logic here. For both hw_queue_init and
hw_queue_init_phys, using an access object to pin the pages for hardware
access is necessary, right? My understanding was that pinning pages is
only required for hw_queue_init_phys.

> 
> I could also drop all of these guideline if they are considered
> very unnecessary.
> 
> Thanks
> Nicolin

Thanks,
baolu

