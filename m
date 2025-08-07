Return-Path: <linux-kselftest+bounces-38439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C29B1D2A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA73118824B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082D21CC57;
	Thu,  7 Aug 2025 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TemzH1NM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8621CA16;
	Thu,  7 Aug 2025 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549415; cv=none; b=XlbRgMsw0fhpdomph/E8ja/dnuK62K3Pk04Fxn7Z9w5/EL3ZTJFUzfq2C5i6XiFTPVhAuqKpceDRHcMP2hs8afkV3arEU9K4dfSD+WbKog+OKggvx/YDhIEaiJA6DN1ORVgBnMLmiz6bK0p2gPF5RODtHb+Ymf2kfWVhuLHFoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549415; c=relaxed/simple;
	bh=UTCRNbFebYsFUQq9KxClYgG18bhqsZibjXtQ+clJ9Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHpROR7yKmEAndP9r39dw9rvWMk5FGxv4T9P573hL3a3P3dfoByXLCS1IJypaGSvBP7BaD1UB+/42lhyUgFKQQATD1VfjuNqTU0wMAvpchK7OZ5H0dmVj5AHCDVQXOAoEYj6LxK6MBso9hzTxCCOFbGH89ZRGiRo/Eag5Hx29VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TemzH1NM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754549410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Wxh0zWaZTvn4TuSOhxTDprJHDrFNRGhtdShEFdmwNCY=;
	b=TemzH1NMURb+gEl1OOxmxPTvsId9our25lEAqogh/cH+4NmRoNj6YA0Sdzx61sqLMLMEgsQIhwDOuPQzx8xbQ9PxIRSgkIqI445PJnVpo1F70uydMrK8htboBe5a05eYTZ3RoCde5FeJfI/Zg+Dl6J9tB5voU+pHZKMe+UVD5fo=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlD2yKP_1754549407 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 14:50:08 +0800
Message-ID: <595a070c-d524-4ecc-9999-382f3432102d@linux.alibaba.com>
Date: Thu, 7 Aug 2025 14:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-2-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250806022045.342824-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/6 10:20, Zi Yan wrote:
> They are useful information for debugging split huge page tests.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/huge_memory.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..8a11c2d402d4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		goto out;
>   	}
>   
> -	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> -		 pid, vaddr_start, vaddr_end);
> +	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset %ld\n",
> +		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
>   
>   	mmap_read_lock(mm);
>   	/*


