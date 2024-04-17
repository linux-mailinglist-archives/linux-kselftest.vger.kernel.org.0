Return-Path: <linux-kselftest+bounces-8238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA468A7B97
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 06:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EA91F229FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 04:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5E32182;
	Wed, 17 Apr 2024 04:54:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A75249FF;
	Wed, 17 Apr 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329654; cv=none; b=k2pihs2cNFBvpxis9Xs3GXeISl9Athf0buoF8maGWL8yaJIlsxVPBANfKz3/nFUlbVxmzK/DG4Sfpsy4KtD0FenOuNG0JsYTkFr/ZrnTaG5cIEsfBF/vYRNFbRSlsuCJhWECK6N10gtkU/jgCwXS0NImFMrFBpMcynTwLOOm6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329654; c=relaxed/simple;
	bh=JI37h1l7RHQE/Ptwu/oRf7eLUHTa3FG+1z1JEcX3tmY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BUERd1P4O4yWqHZ4CDS/nVu+ynG+FZCLfa316GUS3/biO9ma8vb1H1cNYtJ9ZUtdGP1n8jZgdZQC79LS4aKeeZhKPjnYQNXoI//0ynlwRHnTSRbgiRRiAFKMxMa2x+ebmbovxaEe0eQkYsyApx2ksdffvhtTL1OVzK2XXjrpxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC86339;
	Tue, 16 Apr 2024 21:54:37 -0700 (PDT)
Received: from [10.162.43.16] (e116581.arm.com [10.162.43.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FDB33F738;
	Tue, 16 Apr 2024 21:54:05 -0700 (PDT)
Message-ID: <815f887c-3625-4715-806a-d5533373b20a@arm.com>
Date: Wed, 17 Apr 2024 10:23:58 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests/arm: Add mm test
From: Dev Jain <dev.jain@arm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-2-dev.jain@arm.com>
 <ac9b16a7-f294-44d4-8243-488db97a009e@collabora.com>
 <2dfae66f-1e34-40e5-a6a1-344ff4422028@arm.com>
Content-Language: en-US
In-Reply-To: <2dfae66f-1e34-40e5-a6a1-344ff4422028@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/10/24 09:45, Dev Jain wrote:
>
> On 4/7/24 02:53, Muhammad Usama Anjum wrote:
>> On 4/5/24 1:44 PM, Dev Jain wrote:
>>> This patch tests the 4GB VA restriction for 32-bit processes; it is 
>>> required
>>> to test the compat layer, whether the kernel knows that it is 
>>> running a 32-bit
>>> process or not. Chunks are allocated until the VA gets exhausted; 
>>> mmap must
>>> fail beyond 4GB. This is asserted against the VA mappings found
>>> in /proc/self/maps.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   tools/testing/selftests/arm/mm/compat_va.c | 94 
>>> ++++++++++++++++++++++
>>>   1 file changed, 94 insertions(+)
>>>   create mode 100644 tools/testing/selftests/arm/mm/compat_va.c
>>>
>>> diff --git a/tools/testing/selftests/arm/mm/compat_va.c 
>>> b/tools/testing/selftests/arm/mm/compat_va.c
>>> new file mode 100644
>>> index 000000000000..3a78f240bc87
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/arm/mm/compat_va.c
>>> @@ -0,0 +1,94 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2024 ARM Limited
>>> + *
>>> + * Author : Dev Jain <dev.jain@arm.com>
>>> + *
>>> + * Tests 4GB VA restriction for 32 bit process
>>> + */
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include <sys/mman.h>
>>> +
>>> +#include <linux/sizes.h>
>>> +#include <kselftest.h>
>>> +
>>> +#define MAP_CHUNK_SIZE    SZ_1M
>>> +#define NR_CHUNKS_4G    (SZ_1G / MAP_CHUNK_SIZE) * 4    /* prevent 
>>> overflow */
>>> +
>>> +static int validate_address_hint(void)
>>> +{
>>> +    char *ptr;
>>> +
>>> +    ptr = mmap((void *) (1UL << 29), MAP_CHUNK_SIZE, PROT_READ |
>>> +           PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +
>>> +    if (ptr == MAP_FAILED)
>>> +        return 0;
>>> +
>>> +    return 1;
>> Usually we return negative value instead of positive one which indicates
>> error situation.
>>
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +    char *ptr[NR_CHUNKS_4G + 3];
>>> +    char line[1000];
>>> +    const char *file_name;
>>> +    int chunks;
>>> +    FILE *file;
>>> +    int i;
>>> +
>>> +    ksft_print_header();
>>> +    ksft_set_plan(1);
>> There are multiple test cases. Instead of saying there is only 1 test.
>> There should be multiple ksft_test_result{_pass,_fail} statements for 
>> each
>> sub-tests.
>
>
> My initial idea was to treat this as a single logical test, as I
>
> am asserting the restriction on the number of chunks against
>
> the VMAs. I guess your approach is cleaner; thanks.


Thinking again, using a lot of return statements is in fact making the 
code easier

to follow. If I just set a variable ret = 0/1 and use it to pass or 
fail, I'll have to

unnecessarily use a lot of if/else statements. Take a look at the 
examples below.

>
>>
>>> +
>>> +    /* try allocation beyond 4 GB */
>>> +    for (i = 0; i < NR_CHUNKS_4G + 3; ++i) {
>>> +        ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
>>> +                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +
>>> +        if (ptr[i] == MAP_FAILED) {
>>> +            if (validate_address_hint())
>>> +                ksft_exit_fail_msg("VA exhaustion failed\n");
>>> +            break;


I will have to set ret value here, forcing two statements inside the if 
block.

>>> +        }
>>> +    }
>>> +
>>> +    chunks = i;
>>> +    if (chunks >= NR_CHUNKS_4G) {
>>> +        ksft_test_result_fail("mmapped chunks beyond 4GB\n");
>>> +        ksft_finished();
>>> +    }
>>> +
>>> +    /* parse /proc/self/maps, confirm 32 bit VA mappings */
>>> +    file_name = "/proc/self/maps";
>>> +    file = fopen(file_name, "r");
>>> +    if (file == NULL)
>>> +        ksft_exit_fail_msg("/proc/self/maps cannot be opened\n");
>>> +


I will have to set ret here, and enclose the below while statement inside

an else block. In short, saving the value of ret will require if/else blocks

if I were to use it in the end in ksft_test_result(). When I use ksft_exit

statements, it is clear that a problem was spotted here, and there is

no need to study the remaining code.

>>> +    while (fgets(line, sizeof(line), file)) {
>>> +        const char *whitespace_loc, *hyphen_loc;
>>> +
>>> +        hyphen_loc = strchr(line, '-');
>>> +        whitespace_loc = strchr(line, ' ');
>>> +
>>> +        if (!(hyphen_loc && whitespace_loc)) {
>>> +            ksft_test_result_skip("Unexpected format");
>>> +            ksft_finished();
>> I'm unable to follow as there are too many return statements. If you 
>> divide
>> the test into multiple sub-tests, you can skip/pass/fail each 
>> sub-test easily.
>>
>>> +        }
>>> +
>>> +        if ((hyphen_loc - line > 8) ||
>>> +            (whitespace_loc - hyphen_loc) > 9) {
>>> +            ksft_test_result_fail("Memory map more than 32 bits\n");
>>> +            ksft_finished();
>>> +        }
>>> +    }
>>> +
>>> +    for (int i = 0; i < chunks; ++i)
>>> +        munmap(ptr[i], MAP_CHUNK_SIZE);
>>> +
>>> +    ksft_test_result_pass("Test\n");
>>> +    ksft_finished();
>>> +}
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

