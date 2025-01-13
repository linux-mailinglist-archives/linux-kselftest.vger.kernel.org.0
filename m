Return-Path: <linux-kselftest+bounces-24309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E8AA0AE94
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 06:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2633165CAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448022540C;
	Mon, 13 Jan 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DjpA+yJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446402253E1
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736744450; cv=none; b=PfaiqB4jW3asxT3V5JvoKdfaoyolJBi4RFteVChNazf+GDESWxawpc2a6rCcgroGzVeQyNMtQ84gSKnTEqQihW7IglhRZOTZOywIFHSuhK1H+m7CjsOzGzX+vIsOD/N+GcR4Z9BttRQsKGVTVsWfoowZNf4JrVawwcDbhocDWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736744450; c=relaxed/simple;
	bh=fHdeRhFRJ1K1hnTlEeAs8KN+T0d2wjawhe5oMupgY9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JclEIZJ3kRiH4YsIqRAKE0JHsq3YNG1eERiFZWE+0xErZ5YE2gb9a2C1IdE4hBwIVORzFckBem95xc3xkXZsTtUMHGmdoqJJDtuPMoIAS17xs6bwzqc5ywKsaZOHt6HQthx8S5Ly1RCzu82XxnHf5DixcXXxYdirTD2A3vipoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DjpA+yJG; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1514aee8-e75c-4c05-8943-65681254feda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736744445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmXuMINrSQ9tkbb9LL/ewhBUDF2cOwbuY0kHl/709N0=;
	b=DjpA+yJGuuD854niQtAPwBTfGEjrzhDTxSnyGHz4FDH/nt/7QrONOLWzE5Z9lejgPuQ4rr
	G77A0CJdQBE2CF6I7SWdNcxoTC3lC5KTFfOZ9OvRi+nBgPrqM11bCtc4ssjqb8RdH1pNfy
	Nh2fIiY9IUiSH0FTLSEuUHJLBm9tv5o=
Date: Mon, 13 Jan 2025 12:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/mm/cow: Modify the incorrect checking
 parameters
To: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org,
 shuah@kernel.org
Cc: sj@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20250113032858.63670-1-hao.ge@linux.dev>
 <dd7440ac-0f2f-42be-9dbc-baf700106d81@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <dd7440ac-0f2f-42be-9dbc-baf700106d81@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Anshuman


Thanks for your revirew.


On 2025/1/13 12:26, Anshuman Khandual wrote:
> Hello Hao,
>
> On 1/13/25 08:58, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> In the run_with_memfd_hugetlb function, some error handle
>> have passed incorrect parameters.
>> It should be "smem", but it was mistakenly written as "mem".
> I guess there are couple of more instances where the returned address
> 'smem' is not getting tested for MAP_FAILED. Hence the commit message
> here needs to be bit more generic rather than run_with_memfd_hugetlb()
> specific.


Thank you for bringing it to my attention. Upon reviewing, I confirm 
that you are correct.


>
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -1482,7 +1482,7 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
>          }
>   
>          smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
> -       if (mem == MAP_FAILED) {
> +       if (smem == MAP_FAILED) {
>                  ksft_test_result_fail("mmap() failed\n");
>                  goto munmap;
>          }
> @@ -1583,7 +1583,7 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
>                  goto close;
>          }
>          smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> -       if (mem == MAP_FAILED) {
> +       if (smem == MAP_FAILED) {
>                  ksft_test_result_fail("mmap() failed\n");
>                  goto munmap;
>          }
>
>
>> Let's fix it.
>>
>> Fixes: baa489fabd01 ("selftests/vm: rename selftests/vm to selftests/mm")
> This commit just renamed the directory from vm/ to mm/ directory. The following
> commit introduced the problem instead. Please update the Fixes: tag as required.
>
> f8664f3c4a08f799 ("selftests/vm: cow: basic COW tests for non-anonymous pages")


Yes, I accidentally copied the wrong information. I will resend a v2  to 
address these issues. Thank you very much


Thanks

Best Regards

Hao


>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   tools/testing/selftests/mm/cow.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index 32c6ccc2a6be..7a89680d1566 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -1684,7 +1684,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>>   		goto close;
>>   	}
>>   	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
>> -	if (mem == MAP_FAILED) {
>> +	if (smem == MAP_FAILED) {
>>   		ksft_test_result_fail("mmap() failed\n");
>>   		goto munmap;
>>   	}
>> @@ -1696,7 +1696,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>>   	fn(mem, smem, hugetlbsize);
>>   munmap:
>>   	munmap(mem, hugetlbsize);
>> -	if (mem != MAP_FAILED)
>> +	if (smem != MAP_FAILED)
>>   		munmap(smem, hugetlbsize);
>>   close:
>>   	close(fd);

