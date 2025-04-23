Return-Path: <linux-kselftest+bounces-31390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF450A98812
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACBB441BE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8761F152D;
	Wed, 23 Apr 2025 11:03:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFB1CBA02
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406209; cv=none; b=WUUx6rISW4kIgldGzTd/69pDFlDLaEftD2w4AtoZaZU/7Bm0MR8Y6FLAn08NEanZOKxJOkKu2GgkpjWfb4wBkcRo+PArLN7yhLB4W0+0Lh70vjnob23hIbyjgAiqDKnWD326DxUiqzQx4Nd9yhxICLORDi7q+gGhqVq5V1Wjfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406209; c=relaxed/simple;
	bh=vHGSDEp6AOXofxRF9mA8MZHTXY/WwIMfjb6MZw/5yuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxRaLfYJ6Zf3/mqVfxPaqX+ADsS11rynCP9NMPX22raZorOf6DKWMtezqyQNr/NpXfRjtlmhXec5HjhDsLF9awBHwsAQ5PXQskBHZsr9iitoFr8E2ox2/rZlJcpmLyyCe8HkZZgqyUiszfe/tSX82VAYFPxM6kwqZnmdW7H4FgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED73D1063;
	Wed, 23 Apr 2025 04:03:21 -0700 (PDT)
Received: from [10.163.76.60] (unknown [10.163.76.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6A393F66E;
	Wed, 23 Apr 2025 04:03:23 -0700 (PDT)
Message-ID: <9260687a-0126-412c-aff2-9a5b358eaca9@arm.com>
Date: Wed, 23 Apr 2025 16:33:19 +0530
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
Cc: baolin.wang@linux.alibaba.com
References: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/25 4:06 pm, Feng Tang wrote:
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

Not sure if fixes tag is needed.

Acked-by: Dev Jain <dev.jain@arm.com>

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


