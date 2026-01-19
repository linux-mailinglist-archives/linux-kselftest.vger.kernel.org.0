Return-Path: <linux-kselftest+bounces-49328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EAD39E53
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E7C3028FD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF623370F;
	Mon, 19 Jan 2026 06:22:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CBB67E;
	Mon, 19 Jan 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803723; cv=none; b=GyoPq0GUwOOipFlJr0cN56h1Fxnf7zYvkmixbFfyX+TiradNK2sbvlmWKCVFanOfbxuqMNASIPQK/FEQeJZ+eVC3rhVGnANeMaVwS1cLDnwJYVoGHpDj6nep6IvyzD4tlKW5fmAOml7Hj51Wma3YYZDctKNlvmSDCPCgTI0+yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803723; c=relaxed/simple;
	bh=6Wjb9fkvBIiqY+RLfUxYtM1kjyOd2PQIyJqlBw3bXqA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X7KmJRKgDkV8qlkJL7Q+g1Do6YdyzcWugkNXMPoiGK2vddghat7GfRSNgyVVU0qxyz1qzQWXI0CBg0UbJRmwYwEAuuG0gslO7alSHdQmUGcdezAAr0jeaqVrAARPRZUf2pwd4mcKr46Yd3BW4i1FatJ4XLcosKY61kNL52wCJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8869A1517;
	Sun, 18 Jan 2026 22:21:47 -0800 (PST)
Received: from [10.164.18.63] (MacBook-Pro.blr.arm.com [10.164.18.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 615313F632;
	Sun, 18 Jan 2026 22:21:50 -0800 (PST)
Message-ID: <e71ffffc-8623-48d6-88b7-4684af4534aa@arm.com>
Date: Mon, 19 Jan 2026 11:51:47 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 aneesh.kumar@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
 <f44fdda0-80da-49a6-a9dd-75b9a46e1f76@lucifer.local>
Content-Language: en-US
In-Reply-To: <f44fdda0-80da-49a6-a9dd-75b9a46e1f76@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 18/01/26 6:28 pm, Lorenzo Stoakes wrote:
> One note - Dev please wrap lines to 75 chars as per standard kernel
> practice. It's super hard to read your mail with unwrapped lines, thanks.
> On Sun, Jan 18, 2026 at 01:25:25PM +0530, Dev Jain wrote:
>> On 16/01/26 6:50 pm, Lorenzo Stoakes wrote:
>>> This self test is asserting internal implementation details and is highly
>>> vulnerable to internal kernel changes as a result.
>>>
>>> It is currently failing locally from at least v6.17, and it seems that it
>>> may have been failing for longer in many configurations/hardware as it
>>> skips if e.g. CONFIG_ANON_VMA_NAME is not specified.
>> True, the test gets skipped for me since the mark_range function was added.
> This is underlining the issue with this test.
>
>>> With these skips and the fact that run_vmtests.sh won't run the tests in
>>> certain configurations it is likely we have simply missed this test being
>>> broken in CI for a long while.
>>>
>>> I have tried multiple versions of these tests and am unable to find a
>>> working bisect as previous versions of the test fail also.
>> Does the test fail for you even for commit 13e860961fd4 ("selftests/mm: virtual_address_range: Switch to ksft_exit_fail_msg").
>> I have never observed failure at this.
> It fails consistently with everything as I said, I gave up on trying to
> bisect it at v6.17.
>
> It's been broken for a whole bunch of commits all over the place so is also
> an active bisection hazard.
>
>>> The tests are essentially mmap()'ing a series of mappings with no hint and
>>> asserting what the get_unmapped_area*() functions will come up with, with
>>> seemingly few checks for what other mappings may already be in place.
>>>
>>> It then appears to be mmap()'ing with a hint, and making a series of
>>> similar assertions about the internal implementation details of the hinting
>>> logic.
>> The revelation of internal detail starts at 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()").
>> All that does is to check whether mmap failure actually means exhaustion. This can reveal bugs in maple tree,
>> if it cannot find a 1G chunk in it, even when the gap is present. This is an internal detail which is not
>> expected to change - no one reports any breakage (AFAIK, please correct if I am wrong) until after 10 months, at
> 'Internal detail that is not expected to change' is incorrect - you can have no
> expectations about internal implementation details.
>
> Another thing I didn't mention is this test takes a LONG time to run, and we are
> already having timeout issues with test runs.
>
>> commit a005145b9c96 ("selftests/mm: virtual_address_range: mmap() without PROT_WRITE"), that too not at the
>> gap assertion code - the breakage happens at the while (start_addr + hop < end_addr) chunk of code. In retrospect I should
>> not have added this chunk - the purpose was to check whether the VMAs being advertised in procfs are actually usable, testing
>> something which, in case breaks, is extremely easy to figure out and fix, without putting this functionality in the test. And, I
>> had no knowledge at the time that this will cause pagetable allocation and will touch physical memory. So commits
>> b2a79f62133a and 3bd6137220bb could have simply been avoided by removing the bit of code I mentioned.
> OK thanks for the explanation, but I don't think this changes anything.
>
>>> Commit 0ef3783d7558 ("selftests/mm: add support to test 4PB VA on PPC64"),
>>> commit 3bd6137220bb ("selftests/mm: virtual_address_range: avoid reading
>>> from VM_IO mappings"), and especially commit a005145b9c96 ("selftests/mm:
>>> virtual_address_range: mmap() without PROT_WRITE") are good examples of the
>>> whack-a-mole nature of maintaining this test.
>>>
>>> The last commit there being particularly pertinent as it was accounting for
>>> an internal implementation detail change that really should have no bearing
>>> on self-tests, that is commit e93d2521b27f ("x86/vdso: Split virtual clock
>>> pages into dedicated mapping").
>>>
>>> The purpose of the mm self-tests are to assert attributes about the API
>>> exposed to users, and to ensure that expectations are met.
>>>
>>> This test is emphatically not doing this, rather making a series of
>>> assumptions about internal implementation details and asserting them.
>>>
>>> It therefore, sadly, seems that the best course is to remove this test
>>> altogether.
>> The objective of the test is to exhaust VA space and find out bugs in mmap(). It has
> Well no, you're asserting gap lengths repeatedly, you are making assertions
> about get_unmapped_area() behaviour that are totally inappropriate in a
> self-test.

Apologies - so I discussed with Aneesh and Anshuman (CCed) and it turns out that the objective
of the test was to test the switch boundary. Upon exhaustion of the lower VA space, kernel
must not start giving out VMAs in the higher VA space, if the hint address is not given. The
original commit is 4e5ce33ceb32 ("selftests/vm: add a test for virtual address range mapping").

I cannot find this API requirement on the man page (because no one bothered to update it),
but it is mentioned in Documentation/arch/arm64/memory.rst:

"To maintain compatibility with software that relies on the ARMv8.0 VA space maximum size
of 48-bits, the kernel will, by default, return virtual addresses to userspace from
a 48-bit range.

Software can "opt-in" to receiving VAs from a 52-bit space by specifying an mmap hint
parameter that is larger than 48-bit."

So this is a thing that needs to be tested on arm64, and on ppc64 (for which the test
was originally added). Not sure about x86.


> I would suggest looking into actually writing unit tests for get_unmapped_area()
> functions using kunit or similar would be the correct approach.
>
> But again I'm not sure that it's appropriate to just have a test assert
> that functions do what they're implemented to do.
>
>> been useful in discovering a bug at [1].
>>
>> [1] https://lore.kernel.org/all/20240123171420.3970220-1-ryan.roberts@arm.com/
> I mean that proves my point that this test is _actually_ a wrongly-abstracted
> get_unmapped_area() unit test...
>
> I'm glad it was useful there, but it's just at the wrong level of abstraction.
>
> The test has been broken consistently, right now it's broken and nobody noticed
> because it got skipped (!), it simply does not work on my threadripper in any
> configuration, nor in virtme-ng, I've looked at the CI and it seems it's not
> been running there either, and it's adding maintenance burden and making test
> runs slow even if you have CONFIG_ANON_VMA_NAME set up.
>
> Every time somebody changes an internal implementation detail about mmap()
> layout, this will fail even though nothing has broken. This alone renders the
> test inappropriate.
>
> It reminds me a little of CRIU, which is tooling that makes a bunch of internal
> kernel impl detail assumptions to work - we are not obliged to keep these kinds
> of things working.
>
> When I first saw this test I felt it was asserting internal impl. details and
> thus not suitable as a self-test but let it go as relatively harmless.

About internal impl details, how is this test any different from merge.c, cow.c,
etc - which consistently test/depend on whether the VMA splits/merges?

>
> Now it's actively harming my work flow (I run mm selftests locally a
> lot). I think on the basis of all the above it's appropriate to remove it.
>
> Thanks, Lorenzo

