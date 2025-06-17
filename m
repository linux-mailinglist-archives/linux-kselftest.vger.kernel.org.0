Return-Path: <linux-kselftest+bounces-35163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8BADC067
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83840188EF71
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AC217F55;
	Tue, 17 Jun 2025 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahzXS8Sg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D251E008B;
	Tue, 17 Jun 2025 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134272; cv=none; b=e7B7xo9F7kDGvGe9OOXlzLR/lKaAilfIvdd9XKFpRwpQVhAmYYWjqNijLD5lClVcmYXqj30vWmtwm4UqOfcAwKWlkCQWtGWxce9wPGFx39/w7UTpIRh0SQOsWOjCo6waKYlG+6EAWi6Nh7nInynq8IEENU3naa/h3ar5s1b39Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134272; c=relaxed/simple;
	bh=hS1jLez6pg2f2TjhjY9W1XKul5ilJirXcpZ9vDFaRGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwY3Ug/NBwgQzAkHk1bUWg87QpdaR1pMU6p5RyH49ZcUYjjTtm4kC7cRAUvleY6JFldJFKNrkmPMULU3ceKiuA5uDDteGYZSpQd+FerEYaWD5ztpG0ripdaZhyet8G3a3JbrSfifuk9FEU87UOFKUC28sB1C9EX8SI6+zWIaMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahzXS8Sg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750134270; x=1781670270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hS1jLez6pg2f2TjhjY9W1XKul5ilJirXcpZ9vDFaRGE=;
  b=ahzXS8SgbcC/OFnLD/sR7e5uKx+WsU5AdW1jFY2GVsRkvFZ9jFNS9NNl
   g8TZmb2CfLQP1aUT85u26KJ3vNoNm4D50cgJcwS32leaOLmGweGcaFkrs
   7kS2Ej5XAJlMhZSUEBgratyi9D5M9LsDc/x4Np77lmR5n0qAv20feEMg9
   nzyZNZy2h0U5lhOoVG35hO2+cqgUsR2T34BCeSpT2NTMsQNiF8lbFbfnL
   7V9W8dblkf32/G/VUMf3zuQ3kgA2WjuPhsaVW9794jPJWQUGmDkdsdN+F
   e1LGvDoUM6dNRBAJbFrVzQuBYr1BHIIIh0F8+5KMqdVhpjESd1RtAglKr
   g==;
X-CSE-ConnectionGUID: qoTuCe63RpiN+8Tfxwdyog==
X-CSE-MsgGUID: Dyg5ZuYyT2GSIdQMwRszog==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54909366"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="54909366"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 21:24:29 -0700
X-CSE-ConnectionGUID: osI7mkNFQI24GZf/sZPogQ==
X-CSE-MsgGUID: 9yvR0dzZRHWogZ9sJL5FrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="153956949"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 21:24:22 -0700
Message-ID: <c3842cc4-f057-4ab6-b0bd-f7742ca7c645@linux.intel.com>
Date: Tue, 17 Jun 2025 12:23:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/25] iommufd/access: Add internal APIs for HW queue
 to use
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
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
 <64145b184a0fa7c9b60532c9b475a51625edb77c.1749884998.git.nicolinc@nvidia.com>
 <20250616133719.GC1174925@nvidia.com> <aFDSNYOTToFSbFA2@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aFDSNYOTToFSbFA2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 10:25, Nicolin Chen wrote:
>>>   struct iommufd_eventq {
>>>   	struct iommufd_object obj;
>>>   	struct iommufd_ctx *ictx;
>>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>> index 9293722b9cff..ad33f1e41a24 100644
>>> --- a/drivers/iommu/iommufd/device.c
>>> +++ b/drivers/iommu/iommufd/device.c
>>> @@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
>>>   	if (access->ioas)
>>>   		WARN_ON(iommufd_access_change_ioas(access, NULL));
>>>   	mutex_unlock(&access->ioas_lock);
>>> -	iommufd_ctx_put(access->ictx);
>>> +	if (access->ops)
>>> +		iommufd_ctx_put(access->ictx);
>> I was hoping we could null the ictx to signal internal? That didn't
>> work out?
> access->ictx should be NULL for internal. It should have been:
> +	if (access->ictx)
> +		iommufd_ctx_put(access->ictx);

access->ictx could be treated as user ownership token. If it's NULL,
there is no user ownership, indicating it's owned by the kernel. This is
the concept here?

Thanks,
baolu

