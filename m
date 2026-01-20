Return-Path: <linux-kselftest+bounces-49490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2702D3C53C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D3B744660
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A13ECBC3;
	Tue, 20 Jan 2026 10:20:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1E3A6414;
	Tue, 20 Jan 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904454; cv=none; b=jCtNIrtjp4co8oa9PBwF/oC3kvKey6Uy5qXpo8qAnVPlTU461JyEkdMlUa4WX3gVcq2HtnU3TTmlyH0JmqdIF+CUsanTHiH6Rhe0rIkI8VoF6LwKCCGSIIcl402jausoVNApsew0+yz1vtYUrg0Yv4f0desdRXeUb9Zc5TPgm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904454; c=relaxed/simple;
	bh=uh8k2UsV80i9t6Ub6wE9jlhIoGqLXD2kPNU35t9hcFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoRMd2Jludqkj1MHcYGeAr/U0Ax1aHWiuW9FHrN/oliAWV8ymBzGVt0ccX7YGa6OIxOapTwYanRFBDJaFiru208rVNLTQTtcQHPf00cTjk5a20BLx+Z8q1+bUlZizdNOkPTlhf2SrzUqEf8Su2X0KLuFnJXUAdOmErXgy79fyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271771476;
	Tue, 20 Jan 2026 02:20:45 -0800 (PST)
Received: from [10.164.18.63] (MacBook-Pro.blr.arm.com [10.164.18.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03AB03F694;
	Tue, 20 Jan 2026 02:20:47 -0800 (PST)
Message-ID: <27ca39af-27d2-4f99-8988-5c45211b659a@arm.com>
Date: Tue, 20 Jan 2026 15:50:45 +0530
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
 <f5f92d9d-d65c-444b-8357-17cca7ec176c@arm.com>
 <8acef9ff-c5e2-4111-9437-f50b427db061@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8acef9ff-c5e2-4111-9437-f50b427db061@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 20/01/26 2:13 pm, Lorenzo Stoakes wrote:
> On Tue, Jan 20, 2026 at 10:59:01AM +0530, Dev Jain wrote:
>> I'll reply to everything here otherwise I'll have to repeat myself at different places.
>>
>> "Also exhausting VA space is an inherently silly thing for a test to do, you're
>> making assumptions about existing VMA layout which is absolutely an
>> implementation detail and may even be influence by libc..."
>>
>> The original version only uses mmap() and checks whether we got a high address mmap
>> success when we shouldn't have. There are no assumptions being made here about
>> VA layout. No matter the VA layout, the test will succeed because the kernel
>> must enforce the distinction between low and high addresses (but see point 3 below).
>>
>>
>> "It is therefore ENTIRELY a user-facing and kernel/user API thing that has to be tested from this perspective."
>>
>> So in merge.c, the statements ASSERT_NE(ptrx, MAP_FAILED) surely assert the
>> user-visible API - that mremap must not fail. But there are statements which
>> also assert where a VMA starts and where it ends, testing VMA merging -
>> I was concerned about these. It is not the goal of userspace to minimize the
>> number of VMAs while making a syscall - that is a kernel optimization. My point being,
>> I suspect that the mm selftests *already* test internal details a lot, and I believe
>> that they *need* to! Running selftests is the most convenient way of testing the mm subsystem.
>> Hence this should not be a ground for removal of test.
> Dev I would rather try to be positive not negative in review but again,
> this isn't constructive, we're not talking about merge.c and even if it
> contained the comment /* Ha ha I am a contradiction */ it wouldn't impact
> this discussion.
>
> You're not correct, mremap() has an API requirement that you can't cross
> VMA boundaries for most operations, therefore start/end of VMA's and
> merging _does_ matter. This also impacts how e.g. madvise() behaves.
>
> As I said before:
>
> 	But you do not - both VMA merge and CoW impact API. Re: merging
> 	certain user-facing functions, most notably mremap(), have API
> 	requirements that the user must not cross VMA boundaries. It is
> 	therefore ENTIRELY a user-facing and kernel/user API thing that has
> 	to be tested from this perspective.
>
> Can we drop the subject please?

I think we are talking past each other, and communication by email has not been
the greatest thing, so I'll step back.

>
>> Talking about the recent commits, they can be reverted. So, the ground for
>> removal should be that the ratio of the time taken by the test (exhausting VA
>> space), to the coverage of the test (for arm64, it is testing backward compatibility of 48-bit VA
>> on 52-bit VA, which one can argue is easy to spot if it ever breaks, and easy to fix)
>> is too large and does not justify a selftest. I tend to agree here.
>>
>> "Add a _new_ selftest, named something sensible like mmap_hint.c or something ..."
>>
>> va_high_addr_switch.c tests stuff around the switch boundary. But it does not
>> exhaust VA space. We *must* exhaust VA space if we are to check that the kernel,
>> in a situation of "emergency" (i.e exhausted lower VA space), starts giving out
>> high addresses, when it shouldn't. Again, one may argue that trying to test
>> this out is not worth it.
>>
>> I personally opine that besides testing the back compat of 48 bit VA on 52 bit VA,
>> we are testing something more important here: exhausting the VA space tests whether
>> the kernel can truly distinguish b/w virtual and physical memory - we stress the virtual
>> memory subsystem without touching physical memory, something which the kernel should be able
>> to handle. But again, any such test has the potential for a timeout. I wonder if there is a
>> faster way of filling up VA space.
>>
>> To summarize, I will agree with you that currently
>>
>> 1. The test is in a broken state
>> 2. The test is taking too much time to test something trivial
>> 3. It is a maintenance hazard. It turns out that the original version used
>>    MAP_CHUNK_SIZE of 16GB, but then it was changed to 1GB because (this is the bit
>>    where the dependency on VA layout comes) on some systems even a single 16GB mmap
>>    may fail. So now we are stuck in making a tradeoff between the size of a single
>>    mmap versus the time taken by the test
>>
>> So the better option seems to just remove the test.
> Right let's just focus on that.
>
>> A separate question: Do you think that the functionality advertised by validate_complete_va_space,
>> to check the gaps between VMAs, deserves a test in kunit / tools/testing/vma, or somewhere else?
> I don't think so as it's not a requirement set in stone as far as I
> understand it.
>
> But expectations as to what get_unmapped_area() should be doing makes more
> sense as a kunit test.
>
> Thanks, Lorenzo

