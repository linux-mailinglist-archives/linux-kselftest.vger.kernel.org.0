Return-Path: <linux-kselftest+bounces-2141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CC7816C2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8902E28449B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8018E1B;
	Mon, 18 Dec 2023 11:32:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375D1B268
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FF771FB;
	Mon, 18 Dec 2023 03:33:37 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA4693F738;
	Mon, 18 Dec 2023 03:32:51 -0800 (PST)
Message-ID: <c417dabb-d7f5-4757-be4f-26b15c3f2fd2@arm.com>
Date: Mon, 18 Dec 2023 11:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
 <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
 <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
 <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
 <d99367ef-72e0-48ad-ba83-45e25efdf0fc@nvidia.com>
 <fb91ab59-ab5c-45c4-a413-bd6c060bfcc8@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <fb91ab59-ab5c-45c4-a413-bd6c060bfcc8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/12/2023 02:40, John Hubbard wrote:
> On 12/15/23 18:25, John Hubbard wrote:
>> On 12/15/23 06:28, Ryan Roberts wrote:
>> ...
>>> I've kept all the existing "pretty" output and results summary as is, it just
>>> gets a hash in front of it when TAP is enabled.
>>>
>>> so this:
>>>
>>> -----------------------
>>> running ./hugepage-mmap
>>> -----------------------
>>> Returned address is 0xffff89e00000
>>> First hex is 0
>>> First hex is 3020100
>>> [PASS]
>>> SUMMARY: PASS=1 SKIP=0 FAIL=0
>>>
>>> becomes this:
>>>
>>> TAP version 13
>>> # -----------------------
>>> # running ./hugepage-mmap
>>> # -----------------------
>>> # Returned address is 0xffff89e00000
>>> # First hex is 0
>>> # First hex is 3020100
>>> # [PASS]
>>> ok 1 hugepage-mmap
>>> # SUMMARY: PASS=1 SKIP=0 FAIL=0
>>> 1..1
>>>
>>> If you think the latter is ofensive, then I can do the wrapping as you suggest.
>>
>> I applied this and ran the tests, all while carefully reminding myself
>> to "think like a human". :) And from that perspective, to me, the output
>> is effectively the same: the leading '#' characters do not really change
>> anything, from a readability point of view.
>>
>> So IMHO you're on perfectly solid ground, if you just switch over
>> directly to this format.

Great thanks for taking a look!

>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>
> 
> I should also point out that some of the subtests already attempt a TAP
> output. So now we end up with TAP-within-TAP output for those programs.

It's actually TAP-in-TAP-in-TAP if you're running from run_kselftest.sh :)

> 
> For example:
>     # -----------------------
>     # running ./madv_populate
>     # -----------------------
>     # TAP version 13
>     # 1..21
>     # # [RUN] test_prot_read
>     # ok 1 MADV_POPULATE_READ with PROT_READ
>     # ok 2 MADV_POPULATE_WRITE with PROT_READ
>     # # [RUN] test_prot_write
>     # ok 3 MADV_POPULATE_READ with PROT_WRITE
>     ...etc...
> 
> Note the double level of leading '#' characters.
> 
> Again, this is still readable enough for humans. But it should probably
> be removed in subsequent patches to the subtests.

I personally don't agree with this. It would be difficult to flatten to a single
TAP instance because the top level doesn't have a clue how many test cases the
child is running. Trying to do this will make things more fragile and less
modular. LAVA can certainly deal with nested test cases and correctly parses
everything to test case names that contain the test name at each level of
nesting. The thing I was trying to solve with this patch was that previously the
top level (run_kselftest.sh) and the bottom level (individual mm test binaries)
were using TAP, but the middle level (run_vmtests.sh) wasn't, and this was
confusing the LAVA parser.

> 
> 
> thanks,


