Return-Path: <linux-kselftest+bounces-24307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C890A0AE2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD64F3A66ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 04:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E531865E5;
	Mon, 13 Jan 2025 04:26:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70BA176242;
	Mon, 13 Jan 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736742396; cv=none; b=bl29ymJ859+lkYuLG37Jdr78KFva8r2ohx2RYCYPJRIcQqIbwd40KuDGdMN8fY4xYaL/BrzwIg/ecqV6j7WIWqjranqYIdolZ9XR9m8cscPoLIa2075f446lQgNPHYi885RnHL9r3kF06VRl2HVKLtYs41EvFF6v7m6JSJncgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736742396; c=relaxed/simple;
	bh=yINSHSrEnwaxbasXyTa4hHzJRDjAMZzT35uA3m0+zBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqKCiCrrSw6bWyCVmGLlKjYV96RRJBOmbEgD94gpirx1hTx7X3XYxI5IK3wNlDHhHN2Rqvce/KscjJX1KRCA5YhbvqRkSMvf+65nQ4Rcst2Dyr/femPPY2JeXVIJA8SE8joH9JRRpDBSNgQpwgh6PL2B6g7CFtzvdDieSSsbab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27190153B;
	Sun, 12 Jan 2025 20:27:01 -0800 (PST)
Received: from [10.163.57.117] (unknown [10.163.57.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF4E3F673;
	Sun, 12 Jan 2025 20:26:29 -0800 (PST)
Message-ID: <dd7440ac-0f2f-42be-9dbc-baf700106d81@arm.com>
Date: Mon, 13 Jan 2025 09:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow: Modify the incorrect checking
 parameters
To: Hao Ge <hao.ge@linux.dev>, akpm@linux-foundation.org, shuah@kernel.org
Cc: sj@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20250113032858.63670-1-hao.ge@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250113032858.63670-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Hao,

On 1/13/25 08:58, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> In the run_with_memfd_hugetlb function, some error handle
> have passed incorrect parameters.
> It should be "smem", but it was mistakenly written as "mem".

I guess there are couple of more instances where the returned address
'smem' is not getting tested for MAP_FAILED. Hence the commit message
here needs to be bit more generic rather than run_with_memfd_hugetlb()
specific.

--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1482,7 +1482,7 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
        }
 
        smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
-       if (mem == MAP_FAILED) {
+       if (smem == MAP_FAILED) {
                ksft_test_result_fail("mmap() failed\n");
                goto munmap;
        }
@@ -1583,7 +1583,7 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
                goto close;
        }
        smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
-       if (mem == MAP_FAILED) {
+       if (smem == MAP_FAILED) {
                ksft_test_result_fail("mmap() failed\n");
                goto munmap;
        }


> 
> Let's fix it.
> 
> Fixes: baa489fabd01 ("selftests/vm: rename selftests/vm to selftests/mm")

This commit just renamed the directory from vm/ to mm/ directory. The following
commit introduced the problem instead. Please update the Fixes: tag as required.

f8664f3c4a08f799 ("selftests/vm: cow: basic COW tests for non-anonymous pages")

> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  tools/testing/selftests/mm/cow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 32c6ccc2a6be..7a89680d1566 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -1684,7 +1684,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>  		goto close;
>  	}
>  	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
> -	if (mem == MAP_FAILED) {
> +	if (smem == MAP_FAILED) {
>  		ksft_test_result_fail("mmap() failed\n");
>  		goto munmap;
>  	}
> @@ -1696,7 +1696,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>  	fn(mem, smem, hugetlbsize);
>  munmap:
>  	munmap(mem, hugetlbsize);
> -	if (mem != MAP_FAILED)
> +	if (smem != MAP_FAILED)
>  		munmap(smem, hugetlbsize);
>  close:
>  	close(fd);

