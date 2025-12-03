Return-Path: <linux-kselftest+bounces-46931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C9C9E73B
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3529C4E150E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC822DCC08;
	Wed,  3 Dec 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvu5yFI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83E2DCBF4;
	Wed,  3 Dec 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753836; cv=none; b=llUd6R7t+aOQ7o5MOXYXJrsgQVzhZgpctqoDYR6r3k6aLxuZZbk/jozSM8z79rwGVzBw3BLl8Seihi+xf7dMpy+79B9czzNczkehpolHYIXYdv0p/69kMCxfHxl3jmMGAQYwHaBLPj5QFKAEQw+ed+jlIMy8impXs2uKJRDQi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753836; c=relaxed/simple;
	bh=S4e+WORc08941gqGHI+Qfm/GmNkEJ5ySt5lGOScr0z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5+Cl2lQxLP+EEHXxRlkTWLVqfUYbwUo6eyT7HtTk5slBEmO7YBTWGcI0eSdvkPuMS5YcSFlRiLMMexHiBlTVXQP3IXlBaoYPhWGcPp/EDvBNLGg4ksXi4Of641vCVjyEZNwt706+4XjC10dfKXUikxpLIdPWHosh8dFuyoKrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvu5yFI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E1CC116B1;
	Wed,  3 Dec 2025 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764753835;
	bh=S4e+WORc08941gqGHI+Qfm/GmNkEJ5ySt5lGOScr0z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cvu5yFI/MWJfoPp0dnwR0P+NhuCgNI2hiu03Tf6XZELP7zbJQpqm5isUjY9e/Tdfh
	 T1FAti4re38m+kkle6trKUG6LfyK78Gorj+43AS2e5UAaONj+LDyx6102ue5fHUWS6
	 OWQCREZ83ki2v2ja4OzL7nuPrPyjIF9xnFm7IcSjDbr+EcpfIRDxFigHPBc+ze8C9T
	 DsmjFaKLsK5OTbq0yP2MUJdYQq+Mr6/7x5jCf3UlJikpFhCn5E7Tyafj+CHKqJ7j/d
	 df7sIZoXwXVkQsejcLEMJuSYUCn/VVgUw/1IjYzOtcfs6u+RP8EKhtBYbWSfEdziKj
	 RoG6FWK4bU01Q==
Message-ID: <69bfdffd-8aa3-4375-9caf-b3311ff72448@kernel.org>
Date: Wed, 3 Dec 2025 10:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: kalyazin@amazon.com, Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
 <553c64e8-d224-4764-9057-84289257cac9@amazon.com> <aS3f_PlxWLb-6NmR@x1.local>
 <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com> <aS4BVC42JiUT51rS@x1.local>
 <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 12:50, Nikita Kalyazin wrote:
> 
> 
> On 01/12/2025 20:57, Peter Xu wrote:
>> On Mon, Dec 01, 2025 at 08:12:38PM +0000, Nikita Kalyazin wrote:
>>>
>>>
>>> On 01/12/2025 18:35, Peter Xu wrote:
>>>> On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
>>>>> I believe I found the precise point where we convinced ourselves that minor
>>>>> support was sufficient: [1].  If at this moment we don't find that reasoning
>>>>> valid anymore, then indeed implementing missing is the only option.
>>>>>
>>>>> [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
>>>>
>>>> Now after I re-read the discussion, I may have made a wrong statement
>>>> there, sorry.  I could have got slightly confused on when the write()
>>>> syscall can be involved.
>>>>
>>>> I agree if you want to get an event when cache missed with the current uffd
>>>> definitions and when pre-population is forbidden, then MISSING trap is
>>>> required.  That is, with/without the need of UFFDIO_COPY being available.
>>>>
>>>> Do I understand it right that UFFDIO_COPY is not allowed in your case, but
>>>> only write()?
>>>
>>> No, UFFDIO_COPY would work perfectly fine.  We will still use write()
>>> whenever we resolve stage-2 faults as they aren't visible to UFFD.  When a
>>> userfault occurs at an offset that already has a page in the cache, we will
>>> have to keep using UFFDIO_CONTINUE so it looks like both will be required:
>>>
>>>    - user mapping major fault -> UFFDIO_COPY (fills the cache and sets up
>>> userspace PT)
>>>    - user mapping minor fault -> UFFDIO_CONTINUE (only sets up userspace PT)
>>>    - stage-2 fault -> write() (only fills the cache)
>>
>> Is stage-2 fault about KVM_MEMORY_EXIT_FLAG_USERFAULT, per James's series?
> 
> Yes, that's the one ([1]).
> 
> [1]
> https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com
> 
>>
>> It looks fine indeed, but it looks slightly weird then, as you'll have two
>> ways to populate the page cache.  Logically here atomicity is indeed not
>> needed when you trap both MISSING + MINOR.
> 
> I reran the test based on the UFFDIO_COPY prototype I had using your
> series [2], and UFFDIO_COPY is slower than write() to populate 512 MiB:
> 237 vs 202 ms (+17%).  Even though UFFDIO_COPY alone is functionally
> sufficient, I would prefer to have an option to use write() where
> possible and only falling back to UFFDIO_COPY for userspace faults to
> have better performance.

Just so I understand correctly: we could even do without UFFDIO_COPY for 
that scenario by using write() + minor faults?

But what you are saying is that there might be a performance benefit in 
using UFFDIO_COPY for userspace faults, to avoid the write()+minor fault 
overhead?

-- 
Cheers

David

