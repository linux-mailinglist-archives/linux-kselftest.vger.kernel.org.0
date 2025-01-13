Return-Path: <linux-kselftest+bounces-24312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BEA0AEF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB103A6910
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A38230D3E;
	Mon, 13 Jan 2025 05:55:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A65230D1F;
	Mon, 13 Jan 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747749; cv=none; b=M8swyKX50SfgVbEHaLwAXVshWfSM2ZSaCqSqm3qlQfJQGSapUJIqgjKWDsf2bRVOJS7rBGXHRC15kSOn181FCY0ruVmFJ+NOAfVr42ZGXC0xyianXzUsluQWCHJzKhDjcTkXUD2NLBEigHhzfR3X6hPVSMT6D6SN+/lrxViy0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747749; c=relaxed/simple;
	bh=41iLlHz/WF0NytmRPAetVi5A4A80TKS1pVPCVvSk2JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnOC6zkwchanFHr+8N9lPqaAuqZVgsp9MjKqgjnWC8lYa62eanWohH3ZbzOgJy652l5BCRY7wQY+Pi2gp/+tbpF1N84ejDVyk2ZoCPR3YaxShLa1+AXQmH5WDB4ETNFhl+oQ/LfSc38pESNqpFWNHzQfy2In7ffz0fEUmpWavmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CB671595;
	Sun, 12 Jan 2025 21:56:14 -0800 (PST)
Received: from [10.163.57.117] (unknown [10.163.57.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD64C3F66E;
	Sun, 12 Jan 2025 21:55:43 -0800 (PST)
Message-ID: <79f364d7-b94f-450b-97ef-c7539c9671ce@arm.com>
Date: Mon, 13 Jan 2025 11:25:44 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm/cow: Modify the incorrect checking
 parameters
To: Hao Ge <hao.ge@linux.dev>, akpm@linux-foundation.org, shuah@kernel.org
Cc: sj@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <1514aee8-e75c-4c05-8943-65681254feda@linux.dev>
 <20250113050908.93638-1-hao.ge@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250113050908.93638-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A small nit.

Please always send a new patch version separately as a new email
thread instead - not part of an ongoing discussion.

On 1/13/25 10:39, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> In the cow.c,some error handle have passed incorrect
> parameters. It should be "smem", but it was mistakenly
> written as "mem".
> 
> Let's fix it.
> 
> Fixes: f8664f3c4a08 ("selftests/vm: cow: basic COW tests for non-anonymous pages")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v2: Anshuman pointed out that the error is not limited to the run_with_memfd_hugetlb function;
>     there are other places where it occurs as well.
>     Therefore, let's fix it all together.
>     Similarly, Update the Fix tag to be accurate.

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  tools/testing/selftests/mm/cow.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 32c6ccc2a6be..c52c93996ba1 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -1482,7 +1482,7 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
>  	}
>  
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
> -	if (mem == MAP_FAILED) {
> +	if (smem == MAP_FAILED) {
>  		ksft_test_result_fail("mmap() failed\n");
>  		goto munmap;
>  	}
> @@ -1583,7 +1583,7 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
>  		goto close;
>  	}
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> -	if (mem == MAP_FAILED) {
> +	if (smem == MAP_FAILED) {
>  		ksft_test_result_fail("mmap() failed\n");
>  		goto munmap;
>  	}
> @@ -1634,7 +1634,7 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
>  		goto close;
>  	}
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> -	if (mem == MAP_FAILED) {
> +	if (smem == MAP_FAILED) {
>  		ksft_test_result_fail("mmap() failed\n");
>  		goto munmap;
>  	}
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

