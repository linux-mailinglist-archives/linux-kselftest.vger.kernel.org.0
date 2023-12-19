Return-Path: <linux-kselftest+bounces-2177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF0818365
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF03FB2211E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF879C6;
	Tue, 19 Dec 2023 08:33:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB29B12B60
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F5841FB;
	Tue, 19 Dec 2023 00:33:50 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2027E3F738;
	Tue, 19 Dec 2023 00:33:05 -0800 (PST)
Message-ID: <cd831119-0462-44bc-adfe-aaf557c3b4e6@arm.com>
Date: Tue, 19 Dec 2023 08:33:03 +0000
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
 <c417dabb-d7f5-4757-be4f-26b15c3f2fd2@arm.com>
 <7663374f-ed7e-4d86-a07f-e71c6bcef841@nvidia.com>
 <cbcdce88-def8-49e2-aad4-d510fb82208f@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cbcdce88-def8-49e2-aad4-d510fb82208f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/12/2023 00:55, John Hubbard wrote:
> On 12/18/23 16:51, John Hubbard wrote:
>> On 12/18/23 03:32, Ryan Roberts wrote:
>> ...
>>>> I should also point out that some of the subtests already attempt a TAP
>>>> output. So now we end up with TAP-within-TAP output for those programs.
>>>
>>> It's actually TAP-in-TAP-in-TAP if you're running from run_kselftest.sh :)
>>>
>>>>
>>>> For example:
>>>>      # -----------------------
>>>>      # running ./madv_populate
>>>>      # -----------------------
>>>>      # TAP version 13
>>>>      # 1..21
>>>>      # # [RUN] test_prot_read
>>>>      # ok 1 MADV_POPULATE_READ with PROT_READ
>>>>      # ok 2 MADV_POPULATE_WRITE with PROT_READ
>>>>      # # [RUN] test_prot_write
>>>>      # ok 3 MADV_POPULATE_READ with PROT_WRITE
>>>>      ...etc...
>>>>
>>>> Note the double level of leading '#' characters.
>>>>
>>>> Again, this is still readable enough for humans. But it should probably
>>>> be removed in subsequent patches to the subtests.
>>>
>>> I personally don't agree with this. It would be difficult to flatten to a single
>>> TAP instance because the top level doesn't have a clue how many test cases the
>>
>> That's not quite what I had in mind...
>>
>>> child is running. Trying to do this will make things more fragile and less
>>> modular. LAVA can certainly deal with nested test cases and correctly parses
>>> everything to test case names that contain the test name at each level of
>>> nesting. The thing I was trying to solve with this patch was that previously the
>>> top level (run_kselftest.sh) and the bottom level (individual mm test binaries)
>>> were using TAP, but the middle level (run_vmtests.sh) wasn't, and this was
>>> confusing the LAVA parser.
>>>
>>
>> I was thinking more along these lines:
>>
>> a) For the individual programs (binaries), there is actually neither need nor
>> desire to create TAP output at that level, because frameworks like LAVA only
>> care about running a lot of tests and parsing the output.
>>
>> b) Therefore, just stop specifying TAP output at the leaf level, and let
>> run_vmtests.sh and run_kselftest.sh do it.
>>
>> Looking at madv_populate.c, I see that it scatters calls to ksft_*() around.
>> And I was thinking that this is all just redundant, isn't it?
>>
> 
> Although I suppose that the counter argument is that the subtests in
> madv_populate.c really *do* want to be specifically printed in TAP
> format.
> 
> arggh, I guess this is just not worth fooling around with after all.

Yes; I wouldn't want to lose the fine granularity we have currently. For example
cow.c has ~900 test cases now that I've multiplied everything up for mTHP. 16 of
those are known to fail (hugetlb issue) and 1 is skipped. I wouldn't want to
reduce that down to a single cow test case that always fails; that's not helpful
to understand if I've regressed something.

But sounds like we are both on the same page now.


>  
> 
> thanks,


