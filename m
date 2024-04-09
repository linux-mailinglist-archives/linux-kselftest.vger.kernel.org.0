Return-Path: <linux-kselftest+bounces-7467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D789D2B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA92839FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBD762C1;
	Tue,  9 Apr 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyeQe9HU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820E537E6;
	Tue,  9 Apr 2024 06:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645565; cv=none; b=PFgr9f1M1E+8gdT5aYI5EE0FLQEHaRD203y80+CzmBVvWPxw3GVI9Sq2rN6MUTfj5rfXhC0vrxOBnOZet4ePNRsTwqTotx9tc08atvEM6rZ6wZLq6rSY1IC9fVF+xo+rDuYosjT5I8YTyIibm1LwGIt02rrxJQ1qADFM3wCpurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645565; c=relaxed/simple;
	bh=Zle6FAHr+wtJCiFQxUsaRDq7UJ+UY3tgUpSmO7Qbp7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EbatQSdffTm5YLO4z8KLzNdA8f2ok+LPc9MSRz+R1BkvgC0+7K+j9wiXn3ljRuTfeIiXDLxxqrO+8wQfQmQkaKLU4UMjvz35sbv2uzCIcomR7pGsp4ZHCsHNhmm75w1jO4u8FkXG9NqZFduKCCo850dGZ4HAbjfzMxZQdf/VTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyeQe9HU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712645564; x=1744181564;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zle6FAHr+wtJCiFQxUsaRDq7UJ+UY3tgUpSmO7Qbp7M=;
  b=XyeQe9HUG31AKvMYHggYeANmWOmoH5Wgyj9/bPVOJd6kT20hqyPKlcQ2
   SSta4BqXfaXZ0jh6pPq5J6mFinmasS90p2MeYUF/UYzpjGCBx2YxMlkrb
   xhPaytb4CFrRJMQiD4YoHUCl2x/lfeym/xZUs7TuyS7q1Jl3O5CmIu8kr
   tMfsZdFNbLed+iF4OOSx/z7MHRsK+7vx42pD0iGF+8Mpp2nVDHhQjcHJi
   3607/vyBxs6MjVUb9f2mXJzsFM4B02Ue/Gw92SHu3/G6sVrSy8AIST6HP
   XBPse5Gz5Z8bbvMfBInxd0yg/UiBAGqgAwPh0Rjo5G933WLKVvAmy+kWg
   A==;
X-CSE-ConnectionGUID: +kEAxvbLQvaMa39NrbeZNQ==
X-CSE-MsgGUID: 4jer2gSGSnecslZPHqTEog==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7792757"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7792757"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:52:43 -0700
X-CSE-ConnectionGUID: QV3bAUOnS1Gi+AaB9c/ZEg==
X-CSE-MsgGUID: TqDHlEfCS5CC6TUhVnmpVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20157423"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:52:35 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>,  Khalid Aziz <khalid.aziz@oracle.com>,
  Henry Huang <henry.hj@antgroup.com>,  Yu Zhao <yuzhao@google.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Gregory Price
 <gregory.price@memverge.com>,  Wei Xu <weixugc@google.com>,  David
 Rientjes <rientjes@google.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Muchun Song <muchun.song@linux.dev>,  Shuah
 Khan <shuah@kernel.org>,  Yosry Ahmed <yosryahmed@google.com>,  Matthew
 Wilcox <willy@infradead.org>,  Sudarshan Rajagopalan
 <quic_sudaraja@quicinc.com>,  Kairui Song <kasong@tencent.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vasily Averin <vasily.averin@linux.dev>,
  Nhat Pham <nphamcs@gmail.com>,  Miaohe Lin <linmiaohe@huawei.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Abel Wu <wuyun.abel@bytedance.com>,
  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young
 for force_scan=true
In-Reply-To: <20240327213108.2384666-2-yuanchu@google.com> (Yuanchu Xie's
	message of "Wed, 27 Mar 2024 14:31:00 -0700")
References: <20240327213108.2384666-1-yuanchu@google.com>
	<20240327213108.2384666-2-yuanchu@google.com>
Date: Tue, 09 Apr 2024 14:50:42 +0800
Message-ID: <875xwr81x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yuanchu Xie <yuanchu@google.com> writes:

> When non-leaf pmd accessed bits are available, MGLRU page table walks
> can clear the accessed bit and promptly ignore the accessed bit on the
> pte because it's on a different node, so the walk does not update the
> generation of said page. When the next scan comes around on the right
> node, the non-leaf pmd accessed bit might remain cleared and the pte
> accessed bits won't be checked. While this is sufficient for
> reclaim-driven aging, where the goal is to select a reasonably cold
> page, the access can be missed when aging proactively for measuring the
> working set size of a node/memcg.
>
> Since force_scan disables various other optimizations, we check
> force_scan to ignore the non-leaf pmd accessed bit.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..1a7c7d537db6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>  
>  		walk->mm_stats[MM_NONLEAF_TOTAL]++;
>  
> -		if (should_clear_pmd_young()) {
> +		if (!walk->force_scan && should_clear_pmd_young()) {
>  			if (!pmd_young(val))
>  				continue;

Sorry, I don't understand why we need this.  If !pmd_young(val), we
don't need to update the generation.  If pmd_young(val), the bloom
filter will be ignored if force_scan == true.  Or do I miss something?

--
Best Regards,
Huang, Ying

