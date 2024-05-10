Return-Path: <linux-kselftest+bounces-10011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12C8C23C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428741F258FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A116F29B;
	Fri, 10 May 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U5kqXRV5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CE168AFC;
	Fri, 10 May 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341417; cv=none; b=UGuIIerQSFPfNqUrU78eGCQMSBt6aacwVS/HCjv5IywCWo3JwIAHRL0FZRYt90Jiis5/y7XqqruFwlaxqPt1d+uX0uP+asK4uGopvuWEpUFl2OTq3sUB4SaAPZ77E8qH0cgI+nl8ItGnAWGM1KF+39B4VhEAfbpcrcJwIPTxg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341417; c=relaxed/simple;
	bh=VnFYmd5eagRdmO3dT+SD1QaxL8kEM7ZQt9iQ3Sag8OQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Py+w1Op5Etg8/c2mAVl8noKkUSmyX6Vst++uiYjkGATrS4Tu3jBksmdQZVVcgmaA4UGXK9GLV39/cunssczWXcrVFyIXajptpKfOFUT095r0/G+Da2kNcxpI1pceSl5pd5kRHBoy6l3cFURGonLwDYPkY/a1Y96APhnEr4XajPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U5kqXRV5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715341414;
	bh=VnFYmd5eagRdmO3dT+SD1QaxL8kEM7ZQt9iQ3Sag8OQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=U5kqXRV5vEWrItkWwAo3TbB+hxGkCLN+mMMDUyeroiE73WlOpgy0lQp8HSNWr+hDZ
	 PX7sw5fe85RqNK71/IBtJNI5+KhKCdQWiqAKQBKAVsFumj63IPa4PL+G2fJ4LpYbQB
	 IUNVrE6HSV4BavZMkc++rnax8FS3Ik5M4GYJpRhne92fSqPuV5MsxWY4nNPDqvZSic
	 ifLJdFS+hYG83vWQfqk4vMwE4nBueol0sygcDnPUD+1stLWZB2jLQZ/TE9dYYHUyjn
	 HxGzwsmo1UXTc9nnnTAGIQPubXMVgz5AR7GbekpsfKWzKVIMqj0kra2cSzjvPzXOp3
	 gTE375TNFNg/A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 67BDD3782185;
	Fri, 10 May 2024 11:43:32 +0000 (UTC)
Message-ID: <79677d57-379e-4cdc-ab89-899817a72206@collabora.com>
Date: Fri, 10 May 2024 16:43:56 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests/mm: hugetlb_madv_vs_map: Avoid test skipping by
 querying hugepage size at runtime
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
References: <20240509095447.3791573-1-dev.jain@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240509095447.3791573-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 2:54 PM, Dev Jain wrote:
> Currently, the size used in mmap() is statically defined, leading to
> skipping of the test on a hugepage size other than 2 MB, since munmap()
> won't free the hugepage for a size greater than 2 MB. Hence, query the
> size at runtime.
> 
> Also, there is no reason why a hugepage allocation should fail, since we
> are using a simple mmap() using MAP_HUGETLB; hence, instead of skipping
> the test, make it fail.
>  
> Signed-off-by: Dev Jain <dev.jain@arm.com>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/hugetlb_madv_vs_map.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
> index d01e8d4901d0..8f122a0f0828 100644
> --- a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
> +++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
> @@ -27,9 +27,9 @@
>  #include "vm_util.h"
>  #include "../kselftest.h"
>  
> -#define MMAP_SIZE (1 << 21)
>  #define INLOOP_ITER 100
>  
> +size_t mmap_size;
>  char *huge_ptr;
>  
>  /* Touch the memory while it is being madvised() */
> @@ -44,7 +44,7 @@ void *touch(void *unused)
>  void *madv(void *unused)
>  {
>  	for (int i = 0; i < INLOOP_ITER; i++)
> -		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
> +		madvise(huge_ptr, mmap_size, MADV_DONTNEED);
>  
>  	return NULL;
>  }
> @@ -59,7 +59,7 @@ void *map_extra(void *unused)
>  	void *ptr;
>  
>  	for (int i = 0; i < INLOOP_ITER; i++) {
> -		ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
> +		ptr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>  			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>  			   -1, 0);
>  
> @@ -93,14 +93,16 @@ int main(void)
>  			       free_hugepages);
>  	}
>  
> +	mmap_size = default_huge_page_size();
> +
>  	while (max--) {
> -		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
> +		huge_ptr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>  				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>  				-1, 0);
>  
>  		if ((unsigned long)huge_ptr == -1) {
> -			ksft_exit_skip("Failed to allocated huge page\n");
> -			return KSFT_SKIP;
> +			ksft_test_result_fail("Failed to allocate huge page\n");
> +			return KSFT_FAIL;
>  		}
>  
>  		pthread_create(&thread1, NULL, madv, NULL);
> @@ -117,7 +119,7 @@ int main(void)
>  		}
>  
>  		/* Unmap and restart */
> -		munmap(huge_ptr, MMAP_SIZE);
> +		munmap(huge_ptr, mmap_size);
>  	}
>  
>  	return KSFT_PASS;

-- 
BR,
Muhammad Usama Anjum

