Return-Path: <linux-kselftest+bounces-36790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3CAFDDBB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B75E1C267CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA51DDC2C;
	Wed,  9 Jul 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AXfFJDmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BD17C220;
	Wed,  9 Jul 2025 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029716; cv=none; b=gTMVw4yPEjgUgmwL4CLFpWYcTL5BIvyKGg9lVcCHXLB/IJilrjiTzuVpq7n1j9iMR0OA/67GqDKXlZKxWy7x5dexooGSAlTYI6vGwila3qS0niVmVOSc8xI8nKQ8pdFOqWYNEoiahnZDPLB8gWG3nLnR3Ok4bC2Rpa2jifNjbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029716; c=relaxed/simple;
	bh=gjJDkwZik1R44Tl6G6J+9kYf5zhAiqNU63ssGloQAUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu98+cC8tQHcDwMJbzlLXD1+m6oEMXT0JZQ1KlxZ2yEGBJEyNIZkbbNyk/tDYZp2eLJl0iKEIL+5JLgt+GgRIg0uru3Ws97/lCJwsLfxDwilLWx+36n2+GaOHsxfKYJqVB5K7Y2k0WqERMy1eM67DYsqfFKW2rLEHdS3iwORf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AXfFJDmY; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752029710; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Igjpbs2IFvXqbYourUEIXZWbcdP5LNhfPWCOH6TZgg0=;
	b=AXfFJDmYUf+4VaWY0Cc4vlXBuCyqD9D+jMeKopOmP6Jk5p7ySKAQp8Im1WnN9Iilrm17zkKIC1otm7PiRbySp+1wL/WNiZYP4NIyW+42qBd6KQy1vFkcVuYzln1XlO89eyMOGX0H/g8Ifao3z3dSPEMzR2sdvuT3pUNCAXiMVvE=
Received: from 30.74.144.112(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiVurL8_1752029709 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 10:55:10 +0800
Message-ID: <cc2571c5-fd19-4d97-a5c6-c6781fb185ac@linux.alibaba.com>
Date: Wed, 9 Jul 2025 10:55:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix split_huge_page_test for folio_split()
 tests.
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709012800.3225727-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250709012800.3225727-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/9 09:27, Zi Yan wrote:
> PID_FMT does not have an offset field, so folio_split() tests are not
> performed. Add PID_FMT_OFFSET with an offset field and use it to perform
> folio_split() tests.
> 
> Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy allocator like split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index aa7400ed0e99..f0d9c035641d 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
>   #define INPUT_MAX 80
>   
>   #define PID_FMT "%d,0x%lx,0x%lx,%d"
> +#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
>   #define PFN_MASK     ((1UL<<55)-1)
> @@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order);
>   	else
> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
> +		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order, offset);
>   
>   	for (i = 0; i < fd_size; i++)


