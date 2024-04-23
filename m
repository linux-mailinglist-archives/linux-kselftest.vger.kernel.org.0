Return-Path: <linux-kselftest+bounces-8667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A418AE039
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F028349C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E556443;
	Tue, 23 Apr 2024 08:49:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C0524A6;
	Tue, 23 Apr 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862151; cv=none; b=h+eEAhcXU834ObEZROS+EBVN1cPmYEolmte8vwNBdXJmo6LA36UORNxKqbXB9xpwVw9htTnSFdBjcqB3tbItikZ5Etxnd3P/43lGy0K2bwhlD++r1ImyTq85JSztVQ0IupLxCJK9s356a8lsX2pQt8Ol4s9klARqD2cGMmR0Qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862151; c=relaxed/simple;
	bh=Tgt7XtMEAaRR8592T/vdx2u5zNhrU+QC1fto751OEbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVaN8fR044CThHZRjXihAMeblPgUxWv6iCQcp4gcXSb4KyOnNi/BH/u1B6zlmyu3SqiQfTMRHeY6MQCBW40nDQnjXr9DEFcEcGcNgeUhoKqFrOP4iFfaHdPhpdREADASfmKOhFksv6N/s5u7n+bvIh4hsdWRjF9et44H34sUf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC426339;
	Tue, 23 Apr 2024 01:49:36 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDECA3F64C;
	Tue, 23 Apr 2024 01:49:06 -0700 (PDT)
Message-ID: <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
Date: Tue, 23 Apr 2024 09:49:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>
Cc: Shivansh Vij <shivanshvij@outlook.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
 <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
 <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/04/2024 18:12, David Hildenbrand wrote:
> On 19.04.24 18:30, Mike Rapoport wrote:
>> On Fri, Apr 19, 2024 at 11:45:14AM +0200, David Hildenbrand wrote:
>>> On 19.04.24 10:33, Shivansh Vij wrote:
>>>>> On 19/04/2024 08:43, Ryan Roberts wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> This series adds uffd write-protect and soft-dirty tracking support for
>>>>>> arm64. I
>>>>>> consider the soft-dirty support (patches 3 and 4) as RFC - see rationale
>>>>>> below.
>>>>>>
>>>>>> That said, these are the last 2 SW bits and we may want to keep 1 bit in
>>>>>> reserve
>>>>>> for future use. soft-dirty is only used for CRIU to my knowledge, and it is
>>>>>> thought that their use case could be solved with the more generic uffd-wp. So
>>>>>> unless somebody makes a clear case for the inclusion of soft-dirty
>>>>>> support, we
>>>>>> are probably better off dropping patches 3 and 4 and keeping bit 63 for
>>>>>> future
>>>>>> use. Although note that the most recent attempt to add soft-dirty for
>>>>>> arm64 was
>>>>>> last month [1] so I'd like to give Shivansh Vij the opportunity to make the
>>>>>> case.
>>>>
>>>> Appreciate the opportunity to provide input here.
>>>>
>>>> I picked option one (dirty tracking in arm) because it seems to be the
>>>> simplest way to move forward, whereas it would be a relatively heavy
>>>> effort to add uffd-wp support to CRIU.
>>>>
>>>>  From a performance perspective I am also a little worried that uffd
>>>> will be slower than just tracking the dirty bits asynchronously with
>>>> sw dirty, but maybe that's not as much of a concern with the addition
>>>> of uffd-wp async.
>>>>
>>>> With all this being said, I'll defer to the wisdom of the crowd about
>>>> which approach makes more sense - after all, with this patch we should
>>>> get uffd-wp support on arm so at least there will be _a_ way forward
>>>> for CRIU (albeit one requiring slightly more work).
>>>
>>> Ccing Mike and Peter. In 2017, Mike gave a presentation "Memory tracking for
>>> iterative container migration"[1] at LPC
>>>
>>> Some key points are still true I think:
>>> (1) More flexible and robust than soft-dirty
>>> (2) May obsolete soft-dirty
>>>
>>> We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part of
>>> [2], because getting soft-dirty return reliable results in some cases turned
>>> out rather hard to fix.

But it sounds like the current soft-dirty semantic is sufficient for CRIU on
other arches? If I understood correctly from my brief scan of the linked post,
the problem is that soft-dirty can sometimes provide false-positives? So could
result in uneccessary copy, but never lost data?

>>>
>>> We might still have to optimize that approach for some very sparse large
>>> VMAs, but that should be solvable.
>>>
>>>   "The major defect of this approach of dirty tracking is we need to
>>>   populate the pgtables when tracking starts. Soft-dirty doesn't do it
>>>   like that. It's unwanted in the case where the range of memory to track
>>>   is huge and unpopulated (e.g., tracking updates on a 10G file with
>>>   mmap() on top, without having any page cache installed yet). One way to
>>>   improve this is to allow pte markers exist for larger than PTE level
>>>   for PMD+. That will not change the interface if to implemented, so we
>>>   can leave that for later.")[3]
>>>
>>>
>>> If we can avoid adding soft-dirty on arm64 that would be great. This will
>>> require work on the CRIU side. One downside of uffd-wp is that it is
>>> currently not as avilable on architectures as soft-dirty.
>>
>> Using uffd-wp instead of soft-dirty in CRIU will require quite some work on
>> CRIU side and probably on the kernel side too.
>>
>> And as of now we'll anyway have to maintain soft-dirty because powerpc and
>> s390 don't have uffd-wp.
>>
>> With UFFD_FEATURE_WP_ASYNC the concern that uffd-wp will be slower than
>> soft-dirty probably doesn't exist, but we won't know for sure until
>> somebody will try.
>>
>> But there were other limitations, the most prominent was checkpointing an
>> application that uses uffd. If CRIU is to use uffd-wp for tracking of the
>> dirty pages, there should be some support for multiple uffd contexts for a
>> VMA and that's surely a lot of work.
> 
> Is it even already supported to checkpoint an application that is using uffd?
> Hard to believe, what if the monitor is running in a completely different
> process than the one being checkpointed?

Shivansh, do you speak for CRIU? Are you able to comment on whether CRIU
supports checkpointing an app that uses uffd?

> 
> Further ... isn't CRIU already using uffd in some cases? ...documentation
> mentions [1] that it is used for "lazy (or post-copy) restore in CRIU". At least
> if the documentation is correct and its actually implemented.
> 
> [1] https://criu.org/Userfaultfd

Shivansh, same question - do you know the current CRIU status/plans for using
uffd-wp instead of soft-dirty? If CRIU doesn't currently implement it and has no
current plans to, how can we guage interest in making a plan?

> 
>>
>>> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
>>> exist at the same time in the same process (or the VMA?). In theory, we

My instinct is that MUXing a PTE bit like this will lead to some subtle problems
that won't appear on arches that support either one or both of the features
independently and unconditionally. Surely better to limit ourselves to either
"arm64 will only support uffd-wp" or "arm64 will support both uffd-wp and
soft-dirty". That way, we could move ahead with reviewing/merging the uffd-wp
support asynchronously to deciding whether we want to support soft-dirty.

>>
>> For instance to have dirty memory tracking in CRIU for an application that
>> uses uffd-wp :)
>>
> 
> Hah! Not a concern for application on architectures where uffd-wp does not exist
> yet! Well, initially, until these applications exist and make use of it :P
> 
> Also, I'm not sure if CRIU can checkpoint each and every application ... I
> suspect one has to draw a line what can be supported and what not.
> 
> Case in point: how should CRIU checkpoint an application that is using softdirty
> tracking itself? If I'm not missing something important, that might not work ....
> 
> If the answer is "no other application is using soft-dirty tracking", then it's
> really a shame we have to carry this baggage (+waste precious PTE bits) only for
> one application ...



