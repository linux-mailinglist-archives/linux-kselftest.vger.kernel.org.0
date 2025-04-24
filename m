Return-Path: <linux-kselftest+bounces-31487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7645A9A254
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C0441F94
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E441F3BBB;
	Thu, 24 Apr 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FjOapuXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F17019995E
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476127; cv=none; b=PlXAuWqo1b96FTbImzFBWAgyXCuLc8LvUf/FVvDlGX/fJHk3f4FjQqfd2N0QRMKcxvtnEnKUmNlyIEO6SmdiHUzdKvsAALVUQ7koDALYwbm1+HtbaTNHfzFAnCfUM5/2oTDa9kk2r/em1xUU0JHRtb6sHGZzblYw2nCR8pqMR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476127; c=relaxed/simple;
	bh=50IEBUCT/jp92rjj2GKJxXFzGek3zLnSdR7dMpHPF5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UlgMeF1NGcAuNA2qRu1Yw0crYtA2fyz/lh5dUAARjCG2ak/Q8vCuPR8tWy05rFqXpCP+NRiEyHrfCf0iNvGCbDmRtwSQDDRq0EIUJHp+Urn8yAfMaz3sMLMXVebPfjK2TWwN156cfgu4MXdCy+hkohTZJ93aJZPbDH4GpqJ0X7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FjOapuXV; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745476114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wVkWw2jUzxAnlkfc6gLfJQociDbxExR7LUr/+zeyl20=;
	b=FjOapuXVW3ovwGetqwXX3fk89GqQYwojDe3YdhwgxVG0xPoDi85ynPnf8SkcF/D21uf8QAA51YKYahfXa0wsd3VTRmwj1bnvCKcIRnMv0JzsRY8Y4ISU2gc78h76vQO/H8L/+U3Co7+wXuibwh1s2XTZ0iRcXxWLlAWXhjudGV0=
Received: from 30.74.146.225(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXxgDaN_1745476114 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 14:28:34 +0800
Message-ID: <da797800-7172-429f-bfe7-87bdec82f2bb@linux.alibaba.com>
Date: Thu, 24 Apr 2025 14:28:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: compaction_test: Support platform with huge
 mount of memory
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Sri Jayaramappa <sjayaram@akamai.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/23 18:36, Feng Tang wrote:
> When running mm selftest to verify mm patches, 'compaction_test' case
> failed on an x86 server with 1TB memory. And the root cause is that it
> has too much free memory than what the test supports.
> 
> The test case tries to allocate 100000 huge pages, which is about 200 GB
> for that x86 server, and when it succeeds, it expects it's large than
> 1/3 of 80% of the free memory in system. This logic only works for
> platform with 750 GB ( 200 / (1/3) / 80% ) or less free memory, and may
> raise false alarm for others.
> 
> Fix it by changing the fixed page number to self-adjustable number
> according to the real number of free memory.
> 
> Fixes: bd67d5c15cc19 ("Test compaction of mlocked memory")
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Make sense to me. I tested it and passed on my platform. So:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@inux.alibaba.com>

> ---
>   tools/testing/selftests/mm/compaction_test.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index 2c3a0eb6b22d..9bc4591c7b16 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -90,6 +90,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
>   	int compaction_index = 0;
>   	char nr_hugepages[20] = {0};
>   	char init_nr_hugepages[24] = {0};
> +	char target_nr_hugepages[24] = {0};
> +	int slen;
>   
>   	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
>   		 "%lu", initial_nr_hugepages);
> @@ -106,11 +108,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
>   		goto out;
>   	}
>   
> -	/* Request a large number of huge pages. The Kernel will allocate
> -	   as much as it can */
> -	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
> -		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
> -			       strerror(errno));
> +	/*
> +	 * Request huge pages for about half of the free memory. The Kernel
> +	 * will allocate as much as it can, and we expect it will get at least 1/3
> +	 */
> +	nr_hugepages_ul = mem_free / hugepage_size / 2;
> +	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
> +		 "%lu", nr_hugepages_ul);
> +
> +	slen = strlen(target_nr_hugepages);
> +	if (write(fd, target_nr_hugepages, slen) != slen) {
> +		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
> +			       nr_hugepages_ul, strerror(errno));
>   		goto close_fd;
>   	}
>   

