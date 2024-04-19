Return-Path: <linux-kselftest+bounces-8474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0E8AB434
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D61A1F2236D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C313775C;
	Fri, 19 Apr 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEs6kza8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDB85284
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546784; cv=none; b=kzDaz507p9mlI40LR8qxCycIUWGmoleonclrhbD5NZFL47AC2OdVnN1wstP32HoNu7u6mHY/NbLMcy4vQj+pzs798A2oUtTCpHHqwQNdyx4acFck8uF23/dmCQUuhy5s6ULzfywFvHMHzfUahfrjnU4R0qcjIgMwPn9PeKw2VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546784; c=relaxed/simple;
	bh=6mkNayftPML6pT2KciKfd4FFbXSB1RlhvOicRs6zOX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX+XRLJM09XV9jb4P4MwgZIYYFCbxePULhHVUJBVkvNDohZDcLUd6R/Qd0xKJA/UD7frWRob3pYSJlyGz6zHwPNNrf1niRAUyYel9IUoHAIGZljs9ZbV8MiBoG0MF+1hoobAyAbF8iENJJOzeTK1pee7vUn259u9nYMJv1raQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEs6kza8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713546781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ffWzMqu7mdQbYGoN2ZnXETKJDhCQefY93Dtj+EcLpGM=;
	b=PEs6kza8OhzOJMv0wHl+Ck8I6cdcNqN8fNgmfRjxtRpv1h7qn+UX+/hNFZN8ipLsDkMZez
	z0+BA7wdb4YBRAfwHETXurQlnKnE0rGKI+5UaB6hADjmoHXN8XgP+SOxXD6um4GnXKhMbq
	3ZgtP36BY3o8Ftdt42f3eEstzIKoxBg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-UQaHHc7-OEu2-nl90VkPVQ-1; Fri, 19 Apr 2024 13:12:59 -0400
X-MC-Unique: UQaHHc7-OEu2-nl90VkPVQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d86a38bb94so20428801fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 10:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713546778; x=1714151578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffWzMqu7mdQbYGoN2ZnXETKJDhCQefY93Dtj+EcLpGM=;
        b=rfX4X5dUA1srk41+B29x9Rb2YIQEgGUnCXx+Xf0kkPZeeec70XF2qVWIAiKhxugfno
         aj/E4zPgzcgLDeH3UKxHRGnCMTnkcTJcmTrYOBPZWnr+jGjmMO+VL5Z2cv5mQ958kRJP
         InFHwffXPw6QljGhz5u2VJhkwNDYG3jqmH43IYiqbdqH6vegFPIDoxHeCR65hwIAKyPV
         9tpdH7EWE2N/g8GkMbWNsxV4mE5N4nyRPm8pqFtSVoOtT96Pl/0JDJ9yU/vPIZGQs10w
         ObCD7gAkt/SoDAglVY/WeuhhOamI6AKxGC+y7SDsFDrbN1wgP/03bez3RdttDd3nysMX
         0XVg==
X-Forwarded-Encrypted: i=1; AJvYcCXh+PrkAoaR/PXbuje2ZeK8SEjWM4YpBDcQo//Q4NCz4f75fYQSnvk0iuQPT0+0MPXIUQKfqNA/aN+S0jBM/kxmpCjzYxAbmq8MnNv+Jzag
X-Gm-Message-State: AOJu0YzIoG3TVCJ2kHg4GEu/me0+5CEkpQsqmrhEBUwURgYFq/PbqSaq
	ekGuAg3n+JJ1Gi0xiWd5mVeYucNkilYq3YnDcg3Kj2H/LR73J7Rb37DlIIyXqm+hWd4M9vf1o0W
	FWYc8FRmOQ/uk5FIqbQ9CqTuz1ZCFcyFpJJSzD5NifaZBPXBQZv0iT3/ahIi8il96bg==
X-Received: by 2002:a2e:834b:0:b0:2d8:4158:cbaa with SMTP id l11-20020a2e834b000000b002d84158cbaamr1754468ljh.7.1713546778045;
        Fri, 19 Apr 2024 10:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/WsAq1RywBMvcnKm1ylFu3yIf/0wkUkJfkHeJmvKLZIe0rmnD3ACJULWqGSOo8wAsgmKA2Q==
X-Received: by 2002:a2e:834b:0:b0:2d8:4158:cbaa with SMTP id l11-20020a2e834b000000b002d84158cbaamr1754446ljh.7.1713546777511;
        Fri, 19 Apr 2024 10:12:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:f300:c9f0:f643:6aa2:16? (p200300cbc716f300c9f0f6436aa20016.dip0.t-ipconnect.de. [2003:cb:c716:f300:c9f0:f643:6aa2:16])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b004161af729f4sm7214198wmb.31.2024.04.19.10.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 10:12:57 -0700 (PDT)
Message-ID: <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
Date: Fri, 19 Apr 2024 19:12:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Shivansh Vij <shivanshvij@outlook.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 18:30, Mike Rapoport wrote:
> On Fri, Apr 19, 2024 at 11:45:14AM +0200, David Hildenbrand wrote:
>> On 19.04.24 10:33, Shivansh Vij wrote:
>>>> On 19/04/2024 08:43, Ryan Roberts wrote:
>>>>> Hi All,
>>>>>
>>>>> This series adds uffd write-protect and soft-dirty tracking support for arm64. I
>>>>> consider the soft-dirty support (patches 3 and 4) as RFC - see rationale below.
>>>>>
>>>>> That said, these are the last 2 SW bits and we may want to keep 1 bit in reserve
>>>>> for future use. soft-dirty is only used for CRIU to my knowledge, and it is
>>>>> thought that their use case could be solved with the more generic uffd-wp. So
>>>>> unless somebody makes a clear case for the inclusion of soft-dirty support, we
>>>>> are probably better off dropping patches 3 and 4 and keeping bit 63 for future
>>>>> use. Although note that the most recent attempt to add soft-dirty for arm64 was
>>>>> last month [1] so I'd like to give Shivansh Vij the opportunity to make the
>>>>> case.
>>>
>>> Appreciate the opportunity to provide input here.
>>>
>>> I picked option one (dirty tracking in arm) because it seems to be the
>>> simplest way to move forward, whereas it would be a relatively heavy
>>> effort to add uffd-wp support to CRIU.
>>>
>>>  From a performance perspective I am also a little worried that uffd
>>> will be slower than just tracking the dirty bits asynchronously with
>>> sw dirty, but maybe that's not as much of a concern with the addition
>>> of uffd-wp async.
>>>
>>> With all this being said, I'll defer to the wisdom of the crowd about
>>> which approach makes more sense - after all, with this patch we should
>>> get uffd-wp support on arm so at least there will be _a_ way forward
>>> for CRIU (albeit one requiring slightly more work).
>>
>> Ccing Mike and Peter. In 2017, Mike gave a presentation "Memory tracking for
>> iterative container migration"[1] at LPC
>>
>> Some key points are still true I think:
>> (1) More flexible and robust than soft-dirty
>> (2) May obsolete soft-dirty
>>
>> We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part of
>> [2], because getting soft-dirty return reliable results in some cases turned
>> out rather hard to fix.
>>
>> We might still have to optimize that approach for some very sparse large
>> VMAs, but that should be solvable.
>>
>>   "The major defect of this approach of dirty tracking is we need to
>>   populate the pgtables when tracking starts. Soft-dirty doesn't do it
>>   like that. It's unwanted in the case where the range of memory to track
>>   is huge and unpopulated (e.g., tracking updates on a 10G file with
>>   mmap() on top, without having any page cache installed yet). One way to
>>   improve this is to allow pte markers exist for larger than PTE level
>>   for PMD+. That will not change the interface if to implemented, so we
>>   can leave that for later.")[3]
>>
>>
>> If we can avoid adding soft-dirty on arm64 that would be great. This will
>> require work on the CRIU side. One downside of uffd-wp is that it is
>> currently not as avilable on architectures as soft-dirty.
> 
> Using uffd-wp instead of soft-dirty in CRIU will require quite some work on
> CRIU side and probably on the kernel side too.
> 
> And as of now we'll anyway have to maintain soft-dirty because powerpc and
> s390 don't have uffd-wp.
> 
> With UFFD_FEATURE_WP_ASYNC the concern that uffd-wp will be slower than
> soft-dirty probably doesn't exist, but we won't know for sure until
> somebody will try.
> 
> But there were other limitations, the most prominent was checkpointing an
> application that uses uffd. If CRIU is to use uffd-wp for tracking of the
> dirty pages, there should be some support for multiple uffd contexts for a
> VMA and that's surely a lot of work.

Is it even already supported to checkpoint an application that is using 
uffd? Hard to believe, what if the monitor is running in a completely 
different process than the one being checkpointed?

Further ... isn't CRIU already using uffd in some cases? 
...documentation mentions [1] that it is used for "lazy (or post-copy) 
restore in CRIU". At least if the documentation is correct and its 
actually implemented.

[1] https://criu.org/Userfaultfd

> 
>> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
>> exist at the same time in the same process (or the VMA?). In theory, we
> 
> For instance to have dirty memory tracking in CRIU for an application that
> uses uffd-wp :)
> 

Hah! Not a concern for application on architectures where uffd-wp does 
not exist yet! Well, initially, until these applications exist and make 
use of it :P

Also, I'm not sure if CRIU can checkpoint each and every application ... 
I suspect one has to draw a line what can be supported and what not.

Case in point: how should CRIU checkpoint an application that is using 
softdirty tracking itself? If I'm not missing something important, that 
might not work ....

If the answer is "no other application is using soft-dirty tracking", 
then it's really a shame we have to carry this baggage (+waste precious 
PTE bits) only for one application ...

-- 
Cheers,

David / dhildenb


