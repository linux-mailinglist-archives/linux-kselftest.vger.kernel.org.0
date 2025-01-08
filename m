Return-Path: <linux-kselftest+bounces-24044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3526A05312
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 07:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119033A6A7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBF1A23AC;
	Wed,  8 Jan 2025 06:16:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38D1A0BFB;
	Wed,  8 Jan 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316989; cv=none; b=B0qF9i3Qos+TKrzOCUrFtSkaKkICoB7p+vKaDPo6mtrXFBi0T4W8OAJffeEmCPC2p4uyop676E7MtsqZfOUt66yHlyBfn/UaSxeukWjOk/VWOwqB2By14Fzwoyoc2aDNYidmFHqFpkbBZ+GqZvzSdA8wp2yiecZAeEDuUIZGZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316989; c=relaxed/simple;
	bh=E4cj80yT/7TJ3pTJJyDumkOo2HKtryvSG00oPGG4abM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieueI6DE7utGA9oQEscU52JJiWQkM7k1MDYVSdx4FLOxtMugDAHzhTqiIxnHHn6POaDOSU8Go4dYQCHIlujRKu/LvEu0SozotYPzlsK2qYcnrQieysAE6AAeiS7ao0F6b7/wgduJXfIAWezmAyyoaNfNw0eY5jVacnpdS65vSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2068213D5;
	Tue,  7 Jan 2025 22:16:54 -0800 (PST)
Received: from [10.162.43.18] (K4MQJ0H1H2.blr.arm.com [10.162.43.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CCFC3F66E;
	Tue,  7 Jan 2025 22:16:22 -0800 (PST)
Message-ID: <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
Date: Wed, 8 Jan 2025 11:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
> If not enough physical memory is available the kernel may fail mmap();
> see __vm_enough_memory() and vm_commit_limit().
> In that case the logic in validate_complete_va_space() does not make
> sense and will even incorrectly fail.
> Instead skip the test if no mmap() succeeded.
>
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>
> ---
> The logic in __vm_enough_memory() seems weird.
> It describes itself as "Check that a process has enough memory to
> allocate a new virtual mapping", however it never checks the current
> memory usage of the process.
> So it only disallows large mappings. But many small mappings taking the
> same amount of memory are allowed; and then even automatically merged
> into one big mapping.
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -178,6 +178,12 @@ int main(int argc, char *argv[])
>   		validate_addr(ptr[i], 0);
>   	}
>   	lchunks = i;
> +
> +	if (!lchunks) {
> +		ksft_test_result_skip("Not enough memory for a single chunk\n");
> +		ksft_finished();
> +	}
> +
>   	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
>   	if (hptr == NULL) {
>   		ksft_test_result_skip("Memory constraint not fulfilled\n");
>

I do not  know about __vm_enough_memory(), but I am going by your description:
You say that the kernel may fail mmap() when enough physical memory is not
there, but it may happen that we have already done 100 mmap()'s, and then
the kernel fails mmap(), so if (!lchunks) won't be able to handle this case.
Basically, lchunks == 0 is not a complete indicator of kernel failing mmap().

The basic assumption of the test is that any process should be able to exhaust
its virtual address space, and running the test under memory pressure and the
kernel violating this behaviour defeats the point of the test I think?


