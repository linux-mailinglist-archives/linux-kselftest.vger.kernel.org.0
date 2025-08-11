Return-Path: <linux-kselftest+bounces-38656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3FB1FF7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9745D3AE967
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407052566F5;
	Mon, 11 Aug 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kwt7cLD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22429CEB;
	Mon, 11 Aug 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894753; cv=none; b=SSacfNLjWZ7STj9xb701E3/YF3wFJz0tCfH+c4CHCmRUJ0hEXnb8s2M+83FDL3NvB7QF3m2anWVnMRfiNbS3Fh1wqWDRRYrwS3mVDoBoKKrd4No9kv/f0EuhaE9jQSqRMjZ56Jj+r1SjySkaX53d0f8pdAuHKMG8U8rTDtVE9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894753; c=relaxed/simple;
	bh=4NZNDTgDD32CAHYuhSESjLaQNrkHAvWdq6vftYv+3KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKfspJm3KNKbloJn8p+xcfSPfDzcVb86ar2QCFZzEnInSZw0q/BoPA3USNf5KxYGhuOGsp39iHp+I5JUAtchdc4q7cTi3wIc4lbE7F8SEdTCzgKC1cSbkUdRKrNtZSueRBMk4c5WCqfe6KZ4u8W7pNacHhc+goR2ENJ+pqaSIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kwt7cLD4; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754894748; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tU05oYk7AfZHOTyMB3YXf3i+Q/YA1x3QXxmOIdL0jBs=;
	b=Kwt7cLD4DZHC4lx7kbbJtzcywj89IUE6VTYDK65KU9m0g7e0lthFCzc/7MWOyfSGX2iEySeg/ngYeGzEKcwOLvTdXkinX//6VKTrOmxH7YzIhZlY46FbGXo+f/9oOEWxweRoMABHgNI0qv0VfSVDifQUmOz7XM+EhUNA5wToP14=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlPK.CB_1754894745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 14:45:46 +0800
Message-ID: <4c60ece9-ed21-4a09-b1c2-5f59074d57eb@linux.alibaba.com>
Date: Mon, 11 Aug 2025 14:45:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 wang lian <lianux.mm@gmail.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-2-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250808190144.797076-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/9 03:01, Zi Yan wrote:
> They are useful information for debugging split huge page tests.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/huge_memory.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..ebf875928bac 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		goto out;
>   	}
>   
> -	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> -		 pid, vaddr_start, vaddr_end);
> +	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
> +		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
>   
>   	mmap_read_lock(mm);
>   	/*
> @@ -4438,8 +4438,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>   	if (IS_ERR(candidate))
>   		goto out;
>   
> -	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
> -		 file_path, off_start, off_end);
> +	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
> +		 file_path, off_start, off_end, new_order, in_folio_offset);
>   
>   	mapping = candidate->f_mapping;
>   	min_order = mapping_min_folio_order(mapping);


