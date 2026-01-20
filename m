Return-Path: <linux-kselftest+bounces-49439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB788D3BECF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 06:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4C0C4ED501
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 05:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70A363C6F;
	Tue, 20 Jan 2026 05:29:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB30363C5C;
	Tue, 20 Jan 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886953; cv=none; b=Cq79h+OGHPzJWseansFVkVdBaTqW3UuqWkYKci99+PkuqOoBdo9a43RkTpR7vrl2X9nJRSI5wMiDYk3kCXuDdK5G3ohlpoZ5gavLdRT8o7N1/WAVLYWEYGRzjw8tfvWanvafGdQWBXaB9Ovsb9qZ6+aG0yucSrCTSEsv+mEN/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886953; c=relaxed/simple;
	bh=TFFU23+kDkS9yikSJRwebcIMEWrCvR/JOlYMN8TbIvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqNbqmSlgnDY22gvbzGbF/xOkmy9GfHMWSUPTfz1cyy5Wg8Mv421iQeYadFprG+UzR/8ZGKK9G1mcQ1ZXaTMymX7T04KrovcDdAesHVJGSgMQp7UN3oGh1dUOfe9DTo8wCg78brt5/GIk+RZmP68MyF9hxSnDTtLcPVohbrpavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D259E1476;
	Mon, 19 Jan 2026 21:29:00 -0800 (PST)
Received: from [10.164.18.63] (MacBook-Pro.blr.arm.com [10.164.18.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1ADA3F740;
	Mon, 19 Jan 2026 21:29:03 -0800 (PST)
Message-ID: <f5f92d9d-d65c-444b-8357-17cca7ec176c@arm.com>
Date: Tue, 20 Jan 2026 10:59:01 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <e71ffffc-8623-48d6-88b7-4684af4534aa@arm.com>
 <f7ed83bf-3554-4bfb-8d77-30ed4785a4a8@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f7ed83bf-3554-4bfb-8d77-30ed4785a4a8@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 19/01/26 2:29 pm, Lorenzo Stoakes wrote:
> On Mon, Jan 19, 2026 at 11:51:47AM +0530, Dev Jain wrote:
>>> Well no, you're asserting gap lengths repeatedly, you are making assertions
>>> about get_unmapped_area() behaviour that are totally inappropriate in a
>>> self-test.
>> Apologies - so I discussed with Aneesh and Anshuman (CCed) and it turns out that the objective
>> of the test was to test the switch boundary. Upon exhaustion of the lower VA space, kernel
>> must not start giving out VMAs in the higher VA space, if the hint address is not given. The
>> original commit is 4e5ce33ceb32 ("selftests/vm: add a test for virtual address range mapping").
> This doesn't change anything, this is still testing get_unmapped_area() which by
> definition is what is returning this.
>
> Also exhausting VA space is an inherently silly thing for a test to do, you're
> making assumptions about existing VMA layout which is absolutely an
> implementation detail and may even be influence by libc...
>
>> I cannot find this API requirement on the man page (because no one bothered to update it),
>> but it is mentioned in Documentation/arch/arm64/memory.rst:
>>
>> "To maintain compatibility with software that relies on the ARMv8.0 VA space maximum size
>> of 48-bits, the kernel will, by default, return virtual addresses to userspace from
>> a 48-bit range.
>>
>> Software can "opt-in" to receiving VAs from a 52-bit space by specifying an mmap hint
>> parameter that is larger than 48-bit."
>>
>> So this is a thing that needs to be tested on arm64, and on ppc64 (for which the test
>> was originally added). Not sure about x86.
> Well 'needs' is strong here...
>
> It would be far more efficient to implement this as a kunit test and wouldn't
> require a extremely slow test that makes assumptions about VMA layout.
>
>> About internal impl details, how is this test any different from merge.c, cow.c,
>> etc - which consistently test/depend on whether the VMA splits/merges?
> This is not a hugely civil/productive way of responding here to be honest, it's
> what-about-ery and implying something that isn't very kind...
>
> But since I am a reasonable if grumpy maintainer, let me indulge you a second
> here.
>
> I thought I'd been clear BUT for avoidance of doubt, I want to remove this test
> because of the COMBINATION of:
>
> 1. It is completely broken and has been broken for some time and nobody noticed.
> 2. It is asserting kernel implementation details.
> 3. It is poorly implemented and breaks often.
> 4. It takes a very long time to run even on fast machines and is a timeout risk.
>
> So even if you had a point, it wouldn't argue against removal.
>
> But you do not - both VMA merge and CoW impact API. Re: merging certain
> user-facing functions, most notably mremap(), have API requirements that the
> user must not cross VMA boundaries. It is therefore ENTIRELY a user-facing and
> kernel/user API thing that has to be tested from this perspective.
>
> CoW is equally a documented and expected behaviour and also affects merging.
>
> Anyway.
>
> Practically speaking I think there are two ways forward here (not mutually
> exclusive):
>
> 1. Implement something in kunit or similar that explicitly tests
>    get_unmapped_area().
>
> 2. Add a _new_ selftest, named something sensible like mmap_hint.c or something,
>    that runs only on relevant arches, and does NOT try to do crazy stuff like
>    mapping the entire VA space, but instead simply tries some trial unhinted
>    mappings some hints in 48-bit space, and some hints in 52-bit space and
>    asserts things are as expected.

I'll reply to everything here otherwise I'll have to repeat myself at different places.

"Also exhausting VA space is an inherently silly thing for a test to do, you're
making assumptions about existing VMA layout which is absolutely an
implementation detail and may even be influence by libc..."

The original version only uses mmap() and checks whether we got a high address mmap
success when we shouldn't have. There are no assumptions being made here about
VA layout. No matter the VA layout, the test will succeed because the kernel
must enforce the distinction between low and high addresses (but see point 3 below).


"It is therefore ENTIRELY a user-facing and kernel/user API thing that has to be tested from this perspective."

So in merge.c, the statements ASSERT_NE(ptrx, MAP_FAILED) surely assert the
user-visible API - that mremap must not fail. But there are statements which
also assert where a VMA starts and where it ends, testing VMA merging -
I was concerned about these. It is not the goal of userspace to minimize the
number of VMAs while making a syscall - that is a kernel optimization. My point being,
I suspect that the mm selftests *already* test internal details a lot, and I believe
that they *need* to! Running selftests is the most convenient way of testing the mm subsystem.
Hence this should not be a ground for removal of test.

Talking about the recent commits, they can be reverted. So, the ground for
removal should be that the ratio of the time taken by the test (exhausting VA
space), to the coverage of the test (for arm64, it is testing backward compatibility of 48-bit VA
on 52-bit VA, which one can argue is easy to spot if it ever breaks, and easy to fix)
is too large and does not justify a selftest. I tend to agree here.

"Add a _new_ selftest, named something sensible like mmap_hint.c or something ..."

va_high_addr_switch.c tests stuff around the switch boundary. But it does not
exhaust VA space. We *must* exhaust VA space if we are to check that the kernel,
in a situation of "emergency" (i.e exhausted lower VA space), starts giving out
high addresses, when it shouldn't. Again, one may argue that trying to test
this out is not worth it.

I personally opine that besides testing the back compat of 48 bit VA on 52 bit VA,
we are testing something more important here: exhausting the VA space tests whether
the kernel can truly distinguish b/w virtual and physical memory - we stress the virtual
memory subsystem without touching physical memory, something which the kernel should be able
to handle. But again, any such test has the potential for a timeout. I wonder if there is a
faster way of filling up VA space.

To summarize, I will agree with you that currently

1. The test is in a broken state
2. The test is taking too much time to test something trivial
3. It is a maintenance hazard. It turns out that the original version used
   MAP_CHUNK_SIZE of 16GB, but then it was changed to 1GB because (this is the bit
   where the dependency on VA layout comes) on some systems even a single 16GB mmap
   may fail. So now we are stuck in making a tradeoff between the size of a single
   mmap versus the time taken by the test

So the better option seems to just remove the test.

A separate question: Do you think that the functionality advertised by validate_complete_va_space,
to check the gaps between VMAs, deserves a test in kunit / tools/testing/vma, or somewhere else? 



>
> If you do point 2, please please use a. use the kselftest_harness.h to write the
> tests in a nice way (see e.g. guard-regions.c for an example of how it's used)
> and b. use the procmap helpers in vm_util.h to check on VMA ranges, you can see
> how they're used in... the merge.c tests you so deride :)
>
> If you or others do both/either I promise to dedicate review resource to the
> series(es). That fair enough?
>
> Thanks, Lorenzo

