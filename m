Return-Path: <linux-kselftest+bounces-8761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C38B077B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89D42850C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AC1598EE;
	Wed, 24 Apr 2024 10:39:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFC6159590;
	Wed, 24 Apr 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955168; cv=none; b=P8vc89utxuacToacB7S3K/K3M7GrESKkcJjPdP48QqmaJPQiq4lRIWZMYDa4FKGOHPhDop9gMmgTDw0uoCWQikqG+zRZs70K5BHv5zFdzOd/dsZ4ePJBIbFJ/kZgpvW1BL3sK0UAtMeipqDgv8wqDYH1yHzEb/VumHpQljJCK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955168; c=relaxed/simple;
	bh=gYnIwp7W9nXD7HEMr1KKSnvXyw/rmZVLa/bJObEUgi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S87fTGWkpD3OD25PS6tpYWKDhj0KacB2wM0JBJPKSm9CYLovyuY5F6j5KTJWubBHXttyBdBZ/PbIJ5B42soWF/7Ai7t98JJuM8wP8QKd+TLfcN10pSdkCKGZHH8aizqNYoUXcyg0Q2BpBHVz4EoeCdhs6O3Anxswy79F8tEngcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF43339;
	Wed, 24 Apr 2024 03:39:54 -0700 (PDT)
Received: from [10.1.25.156] (unknown [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24EA3F73F;
	Wed, 24 Apr 2024 03:39:24 -0700 (PDT)
Message-ID: <3e14ad32-17da-49fd-a4ac-8f87f9151dba@arm.com>
Date: Wed, 24 Apr 2024 11:39:23 +0100
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
To: David Hildenbrand <david@redhat.com>,
 Shivansh Vij <shivanshvij@outlook.com>, Mike Rapoport <rppt@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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
 <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
 <MW4PR12MB68755A569FE893DC72D86616B9112@MW4PR12MB6875.namprd12.prod.outlook.com>
 <e001f009-0aeb-4a59-950e-3e5ed1c55751@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e001f009-0aeb-4a59-950e-3e5ed1c55751@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 22:02, David Hildenbrand wrote:
>>>
>>> Shivansh, do you speak for CRIU? Are you able to comment on whether CRIU
>>> supports checkpointing an app that uses uffd?
>>
>> I do not speak for CRIU - I'm just a user (and hopefully a future
>> contributor), but not a maintainer or owner. I can however comment on whether
>> CRIU supports checkpointing an app that uses UFFD - it doesn't. Looking
>> through both the implementation of CRIU (specifically how they restore memory
>> [1]), and at recently filed Github issues [2], it's pretty clear that CRIU
>> doesn't support processes using UFFD - that they do not currently have plans
>> to [3].
> 
> Thanks for all these pointers!
> 
>>
>> [1]
>> https://github.com/checkpoint-restore/criu/blob/criu-2.x-stable/criu/mem.c#L683
>> [2] https://github.com/checkpoint-restore/criu/issues/2021
>> [3]
>> https://github.com/checkpoint-restore/criu/issues/2021#issuecomment-1346971967
>>
>>>>
>>>> Further ... isn't CRIU already using uffd in some cases? ...documentation
>>>> mentions [1] that it is used for "lazy (or post-copy) restore in CRIU". At
>>>> least
>>>> if the documentation is correct and its actually implemented.
>>>>
>>>
>>> Shivansh, same question - do you know the current CRIU status/plans for using
>>> uffd-wp instead of soft-dirty? If CRIU doesn't currently implement it and has no
>>> current plans to, how can we guage interest in making a plan?
>>>
>>
>> While I cannot gauge whether the maintainers or main contributors of CRIU plan
>> on using uffd-wp instead of soft-dirty in the future, I can tell you that
>> there is no currently open issue to track that work, and whenever anyone in
>> the past has asked about ARM64 pre-dump support to CRIU (which is the feature
>> that uses soft-dirty/would use uffd-wp), they've always just said it's not
>> supported - but that they do want the feature [4].
>>
>> So in summary, they want the feature, but no one is working on implementing it
>> (either with soft-dirty or with uffd-wp).
>>
>> I doubt that CRIU would have any issues with adding the feature via soft-dirty
>> (since, as shown in [4] they're interested in it), but as for using uffd-wp
>> they definitely haven't shown any interest thus far. Based on the fact that it
>> would be a very significant amount of work and it would really only be for
>> ARM64 support (which they're already fine without), I'd be very surprised if
>> they were interested in pursuing it.
>>
> 
> Of course, nobody wants to do the work. But that doesn't mean that the kernel
> has to do the work :)
> 
> If there are some major challenges why it cannot possible be done with uffd-wp
> (unfixable), that's a different story.
> 
>> [4]
>> https://github.com/checkpoint-restore/criu/issues/1859#issuecomment-1972674047
>>
>>>>
>>>>>
>>>>>> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
>>>>>> exist at the same time in the same process (or the VMA?). In theory, we
>>>
>>> My instinct is that MUXing a PTE bit like this will lead to some subtle problems
>>> that won't appear on arches that support either one or both of the features
>>> independently and unconditionally. Surely better to limit ourselves to either
>>> "arm64 will only support uffd-wp" or "arm64 will support both uffd-wp and
>>> soft-dirty". That way, we could move ahead with reviewing/merging the uffd-wp
>>> support asynchronously to deciding whether we want to support soft-dirty.
>>>
>>
>> My personal preference is having both approaches supported - especially in the
>> context of CRIU since I doubt they'll be willing to rewrite all of the dumping
>> and restore logic just for ARM64 support.
> 
> Sure, nobody does any work unless they are forced to.
> 
> But this is something that arm64 maintainers will have to decide.
> 
> Let's start with uffd-wp that has other well-known users that could benefit
> (e.g., QEMU background snapshots).

Right. I'm going to:

  - re-post patch 5 standalone to go in via kselftests.
  - re-post patches 1 & 2 as a series to enable uffd-wp on arm64; uncontentious
    I think.
  - Have a chat with Catalin about appetite for soft-dirty on arm64; But likely
    that will be left here until/unless there is clear justificaiton that the
    use case cannot be met with uffd-wp.

Thanks,
Ryan


